import uvm_pkg::*;
`include "uvm_macros.svh"

`include "dut_if.sv"
`include "lib_test.sv"
`include "adc_dms_model.sv"

module top;
  dut_if dut_if();
  
  reg_block reg_map(.clk(dut_if.clk), 
                    .rst_n(dut_if.rst_n),
                    .req(dut_if.req),
                    .wr_en(dut_if.wr_en),
                    .addr(dut_if.addr),
                    .wr_data(dut-if.wr_data),
                    .rd_data(dut_if.rd_data),
                    .I_adc_data(dut_if.I_adc_data),
                    .O_coef0(dut_if.O_coef0),
                    .O_coef1(dut_if.O_coef1),
                    .O_coef2(dut_if.O_coef2),
                    .O_coef_div(dut_if.O_coef_div),
                    .O_decimation_ratio(dut_if.O_decimation_ratio),
                    .O_conv_en(dut_if.O_conv_en)
                  );     
  
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    $shm_open("waves.shm");
    $shm_probe("ASM");
	//reset?
  end
  
  initial begin
    //interface to database
    run_test();
  end
    
endmodule : top
