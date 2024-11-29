`ifndef _CLK_SEQUENCER
`define _CLK_SEQUENCER

class sequencer_clk extends uvm_sequencer#(clk_basic_tr);
    `uvm_component_utils(sequencer_clk)

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

endclass

`endif //_CLK_SEQUENCER