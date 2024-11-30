// Definición de macros para los valores por defecto
`define DEFAULT_FIR_COEF_0 8'h01
`define DEFAULT_FIR_COEF_1 8'h00
`define DEFAULT_FIR_COEF_2 8'h00
`define DEFAULT_FIR_DIV    8'h00
`define DEFAULT_CIC_COEF   2'b01
`define DEFAULT_CHIP_ID    8'hA5

class test_def_values extends base_test;
    `uvm_component_utils(test_def_values)

    clk_basic_seq seq;

    function new(string name, uvm_component parent);
    super.new(name,parent);
    endfunction

    //Build phase
    task build_phase(uvm_phase phase);
        super.build_phase(phase);

        seq = clk_basic_seq::type_id::create("seq");
    endtask : build_phase

    //Run phase
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        `uvm_info(get_name(), "  ** TEST DEFAULT VALUES **", UVM_LOW)
        // Iniciar la secuencia de reloj
        seq.en_clk = 1;
        seq.period_ns = 1000;
        seq.start(env.i_clk_agent.sequencer);

        // Espera un ciclo
        #1us;

        // Assertions para verificar los valores por defecto de los registros
        // Verificación de FIR_COEF_0
        assert (dut_vif.reg_fir_coef_0 == DEFAULT_FIR_COEF_0)
            else $fatal("Error: reg_fir_coef_0 tiene un valor incorrecto: 0x%0h, se esperaba: 0x%0h", dut_vif.reg_fir_coef_0, DEFAULT_FIR_COEF_0);

        // Verificación de FIR_COEF_1
        assert (dut_vif.reg_fir_coef_1 == DEFAULT_FIR_COEF_1)
            else $fatal("Error: reg_fir_coef_1 tiene un valor incorrecto: 0x%0h, se esperaba: 0x%0h", dut_vif.reg_fir_coef_1, DEFAULT_FIR_COEF_1);

        // Verificación de FIR_COEF_2
        assert (dut_vif.reg_fir_coef_2 == DEFAULT_FIR_COEF_2)
            else $fatal("Error: reg_fir_coef_2 tiene un valor incorrecto: 0x%0h, se esperaba: 0x%0h", dut_vif.reg_fir_coef_2, DEFAULT_FIR_COEF_2);

        // Verificación de FIR_DIV
        assert (dut_vif.reg_fir_div == DEFAULT_FIR_DIV)
            else $fatal("Error: reg_fir_div tiene un valor incorrecto: 0x%0h, se esperaba: 0x%0h", dut_vif.reg_fir_div, DEFAULT_FIR_DIV);

        // Verificación de CIC_COEF (decimation rate)
        assert (dut_vif.reg_cic_coef == DEFAULT_CIC_COEF)
            else $fatal("Error: reg_cic_coef tiene un valor incorrecto: 0x%0h, se esperaba: 0x%0h", dut_vif.reg_cic_coef, DEFAULT_CIC_COEF);

        // Verificación de CHIP_ID
        assert (dut_vif.reg_chip_id == DEFAULT_CHIP_ID)
            else $fatal("Error: reg_chip_id tiene un valor incorrecto: 0x%0h, se esperaba: 0x%0h", dut_vif.reg_chip_id, DEFAULT_CHIP_ID);

        phase.drop_objection(this);
    endtask : run_phase
endclass : test_def_values

