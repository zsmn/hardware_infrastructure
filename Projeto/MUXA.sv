module MUXA(
input logic AluSrcA, 
input logic[64-1:0]dadoA, dadoB,
output logic [64-1:0]dadoOUT
);

always_comb begin
	if(!AluSrcA) dadoOUT = dadoA;
	else dadoOUT = dadoB;
end

endmodule 