import uvm_pkg::*;
`include "uvm_macros.svh"

`include "dut_if.sv"
`include "lib_test.sv"
`include "adc_dms_model.sv"

module top;
  //instantiate interface
  dut_if my_dut_if();

  //instantiate dut
  reg_block reg_map(.clk(my_dut_if.clk), 
                    .rst_n(my_dut_if.reset_n),
                    .req(my_dut_if.req),
                    .wr_en(my_dut_if.wr_en),
                    .addr(my_dut_if.addr),
                    .wr_data(my_dut_if.wr_data),
                    .rd_data(my_dut_if.rd_data),
                    .I_adc_data(my_dut_if.I_adc_data),
                    .O_coef0(my_dut_if.O_coef0),
                    .O_coef1(my_dut_if.O_coef1),
                    .O_coef2(my_dut_if.O_coef2),
                    .O_coef_div(my_dut_if.O_coef_div),
                    .O_decimation_ratio(my_dut_if.O_decimation_ratio),
                    .O_conv_en(my_dut_if.O_conv_en)
                  );

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    $shm_open("waves.shm");
    $shm_probe("ASM");
    //reset
    my_dut_if.reset_n = 0;
   #5 my_dut_if.reset_n = 1;
   //set up adc data to 0. It is needed because in dut the reg has no default value, it takes it from ADC block and it is expected to be 0 after reset.
   my_dut_if.I_adc_data = 0;
  end

  initial begin
    //interface to database
    uvm_config_db #(virtual dut_if)::set (null, "*", "dut_if", my_dut_if);

    //run tests
    run_test();
  end

endmodule : top
