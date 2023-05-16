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
    
    wire    [31:0]                  src_addr_vec;
    wire    [31:0]                  dst_addr_vec;
    wire    [15:0]                  byte_len_vec;
    wire                            start_vec;
    wire                            done_vec;
    
 
    SAL_CFG                         u_cfg
    (
        .clk                        (clk),
        .rst_n                      (rst_n),

        .apb_if                     (apb_if),
        
        .ch0_src_addr_o             (src_addr_vec),
        .ch0_dst_addr_o             (dst_addr_vec),
        .ch0_byte_len_o             (byte_len_vec),
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
