`include "test_defines.sv"

class random_test_def_values extends base_test;
    `uvm_component_utils(random_test_def_values)

    rand bit[7:0] random_addr;
    bit[7:0]  def_val;

    //constraints
    constraint random_addr_c{
        random_addr in {8'h00, 8'h01, 8'h02, 8'h03, 8'h04, 8'h05, 8'h07};
    }

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction : new

    //Run phase
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        // Iniciar la secuencia de reloj
        //create sequence
        seq = clk_basic_seq::type_id::create("seq");
        seq.en_clk = 1;
        seq.period_ns = 10;
        seq.start(env.i_clk_agent.sequencer);

        `uvm_info(get_name(), "\n  ** RANDOM TEST DEFAULT VALUES **", UVM_LOW)

        for (int i = 0; i < 10; i++) begin
            this.randomize();
            get_random_addr_def_value(random_addr, def_val);
            
            if(def_val !== `ERROR_DEF) begin
                check_register(random_addr, def_val);
            end else begin
                `uvm_error("REGISTER_ADDR OUT OF RANGE");
            end
        end
        
        //reset
        dut_vif.reset_n = 0;
        #5 dut_vif.reset_n = 1;

        for (int i = 0; i < 10; i++) begin
            this.randomize();
            get_random_addr_def_value(random_addr, def_val);

            if(def_val != `ERROR_DEF) begin
                check_register(random_addr, def_val);
            end else begin
                `uvm_error("REGISTER_ADDR OUT OF RANGE");
            end
        end

        phase.drop_objection(this);
    endtask : run_phase

    task get_random_addr_def_value(input bit[7:0] addr, output bit[7:0] default_value)

        case (addr)
            `FIR_COEF_0_ADDR:
                default_value = `FIR_COEF_0_DEF;
            
            `FIR_COEF_1_ADDR:
                default_value = `FIR_COEF_1_DEF;
            
            `FIR_COEF_2_ADDR:
                default_value = `FIR_COEF_2_DEF;
            
            `FIR_DIV_ADDR:
                default_value = `FIR_DIV_DEF;
            
            `CIC_COEF_ADDR:
                default_value = `CIC_COEF_DEF;
            
            `CHIP_ID_ADDR:
                default_value = `CHIP_ID_DEF;

            `OUTPUT_ADDR:
                default_value = `OUTPUT_DEF;

            default:
                default_value = `ERROR_DEF; 
        endcase

        `uvm_info("RANDOMIZE DATA:", $sformatf("ADDR: 0x%0h, DEF_VALUE: 0x%0h", addr, default_value), UVM_LOW);
    endtask : get_random_addr_def_value

endclass : random_test_def_values

