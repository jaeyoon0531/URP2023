`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 17:36:31
// Design Name: 
// Module Name: DATALINK
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


module TX_DATA_LINK_LAYER (
    input wire clk,
    input wire reset_n,
    
    // Transaction Layer interface
    input wire [31:0] tlp_data_in,
    input wire tlp_data_in_valid,
    output wire tlp_data_in_ready,
    
    // Physical Layer interface
    output wire [47:0] tlp_data_out,
    output wire tlp_data_out_valid,
    input wire tlp_data_out_ready,
    input wire ack,
    input wire nack
);

    
    /*
    * FILL YOUR CODES HERE
    */
    // LCRC 생성 / sequence number 생성 / Retry buffer

   

endmodule
