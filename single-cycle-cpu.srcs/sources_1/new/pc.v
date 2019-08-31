`timescale 1ns / 1ps
`include "instruction_head.v"

/* Module: Program counter
 */

module pc(
           input wire       clk,
           input wire       rst,
           input wire[31:0] npc,

           output reg[31:0] pc
       );

always @(posedge rst or posedge clk) begin
    if (rst) begin
        pc <= `INITIAL_VAL;
    end
    else begin
        pc <= npc;
    end
end
endmodule
