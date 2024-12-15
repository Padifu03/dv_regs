`include "test_defines.sv"

class test_w_r_permission extends base_test;
  `uvm_component_utils(test_w_r_permission)
  
  // Valores fijos para las pruebas
  localparam bit [7:0] TEST_WRITE_VALUE_RW = 8'hAA;
  localparam bit [7:0] TEST_WRITE_VALUE_R = 8'hCC;    // Valor para intentar escribir en registro R
  localparam bit [7:0] TEST_WRITE_VALUE_W = 8'h55;    // Valor para escribir en registro W

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info(get_name(), "  ** READ_WRITE_TEST **", UVM_LOW)
    // Iniciar la secuencia de reloj
    //create sequence
    seq = clk_basic_seq::type_id::create("seq");
    seq.en_clk = 1;
    seq.period_ns = 10;
    seq.start(env.i_clk_agent.sequencer);

    // Verificación de registros RW (FIR_COEF_0, FIR_COEF_1, FIR_COEF_2, FIR_DIV, CIC_COEF)
    check_rw_register(`FIR_COEF_0_ADDR, `FIR_COEF_0_DEF, TEST_WRITE_VALUE_RW);
    check_rw_register(`FIR_COEF_1_ADDR, `FIR_COEF_1_DEF, TEST_WRITE_VALUE_RW);
    check_rw_register(`FIR_COEF_2_ADDR, `FIR_COEF_2_DEF, TEST_WRITE_VALUE_RW);
    check_rw_register(`FIR_DIV_ADDR,    `FIR_DIV_DEF,    TEST_WRITE_VALUE_RW);
    check_rw_register(`CIC_COEF_ADDR,   `CIC_COEF_DEF,   TEST_WRITE_VALUE_RW);

    // Verificación de registros R (CHIP_ID, OUTPUT)
    check_read_only_register(`CHIP_ID_ADDR, `CHIP_ID_DEF, TEST_WRITE_VALUE_R);
    check_read_only_register(`OUTPUT_ADDR,  `OUTPUT_DEF,  TEST_WRITE_VALUE_R);

    // Verificación de registro W (CONTROL)
    check_write_only_register(`CONTROL_ADDR, TEST_WRITE_VALUE_W);

    //reset
    dut_vif.reset_n = 0;
    #5 dut_vif.reset_n = 1;
    `uvm_info(get_name(), "********************* RESET DONE! *********************", UVM_LOW);

    check_register(`FIR_COEF_0_ADDR, `FIR_COEF_0_DEF);      // Verificar FIR_COEF_0
    check_register(`FIR_COEF_1_ADDR, `FIR_COEF_1_DEF);      // Verificar FIR_COEF_1
    check_register(`FIR_COEF_2_ADDR, `FIR_COEF_2_DEF);      // Verificar FIR_COEF_2
    check_register(`FIR_DIV_ADDR, `FIR_DIV_DEF);            // Verificar FIR_DIV
    check_register(`CIC_COEF_ADDR, `CIC_COEF_DEF);          // Verificar CIC_COEF
    check_register(`CHIP_ID_ADDR, `CHIP_ID_DEF);            // Verificar CHIP_ID
    check_register(`OUTPUT_ADDR, `OUTPUT_DEF);              // Verificar OUTPUT

 	  phase.drop_objection(this);
  endtask

  // Tarea para verificar un registro RW
  // Lee el valor por defecto, escribe un valor fijo y vuelve a leer para verificar.
  task check_rw_register(input [7:0] addr, input [7:0] default_val, input [7:0] write_val);
    reg [7:0] read_data;

    // Leer valor por defecto
    read_register(addr, read_data);
    assert (read_data == default_val) else begin
      `uvm_error(get_name(), $sformatf("Default mismatch at 0x%0h: expected 0x%0h, got 0x%0h", addr, default_val, read_data));
    end
    if (read_data == default_val)
      `uvm_info(get_name(), $sformatf("Default OK: 0x%0h at 0x%0h", read_data, addr), UVM_LOW);

    // Escribir valor fijo
    write_register(addr, write_val);

    // Leer y verificar
    read_register(addr, read_data);
    assert (read_data == write_val) else begin
      `uvm_error(get_name(), $sformatf("RW register mismatch at 0x%0h: wrote 0x%0h, got 0x%0h", addr, write_val, read_data));
    end
    if (read_data == write_val)
      `uvm_info(get_name(), $sformatf("RW register 0x%0h write/read OK: 0x%0h", addr, read_data), UVM_LOW);
  endtask : check_rw_register

  // Tarea para verificar un registro de solo lectura (R)
  // Verifica el valor por defecto, intenta escribir sin cambiar su valor.
  task check_read_only_register(input [7:0] addr, input [7:0] default_val, input [7:0] write_val);
    reg [7:0] read_data;

    // Leer valor por defecto
    read_register(addr, read_data);
    assert (read_data == default_val) else begin
      `uvm_error(get_name(), $sformatf("Read-only default mismatch at 0x%0h: expected 0x%0h, got 0x%0h", addr, default_val, read_data));
    end
    if (read_data == default_val)
      `uvm_info(get_name(), $sformatf("Read-only default OK: 0x%0h at 0x%0h", read_data, addr), UVM_LOW);

    // Intentar escribir no cambia el valor
    write_register(addr, write_val);

    // Leer de nuevo para comprobar que no cambió
    read_register(addr, read_data);
    assert (read_data == default_val) else begin
      `uvm_error(get_name(), $sformatf("Read-only register changed at 0x%0h: expected 0x%0h, got 0x%0h", addr, default_val, read_data));
    end
    if (read_data == default_val)
      `uvm_info(get_name(), $sformatf("Read-only register 0x%0h unchanged after write attempt (OK)", addr), UVM_LOW);
  endtask : check_read_only_register

  // Tarea para verificar un registro de solo escritura (W)
  // Escribe un valor, y la lectura debe ser 0 (según lo establecido).
  task check_write_only_register(input [7:0] addr, input [7:0] write_val);
    reg [7:0] read_data;

    // Escribir valor
    write_register(addr, write_val);

    // Leer debería devolver 0
    read_register(addr, read_data);
    assert (read_data == 8'h00) else begin
      `uvm_error(get_name(), $sformatf("Write-only register at 0x%0h returned non-zero (0x%0h)", addr, read_data));
    end
    if (read_data == 8'h00)
      `uvm_info(get_name(), $sformatf("Write-only register 0x%0h read OK: got 0x00", addr), UVM_LOW);
  endtask : check_write_only_register

endclass : test_w_r_permission
