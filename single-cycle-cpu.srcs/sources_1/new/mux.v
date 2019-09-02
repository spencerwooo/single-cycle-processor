`timescale 1ns / 1ps

/* Multiplexer modules
 */

/* Module: RegDst module, determines the intake of register write
 */
module mux_reg_dst(
           input wire      reg_dst,
           input wire[4:0] mux_in_0,
           input wire[4:0] mux_in_1,

           output reg[4:0] mux_out
       );

always @ (reg_dst or mux_in_0 or mux_in_1) begin
    case (reg_dst)
        1'b0:
            mux_out <= mux_in_0;
        1'b1:
            mux_out <= mux_in_1;
    endcase
end
endmodule
