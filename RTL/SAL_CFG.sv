`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/16 16:13:15
// Design Name: 
// Module Name: SAL_CFG
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

`include "TIME_SCALE.svh"
`include "PARAMS.svh"

module SAL_CFG
(
    // clock & reset
    input                       clk,
    input                       rst_n,

    // APB interface
    APB_IF.SLV                  apb_if,
    
    // configuration registers for CH0
    output  reg     [2:0]       header_fmt_o,
    output  reg     [4:0]       header_type_o,
    output  reg     [2:0]       header_tc_o,
    output  reg     [8:0]       header_length_o,
    output  reg     [15:0]      header_requestID_o,
    output  reg     [15:0]      header_completID_o,
    output  wire                ch0_start_o
   
);

    // Configuration register for CH0 to read/write
    reg     [2:0]                header_fmt;
    reg     [4:0]                header_type;
    reg     [2:0]                header_tc;
    reg     [8:0]                header_length;
    reg     [15:0]               header_requestID;
    reg     [15:0]               header_completID;

    wire wren   = apb_if.psel & apb_if.penable & apb_if.pwrite;

    always @(posedge clk) begin
        if(!rst_n) begin 
            header_fmt              <= 32'd0;
            header_type             <= 32'd0;
            header_tc               <= 32'd0;
            header_length           <= 32'd0;
            header_requestID        <= 32'd0;
            header_completID        <= 32'd0;
 
        end
        else if(wren) begin 
            case(apb_if.paddr)
                'h100: header_fmt           <= apb_if.pwdata[2:0];
                'h100: header_type          <= apb_if.pwdata[7:3];
                'h100: header_tc            <= apb_if.pwdata[10:8]; 
                'h100: header_length        <= apb_if.pwdata[17:9];
                'h104: header_requestID     <= apb_if.pwdata[15:0];
                'h104: header_completID     <= apb_if.pwdata[15:0];
            endcase
        end
    end


    wire ch0_start  = wren & (apb_if.paddr=='h10C) & apb_if.pwdata[0]; 
  
  
    // output assignments
    assign  ch0_start_o             = ch0_start;
    
    assign  header_fmt_o            = header_fmt;
    assign  header_type_o           = header_type;
    assign  header_tc_o             = header_tc;
    assign  header_length_o         = header_length;
    assign  header_requestID_o      = header_requestID;
    assign  header_completID_o      = header_completID;

endmodule
