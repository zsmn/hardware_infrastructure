module ControlUnit(
input logic Clk, Reset,
output logic PCwrite, AluSrcA, ImemRead, LoadIr,
output logic [1:0]AluSrcB,
output logic [2:0]ALUFct
);

enum logic[1:0]{SendEnd, AttEnd, InitState}NextStage, Stage;

always_ff@(posedge Clk or posedge Reset) begin
	if(Reset) 
		Stage <= InitState;
	else
		Stage <= NextStage;
end

always_comb begin
	case(Stage)
	InitState:begin
		PCwrite = 1'b0;
		AluSrcA = 1'b0;
		ImemRead = 1'b0;
		AluSrcB = 2'b00;
		ALUFct = 3'b000;
		LoadIr = 1'b0;
		NextStage = SendEnd;
	end
	SendEnd: begin
		//pego o endereço de pc para ler da memoriaa instrução
		//faço pc +4
		PCwrite = 1'b0;
		AluSrcA = 1'b0;
		ImemRead = 1'b0;
		AluSrcB = 2'b01;
		ALUFct = 3'b001;
		LoadIr = 1'b0;
		NextStage = AttEnd;
	end
	AttEnd: begin
		//atualizo pc com pc+4
		//escrevo o registrador de instrução com a instrução atual
		PCwrite = 1'b1;
		AluSrcA = 1'b0;
		ImemRead = 1'b0;
		AluSrcB = 2'b01;
		ALUFct = 3'b001;
		LoadIr = 1'b1;
		NextStage = SendEnd;
	end
	endcase
end

endmodule 