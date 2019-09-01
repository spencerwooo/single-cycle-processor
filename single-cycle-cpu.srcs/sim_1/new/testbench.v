`timescale 1ns / 1ps

/*
 * Module: testbench
 */

module testbench();
reg clk;
reg rst;
top ZAN_TOP(clk, rst);

initial begin
    // Load instructions
    $readmemh("../../../single-cycle-cpu.tbcode/instructions.txt", ZAN_TOP.ZAN_INSTR_MEM.im);
    // Load register initial values
    $readmemh("../../../single-cycle-cpu.tbcode/register.txt", ZAN_TOP.ZAN_REG_FILE.gpr);

    rst = 1;
    clk = 0;

    #30 rst = 0;
    $display("%h", ZAN_TOP.ZAN_REG_FILE.gpr[9]);
    $display("%h", ZAN_TOP.ZAN_REG_FILE.gpr[10]);
    #80 $display("%h", ZAN_TOP.ZAN_REG_FILE.gpr[11]);
    #20 $stop;
end

always
    #20 clk = ~clk;
endmodule
