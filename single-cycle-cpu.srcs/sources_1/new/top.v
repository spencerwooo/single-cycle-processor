`timescale 1ns / 1ps
`include "instruction_head.v"

/* Module: CPU's hierarchical top module
 */

module top(
           input wire clk,
           input wire rst
       );

// Instruction fetch module i/o
wire[31:0] pc;
wire[31:0] npc;
wire[31:0] instruction;

// Decode instruction type and function
wire[5:0]  opcode;
wire[5:0]  func;

// Decode registers
wire[4:0]  rs;
wire[4:0]  rt;
wire[4:0]  rd;
wire[4:0]  sa;

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
assign imm16  = instruction[15:0];
assign imm26  = instruction[25:0];

// MUX
wire[4:0]  reg_dst_out;
wire[31:0] reg_src_out;
wire[31:0] alu_src_out;

// Data memory
wire[31:0] read_mem_data;

// Extend module
wire[31:0] ext_out;

// Register file
wire[31:0] reg1_data;
wire[31:0] reg2_data;

// ALU
wire[31:0] alu_result;

// Control signals
wire[`ALU_OP_LENGTH - 1:0]  alu_op;
wire                        reg_dst;
wire                        reg_write;
wire                        alu_src;
wire                        mem_write;
wire[`REG_SRC_LENGTH - 1:0] reg_src;
wire[`EXT_OP_LENGTH - 1:0]  ext_op;
wire[`NPC_OP_LENGTH  - 1:0] npc_op;
wire                        zero;

/*
 * Instantiate modules
 */

// Instruction fetch modules: PC, NPC and Instruction_Memory
pc ZAN_PC(.clk(clk),
          .rst(rst),
          .npc(npc),
          .pc(pc));

npc ZAN_NPC(.npc_op(npc_op),
            .pc(pc),
            .imm16(imm16),
            .imm26(imm26),
            .npc(npc));

instruction_memory ZAN_INSTR_MEM(.pc_addr(pc[11:2]),
                                 .instruction(instruction));

// Module: Control Unit
control_unit ZAN_CU(.opcode(opcode),
                    .sa(sa),
                    .func(func),
                    .zero(zero),
                    .alu_op(alu_op),
                    .reg_write(reg_write),
                    .reg_dst(reg_dst),
                    .alu_src(alu_src),
                    .mem_write(mem_write),
                    .reg_src(reg_src),
                    .ext_op(ext_op),
                    .npc_op(npc_op));

// Module: Data Memory
data_memory ZAN_DATA_MEM(.clk(clk),
                         .mem_write(mem_write),
                         .mem_addr(alu_result[11:2]),
                         .write_mem_data(reg2_data),
                         .read_mem_data(read_mem_data));

// Module: Multiplexers
mux_reg_dst ZAN_MUX_REGDST(.reg_dst(reg_dst),
                           .mux_in_0(rt),
                           .mux_in_1(rd),
                           .mux_out(reg_dst_out));

mux_reg_src ZAN_MUX_REGSRC(.reg_src(reg_src),
                           .mux_in_0(alu_result),
                           .mux_in_1(read_mem_data),
                           .mux_in_2(ext_out),
                           .mux_out(reg_src_out));

mux_alu_src ZAN_MUX_ALUSRC(.alu_src(alu_src),
                           .mux_in_0(reg2_data),
                           .mux_in_1(ext_out),
                           .mux_out(alu_src_out));

// Module: Register File
register_file ZAN_REG_FILE(.clk(clk),
                           .reg_write(reg_write),
                           .read_reg1_addr(rs),
                           .read_reg2_addr(rt),
                           .write_reg_addr(reg_dst_out),
                           .write_data(reg_src_out),
                           .reg1_data(reg1_data),
                           .reg2_data(reg2_data));

// Module: ALU
alu ZAN_ALU(.alu_op(alu_op),
            .alu_input1(reg1_data),
            .alu_input2(alu_src_out),
            .sa(sa),
            .alu_result(alu_result),
            .zero(zero));

// Module: extender shifter two-in-one
extend ZAN_EXTEND(.imm16(imm16),
                  .ext_op(ext_op),
                  .ext_out(ext_out));
endmodule
