using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Text;
using System.Windows.Forms;

namespace SimpleSerial
{
    public partial class Form1 : Form
    {
        // Add this variable 
        string RxString;
        string file;

        public Form1()
        {
            InitializeComponent();
            RefreshCommPortList();
            ddBaudRate.SelectedIndex = 0;
        }

        private void RefreshCommPortList()
        {
            ddCommList.Items.Clear();
            ddCommList.Items.AddRange(System.IO.Ports.SerialPort.GetPortNames());
            ddCommList.SelectedIndex = 0;
        }
        private void buttonStart_Click(object sender, EventArgs e)
        {
            serialPort1.PortName = ddCommList.SelectedItem.ToString();
            serialPort1.BaudRate = int.Parse(ddBaudRate.SelectedItem.ToString());
            serialPort1.StopBits = System.IO.Ports.StopBits.Two;

            serialPort1.Open();
            if (serialPort1.IsOpen)
            {
                buttonStart.Enabled = false;
                buttonStop.Enabled = true;
                tbSend.Enabled = true;
                btnSend.Enabled = true;
                ddCommList.Enabled = false;
                ddBaudRate.Enabled = false;
            }
        }

        private void buttonStop_Click(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Close();
                buttonStart.Enabled = true;
                buttonStop.Enabled = false;
                tbSend.ReadOnly = true;
                btnSend.Enabled = true;
                ddCommList.Enabled = true;
                ddBaudRate.Enabled = true;
                tbSend.Text = "";
                textBox1.Text = "";
            }

        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (serialPort1.IsOpen) serialPort1.Close();
        }

        int rcv_count = 0;
        private void DisplayText(object sender, EventArgs e)
        {
            textBox1.AppendText(RxString);


            foreach (char c in RxString)
            {
                rcv_count++;
                if (rcv_count % 8 == 0)
                {
                    tbSend.AppendText("\n\r");
                }
                tbSend.AppendText(string.Format("{0:X2} ", (int)c));
            }
        }

        private void serialPort1_DataReceived(object sender, System.IO.Ports.SerialDataReceivedEventArgs e)
        {
            RxString = serialPort1.ReadExisting();

            this.Invoke(new EventHandler(DisplayText));
        }

        private void button1_Click(object sender, EventArgs e)
        {
            // If the port is closed, don't try to send a character.
            if (!serialPort1.IsOpen) return;

            // Send the one character buffer.
            serialPort1.Write(tbSend.Text.ToCharArray(), 0, tbSend.Text.ToCharArray().Length);

            tbSend.Text = "";
        }

        private void btnCommListRefresh_Click(object sender, EventArgs e)
        {
            RefreshCommPortList();
        }

        private void btnCommListRefresh_Click_1(object sender, EventArgs e)
        {

        }

