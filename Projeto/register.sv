module register(
            input clk,
            input reset,
            input regWrite,
            input logic [64-1:0] DadoIn,
            output logic [64-1:0] DadoOut
        );

always_ff @(posedge clk or posedge reset)
begin	
	if(reset)begin
		DadoOut <= 64'd0;
	end
	else
	begin
		if (regWrite) begin
		    DadoOut <= DadoIn;
		end
	end		
end
endmodule 