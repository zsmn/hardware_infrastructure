module regcausa(
            input clk,
            input reset,
            input regWrite,
            input logic [1:0] DadoIn,
            output logic [1:0] DadoOut
        );

always_ff @(posedge clk or posedge reset)
begin	
	if(reset)begin
		DadoOut <= 2'd0;
	end
	else
	begin
		if (regWrite) begin
		    DadoOut <= DadoIn;
		end
	end		
end
endmodule 
