`ifndef _CLK_AGT
`define _CLK_AGT

`include "transaction_clk.sv"
`include "monitor_clk.sv"
`include "driver_clk.sv"

class clk_rst_agent extends uvm_agent;
    `uvm_component_utils(clk_agent)

endclass : clk_rst_agent

`endif //_CLK_AGT
