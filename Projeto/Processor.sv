module Processor(
	input logic Clk, Reset, 
	output logic [4:0]inst19_15,
	output logic [4:0]inst24_20,
	output logic [4:0]inst11_7,
	output logic [6:0]inst6_0,
	output logic [31:0]inst31_0
);

//fios para ligar os modulos
wire [63:0]Fio_PCin; //liga o alu_out ao PC
wire [63:0]Fio_PCout; //liga PC ao raddres, separar os 32 bits menos significativos, liga PC ao muxa
wire [63:0]Fio_muxAula; // liga o muxa a alu
wire [63:0]Fio_muxBula; // liga o muxb  a alu
wire Fio_PCwrite; // fio que funciona como flag para ver se vamos ter que escrever algo em PC
wire Fio_Wr; //flag que indica que se vamos escrever ou nao na memoria; 0 = nao escreve nada
wire Fio_AluSrcA; // seletor do meu mux A
wire [1:0]Fio_AluSrcB; //seletor do meu mux B
wire [2:0]Fio_Alufunct;
wire [31:0]Fio_Adressin; //liga o alu_out ao PC
wire [31:0]MemData;
wire Fio_LoadIr;
wire [63:0]Fio_muxBancRegs;
wire [63:0]Fio_bancRegA;
wire [63:0]Fio_bancRegB;
wire [63:0]Fio_dMemRegC;

//fios fantasmas
wire overflow;
wire negativo;
wire zero;
wire igual;
wire maior;
wire menor;

wire [63:0]Fio_regBmuxB;
wire [63:0]Fio_regAmuxA;
wire [63:0]Fio_dadoC;
wire [63:0]Fio_dadoD;

wire [63:0]Fio_Outwrite;

wire [31:0]Fio_fantasma1;
wire [31:0]Fio_fantasma2;

//submodulos
register PC(.clk(Clk), .reset(Reset), .regWrite(Fio_PCwrite), .DadoIn(Fio_PCin), .DadoOut(Fio_PCout), .DadoOut_inst(Fio_Adressin));
Memoria32 MenInst(.raddress(Fio_Adressin), .waddress(Fio_fantasma1), .Clk(Clk), .Datain(Fio_fantasma2), .Dataout(MemData), .Wr(Fio_Wr));
MUXA MuxA(.AluSrcA(Fio_AluSrcA), .dadoA(Fio_PCout), .dadoB(Fio_regAmuxA), .dadoOUT(Fio_muxAula));
MUXB MuxB(.AluSrcB(Fio_AluSrcB), .dadoA(Fio_regBmuxB), .dadoB(64'd4), .dadoC(Fio_dadoC), .dadoD(Fio_dadoD), .dadoOUT(Fio_muxBula));
ula64 ALU(Fio_muxAula, Fio_muxBula, Fio_Alufunct, Fio_PCin, overflow, negativo, zero, igual, maior, menor);
register aluOut(.clk(Clk), .reset(Reset), .regWrite(Fio_PCWrite), .DadoIn(Fio_PCin), .DadoOut(Fio_Outwrite));
Instr_Reg_RISC_V regInst(Clk, Reset, Fio_LoadIr, MemData, inst19_15, inst24_20, inst11_7, inst6_0, inst31_0);
ControlUnit Unidade_Controle(.Clk(Clk), .Reset(Reset), .PCwrite(Fio_PCwrite), .AluSrcA(Fio_AluSrcA), .ImemRead(Fio_Wr),.LoadIr(Fio_LoadIr), .AluSrcB(Fio_AluSrcB), .ALUFct(Fio_Alufunct));
bancoReg BancRegs (.clock(Clk), .write(Fio_PCwrite), .reset(Reset), .regreader1(inst19_15), .regreader2(inst24_20), .regwriteaddress(inst11_7), .datain(Fio_muxBancRegs), .dataout1(Fio_bancRegA), .dataout2(Fio_bancRegB));
register regTempA(.clk(Clk), .reset(Reset), .regWrite(Fio_PCWrite), .DadoIn(Fio_bancRegA), .DadoOut(Fio_regAmuxA));
register regTempB(.clk(Clk), .reset(Reset), .regWrite(Fio_PCWrite), .DadoIn(Fio_bancRegB), .DadoOut(Fio_regBmuxB));
// parte da memoria, criar o MuxC
//Memoria64 DMem(.Clk(Clk), .Wr(Fio_Wr), .raddress(), .waddress(), .Datain(), .Dataout(Fio_dMemRegC));
//register regTempC(.clk(Clk), .reset(Reset), .regWrite(Fio_PCWrite), .DadoIn(Fio_dMemRegC), .DadoOut());
//MUXC MuxC()

endmodule
