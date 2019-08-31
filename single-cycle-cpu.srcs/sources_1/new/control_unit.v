`timescale 1ns / 1ps
`include "instruction_head.v"

/* Module: Control Unit
 */

module control_unit(
           input wire[5:0] opcode,
           input wire[4:0] sa,
           input wire[5:0] func,
           input wire      zero, // For instruction BEQ, determining the result of rs-rt

           output wire[`ALU_OP_LENGTH - 1:0] alu_op,
           output wire                       reg_write
       );

wire type_r, add, sub;
assign type_r    = (opcode == `INST_R_TYPE)       ? 1 : 0;
assign add       = (type_r && func == `FUNC_ADD)  ? 1 : 0;
assign subu      = (type_r && func == `FUNC_SUBU) ? 1 : 0;

assign alu_op    = add ? `ALU_OP_ADD :
                   sub ? `ALU_OP_SUB : `ALU_OP_DEFAULT;
assign reg_write = (type_r || add || subu) ? 1 : 0;
endmodule
