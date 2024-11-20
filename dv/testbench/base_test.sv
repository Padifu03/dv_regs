`include "environment.sv"

class base_test extends uvm_test;

  environment env;

  `uvm_component_utils(base_test)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  //Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //create environment
    env = environment::type_id::create("top_env", this);
  endfunction

  //Check build phase
  virtual function void end_of_elaboration_phase (uvm_phase phase);
    uvm_top.print_topology ();
  endfunction

  //Start phase
  /* No sirve a priori. Si que podemos hacer un par de task para el reset y el clk
  function void start_of_simulation_phase (uvm_phase phase);
      super.start_of_simulation_phase (phase);

      // [Optional] Assign a default sequence to be executed by the sequencer or look at the run_phase ...
      //uvm_config_db#(uvm_object_wrapper)::set(this,"m_top_env.my_agent.m_seqr0.main_phase",
      //                                        "default_sequence", base_sequence::type_id::get());

   endfunction

  // Run phase
  // or [Recommended] start a sequence for this particular test
  virtual task run_phase (uvm_phase phase);
    my_seq m_seq = my_seq::type_id::create ("m_seq");

    super.run_phase(phase);
    phase.raise_objection (this);
    m_seq.start (m_env.seqr);
    phase.drop_objection (this);
  endtask
  */
endclass
