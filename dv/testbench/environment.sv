`include "agent_i2c.sv"

class environment extends uvm_env;  
  `uvm_component_utils(environment)

  i2c_agent i2c_agt;
  //instantiate agents, interface...

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    //create agents
    i2c_agt = i2c_agent::type_id::create("m_i2c_agt", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    //interface to database 
  endfunction
endclass : environment
