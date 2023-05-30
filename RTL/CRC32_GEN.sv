`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/31 01:41:30
// Design Name: 
// Module Name: CRC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module crc (
    input wire [31:0]               crcIn,
    input wire [31:0]               data,
    output reg [31:0]               crcOut
);
    
    assign crcOut[0] = crcIn[0] ^ crcIn[1] ^ crcIn[2] ^ crcIn[3] ^ crcIn[4] ^ crcIn[6] ^ crcIn[7] ^ crcIn[8] ^ crcIn[16] ^ crcIn[20] ^ crcIn[22] ^ crcIn[23] ^ crcIn[26] ^ data[0] ^ data[1] ^ data[2] ^ data[3] ^ data[4] ^ data[6] ^ data[7] ^ data[8] ^ data[16] ^ data[20] ^ data[22] ^ data[23] ^ data[26];
    assign crcOut[1] = crcIn[1] ^ crcIn[2] ^ crcIn[3] ^ crcIn[4] ^ crcIn[5] ^ crcIn[7] ^ crcIn[8] ^ crcIn[9] ^ crcIn[17] ^ crcIn[21] ^ crcIn[23] ^ crcIn[24] ^ crcIn[27] ^ data[1] ^ data[2] ^ data[3] ^ data[4] ^ data[5] ^ data[7] ^ data[8] ^ data[9] ^ data[17] ^ data[21] ^ data[23] ^ data[24] ^ data[27];
    assign crcOut[2] = crcIn[0] ^ crcIn[2] ^ crcIn[3] ^ crcIn[4] ^ crcIn[5] ^ crcIn[6] ^ crcIn[8] ^ crcIn[9] ^ crcIn[10] ^ crcIn[18] ^ crcIn[22] ^ crcIn[24] ^ crcIn[25] ^ crcIn[28] ^ data[0] ^ data[2] ^ data[3] ^ data[4] ^ data[5] ^ data[6] ^ data[8] ^ data[9] ^ data[10] ^ data[18] ^ data[22] ^ data[24] ^ data[25] ^ data[28];
    assign crcOut[3] = crcIn[1] ^ crcIn[3] ^ crcIn[4] ^ crcIn[5] ^ crcIn[6] ^ crcIn[7] ^ crcIn[9] ^ crcIn[10] ^ crcIn[11] ^ crcIn[19] ^ crcIn[23] ^ crcIn[25] ^ crcIn[26] ^ crcIn[29] ^ data[1] ^ data[3] ^ data[4] ^ data[5] ^ data[6] ^ data[7] ^ data[9] ^ data[10] ^ data[11] ^ data[19] ^ data[23] ^ data[25] ^ data[26] ^ data[29];
    assign crcOut[4] = crcIn[2] ^ crcIn[4] ^ crcIn[5] ^ crcIn[6] ^ crcIn[7] ^ crcIn[8] ^ crcIn[10] ^ crcIn[11] ^ crcIn[12] ^ crcIn[20] ^ crcIn[24] ^ crcIn[26] ^ crcIn[27] ^ crcIn[30] ^ data[2] ^ data[4] ^ data[5] ^ data[6] ^ data[7] ^ data[8] ^ data[10] ^ data[11] ^ data[12] ^ data[20] ^ data[24] ^ data[26] ^ data[27] ^ data[30];
    assign crcOut[5] = crcIn[0] ^ crcIn[3] ^ crcIn[5] ^ crcIn[6] ^ crcIn[7] ^ crcIn[8] ^ crcIn[9] ^ crcIn[11] ^ crcIn[12] ^ crcIn[13] ^ crcIn[21] ^ crcIn[25] ^ crcIn[27] ^ crcIn[28] ^ crcIn[31] ^ data[0] ^ data[3] ^ data[5] ^ data[6] ^ data[7] ^ data[8] ^ data[9] ^ data[11] ^ data[12] ^ data[13] ^ data[21] ^ data[25] ^ data[27] ^ data[28] ^ data[31];
    assign crcOut[6] = crcIn[0] ^ crcIn[2] ^ crcIn[3] ^ crcIn[9] ^ crcIn[10] ^ crcIn[12] ^ crcIn[13] ^ crcIn[14] ^ crcIn[16] ^ crcIn[20] ^ crcIn[23] ^ crcIn[28] ^ crcIn[29] ^ data[0] ^ data[2] ^ data[3] ^ data[9] ^ data[10] ^ data[12] ^ data[13] ^ data[14] ^ data[16] ^ data[20] ^ data[23] ^ data[28] ^ data[29];
    assign crcOut[7] = crcIn[1] ^ crcIn[3] ^ crcIn[4] ^ crcIn[10] ^ crcIn[11] ^ crcIn[13] ^ crcIn[14] ^ crcIn[15] ^ crcIn[17] ^ crcIn[21] ^ crcIn[24] ^ crcIn[29] ^ crcIn[30] ^ data[1] ^ data[3] ^ data[4] ^ data[10] ^ data[11] ^ data[13] ^ data[14] ^ data[15] ^ data[17] ^ data[21] ^ data[24] ^ data[29] ^ data[30];
    assign crcOut[8] = crcIn[0] ^ crcIn[2] ^ crcIn[4] ^ crcIn[5] ^ crcIn[11] ^ crcIn[12] ^ crcIn[14] ^ crcIn[15] ^ crcIn[16] ^ crcIn[18] ^ crcIn[22] ^ crcIn[25] ^ crcIn[30] ^ crcIn[31] ^ data[0] ^ data[2] ^ data[4] ^ data[5] ^ data[11] ^ data[12] ^ data[14] ^ data[15] ^ data[16] ^ data[18] ^ data[22] ^ data[25] ^ data[30] ^ data[31];
    assign crcOut[9] = crcIn[0] ^ crcIn[2] ^ crcIn[4] ^ crcIn[5] ^ crcIn[7] ^ crcIn[8] ^ crcIn[12] ^ crcIn[13] ^ crcIn[15] ^ crcIn[17] ^ crcIn[19] ^ crcIn[20] ^ crcIn[22] ^ crcIn[31] ^ data[0] ^ data[2] ^ data[4] ^ data[5] ^ data[7] ^ data[8] ^ data[12] ^ data[13] ^ data[15] ^ data[17] ^ data[19] ^ data[20] ^ data[22] ^ data[31];
    assign crcOut[10] = crcIn[0] ^ crcIn[2] ^ crcIn[4] ^ crcIn[5] ^ crcIn[7] ^ crcIn[9] ^ crcIn[13] ^ crcIn[14] ^ crcIn[18] ^ crcIn[21] ^ crcIn[22] ^ crcIn[26] ^ data[0] ^ data[2] ^ data[4] ^ data[5] ^ data[7] ^ data[9] ^ data[13] ^ data[14] ^ data[18] ^ data[21] ^ data[22] ^ data[26];
    assign crcOut[11] = crcIn[1] ^ crcIn[3] ^ crcIn[5] ^ crcIn[6] ^ crcIn[8] ^ crcIn[10] ^ crcIn[14] ^ crcIn[15] ^ crcIn[19] ^ crcIn[22] ^ crcIn[23] ^ crcIn[27] ^ data[1] ^ data[3] ^ data[5] ^ data[6] ^ data[8] ^ data[10] ^ data[14] ^ data[15] ^ data[19] ^ data[22] ^ data[23] ^ data[27];
    assign crcOut[12] = crcIn[2] ^ crcIn[4] ^ crcIn[6] ^ crcIn[7] ^ crcIn[9] ^ crcIn[11] ^ crcIn[15] ^ crcIn[16] ^ crcIn[20] ^ crcIn[23] ^ crcIn[24] ^ crcIn[28] ^ data[2] ^ data[4] ^ data[6] ^ data[7] ^ data[9] ^ data[11] ^ data[15] ^ data[16] ^ data[20] ^ data[23] ^ data[24] ^ data[28];
    assign crcOut[13] = crcIn[0] ^ crcIn[3] ^ crcIn[5] ^ crcIn[7] ^ crcIn[8] ^ crcIn[10] ^ crcIn[12] ^ crcIn[16] ^ crcIn[17] ^ crcIn[21] ^ crcIn[24] ^ crcIn[25] ^ crcIn[29] ^ data[0] ^ data[3] ^ data[5] ^ data[7] ^ data[8] ^ data[10] ^ data[12] ^ data[16] ^ data[17] ^ data[21] ^ data[24] ^ data[25] ^ data[29];
    assign crcOut[14] = crcIn[0] ^ crcIn[1] ^ crcIn[4] ^ crcIn[6] ^ crcIn[8] ^ crcIn[9] ^ crcIn[11] ^ crcIn[13] ^ crcIn[17] ^ crcIn[18] ^ crcIn[22] ^ crcIn[25] ^ crcIn[26] ^ crcIn[30] ^ data[0] ^ data[1] ^ data[4] ^ data[6] ^ data[8] ^ data[9] ^ data[11] ^ data[13] ^ data[17] ^ data[18] ^ data[22] ^ data[25] ^ data[26] ^ data[30];
    assign crcOut[15] = crcIn[1] ^ crcIn[2] ^ crcIn[5] ^ crcIn[7] ^ crcIn[9] ^ crcIn[10] ^ crcIn[12] ^ crcIn[14] ^ crcIn[18] ^ crcIn[19] ^ crcIn[23] ^ crcIn[26] ^ crcIn[27] ^ crcIn[31] ^ data[1] ^ data[2] ^ data[5] ^ data[7] ^ data[9] ^ data[10] ^ data[12] ^ data[14] ^ data[18] ^ data[19] ^ data[23] ^ data[26] ^ data[27] ^ data[31];
    assign crcOut[16] = crcIn[1] ^ crcIn[4] ^ crcIn[7] ^ crcIn[10] ^ crcIn[11] ^ crcIn[13] ^ crcIn[15] ^ crcIn[16] ^ crcIn[19] ^ crcIn[22] ^ crcIn[23] ^ crcIn[24] ^ crcIn[26] ^ crcIn[27] ^ crcIn[28] ^ data[1] ^ data[4] ^ data[7] ^ data[10] ^ data[11] ^ data[13] ^ data[15] ^ data[16] ^ data[19] ^ data[22] ^ data[23] ^ data[24] ^ data[26] ^ data[27] ^ data[28];
    assign crcOut[17] = crcIn[2] ^ crcIn[5] ^ crcIn[8] ^ crcIn[11] ^ crcIn[12] ^ crcIn[14] ^ crcIn[16] ^ crcIn[17] ^ crcIn[20] ^ crcIn[23] ^ crcIn[24] ^ crcIn[25] ^ crcIn[27] ^ crcIn[28] ^ crcIn[29] ^ data[2] ^ data[5] ^ data[8] ^ data[11] ^ data[12] ^ data[14] ^ data[16] ^ data[17] ^ data[20] ^ data[23] ^ data[24] ^ data[25] ^ data[27] ^ data[28] ^ data[29];
    assign crcOut[18] = crcIn[0] ^ crcIn[3] ^ crcIn[6] ^ crcIn[9] ^ crcIn[12] ^ crcIn[13] ^ crcIn[15] ^ crcIn[17] ^ crcIn[18] ^ crcIn[21] ^ crcIn[24] ^ crcIn[25] ^ crcIn[26] ^ crcIn[28] ^ crcIn[29] ^ crcIn[30] ^ data[0] ^ data[3] ^ data[6] ^ data[9] ^ data[12] ^ data[13] ^ data[15] ^ data[17] ^ data[18] ^ data[21] ^ data[24] ^ data[25] ^ data[26] ^ data[28] ^ data[29] ^ data[30];
    assign crcOut[19] = crcIn[0] ^ crcIn[1] ^ crcIn[4] ^ crcIn[7] ^ crcIn[10] ^ crcIn[13] ^ crcIn[14] ^ crcIn[16] ^ crcIn[18] ^ crcIn[19] ^ crcIn[22] ^ crcIn[25] ^ crcIn[26] ^ crcIn[27] ^ crcIn[29] ^ crcIn[30] ^ crcIn[31] ^ data[0] ^ data[1] ^ data[4] ^ data[7] ^ data[10] ^ data[13] ^ data[14] ^ data[16] ^ data[18] ^ data[19] ^ data[22] ^ data[25] ^ data[26] ^ data[27] ^ data[29] ^ data[30] ^ data[31];
    assign crcOut[20] = crcIn[0] ^ crcIn[3] ^ crcIn[4] ^ crcIn[5] ^ crcIn[6] ^ crcIn[7] ^ crcIn[11] ^ crcIn[14] ^ crcIn[15] ^ crcIn[16] ^ crcIn[17] ^ crcIn[19] ^ crcIn[22] ^ crcIn[27] ^ crcIn[28] ^ crcIn[30] ^ crcIn[31] ^ data[0] ^ data[3] ^ data[4] ^ data[5] ^ data[6] ^ data[7] ^ data[11] ^ data[14] ^ data[15] ^ data[16] ^ data[17] ^ data[19] ^ data[22] ^ data[27] ^ data[28] ^ data[30] ^ data[31];
    assign crcOut[21] = crcIn[0] ^ crcIn[2] ^ crcIn[3] ^ crcIn[5] ^ crcIn[12] ^ crcIn[15] ^ crcIn[17] ^ crcIn[18] ^ crcIn[22] ^ crcIn[26] ^ crcIn[28] ^ crcIn[29] ^ crcIn[31] ^ data[0] ^ data[2] ^ data[3] ^ data[5] ^ data[12] ^ data[15] ^ data[17] ^ data[18] ^ data[22] ^ data[26] ^ data[28] ^ data[29] ^ data[31];
    assign crcOut[22] = crcIn[2] ^ crcIn[7] ^ crcIn[8] ^ crcIn[13] ^ crcIn[18] ^ crcIn[19] ^ crcIn[20] ^ crcIn[22] ^ crcIn[26] ^ crcIn[27] ^ crcIn[29] ^ crcIn[30] ^ data[2] ^ data[7] ^ data[8] ^ data[13] ^ data[18] ^ data[19] ^ data[20] ^ data[22] ^ data[26] ^ data[27] ^ data[29] ^ data[30];
    assign crcOut[23] = crcIn[0] ^ crcIn[3] ^ crcIn[8] ^ crcIn[9] ^ crcIn[14] ^ crcIn[19] ^ crcIn[20] ^ crcIn[21] ^ crcIn[23] ^ crcIn[27] ^ crcIn[28] ^ crcIn[30] ^ crcIn[31] ^ data[0] ^ data[3] ^ data[8] ^ data[9] ^ data[14] ^ data[19] ^ data[20] ^ data[21] ^ data[23] ^ data[27] ^ data[28] ^ data[30] ^ data[31];
    assign crcOut[24] = crcIn[2] ^ crcIn[3] ^ crcIn[6] ^ crcIn[7] ^ crcIn[8] ^ crcIn[9] ^ crcIn[10] ^ crcIn[15] ^ crcIn[16] ^ crcIn[21] ^ crcIn[23] ^ crcIn[24] ^ crcIn[26] ^ crcIn[28] ^ crcIn[29] ^ crcIn[31] ^ data[2] ^ data[3] ^ data[6] ^ data[7] ^ data[8] ^ data[9] ^ data[10] ^ data[15] ^ data[16] ^ data[21] ^ data[23] ^ data[24] ^ data[26] ^ data[28] ^ data[29] ^ data[31];
    assign crcOut[25] = crcIn[1] ^ crcIn[2] ^ crcIn[6] ^ crcIn[9] ^ crcIn[10] ^ crcIn[11] ^ crcIn[17] ^ crcIn[20] ^ crcIn[23] ^ crcIn[24] ^ crcIn[25] ^ crcIn[26] ^ crcIn[27] ^ crcIn[29] ^ crcIn[30] ^ data[1] ^ data[2] ^ data[6] ^ data[9] ^ data[10] ^ data[11] ^ data[17] ^ data[20] ^ data[23] ^ data[24] ^ data[25] ^ data[26] ^ data[27] ^ data[29] ^ data[30];
    assign crcOut[26] = crcIn[2] ^ crcIn[3] ^ crcIn[7] ^ crcIn[10] ^ crcIn[11] ^ crcIn[12] ^ crcIn[18] ^ crcIn[21] ^ crcIn[24] ^ crcIn[25] ^ crcIn[26] ^ crcIn[27] ^ crcIn[28] ^ crcIn[30] ^ crcIn[31] ^ data[2] ^ data[3] ^ data[7] ^ data[10] ^ data[11] ^ data[12] ^ data[18] ^ data[21] ^ data[24] ^ data[25] ^ data[26] ^ data[27] ^ data[28] ^ data[30] ^ data[31];
    assign crcOut[27] = crcIn[0] ^ crcIn[1] ^ crcIn[2] ^ crcIn[6] ^ crcIn[7] ^ crcIn[11] ^ crcIn[12] ^ crcIn[13] ^ crcIn[16] ^ crcIn[19] ^ crcIn[20] ^ crcIn[23] ^ crcIn[25] ^ crcIn[27] ^ crcIn[28] ^ crcIn[29] ^ crcIn[31] ^ data[0] ^ data[1] ^ data[2] ^ data[6] ^ data[7] ^ data[11] ^ data[12] ^ data[13] ^ data[16] ^ data[19] ^ data[20] ^ data[23] ^ data[25] ^ data[27] ^ data[28] ^ data[29] ^ data[31];
    assign crcOut[28] = crcIn[0] ^ crcIn[4] ^ crcIn[6] ^ crcIn[12] ^ crcIn[13] ^ crcIn[14] ^ crcIn[16] ^ crcIn[17] ^ crcIn[21] ^ crcIn[22] ^ crcIn[23] ^ crcIn[24] ^ crcIn[28] ^ crcIn[29] ^ crcIn[30] ^ data[0] ^ data[4] ^ data[6] ^ data[12] ^ data[13] ^ data[14] ^ data[16] ^ data[17] ^ data[21] ^ data[22] ^ data[23] ^ data[24] ^ data[28] ^ data[29] ^ data[30];
    assign crcOut[29] = crcIn[0] ^ crcIn[1] ^ crcIn[5] ^ crcIn[7] ^ crcIn[13] ^ crcIn[14] ^ crcIn[15] ^ crcIn[17] ^ crcIn[18] ^ crcIn[22] ^ crcIn[23] ^ crcIn[24] ^ crcIn[25] ^ crcIn[29] ^ crcIn[30] ^ crcIn[31] ^ data[0] ^ data[1] ^ data[5] ^ data[7] ^ data[13] ^ data[14] ^ data[15] ^ data[17] ^ data[18] ^ data[22] ^ data[23] ^ data[24] ^ data[25] ^ data[29] ^ data[30] ^ data[31];
    assign crcOut[30] = crcIn[3] ^ crcIn[4] ^ crcIn[7] ^ crcIn[14] ^ crcIn[15] ^ crcIn[18] ^ crcIn[19] ^ crcIn[20] ^ crcIn[22] ^ crcIn[24] ^ crcIn[25] ^ crcIn[30] ^ crcIn[31] ^ data[3] ^ data[4] ^ data[7] ^ data[14] ^ data[15] ^ data[18] ^ data[19] ^ data[20] ^ data[22] ^ data[24] ^ data[25] ^ data[30] ^ data[31];
    assign crcOut[31] = crcIn[0] ^ crcIn[1] ^ crcIn[2] ^ crcIn[3] ^ crcIn[5] ^ crcIn[6] ^ crcIn[7] ^ crcIn[15] ^ crcIn[19] ^ crcIn[21] ^ crcIn[22] ^ crcIn[25] ^ crcIn[31] ^ data[0] ^ data[1] ^ data[2] ^ data[3] ^ data[5] ^ data[6] ^ data[7] ^ data[15] ^ data[19] ^ data[21] ^ data[22] ^ data[25] ^ data[31];

endmodule
