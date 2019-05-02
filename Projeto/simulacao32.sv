`timescale 1ps/1ps
 
module simulacao32;
logic clk;
logic rst;

//processador
Processor CPU(.Clk(clk), .Reset(rst));

//gerador de clock e reset
    localparam CLKPERIOD = 1000;
    localparam CLKDELAY = CLKPERIOD/2;
 
initial begin
    	clk = 1'b0;
    	rst = 1'b1;
    	#(CLKPERIOD)
    	rst = 1'b0;
end
 always #(CLKDELAY) clk = ~clk;

endmodule
