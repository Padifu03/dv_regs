`ifndef _CLK_DRV
`define _CLK_DRV

class clk_driver extends uvm_driver #(clk_basic_tr);
    clk_basic_tr req;
    clk_basic_tr req_backup;
    `uvm_component_utils(clk_driver)

    virtual dut_if dut_vif;

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // Build phase
    function void build_phase(uvm_phase phase);
    endfunction : build_phase

    // Connect phase
    function void connect_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual dut_if)::get(this, "", "dut_if", dut_vif))
            `uvm_fatal("NO_VIF",{"virtual interface must be set for:", get_full_name().".vif"} );
    endfunction : connect_phase

    // Run phase
    task run_phase(uvm_phase phase);
        drive();
        forever begin
            seq_item_port.get_next_item(req);
            req_backup = req;
            `uvm_info("CLK", $sformatf("Drv writes %p", req), UVM_LOW);
            seq_item_port.item_done();
        end
    endtask : run_phase

    // Drive clk
    task drive();
        dut_vif.clk = 0;

        fork
            forever begin
                if(req_backup.en_clk) begin
                    dut_vif.clk = 0;
                    #(req_backup.period_ns*1ns/2);
                    dut_vif.clk = 1;
                    #(req_backup.period_ns*1ns/2);
                end else begin
                    dut_vif.clk = 0;
                end
            end
        join_none
    endtask : drive

endclass : clk_driver

`endif //_CLK_DRV