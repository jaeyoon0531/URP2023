`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/16 16:07:53
// Design Name: 
// Module Name: PCIe
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


module PCIe
(
    // clock & reset
    input                           clk,
    input                           rst_n,

    // APB interface
    APB_IF.SLV                      apb_if,

    // AXI interface
    AXI_A_IF.DST                    axi_ar_if,
    AXI_A_IF.DST                    axi_aw_if,
    AXI_W_IF.DST                    axi_w_if,
    
    AXI_B_IF.SRC                    axi_b_if,
    AXI_R_IF.SRC                    axi_r_if,
    
    //OUTPUT
    output  wire    [2:0]           header_fmt_o,
    output  wire    [4:0]           header_type_o,
    output  wire    [2:0]           header_tc_o,
    output  wire    [8:0]           header_length_o,
    output  wire    [15:0]          header_requestID_o,
    output  wire    [15:0]          header_completID_o,
    output  wire    [1023:0]        data_out,
    output  wire    [31:0]          addr_out
    
    );
    
    //=========================================================
    //  CFG ~ TX
    //=========================================================
    wire    [2:0]                   header_fmt;
    wire    [4:0]                   header_type;
    wire    [2:0]                   header_tc;
    wire    [8:0]                   header_length;
    wire    [15:0]                  header_requestID;
    wire    [15:0]                  header_completID; 
    wire                            start_vec;
    wire                            done_vec;
    
    //=========================================================
    //  Tx ~ RX
    //=========================================================
    wire    [1023:0]                out_TX_to_RX;
    wire                            out_valid_TX_to_RX;
    wire                            in_ready_RX_to_TX;
    wire    [31:0]                  dllp;
    wire                            dllp_valid;
    wire                            dllp_ready;
    
    
    

    SAL_CFG                         u_cfg
    (
        .clk                        (clk),
        .rst_n                      (rst_n),

        .apb_if                     (apb_if),
        
        .header_fmt_c               (header_fmt),
        .header_type_c              (header_type),
        .header_tc_c                (header_tc),
        .header_length_c            (header_length),
        .header_requestID_c         (header_requestID),
        .header_completID_c         (header_completID),
        .ch0_start_o                (start_vec)
    );
    
    
    TX                              u_tx (
        .clk                        (clk),
        .reset_n                    (rst_n),
        
        // Transaction Layer Interface
        .axi_w_if                   (axi_w_if),
        .axi_aw_if                  (axi_aw_if),

        .header_fmt_i               (header_fmt),
        .header_type_i              (header_type),
        .header_tc_i                (header_tc),
        .header_length_i            (header_length),
        .header_requestID_i         (header_requestID),
        .header_completID_i         (header_completID),
        
        //.apb_if                     (apb_if),
        
        // Data Link Layer Interface
        .rx_tlp_data                (out_TX_to_RX),
        .rx_tlp_valid               (out_valid_TX_to_RX),
        .rx_tlp_ready               (in_ready_RX_to_TX),
        .dllp_i                     (dllp),
        .dllp_ready                 (dllp_ready),
        .dllp_valid                 (dllp_valid)
        
    );
    
    
    RX                              u_rx (
        .clk                        (clk),
        .reset_n                    (rst_n),
        
        // Data Link Layer Interface
        .rx_tlp_data                (out_TX_to_RX),
        .rx_tlp_valid               (out_valid_TX_to_RX),
        .rx_tlp_ready               (in_ready_RX_to_TX),
        .dllp_o                     (dllp),
        .dllp_valid                 (dllp_valid),
        .dllp_ready                 (dllp_ready),
        
        // Transaction Layer Interface
        //.axi_r_if                   (axi_r_if),
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