        private void btn_sendFile_Click(object sender, EventArgs e)
        {

            OpenFileDialog openFileDialog1 = new OpenFileDialog();


            openFileDialog1.Filter = "Gameboy files (*.gb)|*.gb|Gameboy Color files (*.gbc)|*.gbc|All files (*.*)|*.*";

            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                file = openFileDialog1.FileName;
                Stream(openFileDialog1.OpenFile());
            }
        }
        private void Stream(Stream myStream)
        {
            try
            {
                if ((myStream) != null)
                {
                    using (myStream)
                    {
                        BinaryReader br = new BinaryReader(myStream);

                        byte[] len = new byte[2];

                        len[0] = (byte)((br.BaseStream.Length >> 15) & 0xff);

                        serialPort1.Write(len, 0, 1);

                        while (br.BaseStream.Position != br.BaseStream.Length)
                        {
                            byte[] b;

                            if (br.BaseStream.Length - br.BaseStream.Position >= 256)
                            {
                                b = br.ReadBytes(256);
                                serialPort1.Write(b, 0, 256);
                            }
                            else
                            {
                                b = br.ReadBytes(256);
                                serialPort1.Write(b, 0, 1);
                            }
                            pbLoad.Value = (int)(100.0 * br.BaseStream.Position / br.BaseStream.Length);
                        }

                        serialPort1.Write(len, 0, 2);
                        serialPort1.Write(len, 0, 2);
                        serialPort1.Write(len, 0, 2);
                        serialPort1.Write(len, 0, 2);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: Could not read file from disk. Original error: " + ex.Message);
            }
        }
        private void btnReset_Click(object sender, EventArgs e)
        {
            if (file != null)
            {
                Stream(File.Open(file, FileMode.Open));
            }

        }

        private void ddBaudRate_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {
            OpenAndSend(2);
        }

        private void OpenAndSend(byte location, bool test = false)
        {
            OpenFileDialog openFileDialog1 = new OpenFileDialog();


            openFileDialog1.Filter = "Gameboy files (*.gb)|*.gb|Gameboy Color files (*.gbc)|*.gbc|All files (*.*)|*.*";

            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                file = openFileDialog1.FileName;
                if (test)
                {
                    Stream3(openFileDialog1.OpenFile(), location);
                }
                else
                { Stream2(openFileDialog1.OpenFile(), location); }
            }
        }
        private void Stream2(Stream myStream, byte location)
        {
            try
            {
                if ((myStream) != null)
                {
                    using (myStream)
                    {
                        BinaryReader br = new BinaryReader(myStream);
                        pbLoad.Value = 0;


                        long len = br.BaseStream.Length ;

                        byte[] data = new byte[4];

                        data[0] = location;
                        data[1] = (byte)((len >> 16) & 0xff);
                        data[2] = (byte)((len >> 8) & 0xff);
                        data[3] = (byte)((len >> 0) & 0xff);

                        serialPort1.Write(data, 0, 4);

                        br.BaseStream.Seek(0, SeekOrigin.Begin);
                        byte[] b = new byte[1] { 0 };
                        while (br.BaseStream.Position < len && br.BaseStream.Position < br.BaseStream.Length)
                        {
                           

                            if (br.BaseStream.Length - br.BaseStream.Position >= 256)
                            {
                                b = br.ReadBytes(256);
                                serialPort1.Write(b, 0, 256);
                            }
                            else
                            {
                                b = br.ReadBytes(1);
                                serialPort1.Write(b, 0, 1);
                            }

                            
                            pbLoad.Value = Math.Min(100,(int)(100.0 * br.BaseStream.Position / len));
                        }

                        pbLoad.Value = 100;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: Could not read file from disk. Original error: " + ex.Message);
            }
        }
        private void Stream3(Stream myStream, byte location)
        {
            try
            {
                if ((myStream) != null)
                {
                    using (myStream)
                    {
                        BinaryReader br = new BinaryReader(myStream);


                        int i = -1;
                        br.BaseStream.Seek(-1, SeekOrigin.End);
                        while (br.BaseStream.ReadByte() == 0)
                        {
                            br.BaseStream.Seek(i, SeekOrigin.End);
                            i--;
                        }

                        long len = br.BaseStream.Length + i + 2;

                        byte[] data = new byte[4];

                        data[0] = location;
                        data[1] = (byte)((len >> 16) & 0xff);
                        data[2] = (byte)((len >> 8) & 0xff);
                        data[3] = (byte)((len >> 0) & 0xff);

                        serialPort1.Write(data, 0, 4);

                        br.BaseStream.Seek(0, SeekOrigin.Begin);

                        byte test = 0;
                        byte[] b = new byte[1];

                        while (br.BaseStream.Position != len)
                        {
                            br.ReadBytes(1);
                            b[0] = test++;
                            serialPort1.Write(b, 0, 1);
                            pbLoad.Value = (int)(100.0 * br.BaseStream.Position / len);
                        }

                        serialPort1.Write(b, 0, 1);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: Could not read file from disk. Original error: " + ex.Message);
            }
        }
        private void button1_Click_1(object sender, EventArgs e)
        {
            OpenAndSend(1);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            OpenAndSend(0);
        }

        private void button4_Click(object sender, EventArgs e)
        {
            OpenAndSend(2, true);
        }

        string gbsPlayer = "";

        private void btnLoadGbs_Click(object sender, EventArgs e)
        {
            UInt16 play_addr;
            UInt16 load_addr;
            UInt16 init_addr;
            UInt16 stack_ptr;
            byte tma;
            byte tca;

            OpenFileDialog openFileDialog1 = new OpenFileDialog();


            openFileDialog1.Filter = "Gameboy Song files (*.gbs)|*.gbs";



            if (openFileDialog1.ShowDialog() != DialogResult.OK) return;

            file = openFileDialog1.FileName;

            BinaryReader gbs = new BinaryReader(System.IO.File.OpenRead(file));

            gbs.BaseStream.Seek(6, SeekOrigin.Begin);
            load_addr = gbs.ReadUInt16();
            init_addr = gbs.ReadUInt16();
            play_addr = gbs.ReadUInt16();
            stack_ptr = gbs.ReadUInt16();

            tma = gbs.ReadByte();
            tca = gbs.ReadByte();

            if(gbsPlayer == null || gbsPlayer.Length < 1)
            {
                openFileDialog1.Filter = "Gameboy Player (*.gb)|*.gb";
                if (openFileDialog1.ShowDialog() != DialogResult.OK) return;
                gbsPlayer = openFileDialog1.FileName;
            }

            BinaryReader player = new BinaryReader(System.IO.File.OpenRead(gbsPlayer));


            SaveFileDialog songFile = new SaveFileDialog();
            if (songFile.ShowDialog() != DialogResult.OK) return;

            BinaryWriter song = new BinaryWriter(System.IO.File.Create(songFile.FileName));

            song.Write(player.ReadBytes((int)player.BaseStream.Length));
            gbs.BaseStream.Seek(0x70, SeekOrigin.Begin);
            song.Seek(load_addr, SeekOrigin.Begin);
            song.Write(gbs.ReadBytes((int)gbs.BaseStream.Length - 0x70));

            song.Seek(0x41, SeekOrigin.Begin);
            song.Write((byte)(play_addr & 0xff));
            song.Write((byte)((play_addr >> 8) & 0xff));

            song.Seek(0x15B, SeekOrigin.Begin);
            song.Write((byte)(init_addr & 0xff));
            song.Write((byte)((init_addr >> 8) & 0xff));

            song.Seek(0x15E, SeekOrigin.Begin);
            song.Write((byte)(stack_ptr & 0xff));
            song.Write((byte)((stack_ptr >> 8) & 0xff));

            song.Seek(0x161, SeekOrigin.Begin);
            song.Write((byte)(tma));
            song.Seek(0x165, SeekOrigin.Begin);
            song.Write((byte)(tca));

            if( ((int)tca & 4) == 2)
            {
                song.Seek(0x155, SeekOrigin.Begin);
                song.Write((byte)4);
            }

            song.Seek(0, SeekOrigin.Begin);

            Stream2(song.BaseStream, 0);

            song.Close();
            gbs.Close();
            player.Close();
        }
    }
}