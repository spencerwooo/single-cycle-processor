`timescale 1ns / 1ps

/*
 * Testbench
 */

module testbench();
reg clk;
reg rst;
top ZAN_TOP(clk, rst);

initial begin
    // // Load instructions
    // $readmemh("../../../tests/instructions.txt", ZAN_TOP.ZAN_INSTR_MEM.im);
    // // Load register initial values
    // $readmemh("../../../tests/register.txt", ZAN_TOP.ZAN_REG_FILE.gpr);
    // // Load memory data initial values
    // $readmemh("../../../tests/data_memory.txt", ZAN_TOP.ZAN_DATA_MEM.dm);

    rst = 1;
    clk = 0;

    #30 rst = 0;
    // #80 $display("$10 value: %h", ZAN_TOP.ZAN_REG_FILE.gpr[10]);
    #500 $stop;
end

always
    #20 clk = ~clk;
endmodule
