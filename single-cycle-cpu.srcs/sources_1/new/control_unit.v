`timescale 1ns / 1ps
`include "instruction_head.v"

/* Module: Control Unit
 */

module control_unit(
           input wire      clk,
           input wire      rst,
           input wire[5:0] opcode,
           input wire[4:0] sa,
           input wire[5:0] func,
           input wire      zero, // For instruction BEQ, determining the result of rs-rt

           output wire[`ALU_OP_LENGTH - 1:0] alu_op,
           output wire                       reg_write
       );

wire type_r, add, subu;

// Whether instruction is R-Type
assign type_r    = (opcode == `INST_R_TYPE)       ? 1 : 0;
// Whether function is ADD
assign add       = (type_r && func == `FUNC_ADD)  ? 1 : 0;
// Whether function is SUB
assign subu      = (type_r && func == `FUNC_SUBU) ? 1 : 0;

// Determine ALUOp signal
assign alu_op    = add ? `ALU_OP_ADD :
       subu ? `ALU_OP_SUB : `ALU_OP_DEFAULT;
// Determine RegWrite signal
assign reg_write = (type_r || add || subu) ? 1 : 0;
endmodule
