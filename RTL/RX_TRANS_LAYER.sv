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
    input wire                      clk,
    input wire                      reset_n,
  
   //data link layer interface
    input wire     [1023:0]         tlp_data_in,
    input wire                      tlp_data_in_valid,
    output reg                      tlp_data_out_ready,
  
    //software interface
    //AXI_R_IF.SRC                axi_r_if   
    output reg     [2:0]            header_fmt_o,
    output reg     [4:0]            header_type_o,
    output reg     [2:0]            header_tc_o,
    output reg     [8:0]            header_length_o,
    output reg     [15:0]           header_requestID_o,
    output reg     [15:0]           header_completID_o,
    output reg     [1023:0]         data_out,
    output reg     [31:0]           addr_out
);

  
    /*
    * FILL YOUR CODES HERE
    */ 
    // FIFO*2 / Arbiter / De_Packetizer 
  
  
endmodule
