`timescale 1ps/1ps
 
module simulacao32;
logic clk;
logic rst;
logic [4:0]inst19_15;
logic [4:0]inst24_20;
logic [4:0]inst11_7;
logic [6:0]inst6_0;
logic [31:0]inst31_0;

//processador
Processor CPU(.Clk(clk), .Reset(rst), .inst19_15(inst19_15), .inst24_20(inst24_20), .inst11_7(inst11_7), .inst6_0(inst6_0), .inst31_0(inst31_0));

//gerador de clock e reset
    localparam CLKPERIOD = 1000;
    localparam CLKDELAY = CLKPERIOD/2;
 
initial begin
    	clk = 1'b0;
    	rst = 1'b1;
    	#(CLKPERIOD)
    	rst = 1'b0;
	$monitor($time, "instrucao(%b)",inst31_0);
end
 always #(CLKDELAY) clk = ~clk;

endmodule
