`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/09 21:26:26
// Design Name: 
// Module Name: CRC32_GEN
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


module crc32_gen (
    input wire                  clk,
    input wire                  reset_n,
    input wire [31:0]           data_in,
    input wire                  data_in_valid,
    output reg [31:0]           crc_out
);

    reg  [31:0] crc_reg;
    wire [31:0] poly = 32'h04C11DB7; // CRC-32 polynomial

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            crc_reg <= 32'hFFFFFFFF;
        end else begin
            if (data_in_valid) begin
                crc_reg <= crc_reg ^ data_in;

                for (integer i = 0; i < 32; i = i + 1) begin
                    if (crc_reg[0]) begin
                        crc_reg <= (crc_reg >> 1) ^ poly;
                    end else begin
                        crc_reg <= crc_reg >> 1;
                    end
                end
            end
        end
    end

    assign crc_out = ~crc_reg;

endmodule
