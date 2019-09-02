`timescale 1ns / 1ps
`include "instruction_head.v"

/* Module: Register File
 */

module register_file(
           input wire        clk,
           input wire        reg_write,      // "Register Write" signal

           input wire[4:0]   read_reg1_addr, // Register rs address
           input wire[4:0]   read_reg2_addr, // Register rt address
           input wire[4:0]   write_reg_addr, // "Write" target register address
           input wire[31:0]  write_data,     // "Write" target register data

           output wire[31:0] reg1_data,      // Register rs data
           output wire[31:0] reg2_data       // Register rt data
       );

// General purpose register
reg[31:0] gpr[31:0];

// Read data from register
assign reg1_data = (read_reg1_addr == 0) ? `INITIAL_VAL : gpr[read_reg1_addr];
assign reg2_data = (read_reg2_addr == 0) ? `INITIAL_VAL : gpr[read_reg2_addr];

always @ (posedge clk) begin
    if (reg_write) begin
        // Write data to register
        gpr[write_reg_addr] <= write_data;
    end
end
endmodule
