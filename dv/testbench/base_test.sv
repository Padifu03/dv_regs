`include "environment.sv"

class base_test extends uvm_test;

  environment env;
  virtual dut_if dut_vif;
  clk_basic_seq seq;

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

  // Task para escribir en un registro
  task write_register(input [7:0] addr, input [7:0] data);
    begin
      // Asignación de valores para escritura
      dut_vif.addr = addr;
      dut_vif.wr_data = data;
      dut_vif.req = 1;
      dut_vif.wr_en = 1;
      #10; // Tiempo de espera para simular ciclos de reloj
      dut_vif.req = 0;
      dut_vif.wr_en = 0;
      #10; // Tiempo de espera para simular ciclos de reloj
    end
  endtask
  
  // Task para leer un registro
  task read_register(input [7:0] addr, output [7:0] data);
    begin
      // Asignación de valores para lectura
      dut_vif.addr = addr;
      dut_vif.req = 1;
      dut_vif.wr_en = 0; // Operación de lectura
      #10;  // Espera de 10 ciclos de reloj
      data = dut_vif.rd_data; // Obtener datos leídos
      dut_vif.req = 0;
      #10;  // Espera de 10 ciclos de reloj
    end
  endtask

  // Task para verificar el valor leído de un registro
  task check_register(input [7:0] addr, input [7:0] expected_value);
    reg [7:0] data;
    begin
      read_register(addr, data);
      assert (data == expected_value) else begin
          // Reportar un error si los valores no coinciden
          `uvm_error("REGISTER_CHECK", $sformatf("Expected 0x%0h, but got 0x%0h for register 0x%0h", expected_value, data, addr));
      end
      if (data == expected_value) begin
        `uvm_info("REGISTER_CHECK", $sformatf("Correct value 0x%0h for register 0x%0h", data, addr), UVM_LOW);
      end
    end
  endtask

endclass
