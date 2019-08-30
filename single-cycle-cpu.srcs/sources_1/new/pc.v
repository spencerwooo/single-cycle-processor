`timescale 1ns / 1ps

/* Module: Program counter
 */

module pc(
           input wire       clk,
           input wire       rst,
           input wire[31:0] npc_addr,
           output reg[31:0] pc_addr
       );

always @(posedge rst or posedge clk) begin
    if (rst) begin
        pc_addr <= 32'h00000000;
    end
    else begin
        pc_addr <= npc_addr;
    end
end
endmodule
