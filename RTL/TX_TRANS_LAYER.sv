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
  input wire          clk,
  input wire          reset_n,
  
  //software interface
  AXI_W_IF.DST        axi_w_if,
  AXI_A_IF.DST        axi_aw_if,
  AXI_A_IF.DST        axi_ar_if,
  
  //data link layer interface
  output reg [63:0]   tlp_out,
  output reg          tlp_out_valid,
  input  reg          tlp_in_ready
  
);



    /*
    * FILL YOUR CODES HERE
    */

  
  
endmodule
