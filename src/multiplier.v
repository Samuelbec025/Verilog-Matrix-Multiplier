`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: KLE Technological University
// Engineer: Samuel S
// 
// Create Date: 11.05.2024 23:25:43
// Design Name: 8x8 Matrix Multiplier
// Module Name: mat_mul
// Project Name: Matrix Multiplication
// Target Devices: FPGA Xilinx Spartan 6
// Tool Versions: AMD Vivaldo ML Edition
// Description: This module implements an 8x8 matrix multiplier.
//              It takes two 8x8 matrices as input and produces their
//              multiplication result as output.
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// - This module is designed to demonstrate
//   matrix multiplication in Verilog.
// - The matrices are assumed to be 8x8 with each element being 3 bits wide.
// - The module includes synchronization logic for clocked operation.
//////////////////////////////////////////////////////////////////////////////////


module matrix_mult
    (   input Clock,
        input reset, //active high reset
        input Enable,    //This should be High throughout the matrix multiplication process.
        input [71:0] A,
        input [71:0] B,
        output reg [71:0] C,
        output reg done     //A High indicates that multiplication is done and result is available at C.
    );   

    // Temporary registers
    reg signed [7:0] matA [2:0][2:0];
    reg signed [7:0] matB [2:0][2:0];
    reg signed [15:0] matC [2:0][2:0];  // Increased to 16 bits to handle intermediate products
    integer i, j, k;  // loop indices
    reg first_cycle;  // indicates it's the first clock cycle after Enable went High.
    reg end_of_mult;  // indicates multiplication has ended.
    reg signed [15:0] temp;  // a temporary register to hold the product of two elements.

    // Matrix multiplication
    always @(posedge Clock or posedge reset) begin
        if (reset == 1) begin  // Active high reset
            i <= 0;
            j <= 0;
            k <= 0;
            temp <= 0;
            first_cycle <= 1;
            end_of_mult <= 0;
            done <= 0;
            // Initialize all the matrix register elements to zero
            for (i = 0; i <= 2; i = i + 1) begin
                for (j = 0; j <= 2; j = j + 1) begin
                    matA[i][j] <= 8'd0;
                    matB[i][j] <= 8'd0;
                    matC[i][j] <= 16'd0;
                end 
            end 
        end else if (Enable == 1) begin  // for the positive edge of Clock
            if (first_cycle == 1) begin  // the very first cycle after Enable is high
                // Convert the matrices which are in a 1-D array to 2-D matrices first
                for (i = 0; i <= 2; i = i + 1) begin
                    for (j = 0; j <= 2; j = j + 1) begin
                        matA[i][j] <= A[(i*3+j)*8+:8];
                        matB[i][j] <= B[(i*3+j)*8+:8];
                        matC[i][j] <= 16'd0;
                    end 
                end
                // Re-initialize registers before the start of multiplication
                first_cycle <= 0;
                end_of_mult <= 0;
                temp <= 0;
                i <= 0;
                j <= 0;
                k <= 0;
            end else if (end_of_mult == 0) begin  // multiplication hasn't ended. Keep multiplying.
                // Actual matrix multiplication starts from now on
                temp = matA[i][k] * matB[k][j];
                matC[i][j] <= matC[i][j] + temp;  // Accumulate the product
                
                if (k == 2) begin
                    k <= 0;
                    if (j == 2) begin
                        j <= 0;
                        if (i == 2) begin
                            i <= 0;
                            end_of_mult <= 1;
                        end else begin
                            i <= i + 1;
                        end
                    end else begin
                        j <= j + 1;
                    end    
                end else begin
                    k <= k + 1;
                end
            end else if (end_of_mult == 1) begin  // End of multiplication has reached
                // Convert 3 by 3 matrix into a 1-D matrix
                for (i = 0; i <= 2; i = i + 1) begin  // run through the rows
                    for (j = 0; j <= 2; j = j + 1) begin  // run through the columns
                        C[(i*3+j)*8+:8] <= matC[i][j][7:0];  // Take the lower 8 bits of the result
                    end
                end   
                done <= 1;  // Set this output High, to say that C has the final result
            end
        end else begin
            done <= 0;  // Reset done when Enable goes low
        end
    end
 
endmodule
