`ifndef _CLK_TR
`define _CLK_TR

class clk_basic_tr extends uvm_sequence_item;
    rand bit en_clk;
    rand int period_ns;
    bit clk;

    //constraint period_c{period_ns==1000;}     

    // Utility and field macros
    `uvm_object_utils_begin(clk_basic_tr)  
        `uvm_field_int(en_clk, UVM_ALL_ON)
        `uvm_field_int(period_ns, UVM_ALL_ON)
    `uvm_object_utils_end

    // Constructor
    function new(string name="" );
        super.new(name);
    endfunction

endclass : clk_basic_tr

`endif //_CLK_TR