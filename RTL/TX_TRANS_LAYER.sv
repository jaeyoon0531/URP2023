// Create Date: 2023/05/08 16:54:14
// Design Name: 
// Module Name: TRANSACTION
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

module TX_TRANS_LAYER (
  input wire                    clk,
  input wire                    reset_n,
  
  //software interface
  AXI_W_IF.DST                  axi_w_if,
  AXI_A_IF.DST                  axi_aw_if,
  
  input  wire  [2:0]            header_fmt_i,
  input  wire  [4:0]            header_type_i,
  input  wire  [2:0]            header_tc_i,
  input  wire  [8:0]            header_length_i,
  input  wire  [15:0]           header_requestID_i,
  input  wire  [15:0]           header_completID_i,
   
  //data link layer interface
  output reg   [1023:0]         tlp_out,
  output reg                    tlp_out_valid,
  input  wire                   tlp_in_ready
  
);


    /*
    * FILL YOUR CODES HERE
    */
    // Packetizer / FIFO*2 / Arbiter
  
  
endmodule
