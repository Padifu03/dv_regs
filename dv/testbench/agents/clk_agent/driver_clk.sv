`ifndef _CLK_DRV
`define _CLK_DRV

class clk_driver extends uvm_driver #(clk_basic_tr);
    clk_basic_tr req;

    `uvm_component_utils(clk_driver)
endclass : clk_driver

`endif //_CLK_DRV