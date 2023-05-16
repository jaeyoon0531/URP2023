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
    APB_IF.DST                      apb_if,

    // AXI interface
    AXI_A_IF.DST                    axi_ar_if,
    AXI_A_IF.DST                    axi_aw_if,
    AXI_W_IF.DST                    axi_w_if,
    AXI_B_IF.SRC                    axi_b_if,
    AXI_R_IF.SRC                    axi_r_if
    
    );
    
    //=========================================================
    //  Tx ~ RX
    //=========================================================
    wire [31:0]                     out_TX_to_RX;
    wire                            out_valid_TX_to_RX;
    wire                            in_ready_RX_to_TX;   
    wire                            ack;
    wire                            nack;
    
    wire    [2:0]                   header_fmt;
    wire    [4:0]                   header_type;
    wire    [2:0]                   header_tc;
    wire    [8:0]                   header_length;
    wire    [15:0]                  header_requestID;
    wire    [15:0]                  header_completID; 
    wire                            start_vec;
    wire                            done_vec;
    
 
    SAL_CFG                         u_cfg
    (
        .clk                        (clk),
        .rst_n                      (rst_n),

        .apb_if                     (apb_if),
        
        .header_fmt_o               (src_addr_vec),
        .header_type_o              (dst_addr_vec),
        .header_tc_o                (byte_len_vec),
        .header_length_o            (header_length),
        .header_requestID_o         (header_requestID),
        .header_completID_o         (header_completID),
        .ch0_start_o                (start_vec),
        .ch0_done_i                 (done_vec)
    );
    
    
    TX                              u_tx (
        .clk                        (clk),
        .reset_n                    (rst_n),
    // Transaction Layer Interface
        .axi_w_if                   (axi_w_if),
        .axi_aw_if                  (axi_aw_if),
        .axi_ar_if                  (axi_ar_if),
        
        //.apb_if                     (apb_if),
        
    // Data Link Layer Interface
        .rx_tlp_data                (out_TX_to_RX),
        .rx_tlp_valid               (out_valid_TX_to_RX),
        .rx_tlp_ready               (in_ready_RX_to_TX),
        .ack                        (ack),
        .nack                       (nack)
    );
    
    
    RX                              u_rx (
        .clk                        (clk),
        .reset_n                    (rst_n),
        
    // Data Link Layer Interface
        .rx_tlp_data                (out_TX_to_RX),
        .rx_tlp_valid               (out_valid_TX_to_RX),
        .rx_tlp_ready               (in_ready_RX_to_TX),
        .ack                        (ack),
        .nack                       (nack),
        
    // Transaction Layer Interface
        .axi_r_if                   (axi_r_if) 
    );  
    
    
    
endmodule  
