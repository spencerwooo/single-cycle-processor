`timescale 1ns / 1ps
`include "instruction_head.v"

/*
 * Multiplexer modules
 */

/*
 * Module: RegDst mux module, determines the intake of register write
 */
module mux_reg_dst(
           input wire                              clk,
           input wire                              reg_dst,  // mux control signal: RegDst
           input wire[4:0]                         mux_in_0, // mux input source: rt
           input wire[4:0]                         mux_in_1, // mux input source: rd

           output reg[4:0]                         mux_out   // mux output
       );

always @ (posedge clk) begin
    case (reg_dst)
        `REG_DST_RT:
            mux_out <= mux_in_0;
        `REG_DST_RD:
            mux_out <= mux_in_1;
    endcase
end
endmodule

/*
 * Module: RegSrc mux module, determines the register source
 */
module mux_reg_src(
           input wire                              clk,
           input wire[`REG_SRC_LENGTH - 1:0]       reg_src,  // mux control signal: RegSrc
           input wire[31:0]                        mux_in_0, // mux input source: ALU result
           input wire[31:0]                        mux_in_1, // mux input source: Data Memory
           input wire[31:0]                        mux_in_2, // mux input source: Extend module output

           output reg[31:0]                        mux_out   // mux output
       );

always @ (posedge clk) begin
    case (reg_src)
        `REG_SRC_ALU:
            mux_out <= mux_in_0;
        `REG_SRC_MEM:
            mux_out <= mux_in_1;
        `REG_SRC_IMM:
            mux_out <= mux_in_2;
        default:
            mux_out <= mux_in_0;
    endcase
end
endmodule

/*
 * Module: ALUSrc mux module, determines the ALU source
 */
module mux_alu_src(
           input wire                              clk,
           input wire                              alu_src,  // mux control signal: ALUSrc
           input wire[31:0]                        mux_in_0, // mux input source: register file
           input wire[31:0]                        mux_in_1, // mux input source: immediate num

           output reg[31:0]                        mux_out   // mux output
       );

always @ (posedge clk) begin
    case (alu_src)
        `ALU_SRC_REG:
            mux_out <= mux_in_0;
        `ALU_SRC_IMM:
            mux_out <= mux_in_1;
    endcase
end
endmodule
