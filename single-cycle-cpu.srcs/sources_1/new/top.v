`timescale 1ns / 1ps
`include "instruction_head.v"

/* Module: CPU's hierarchical top module
 */

module top(
           input  wire       clk,
           input  wire       rst
       );

// Instruction fetch module i/o
wire[31:0] pc;
wire[31:0] npc;
wire[31:0] instruction;

// Decode instruction type and function
wire[5:0] opcode;
wire[5:0] func;

// Decode registers
wire[4:0] rs;
wire[4:0] rt;
wire[4:0] rd;
wire[4:0] sa;

// Decode 16 bit and 26 bit immediates
wire[15:0] imm16;
wire[25:0] imm26;

// Assign decoded instruction to variables
assign opcode = instruction[31:26];
assign func   = instruction[5:0];
assign rs     = instruction[25:21];
assign rt     = instruction[20:16];
assign rd     = instruction[15:11];
assign sa     = instruction[10:6];

wire[31:0] reg1_data;
wire[31:0] reg2_data;

wire[31:0] alu_result;

// Write register control signal
wire reg_write;
// ALU operator control signal
wire[`ALU_OP_LENGTH - 1:0] alu_op;
// ALU zero control signal
wire zero;

/*
 * Instantiate modules
 */

// Instruction fetch modules: PC, NPC and Instruction_Memory
pc ZAN_PC(.clk(clk),
          .rst(rst),
          .npc(npc),
          .pc(pc));

npc ZAN_NPC(.pc(pc),
            .npc(npc));

instruction_memory ZAN_INSTR_MEM(.pc_addr(pc[11:2]),
                                 .instruction(instruction));

// Module: Control Unit
control_unit ZAN_CU(.clk(clk),
                    .rst(rst),
                    .opcode(opcode),
                    .sa(sa),
                    .func(func),
                    .zero(zero),
                    .alu_op(alu_op),
                    .reg_write(reg_write));

// Mux: RegDst
// mux_reg_dst ZAN_MUX_REGDST(.);

// Module: Register File
register_file ZAN_REG_FILE(.clk(clk),
                           .reg_write(reg_write),
                           .read_reg1_addr(rs),
                           .read_reg2_addr(rt),
                           .write_reg_addr(rd),
                           .write_data(alu_result),
                           .reg1_data(reg1_data),
                           .reg2_data(reg2_data));

// Module: ALU
alu ZAN_ALU(.alu_op(alu_op),
            .alu_input1(reg1_data),
            .alu_input2(reg2_data),
            .sa(sa),
            .alu_result(alu_result),
            .zero(zero));
endmodule
