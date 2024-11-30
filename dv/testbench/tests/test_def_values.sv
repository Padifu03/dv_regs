class test_def_values extends base_test;
  `uvm_component_utils(test_def_values)
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info(get_name(), "  ** TEST DEFAULT VALUES **", UVM_LOW)

	#100us;
    
 	phase.drop_objection(this);
  endtask
endclass : test_def_values
