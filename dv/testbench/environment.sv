//`include "agent_i2c.sv"

class environment extends uvm_env;
  `uvm_component_utils(environment)

  virtual dut_if my_dut_if;

  //instantiate agents, interface...

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    //create agents
  endfunction

  function void connect_phase(uvm_phase phase);
    //interface to database
    uvm_config_db #(virtual dut_if) :: get (this, "*", "dut_if", my_dut_if);
  endfunction

endclass : environment
