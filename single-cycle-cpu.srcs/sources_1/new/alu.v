`timescale 1ns / 1ps
`include "instruction_head.v"

/* Module: ALU
 */

module alu(
           input wire[`ALU_OP_LENGTH - 1:0] alu_op, // ALU Operator signal

           input wire[31:0]                 alu_input1,
           input wire[31:0]                 alu_input2,
           input wire[4:0]                  sa,

           output wire[31:0] alu_result,
           output wire       zero
       );

reg[32:0] alu_reg;

assign alu_result = alu_reg[31:0];
assign zero       = (alu_reg == 0) ? 1'b1 : 1'b0;

always @ (*) begin
    case (alu_op)
        `ALU_OP_ADD:
            alu_reg <= {alu_input1[31], alu_input1} + {alu_input2[31], alu_input2};
        `ALU_OP_SUB:
            alu_reg <= {alu_input1[31], alu_input1} - {alu_input2[31], alu_input2};
        default:
            alu_reg <= {alu_input2[31], alu_input2};
    endcase
end
endmodule
