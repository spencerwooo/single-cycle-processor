`timescale 1ns / 1ps
`include "instruction_head.v"

/* Module: Instruction Memory
 */

module instruction_memory(
           input wire[11:2]  pc_addr,

           output wire[31:0] instruction
       );

reg[31:0] im[`IM_LENGTH:0];
assign instruction = im[pc_addr];
endmodule
