`ifndef _CLK_AGT
`define _CLK_AGT

`include "agents/clk_agent/transaction_clk.sv"
`include "agents/clk_agent/sequencer_clk.sv"
`include "agents/clk_agent/seq_clk.sv"
`include "agents/clk_agent/monitor_clk.sv"
`include "agents/clk_agent/driver_clk.sv"

class clk_agent extends uvm_agent;
    // Component instances
    clk_driver      driver;
    clk_sequencer   sequencer;
    clk_monitor     monitor;

    `uvm_component_utils(clk_agent);

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // Build phase
    function void build_phase(uvm_phase phase);
        driver = clk_driver::type_id::create("clk_drv", this);
        monitor = clk_monitor::type_id::create("clk_mon", this);
        m_sequencer = clk_sequencer::type_id::create("clk_sequencer", this);
    endfunction : build_phase

    // Connect phase
    function void connect_phase(uvm_phase phase);
        if(get_is_active() == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end
    endfunction : connect_phase

    // Run phase
    task run_phase(uvm_phase phase);
    endtask : run_phase

endclass : clk_agent

`endif //_CLK_AGT
