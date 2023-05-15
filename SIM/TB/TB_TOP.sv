`include "TIME_SCALE.svh"
`include "PARAMS.svh"
`define PARAM   32

module TOP;

    logic                       clk;
    logic                       rst_n;

    // clock generation
    initial begin
        clk                         = 1'b0;
        forever
            #(`CLK_PERIOD/2) clk         = ~clk;
    end

    // reset generation
    initial begin
        
        rst_n                       = 1'b0;
        repeat (3) @(posedge clk);
        
        rst_n                       = 1'b1;
    end
    
    //APB_IF                          apb_if      (.clk(clk), .rst_n(rst_n));

    // AXI interface    
    AXI_A_IF                        axi_ar_if   (.clk(clk), .rst_n(rst_n));
    AXI_R_IF                        axi_r_if    (.clk(clk), .rst_n(rst_n));
    AXI_A_IF                        axi_aw_if   (.clk(clk), .rst_n(rst_n));
    AXI_W_IF                        axi_w_if    (.clk(clk), .rst_n(rst_n));
    AXI_B_IF                        axi_b_if    (.clk(clk), .rst_n(rst_n));
    
    

    axi_id_t                        simple_id;
    axi_id_t                        rid;
    axi_resp_t                      rresp;
 

    //=========================================================
    //  Tx ~ RX
    //=========================================================
    wire [31:0]             out_TX_to_RX;
    wire                    out_valid_TX_to_RX;
    wire                    in_ready_RX_to_TX;   
    wire                    ack;
    wire                    nack;
    
    
    
    TX              u_tx (
        .clk(clk),
        .reset_n(reset_n),
    // Transaction Layer Interface
        .axi_w_if(axi_w_if),
        .axi_aw_if(axi_aw_if),
        .axi_ar_if(axi_ar_if),
        
    
    // Data Link Layer Interface
        .rx_tlp_data(out_TX_to_RX),
        .rx_tlp_valid(out_valid_TX_to_RX),
        .rx_tlp_ready(in_ready_RX_to_TX),
        .ack(ack),
        .nack(nack)
    );
    
    
    RX              u_rx (
        .clk(clk),
        .reset_n(reset_n),
        
    // Data Link Layer Interface
        .rx_tlp_data(out_TX_to_RX),
        .rx_tlp_valid(out_valid_TX_to_RX),
        .rx_tlp_ready(in_ready_RX_to_TX),
        .ack(ack),
        .nack(nack),
        
    // Transaction Layer Interface
        .axi_r_if(axi_r_if),
             
    );        
    
    
    task init();
        axi_aw_if.init();
        axi_w_if.init();
        axi_b_if.init();
        axi_ar_if.init();
        axi_r_if.init();

        // wait for a reset release
        @(posedge rst_n);

        // wait enough cycles for DRAM to finish their initialization
        repeat (250) @(posedge clk);
    endtask

    logic       [`AXI_ID_WIDTH-1:0]     simple_id;
    assign  simple_id                   = 'd0;


    //AW,W TLP
    task automatic write32B(
        //AW
        input [`AXI_ADDR_WIDTH-1:0] addr,
        //W
        input [255:0]               data
    );
        logic   [`AXI_ID_WIDTH-1:0] rid;
        logic   [1:0]               rresp;

        // drive to AW and W
        fork
            //AW
            begin
                axi_aw_if.transfer(simple_id, addr, 'd1, `AXI_SIZE_128, `AXI_BURST_INCR);
            end
            //W
            begin
                axi_w_if.transfer(simple_id, data[127:0], 16'hFFFF, 1'b0);
                axi_w_if.transfer(simple_id, data[255:128], 16'hFFFF, 1'b1);
            end
        join

        // receive from B
        axi_b_if.receive(rid, rresp);

        // check responses
        if (rid!==simple_id) begin $display("ID mismatch (expected: %d, received: %d)", simple_id, rid); $finish; end
        if (rresp!==2'b00) begin $display("Non-OK response (received: %d)", rresp); $finish; end
    endtask

    //R TLP
    task automatic read32B(
        input [`AXI_ADDR_WIDTH-1:0] addr,
        output [255:0]              data
    );
        logic   [`AXI_ID_WIDTH-1:0] rid;
        logic   [1:0]               rresp;
        logic                       rlast;

        // drive to AR
        axi_ar_if.transfer(simple_id, addr, 'd1, `AXI_SIZE_128, `AXI_BURST_INCR);

        // receive from R
        axi_r_if.receive(rid, data, rresp, rlast);
        if (rlast!==1'b0) begin $display("RLAST mismatch (expected: %d, received: %d)", 0, rlast); $finish; end
        if (rid!==simple_id) begin $display("ID mismatch (expected: %d, received: %d)", simple_id, rid); $finish; end
        if (rresp!==2'b00) begin $display("Non-OK response (received: %d)", rresp); $finish; end

    endtask


    logic   [255:0]             data;
    initial begin
        init();
        //AW,W
        write32B('d0,   {8{32'h01234567}});
        write32B('d32,  {8{32'h01234567}});
        
        //AR
        read32B('d0, data);
        read32B('d32, data);

        repeat (30) @(posedge clk);

        $finish;
    end

      

endmodule
