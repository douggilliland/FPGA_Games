namespace SimpleSerial
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.buttonStart = new System.Windows.Forms.Button();
            this.buttonStop = new System.Windows.Forms.Button();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.serialPort1 = new System.IO.Ports.SerialPort(this.components);
            this.tbSend = new System.Windows.Forms.TextBox();
            this.btnSend = new System.Windows.Forms.Button();
            this.ddCommList = new System.Windows.Forms.ComboBox();
            this.btnCommListRefresh = new System.Windows.Forms.Button();
            this.ddBaudRate = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.btn_sendFile = new System.Windows.Forms.Button();
            this.pbLoad = new System.Windows.Forms.ProgressBar();
            this.btnReset = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.btnLoadGbs = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // buttonStart
            // 
            this.buttonStart.Location = new System.Drawing.Point(20, 20);
            this.buttonStart.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.buttonStart.Name = "buttonStart";
            this.buttonStart.Size = new System.Drawing.Size(112, 35);
            this.buttonStart.TabIndex = 0;
            this.buttonStart.Text = "Start";
            this.buttonStart.UseVisualStyleBackColor = true;
            this.buttonStart.Click += new System.EventHandler(this.buttonStart_Click);
            // 
            // buttonStop
            // 
            this.buttonStop.Enabled = false;
            this.buttonStop.Location = new System.Drawing.Point(141, 20);
            this.buttonStop.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.buttonStop.Name = "buttonStop";
            this.buttonStop.Size = new System.Drawing.Size(112, 35);
            this.buttonStop.TabIndex = 1;
            this.buttonStop.Text = "Stop";
            this.buttonStop.UseVisualStyleBackColor = true;
            this.buttonStop.Click += new System.EventHandler(this.buttonStop_Click);
            // 
            // textBox1
            // 
            this.textBox1.Font = new System.Drawing.Font("Consolas", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBox1.Location = new System.Drawing.Point(20, 105);
            this.textBox1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.textBox1.Multiline = true;
            this.textBox1.Name = "textBox1";
            this.textBox1.ReadOnly = true;
            this.textBox1.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.textBox1.Size = new System.Drawing.Size(418, 312);
            this.textBox1.TabIndex = 2;
            // 
            // tbSend
            // 
            this.tbSend.Enabled = false;
            this.tbSend.Font = new System.Drawing.Font("Consolas", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbSend.Location = new System.Drawing.Point(470, 23);
            this.tbSend.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.tbSend.Multiline = true;
            this.tbSend.Name = "tbSend";
            this.tbSend.Size = new System.Drawing.Size(382, 393);
            this.tbSend.TabIndex = 3;
            // 
            // btnSend
            // 
            this.btnSend.Enabled = false;
            this.btnSend.Location = new System.Drawing.Point(741, 428);
            this.btnSend.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.btnSend.Name = "btnSend";
            this.btnSend.Size = new System.Drawing.Size(112, 35);
            this.btnSend.TabIndex = 4;
            this.btnSend.Text = "Send";
            this.btnSend.UseVisualStyleBackColor = true;
            this.btnSend.Click += new System.EventHandler(this.button1_Click);
            // 
            // ddCommList
            // 
            this.ddCommList.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ddCommList.FormattingEnabled = true;
            this.ddCommList.Items.AddRange(new object[] {
            "com1"});
            this.ddCommList.Location = new System.Drawing.Point(262, 22);
            this.ddCommList.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.ddCommList.Name = "ddCommList";
            this.ddCommList.Size = new System.Drawing.Size(127, 28);
            this.ddCommList.TabIndex = 5;
            // 
            // btnCommListRefresh
            // 
            this.btnCommListRefresh.Location = new System.Drawing.Point(400, 20);
            this.btnCommListRefresh.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.btnCommListRefresh.Name = "btnCommListRefresh";
            this.btnCommListRefresh.Size = new System.Drawing.Size(39, 35);
            this.btnCommListRefresh.TabIndex = 6;
            this.btnCommListRefresh.Text = "R";
            this.btnCommListRefresh.UseVisualStyleBackColor = true;
            this.btnCommListRefresh.Click += new System.EventHandler(this.btnCommListRefresh_Click_1);
            // 
            // ddBaudRate
            // 
            this.ddBaudRate.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ddBaudRate.FormattingEnabled = true;
            this.ddBaudRate.Items.AddRange(new object[] {
            "115200",
            "230400",
            "1048576"});
            this.ddBaudRate.Location = new System.Drawing.Point(262, 63);
            this.ddBaudRate.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.ddBaudRate.Name = "ddBaudRate";
            this.ddBaudRate.Size = new System.Drawing.Size(127, 28);
            this.ddBaudRate.TabIndex = 7;
            this.ddBaudRate.SelectedIndexChanged += new System.EventHandler(this.ddBaudRate_SelectedIndexChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(18, 75);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(79, 20);
            this.label1.TabIndex = 8;
            this.label1.Text = "Recieved:";
            // 
            // btn_sendFile
            // 
            this.btn_sendFile.Location = new System.Drawing.Point(470, 426);
            this.btn_sendFile.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.btn_sendFile.Name = "btn_sendFile";
            this.btn_sendFile.Size = new System.Drawing.Size(112, 35);
            this.btn_sendFile.TabIndex = 9;
            this.btn_sendFile.Text = "Send File";
            this.btn_sendFile.UseVisualStyleBackColor = true;
            this.btn_sendFile.Click += new System.EventHandler(this.btn_sendFile_Click);
            // 
            // pbLoad
            // 
            this.pbLoad.Location = new System.Drawing.Point(22, 428);
            this.pbLoad.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.pbLoad.Name = "pbLoad";
            this.pbLoad.Size = new System.Drawing.Size(417, 35);
            this.pbLoad.TabIndex = 10;
            // 
            // btnReset
            // 
            this.btnReset.Location = new System.Drawing.Point(606, 428);
            this.btnReset.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.btnReset.Name = "btnReset";
            this.btnReset.Size = new System.Drawing.Size(112, 35);
            this.btnReset.TabIndex = 11;
            this.btnReset.Text = "Reset";
            this.btnReset.UseVisualStyleBackColor = true;
            this.btnReset.Click += new System.EventHandler(this.btnReset_Click);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(862, 149);
            this.button1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(112, 35);
            this.button1.TabIndex = 12;
            this.button1.Text = "Load Bios";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click_1);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(862, 194);
            this.button2.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(112, 35);
            this.button2.TabIndex = 13;
            this.button2.Text = "Load Rom";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(862, 102);
            this.button3.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(112, 35);
            this.button3.TabIndex = 14;
            this.button3.Text = "Load Pre Bios";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // button4
            // 
            this.button4.Location = new System.Drawing.Point(862, 23);
            this.button4.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(112, 35);
            this.button4.TabIndex = 15;
            this.button4.Text = "Test";
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // btnLoadGbs
            // 
            this.btnLoadGbs.Location = new System.Drawing.Point(862, 302);
            this.btnLoadGbs.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.btnLoadGbs.Name = "btnLoadGbs";
            this.btnLoadGbs.Size = new System.Drawing.Size(112, 35);
            this.btnLoadGbs.TabIndex = 16;
            this.btnLoadGbs.Text = "Load GBS";
            this.btnLoadGbs.UseVisualStyleBackColor = true;
            this.btnLoadGbs.Click += new System.EventHandler(this.btnLoadGbs_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(990, 482);
            this.Controls.Add(this.btnLoadGbs);
            this.Controls.Add(this.button4);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.btnReset);
            this.Controls.Add(this.pbLoad);
            this.Controls.Add(this.btn_sendFile);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.ddBaudRate);
            this.Controls.Add(this.btnCommListRefresh);
            this.Controls.Add(this.ddCommList);
            this.Controls.Add(this.btnSend);
            this.Controls.Add(this.tbSend);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.buttonStop);
            this.Controls.Add(this.buttonStart);
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.Name = "Form1";
            this.Text = "Form1";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonStart;
        private System.Windows.Forms.Button buttonStop;
        private System.Windows.Forms.TextBox textBox1;
        private System.IO.Ports.SerialPort serialPort1;
        private System.Windows.Forms.TextBox tbSend;
        private System.Windows.Forms.Button btnSend;
        private System.Windows.Forms.ComboBox ddCommList;
        private System.Windows.Forms.Button btnCommListRefresh;
        private System.Windows.Forms.ComboBox ddBaudRate;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btn_sendFile;
        private System.Windows.Forms.ProgressBar pbLoad;
        private System.Windows.Forms.Button btnReset;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Button btnLoadGbs;
    }
}

