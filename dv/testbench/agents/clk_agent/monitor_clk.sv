`ifndef _CLK_MON
`define _CLK_MON

class clk_monitor extends uvm_monitor;
    `uvm_component_utils(clk_monitor)

    uvm_analysis_port #(clk_basic_tr) port;
    virtual dut_if i_dut_vif;

    function new(string name, uvm_component parent);
    super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
    port = new("port", this);
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
    //get interface through the database???
    assert(uvm_config_db#(virtual dut_if)::get(this, "", "dut_if", i_dut_vif));
    endfunction

    task run_phase(uvm_phase phase);
        tr = new();

        forever begin //infinite loop
        //wait for events, send through the port
            @(i_dut_vif.clk);
            tr.clk = i_dut_vif.clk;
            port.write(tr);
        end
    endtask : run_phase

endclass : clk_rst_monitor

`endif //_CLK_MON
