`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/09 13:39:46
// Design Name: 
// Module Name: ARBITER
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

module ARBITER
#(
    N_MASTER                    = 4,
    DATA_SIZE                   = 32
)
(
    input   wire                clk,
    input   wire                rst_n,  // _n means active low

    // configuration registers
    input   wire                src_valid_i[N_MASTER],
    output  reg                 src_ready_o[N_MASTER],
    input   wire    [DATA_SIZE-1:0]     src_data_i[N_MASTER],

    output  reg                 dst_valid_o,
    input   wire                dst_ready_i,
    output  reg     [DATA_SIZE-1:0] dst_data_o
);
    localparam  MASTER_CNT        = $clog2(N_MASTER);
    reg   [MASTER_CNT-1:0]        LRU,  LRU_n;

    reg                           valid,  valid_n;
    reg   [DATA_SIZE-1:0]         data,   data_n;

    reg                           cnt, cnt_n;
  
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            valid           <= 1'b0;
            data            <= 'd0;
            LRU             <= 'd0;
            cnt             <= 'd0;
        end
        else begin
            valid           <= valid_n;
            data            <= data_n;
            LRU             <= LRU_n;
            cnt             <= cnt_n;
        end
    end

    always_comb begin
        valid_n           = valid;
        if (!valid | dst_ready_i) begin  // 처음 access & ready_i
            if(src_valid_i[0]|src_valid_i[1]|src_valid_i[2]|src_valid_i[3]) begin
                valid_n = 1'b1;
            end
            else begin
                valid_n = 1'b0;
            end
        end
    end

    // select priority (up count or down count)
    always_comb begin
        cnt_n            = cnt;
        if(!valid | dst_ready_i) cnt_n = cnt + 1'd1;
    end
    // round-robin arbiter
    always_comb begin
        data_n                = data;
        LRU_n                 = LRU;
        {src_ready_o[0],src_ready_o[1],src_ready_o[2],src_ready_o[3]}        = 4'b0000;
        
        if (!valid | dst_ready_i) begin 
            if(cnt == 0) begin // up count
                case(LRU)
                'd0: begin
                    if (src_valid_i[1]) begin
                        data_n              = src_data_i[1];
                        LRU_n               = 'd1;
                        src_ready_o[1]      = 1'b1;
                    end
                    else if (src_valid_i[2]) begin
                        data_n              = src_data_i[2];
                        LRU_n               = 'd2;
                        src_ready_o[2]      = 1'b1;
                    end
                    else if (src_valid_i[3]) begin
                        data_n              = src_data_i[3];
                        LRU_n               = 'd3;
                        src_ready_o[3]      = 1'b1;
                    end
                    else if (src_valid_i[0]) begin
                        data_n              = src_data_i[0];
                        src_ready_o[0]      = 1'b1;
                    end
                end
                'd1 : begin
                    if (src_valid_i[2]) begin
                        data_n              = src_data_i[2];
                        LRU_n               = 'd2;
                        src_ready_o[2]      = 1'b1;
                    end
                    else if (src_valid_i[3]) begin
                        data_n              = src_data_i[3];
                        LRU_n               = 'd3;
                        src_ready_o[3]      = 1'b1;
                    end
                    else if (src_valid_i[0]) begin
                        data_n              = src_data_i[0];
                        LRU_n               = 'd0;
                        src_ready_o[0]      = 1'b1;
                    end
                    else if (src_valid_i[1]) begin
                        data_n              = src_data_i[1];
                        src_ready_o[1]      = 1'b1;
                    end
                end
                'd2 : begin
                    if (src_valid_i[3]) begin
                        data_n              = src_data_i[3];
                        LRU_n               = 'd3;
                        src_ready_o[3]      = 1'b1;
                    end
                    else if (src_valid_i[0]) begin
                        data_n              = src_data_i[0];
                        LRU_n               = 'd0;
                        src_ready_o[0]      = 1'b1;
                    end
                    else if (src_valid_i[1]) begin
                        data_n              = src_data_i[1];
                        LRU_n               = 'd1;
                        src_ready_o[1]      = 1'b1;
                    end
                    else if (src_valid_i[2]) begin
                        data_n              = src_data_i[2];
                        src_ready_o[2]      = 1'b1;
                    end
                end
                'd3 : begin
                    if (src_valid_i[0]) begin
                        data_n              = src_data_i[0];
                        LRU_n               = 'd0;
                        src_ready_o[0]      = 1'b1;
                    end
                    else if (src_valid_i[1]) begin
                        data_n              = src_data_i[1];
                        LRU_n               = 'd1;
                        src_ready_o[1]      = 1'b1;
                    end
                    else if (src_valid_i[2]) begin
                        data_n              = src_data_i[2];
                        LRU_n               = 'd2;
                        src_ready_o[2]      = 1'b1;
                    end
                    else if (src_valid_i[3]) begin
                        data_n              = src_data_i[3];
                        src_ready_o[3]      = 1'b1;
                    end
                end
                endcase
            end else begin // down count
                case(LRU)
                'd0: begin
                    if (src_valid_i[3]) begin
                        data_n              = src_data_i[3];
                        LRU_n               = 'd1;
                        src_ready_o[3]      = 1'b1;
                    end
                    else if (src_valid_i[2]) begin
                        data_n              = src_data_i[2];
                        LRU_n               = 'd2;
                        src_ready_o[2]      = 1'b1;
                    end
                    else if (src_valid_i[1]) begin
                        data_n              = src_data_i[1];
                        LRU_n               = 'd3;
                        src_ready_o[1]      = 1'b1;
                    end
                    else if (src_valid_i[0]) begin
                        data_n              = src_data_i[0];
                        src_ready_o[0]      = 1'b1;
                    end
                end
                'd1 : begin
                    if (src_valid_i[0]) begin
                        data_n              = src_data_i[0];
                        LRU_n               = 'd2;
                        src_ready_o[0]      = 1'b1;
                    end
                    else if (src_valid_i[3]) begin
                        data_n              = src_data_i[3];
                        LRU_n               = 'd3;
                        src_ready_o[3]      = 1'b1;
                    end
                    else if (src_valid_i[2]) begin
                        data_n              = src_data_i[2];
                        LRU_n               = 'd0;
                        src_ready_o[2]      = 1'b1;
                    end
                    else if (src_valid_i[1]) begin
                        data_n              = src_data_i[1];
                        src_ready_o[1]      = 1'b1;
                    end
                end
                'd2 : begin
                    if (src_valid_i[1]) begin
                        data_n              = src_data_i[1];
                        LRU_n               = 'd3;
                        src_ready_o[1]      = 1'b1;
                    end
                    else if (src_valid_i[0]) begin
                        data_n              = src_data_i[0];
                        LRU_n               = 'd0;
                        src_ready_o[0]      = 1'b1;
                    end
                    else if (src_valid_i[3]) begin
                        data_n              = src_data_i[3];
                        LRU_n               = 'd1;
                        src_ready_o[3]      = 1'b1;
                    end
                    else if (src_valid_i[2]) begin
                        data_n              = src_data_i[2];
                        src_ready_o[2]      = 1'b1;
                    end
                end
                'd3 : begin
                    if (src_valid_i[2]) begin
                        data_n              = src_data_i[2];
                        LRU_n               = 'd0;
                        src_ready_o[2]      = 1'b1;
                    end
                    else if (src_valid_i[1]) begin
                        data_n              = src_data_i[1];
                        LRU_n               = 'd1;
                        src_ready_o[1]      = 1'b1;
                    end
                    else if (src_valid_i[0]) begin
                        data_n              = src_data_i[0];
                        LRU_n               = 'd2;
                        src_ready_o[0]      = 1'b1;
                    end
                    else if (src_valid_i[3]) begin
                        data_n              = src_data_i[3];
                        src_ready_o[3]      = 1'b1;
                    end
                end
                endcase
            end
        end
    end

    assign  dst_valid_o             = valid;
    assign  dst_data_o              = data;

endmodule
