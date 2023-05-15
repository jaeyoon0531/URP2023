`ifndef __SAL_TYPEDEF_SVH__
`define __SAL_TYPEDEF_SVH__

`define CLK_PERIOD                      2.5

//----------------------------------------------------------
// AXI interface
//----------------------------------------------------------
`define AXI_READ_ACCEPTANCE_CAP         8
`define AXI_WRITE_ACCEPTANCE_CAP        1

`define AXI_ID_WIDTH                    4
`define AXI_ADDR_WIDTH                  32
`define AXI_DATA_WIDTH                  128
`define AXI_STRB_WIDTH                  (`AXI_DATA_WIDTH/8)
`define AXI_LEN_WIDTH                   4
`define AXI_SIZE_WIDTH                  3
`define AXI_BURST_WIDTH                 2
`define AXI_RESP_WIDTH                  2

// name magic numbers
`define AXI_SIZE_8                      3'b000
`define AXI_SIZE_16                     3'b001
`define AXI_SIZE_32                     3'b010
`define AXI_SIZE_64                     3'b011
`define AXI_SIZE_128                    3'b100

`define AXI_BURST_FIXED                 2'b00
`define AXI_BURST_INCR                  2'b01
`define AXI_BURST_WRAP                  2'b11

`define AXI_RESP_OKAY                   2'b00
`define AXI_RESP_EXOKAY                 2'b01
`define AXI_RESP_SLVERR                 2'b10
`define AXI_RESP_DECERR                 2'b11

typedef logic   [`AXI_ID_WIDTH-1:0]     axi_id_t;
typedef logic   [`AXI_ADDR_WIDTH-1:0]   axi_addr_t;
typedef logic   [`AXI_DATA_WIDTH-1:0]   axi_data_t;
typedef logic   [`AXI_STRB_WIDTH-1:0]   axi_strb_t;
typedef logic   [`AXI_LEN_WIDTH-1:0]    axi_len_t;
typedef logic   [`AXI_SIZE_WIDTH-1:0]   axi_size_t;
typedef logic   [`AXI_BURST_WIDTH-1:0]  axi_burst_t;
typedef logic   [`AXI_RESP_WIDTH-1:0]   axi_resp_t;





`endif /* __SAL_TYPEDEF_SVH__ */
