`include "environment.sv"

class base_test extends uvm_test;

  environment env;
  virtual dut_if dut_vif;
  `uvm_component_utils(base_test)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  //Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //create environment
    env = environment::type_id::create("top_env", this);

    //get dut_if
    if(!uvm_config_db#(virtual dut_if)::get(this, "", "dut_if", dut_vif))
            `uvm_fatal("NO_VIF",{"virtual interface must be set for:", get_full_name(),".vif"} );
  endfunction

  //Check build phase
  virtual function void end_of_elaboration_phase (uvm_phase phase);
    uvm_top.print_topology ();
  endfunction
endclass
