`include "test_defines.sv"

class test_def_values extends base_test;
    `uvm_component_utils(test_def_values)

    function new(string name, uvm_component parent);
    super.new(name,parent);
    endfunction

    //Run phase
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        `uvm_info(get_name(), "  ** DIRECT TEST DEFAULT VALUES **", UVM_LOW)
        // Iniciar la secuencia de reloj
        //create sequence
        seq = clk_basic_seq::type_id::create("seq");
        seq.en_clk = 1;
        seq.period_ns = 10;
        seq.start(env.i_clk_agent.sequencer);

        // Espera un ciclo
        #1;

        check_register(`FIR_COEF_0_ADDR, `FIR_COEF_0_DEF);      // Verificar FIR_COEF_0
        check_register(`FIR_COEF_1_ADDR, `FIR_COEF_1_DEF);      // Verificar FIR_COEF_1
        check_register(`FIR_COEF_2_ADDR, `FIR_COEF_2_DEF);      // Verificar FIR_COEF_2
        check_register(`FIR_DIV_ADDR, `FIR_DIV_DEF);            // Verificar FIR_DIV
        check_register(`CIC_COEF_ADDR, `CIC_COEF_DEF);          // Verificar CIC_COEF
        check_register(`CHIP_ID_ADDR, `CHIP_ID_DEF);            // Verificar CHIP_ID
        check_register(`OUTPUT_ADDR, `OUTPUT_DEF);              // Verificar OUTPUT

        //reset
        dut_vif.reset_n = 0;
        #5 dut_vif.reset_n = 1;

        check_register(`FIR_COEF_0_ADDR, `FIR_COEF_0_DEF);      // Verificar FIR_COEF_0
        check_register(`FIR_COEF_1_ADDR, `FIR_COEF_1_DEF);      // Verificar FIR_COEF_1
        check_register(`FIR_COEF_2_ADDR, `FIR_COEF_2_DEF);      // Verificar FIR_COEF_2
        check_register(`FIR_DIV_ADDR, `FIR_DIV_DEF);            // Verificar FIR_DIV
        check_register(`CIC_COEF_ADDR, `CIC_COEF_DEF);          // Verificar CIC_COEF
        check_register(`CHIP_ID_ADDR, `CHIP_ID_DEF);            // Verificar CHIP_ID
        check_register(`OUTPUT_ADDR, `OUTPUT_DEF);              // Verificar OUTPUT
        
        phase.drop_objection(this);
    endtask : run_phase
endclass : test_def_values

