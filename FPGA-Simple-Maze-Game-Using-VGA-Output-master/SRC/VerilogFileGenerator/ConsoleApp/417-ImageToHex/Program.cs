using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace _417_ImageToHex
{
    class Program
    {
        static void Main(string[] args)
        {
            string INPUTFILE_R = @"C:\Users\Nathaniel\Desktop\maze\channelRed.csv";
            string INPUTFILE_G = @"C:\Users\Nathaniel\Desktop\maze\channelGreen.csv";
            string INPUTFILE_B = @"C:\Users\Nathaniel\Desktop\maze\channelBlue.csv";

            string OUTPUTFILE = @"C:\Users\Nathaniel\Desktop\maze\ImageMazeChannelValueROM.v";

            List<string> allResults = new List<string>();

            var channelR = File.ReadAllLines(INPUTFILE_R);
            var channelG = File.ReadAllLines(INPUTFILE_G);
            var channelB = File.ReadAllLines(INPUTFILE_B);

            for (int y = 0; y < channelR.Length; y++)
            {
                var rowR = channelR[y].Split(',');
                var rowG = channelG[y].Split(',');
                var rowB = channelB[y].Split(',');

                for (int x = 0; x < rowR.Length; x++)
                {
                    int R = int.Parse(rowR[x]) >> 5;
                    int G = int.Parse(rowG[x]) >> 5;
                    int B = int.Parse(rowB[x]) >> 6;

                    string results = string.Empty;
                    int memLocation = 800 * (y + 1) + x;

                    results += string.Format("CnR[{0}] = 3'b{1};\n", memLocation, Convert.ToString(R, 2).PadLeft(3, '0'));
                    results += string.Format("CnG[{0}] = 3'b{1};\n", memLocation, Convert.ToString(G, 2).PadLeft(3, '0'));
                    results += string.Format("CnB[{0}] = 2'b{1};\n", memLocation, Convert.ToString(B, 2).PadLeft(2, '0'));

                    allResults.Add(results);
                }
            }

            File.WriteAllText(OUTPUTFILE,
@"module ImageMazeChannelValueROM(
                             input [10:0] PixelX1,
                             input [10:0] PixelY1,

							 input [10:0] PixelX2,
                             input [10:0] PixelY2,

							 input [10:0] PixelX3,
                             input [10:0] PixelY3,

							 input [10:0] PixelX4,
                             input [10:0] PixelY4,

							 input [10:0] PixelX5,
                             input [10:0] PixelY5,

							 output [2:0] R1,
							 output [2:0] G1,
							 output [1:0] B1,

							 output [2:0] R2,
							 output [2:0] G2,
							 output [1:0] B2,

							 output [2:0] R3,
							 output [2:0] G3,
							 output [1:0] B3,

							 output [2:0] R4,
							 output [2:0] G4,
							 output [1:0] B4,

							 output [2:0] R5,
							 output [2:0] G5,
							 output [1:0] B5
);

    reg [2:0] CnR [0:800*800]; // 3-bit x,y pair
	reg [2:0] CnG [0:800*800]; // 3-bit x,y pair
	reg [1:0] CnB [0:800*800]; // 2-bit x,y pair	


	assign R1[2:0] = CnR[((1 + PixelY1)*800) + PixelX1];
	assign G1[2:0] = CnG[((1 + PixelY1)*800) + PixelX1];
	assign B1[1:0] = CnB[((1 + PixelY1)*800) + PixelX1];
	
	assign R2[2:0] = CnR[((1 + PixelY2)*800) + PixelX2];
	assign G2[2:0] = CnG[((1 + PixelY2)*800) + PixelX2];
	assign B2[1:0] = CnB[((1 + PixelY2)*800) + PixelX2];
	
	assign R3[2:0] = CnR[((1 + PixelY3)*800) + PixelX3];
	assign G3[2:0] = CnG[((1 + PixelY3)*800) + PixelX3];
	assign B3[1:0] = CnB[((1 + PixelY3)*800) + PixelX3];
	
	assign R4[2:0] = CnR[((1 + PixelY4)*800) + PixelX4];
	assign G4[2:0] = CnG[((1 + PixelY4)*800) + PixelX4];
	assign B4[1:0] = CnB[((1 + PixelY4)*800) + PixelX4];
	
	assign R5[2:0] = CnR[((1 + PixelY5)*800) + PixelX5];
	assign G5[2:0] = CnG[((1 + PixelY5)*800) + PixelX5];
	assign B5[1:0] = CnB[((1 + PixelY5)*800) + PixelX5];


	initial begin

" + string.Join("", allResults) +

  @"end

  endmodule");

        }
    }
}
