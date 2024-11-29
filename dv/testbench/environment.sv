//`include "agent_i2c.sv"
`include "agents/clk_agent/agent_clk.sv"

class environment extends uvm_env;
  //instantiate if
  virtual dut_if my_dut_if;

  //instantiate agents
  clk_agent i_clk_agent;

  `uvm_component_utils(environment)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    //create agents
    super.build_phase(phase);

    i_clk_agent = clk_agent::type_id::create("clk_agent", this);
  endfunction : build_phase

  // Connect phase
  function void connect_phase(uvm_phase phase);
    //interface to database
    uvm_config_db #(virtual dut_if) :: get (this, "*", "dut_if", my_dut_if);
  endfunction

endclass : environment
