module register(
            input clk,
            input reset,
            input regWrite,
            input logic [64-1:0] DadoIn,
            output logic [64-1:0] DadoOut, 
	    output logic [32-1:0]DadoOut_inst
        );

always_ff @(posedge clk or posedge reset)
begin	
	if(reset)begin
		DadoOut <= 64'd0;
		DadoOut_inst <= 32'd0;
	end
	else
	begin
		if (regWrite) begin
		    DadoOut <= DadoIn;
		    DadoOut_inst <= DadoIn[31:0];
		end
	end		
end
endmodule 