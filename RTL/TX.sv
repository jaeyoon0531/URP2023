`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 18:25:43
// Design Name: 
// Module Name: TX
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

module TX (
    input wire              clk,
    input wire              reset_n,
    // Transaction Layer Interface
    AXI_W_IF.DST            axi_w_if,
    AXI_A_IF.DST            axi_aw_if,
    AXI_A_IF.DST            axi_ar_if,
    
     
    // Data Link Layer Interface
    output wire [31:0]      rx_tlp_data,
    output wire             rx_tlp_valid,
    input wire              rx_tlp_ready,
    input wire              ack,
    input wire              nack
    
);

    wire [31:0]             out_data_trans;
    wire                    out_valid_trans;
    wire                    in_ready_trans;                 
 
 
    // Instantiate Transaction Layer
    TX_TRANS_LAYER        u_trans_layer (
        .clk(clk),
        .reset_n(reset_n),
        
        //software interface
        .axi_w_if(axi_w_if),
        .axi_aw_if(axi_aw_if),
        .axi_ar_if(axi_ar_if),
                
        //data link layer interface
        .tlp_out(out_data_trans),
        .tlp_out_valid(out_valid_trans),
        .tlp_in_ready(in_ready_trans)
    );

    // Instantiate Data Link Layer
    TX_DATA_LINK_LAYER    u_dll_layer (
        .clk(clk),
        .reset_n(reset_n),
        
        //transaction interface
        .tlp_data_in(out_data_trans),
        .tlp_data_in_valid(out_valid_trans),
        .tlp_data_in_ready(in_ready_trans),
        
        //RX interface
        .tlp_data_out(rx_tlp_data),
        .tlp_data_out_valid(rx_tlp_valid),
        .tlp_data_out_ready(rx_tlp_ready),
        .ack(ack),
        .nack(nack)
    );

endmodule
