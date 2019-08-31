`timescale 1ns / 1ps
`include "instruction_head.v"

/* Module: Next program counter
 */

module npc(
           input wire[31:0]  pc,

           output wire[31:0] npc
       );

wire[31:0] next_inst;

assign next_inst = pc + 4;
assign npc = next_inst;
endmodule
