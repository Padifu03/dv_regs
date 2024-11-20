`ifndef _DUT_IF
`define _DUT_IF

interface dut_if();
  logic         clk;		  //chip clock
  logic         reset_n;	//chip reset
  
  //reg_block signals
  logic                   req;
  logic                   wr_en;
  logic  [7:0]            addr;
  logic  [7:0]            wr_data;

  logic  [7:0]            rd_data;
  
  logic  signed [7:0]     I_adc_data;
  reg    signed [7:0]     O_coef0;
  reg    signed [7:0]     O_coef1;
  reg    signed [7:0]     O_coef2;
  reg    signed [7:0]     O_coef_div;
  reg    [1:0]            O_decimation_ratio;
  reg                     O_conv_en;
endinterface

`endif // _DUT_IF
