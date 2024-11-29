`ifndef _CLK_SEQ
`define _CLK_SEQ

`include "transaction_clk.sv"

class clk_rst_basic_seq extends uvm_sequence#(clk_basic_tr);
    bit en_clk;
    int period_ns;

    `uvm_object_utils(clk_basic_tr)

    function new(string name = "clk_basic_seq");
        super.new(name);
    endfunction

    virtual task body();
        `uvm_info(get_type_name(), "clk_basic_seq created", UVM_LOW);
        `uvm_do_with(req,{ req.en_clk == en_clk;
                           req.period_ns == period_ns;    });
    endtask : body

endclass : clk_rst_basic_seq 

`endif // _CLK_SEQ