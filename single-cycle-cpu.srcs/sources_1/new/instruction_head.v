/* Module: Instruction Control Signals
 *
 * Define: LUI, ADDIU, ADD, LW, SW, BEQ, J, SUBU
 */

// Instruction Memory Capacity
`define IM_LENGTH      1023
// Default register data (32 digits of 0)
`define INITIAL_VAL    32'h00000000

// R-Type instructions
`define INST_R_TYPE    6'b000000 // R-Type opcode, decode via function code
`define FUNC_ADD       6'b100000 // ADD instruction function
`define FUNC_SUBU      6'b100011 // SUBU instruction function

// I-Type instructions
`define INST_LUI       6'b001111 // LUI
`define INST_ADDIU     6'b001001 // ADDIU
`define INST_LW        6'b100011 // LW
`define INST_SW        6'b101011 // SW
`define INST_BEQ       6'b000100 // BEQ

// J-Type instructions
`define INST_J         6'b000010 // J

// ALU Control Signals
`define ALU_OP_LENGTH  3         // Bits of signal ALUOp
`define ALU_OP_ADD     3'b001    // ALUOp ADD
`define ALU_OP_SUB     3'b010    // ALUOp SUB
`define ALU_OP_DEFAULT 3'b111    // ALUOp default value
