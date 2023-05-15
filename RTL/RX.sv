`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 18:25:58
// Design Name: 
// Module Name: RX
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


module RX (
    input wire clk,
    input wire reset_n,
    
    // Data Link Layer Interface
    input wire [31:0] rx_tlp_data,
    input wire rx_tlp_valid,
    output wire rx_tlp_ready,
    output wire ack,
    output wire nack,
    
    // Transaction Layer Interface
    AXI_R_IF.SRC                axi_r_if
);

    wire [31:0]             out_data_dll;
    wire                    out_valid_dll;
    wire                    in_ready_dll;                 
 
 
    // Instantiate Data Link Layer
    RX_DATA_LINK_LAYER    u_dll_layer (
        .clk(clk),
        .reset_n(reset_n),
        
        //RX interface
        .tlp_data_in(rx_tlp_data),
        .tlp_data_in_valid(rx_tlp_valid),
        .tlp_data_in_ready(rx_tlp_ready),
        .ack(ack),
        .nack(nack),
        
        //transaction interface
        .tlp_data_out(out_data_dll),
        .tlp_data_out_valid(out_valid_dll),
        .tlp_data_out_ready(in_ready_dll)                  
    );
 
    // Instantiate Transaction Layer
    RX_TRANS_LAYER        u_trans_layer (
        .clk(clk),
        .reset_n(reset_n),
        
        //data link layer interface
        .tlp_data_in(out_data_dll),
        .tlp_data_in_valid(out_valid_dll),
        .tlp_data_in_ready(in_ready_dll),
        
        //software interface
        .axi_r_if(axi_r_if)              
    );
    
    
    
    
endmodule
