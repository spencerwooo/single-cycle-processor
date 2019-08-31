`timescale 1ns / 1ps

/* Module: Instruction Register
 */

module instruction_register(
    input wire       rst,
    input wire       clk,
    input wire[15:0] imm16, // 16 digit immediate number
    input wire[25:0] imm26, // 26 digit immediate number

    );
endmodule
