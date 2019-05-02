module suber(
    input logic [63:0]DadoIn, 
	output logic [63:0]DadoOut
);

always_comb begin
    DadoOut = (DadoIn -64'd4);
end

endmodule