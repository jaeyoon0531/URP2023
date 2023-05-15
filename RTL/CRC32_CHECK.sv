`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/09 21:33:11
// Design Name: 
// Module Name: CRC32_CHECK
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


module crc32_check (
    input wire                  clk,
    input wire                  reset_n,
    input wire [31:0]           data_in,
    input wire                  data_in_valid,
    input wire                  crc_valid,
    output reg                  crc_check_passed
);

    reg  [31:0] crc_reg;
    wire [31:0] poly = 32'h04C11DB7; // CRC-32 polynomial

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            crc_reg <= 32'hFFFFFFFF;
            crc_check_passed <= 1'b0;
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

            if (crc_valid) begin
                crc_check_passed <= (crc_reg == ~data_in); //correct:1, error: 0
                crc_reg <= 32'hFFFFFFFF; // Reset the CRC register for the next packet
            end
        end
    end

endmodule
