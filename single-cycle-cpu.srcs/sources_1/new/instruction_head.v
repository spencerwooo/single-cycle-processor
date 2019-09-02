/* Module: Instruction Control Signals
 *
 * Define: LUI, ADDIU, ADD, LW, SW, BEQ, J, SUBU
 */

// Instruction Memory Capacity
`define IM_LENGTH       1023
// Data Memory Capacity
`define DM_LENGTH       1023
// Default register data (32 digits of 0)
`define INITIAL_VAL     32'h00000000

// R-Type instructions
`define INST_R_TYPE     6'b000000  // R-Type opcode, decode via function code
`define FUNC_ADD        6'b100000  // ADD func code
`define FUNC_SUBU       6'b100011  // SUBU func code

// I-Type instructions
`define INST_LUI        6'b001111  // LUI
`define INST_ADDIU      6'b001001  // ADDIU
`define INST_LW         6'b100011  // LW
`define INST_SW         6'b101011  // SW
`define INST_BEQ        6'b000100  // BEQ

// J-Type instructions
`define INST_J          6'b000010  // J

// ALU Control Signals
`define ALU_OP_LENGTH   3          // Bits of signal ALUOp
`define ALU_OP_DEFAULT  3'b000     // ALUOp default value
`define ALU_OP_ADD      3'b001     // ALUOp ADD
`define ALU_OP_SUB      3'b010     // ALUOp SUB

// RegDst Control Signals
`define REG_DST_RT      1'b0       // Register write destination: rt
`define REG_DST_RD      1'b1       // Register write destination: rd

// ALUSrc Control Signals
`define ALU_SRC_REG     1'b0       // ALU source: register file
`define ALU_SRC_IMM     1'b1       // ALU Source: immediate

// RegSrc Control Signals
`define REG_SRC_LENGTH  2          // Bits of signal RegSrc
`define REG_SRC_DEFAULT 2'b00      // Register default value
`define REG_SRC_ALU     2'b01      // Register write source: ALU
`define REG_SRC_MEM     2'b10      // Register write source: Data Memory
`define REG_SRC_IMM     2'b11      // Register write source: Extended immediate

// ExtOp Control Signals
`define EXT_OP_LENGTH   2          // Bits of Signal ExtOp
`define EXT_OP_DEFAULT  2'b00      // ExtOp default value
`define EXT_OP_SFT16    2'b01      // LUI: Shift Left 16
`define EXT_OP_SIGNED   2'b10      // ADDIU: `imm16` signed extended to 32 bit
`define EXT_OP_UNSIGNED 2'b11      // LW, SW: `imm16` unsigned extended to 32 bit

// NPCOp Control Signals
`define NPC_OP_LENGTH   3          // Bits of NPCOp
`define NPC_OP_DEFAULT  3'b000     // NPCOp default value
`define NPC_OP_NEXT     3'b001     // Next instruction: normal
`define NPC_OP_JUMP     3'b010     // Next instruction: J
`define NPC_OP_OFFSET   3'b011     // Next instruction: BEQ
