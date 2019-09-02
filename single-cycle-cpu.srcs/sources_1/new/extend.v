`timescale 1ns / 1ps
`include "instruction_head.v"

/* Module: sign extend and shift left two-in-one
 */

module extend(
           input wire[15:0]                 imm16,     // 16 bit immediate
           input wire[`EXT_OP_LENGTH - 1:0] ext_op,    // ExtOp control signal

           output reg[31:0]                 ext_out    // Extend module output
       );

always @ (*) begin
    case (ext_op)
        `EXT_OP_SFT16:
            ext_out <= {imm16, 16'b0};                 // LUI: 16 digit shift left
        `EXT_OP_SIGNED:
            ext_out <= {{16{imm16[15]}}, imm16};       // ADDIU: signed extend of immediate
        `EXT_OP_UNSIGNED:
            ext_out <= {16'b0, imm16};                 // LW, SW: unsigned extend of immediate
        default:
            ext_out <= {16'b0, imm16};                 // Default
    endcase
end
endmodule
