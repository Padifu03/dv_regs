`ifndef _CLK_SEQ
`define _CLK_SEQ

//`include "transaction_clk.sv"

class clk_basic_seq extends uvm_sequence#(clk_basic_tr);
    bit en_clk;
    int period_ns;

    `uvm_object_utils(clk_basic_seq)
    //`uvm_declare_p_sequencer(clk_sequencer)

    function new(string name = "clk_basic_seq");
        super.new(name);
    endfunction

    virtual task body();
        req = clk_basic_tr::type_id::create("req");
        $display("Sequence values: EN: %0d, PERIOD: %0d", en_clk, period_ns);
        $display("Pre UVM do Transaction values: EN: %0d, PERIOD: %0d", req.en_clk, req.period_ns);
        `uvm_info(get_type_name(), "clk_basic_seq created", UVM_LOW);
        req.en_clk = en_clk;
        req.period_ns = period_ns;
        $display("Assigned with seq Transaction values: EN: %0d, PERIOD: %0d", req.en_clk, req.period_ns);
        `uvm_do_with(req,{ req.en_clk == 1;
                           req.period_ns == 10;    }) //TODO: SOLUCIONAR PROBLEMA CON PASO DE VALOR EN TEST A TRAVÉS DE LA SEQUENCIA; APARECE UN VALOR ALEATORIO. MIENTRAS SE FIJA EL VALOR A 1000ns y EN a 1.
        $display("Transaction values: EN: %0d, PERIOD: %0d", req.en_clk, req.period_ns);
    endtask : body

endclass : clk_basic_seq 

`endif // _CLK_SEQ