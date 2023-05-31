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
    input   wire                     clk,
    input   wire                     reset_n,
    
    // Data Link Layer Interface
    input   wire    [1023:0]         rx_tlp_data,
    input   wire                     rx_tlp_valid,
    input   wire                     dllp_ready,
    output  wire                     rx_tlp_ready,
    output  wire    [31:0]           dllp_o,
    output  wire                     dllp_valid,
    
    // Transaction Layer Interface
    //AXI_R_IF.SRC                axi_r_if,
    output  wire    [2:0]           header_fmt_o,
    output  wire    [4:0]           header_type_o,
    output  wire    [2:0]           header_tc_o,
    output  wire    [8:0]           header_length_o,
    output  wire    [15:0]          header_requestID_o,
    output  wire    [15:0]          header_completID_o,
    
    output  wire    [1023:0]        data_out,
    output  wire    [31:0]          addr_out
        
);

    wire    [1023:0]                out_data_dll;
    wire                            out_valid_dll;
    wire                            in_ready_dll;                 
 
 
    // Instantiate Data Link Layer
    RX_DATA_LINK_LAYER              u_dll_layer (
        .clk                        (clk),
        .reset_n                    (reset_n),
        
        //RX interface
        .tlp_data_in                (rx_tlp_data),
        .tlp_data_in_valid          (rx_tlp_valid),
        .tlp_data_out_ready         (rx_tlp_ready),
        .dllp                       (dllp_o),

        //transaction interface
        .tlp_data_out               (out_data_dll),
        .tlp_data_out_valid         (out_valid_dll),
        .tlp_data_in_ready          (in_ready_dll)
                       
    );
 
    // Instantiate Transaction Layer
    RX_TRANS_LAYER                  u_trans_layer (
        .clk                        (clk),
        .reset_n                    (reset_n),
        
        //data link layer interface
        .tlp_data_in                (out_data_dll),
        .tlp_data_in_valid          (out_valid_dll),
        .tlp_data_out_ready         (in_ready_dll),
        
        //software interface
        //.axi_r_if(axi_r_if)
        .header_fmt_o               (header_fmt_o),
        .header_type_o              (header_type_o),
        .header_tc_o                (header_tc_o),
        .header_length_o            (header_length_o),
        .header_requestID_o         (header_requestID_o),
        .header_completID_o         (header_completID_o),
        .data_out                   (data_out),
        .addr_out                   (addr_out)
                                 
    );
    
    
    
    
endmodule
