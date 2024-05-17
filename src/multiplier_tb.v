module tb_matrix_mult;  // Testbench module

reg [71:0] A;
reg [71:0] B;
wire [71:0] C;
reg Clock, reset, Enable;
wire done;
reg [7:0] matC [2:0][2:0];
integer i, j;
parameter Clock_period = 10;  // Change clock period here

initial begin
    Clock = 1;
    reset = 1;
    Enable = 0;
    #100;  // Apply reset for 100 ns before applying inputs
    reset = 0;
    #Clock_period;
    // Input matrices are set and Enable input is set High
    A = {8'd9, 8'd8, 8'd7, 8'd6, 8'd5, 8'd4, 8'd3, 8'd2, 8'd1};
    B = {8'd1, 8'd9, 8'd8, 8'd7, 8'd6, 8'd5, 8'd4, 8'd3, 8'd2};
    Enable = 1;
    
    // Wait until 'done' output goes High
    wait(done);
    
    #(Clock_period / 2);  // Wait for half a clock cycle
    
    // Convert the 1-D matrix into 2-D format to easily verify the results
    for (i = 0; i <= 2; i = i + 1) begin
        for (j = 0; j <= 2; j = j + 1) begin
            matC[i][j] = C[(i * 3 + j) * 8 +: 8];
        end
    end
    
    // Check results
    $display("Result matrix C:");
    for (i = 0; i <= 2; i = i + 1) begin
        for (j = 0; j <= 2; j = j + 1) begin
            $write("%d ", matC[i][j]);
        end
        $display;
    end
    
    // Expected result is (93, 150, 126, 57, 96, 81, 21, 42, 36)
    // Verify results
    if (matC[0][0] !== 93 || matC[0][1] !== 150 || matC[0][2] !== 126 ||
        matC[1][0] !== 57 || matC[1][1] !== 96 || matC[1][2] !== 81 ||
        matC[2][0] !== 21 || matC[2][1] !== 42 || matC[2][2] !== 36) begin
        $display("Test failed!");
    end else begin
        $display("Test passed!");
    end
    
    #Clock_period;  // Wait for one clock cycle
    Enable = 0;  // Reset Enable
    #Clock_period;
    $stop;  // Stop the simulation, as we have finished testing the design
end

// Generate a 50 MHz clock for testing the design
always #(Clock_period / 2) Clock <= ~Clock;

// Instantiate the matrix multiplier
matrix_mult matrix_multiplier (
    .Clock(Clock), 
    .reset(reset), 
    .Enable(Enable), 
    .A(A),
    .B(B), 
    .C(C),
    .done(done)
);

endmodule
