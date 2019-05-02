module MUX4(
input logic [1:0]AluSrcB, 
input logic[64-1:0]dadoA, dadoB, dadoC, dadoD,
output logic [64-1:0]dadoOUT
);

always_comb begin
	case(AluSrcB)
		2'b00: dadoOUT = dadoA;
		2'b10: dadoOUT = dadoC;
		2'b11: dadoOUT = dadoD;
		default: dadoOUT = dadoB;
	endcase
end

endmodule 
