`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/09 22:26:09
// Design Name: 
// Module Name: RX_TRANS_LAYER
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


module RX_TRANS_LAYER (
  input wire clk,
  input wire reset_n,
  
  //data link layer interface
  input wire [31:0] tlp_data_in,
  input wire tlp_data_in_valid,
  output reg tlp_data_in_ready,
  
  //software interface
  AXI_R_IF.SRC                axi_r_if
);

  
    /*
    * FILL YOUR CODES HERE
    */ 
  
  
  
endmodule
