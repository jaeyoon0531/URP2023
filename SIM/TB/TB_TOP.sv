`include "TIME_SCALE.svh"
`include "PARAMS.svh"
`define PARAM   32

module TB_TOP;

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
        // activate the reset (active low)
        rst_n                       = 1'b0;
        repeat (3) @(posedge clk);
        // release the reset after 10 cycles
        rst_n                       = 1'b1;
    end
    
    APB_IF                          apb_if      (.clk(clk), .rst_n(rst_n));

    // AXI interface    
    AXI_A_IF                        axi_ar_if   (.clk(clk), .rst_n(rst_n));
    AXI_R_IF                        axi_r_if    (.clk(clk), .rst_n(rst_n));
    AXI_A_IF                        axi_aw_if   (.clk(clk), .rst_n(rst_n));
    AXI_W_IF                        axi_w_if    (.clk(clk), .rst_n(rst_n));
    AXI_B_IF                        axi_b_if    (.clk(clk), .rst_n(rst_n));
     
    reg    [2:0]                    header_fmt_o;
    reg    [4:0]                    header_type_o;
    reg    [2:0]                    header_tc_o;
    reg    [8:0]                    header_length_o;
    reg    [15:0]                   header_requestID_o;
    reg    [15:0]                   header_completID_o;
    reg    [1023:0]                 data_o;
    reg    [31:0]                   addr_o;


    PCIe                            u_pcie
    (
        .clk                        (clk),
        .rst_n                      (rst_n),

        // APB interface
        .apb_if                     (apb_if),

        // AXI interface
        .axi_ar_if                  (axi_ar_if),
        .axi_aw_if                  (axi_aw_if),
        .axi_w_if                   (axi_w_if),
        .axi_b_if                   (axi_b_if),
        .axi_r_if                   (axi_r_if),
        
        .header_fmt_o               (header_fmt_o),
        .header_type_o              (header_type_o),
        .header_tc_o                (header_tc_o),
        .header_length_o            (header_length_o),
        .header_requestID_o         (header_requestID_o),
        .header_completID_o         (header_completID_o),
        .data_out                   (data_o),
        .addr_out                   (addr_o) 
    );

    
    task init();
        axi_aw_if.init();
        axi_w_if.init();
        axi_b_if.init();
        axi_ar_if.init();
        axi_r_if.init();
        apb_if.init();

        // wait for a reset release
        @(posedge rst_n);

        // wait enough cycles for DRAM to finish their initialization
        repeat (250) @(posedge clk);
    endtask

    logic       [`AXI_ID_WIDTH-1:0]     simple_id;
    assign  simple_id                   = 'd0;


    //AW,W,CFG TLP
    task automatic write(
        //AW
        input [31:0] addr,
        //W
        input [127:0]               data,
        input [95:0]               header
    );
        logic   [`AXI_ID_WIDTH-1:0] rid;
        logic   [1:0]               rresp;

        // drive to AW and W
        fork
            //AW
            begin
                axi_aw_if.send(simple_id, addr, 'd1, `AXI_SIZE_128, `AXI_BURST_INCR);
            end
            //W
            begin
                axi_w_if.send(simple_id, data, 16'hFFFF, 1'b0);
                //axi_w_if.send(simple_id, data[255:128], 16'hFFFF, 1'b1);
            end
            //APB
            begin
                apb_if.write(addr, header);
            end
        join

        // receive from B
        axi_b_if.recv(rid, rresp);

        // check responses
        if (rid!==simple_id) begin $display("ID mismatch (expected: %d, received: %d)", simple_id, rid); $finish; end
        if (rresp!==2'b00) begin $display("Non-OK response (received: %d)", rresp); $finish; end
    endtask

    
    logic   [127:0]             data;
    
    initial begin
        init();
        //AW,W,APB
        write('d0,   {4{32'h01234567}}, {3{32'h01234567}});
        write('d32,  {4{32'h01234567}}, {3{32'h01234567}});
 

        repeat (30) @(posedge clk);

        $finish;
    end

endmodule
