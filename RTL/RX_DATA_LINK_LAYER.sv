`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/09 22:26:09
// Design Name: 
// Module Name: RX_DATA_LINK_LAYER
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


module RX_DATA_LINK_LAYER(
    input  wire                 clk,
    input  wire                 reset_n,
    
    // Physical Layer interface
    input  wire [1023:0]        tlp_data_in,
    input  wire                 tlp_data_in_valid,
    input  wire                 dllp_ready,
    output reg                  tlp_data_out_ready,
    output reg  [31:0]          dllp,
    output reg                  dllp_valid,
    
    
    // Transaction Layer interface
    output reg [1023:0]         tlp_data_out,
    output reg                  tlp_data_out_valid,
    input  wire                 tlp_data_in_ready
    );
    

    
    /*
    * FILL YOUR CODES HERE
    */
    // LCRC 체크 / sequence number 체크 / DLLP 생성



endmodule
