/* Module: Instruction Control Signals
 *
 * Define: LUI, ADDIU, ADD, LW, SW, BEQ, J, SUBU
 */

// Instruction Memory Capacity
`define IM_LENGTH   1023

// R-Type instructions
`define INST_R_TYPE 6'b000000 // R-Type opcode
`define FUNC_ADD    6'b100000 // ADD instruction function
`define FUNC_SUBU   6'b100011 // SUBU instruction function

// I-Type instructions
`define INST_LUI    6'b001111 // LUI
`define INST_ADDIU  6'b001001 // ADDIU
`define INST_LW     6'b100011 // LW
`define INST_SW     6'b101011 // SW
`define INST_BEQ    6'b000100 // BEQ

// J-Type instructions
`define INST_J      6'b000010 // J\
