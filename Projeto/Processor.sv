module Processor(
	input logic Clk, Reset
);
	

//fios para ligar os modulos
wire [63:0]Fio_PCin; //liga o alu_out ao PC
wire [63:0]Fio_PCout; //liga PC ao raddres, separar os 32 bits menos significativos, liga PC ao muxa
wire [63:0]Fio_muxAula; // liga o muxa a alu
wire [63:0]Fio_muxBula; // liga o muxb  a alu
wire Fio_resultPCWrite; // fio que funciona como flag para ver se vamos ter que escrever algo em PC
wire Fio_IMemWR; //flag que indica que se vamos escrever ou nao na memoria; 0 = nao escreve nada
wire [1:0]Fio_AluSrcA; // seletor do meu mux A
wire [1:0]Fio_AluSrcB; //seletor do meu mux B
wire [2:0]Fio_Alufunct;
wire [31:0]Fio_Adressin; //liga o alu_out ao PC
wire [31:0]MemData;
wire Fio_LoadIr;
wire [63:0]Fio_muxBancRegs;
wire [63:0]Fio_bancRegA;
wire [63:0]Fio_bancRegB;
wire [63:0]Fio_dMemRegC;
wire [4:0]Fio_regRead1;
wire [4:0]Fio_regRead2;
wire [4:0]Fio_regWrite;
wire [6:0]inst6_0;
wire [31:0]Fio_allinst;
wire Fio_LoadRegA;
wire Fio_LoadRegB;
wire [63:0]Fio_AluResult;
wire [63:0]Fio_AluOut;
wire Fio_PCsource;
wire Fio_DmemControl;
wire Fio_LoadRegC;
wire [63:0]Fio_regCmux;
wire [1:0]Fio_MemTOregs; //alterado
wire [1:0]Fio_ShiftControl;
wire [5:0]Fio_Nshift;
wire Fio_PcWriteCond;
wire overflow;
wire negativo;
wire Fio_AluZero;
wire Fio_AluGE; //alterado
wire Fio_AluLT; //alterado
wire Fio_AluO; //alterado
wire [63:0]Fio_FlagRD; //alterado
wire Fio_AluEQ; //alterado
wire Fio_AluG; //alterado
wire igual;
wire maior;
wire menor;
wire Fio_WriteReg;
wire [63:0]Fio_regBmuxB;
wire [63:0]Fio_regAmuxA;
wire [63:0]Fio_extensorMux;
wire [63:0]Fio_shiftMux;
wire [63:0]Fio_Outwrite;
wire [63:0]Fio_muxEshift; // alterado
wire Fio_PCwrite;
wire Fio_FlagComp; //alterado
wire Fio_ResetRegA;
wire Fio_AndOut;

//alterados
wire [63:0]Fio_DadoMemOUT;
wire [63:0]Fio_DadoMemIN;
//fios fantasmas
wire [31:0]Fio_fantasma1;
wire [31:0]Fio_fantasma2;
wire [63:0]Fio_fantasma3; //alterado
wire Fio_ShiftSrc;

//execeção
wire [63:0]Fio_fout;
wire [63:0]Fio_EndExp;
wire Fio_srcEnd;
wire Fio_exception;
wire Fio_CausaControl;
wire Fio_EPCcontrol;
wire [63:0]Fio_EpcOut;
wire [63:0]Fio_SuberOut;
wire [63:0]Fio_MuxGout;
wire Fio_SrcInst;
wire [63:0]Fio_CausaOut;

//unidadede controle
ControlUnit Unidade_Controle(
	.Clk(Clk), //
	.Reset(Reset),// 
	.PCwrite(Fio_PCwrite),//
	.AluSrcA(Fio_AluSrcA), //
	.ImemWR(Fio_IMemWR), //
	.LoadIr(Fio_LoadIr), //
	.LoadRegA(Fio_LoadRegA), //
	.LoadRegB(Fio_LoadRegB), //
	.LoadOut(Fio_LoadOut), //
	.WriteReg(Fio_WriteReg), //
	.DMemControl(Fio_DmemControl), //
	.LoadRegC(Fio_LoadRegC), //
	.PCWriteCond(Fio_PcWriteCond), //
	.ShiftScr(Fio_ShiftSrc), //
	.AluSrcB(Fio_AluSrcB), //
	.PCSrc(Fio_PCsource), //
	.MemTOreg(Fio_MemTOregs), //
	.ShiftControl(Fio_ShiftControl), //
	.ALUFct(Fio_Alufunct), //
	.instruction(Fio_allinst), //
	.FlagComp(Fio_FlagComp), //alterado //
	.AluZero(Fio_AluZero),//
	.AluEG(Fio_AluGE),//alterado //
	.AluLT(Fio_AluLT),//alterado //
	.AluO(Fio_AluO),//alterado //
	.ResetRegA(Fio_ResetRegA), //
	.Nshift(Fio_Nshift), //
	.FlagRd(Fio_FlagRD),
	//excecao
	.exception(Fio_exception),
	.EPCcontrol(Fio_EPCcontrol),
	.SrcEnd(Fio_srcEnd),
	.EndExp(Fio_EndExp),
	.CausaControl(Fio_CausaControl),
	.srcInst(Fio_SrcInst)
);

//submodulos
register PC(
	.clk(Clk), 
	.reset(Reset), 
	.regWrite(Fio_resultPCWrite), 
	.DadoIn(Fio_MuxGout), 
	.DadoOut(Fio_PCout)
);


Memoria32 MenInst(
	.raddress(Fio_fout[31:0]), 
	.waddress(Fio_fantasma1), 
	.Clk(Clk), 
	.Datain(Fio_fantasma2), 
	.Dataout(MemData), 
	.Wr(Fio_IMemWR)
);

Instr_Reg_RISC_V regInst(Clk, Reset, Fio_LoadIr, MemData, Fio_regRead1, Fio_regRead2, Fio_regWrite, inst6_0, Fio_allinst);

bancoReg BancRegs(
	.clock(Clk), 
	.write(Fio_WriteReg), 
	.reset(Reset), 
	.regreader1(Fio_regRead1), 
	.regreader2(Fio_regRead2), 
	.regwriteaddress(Fio_regWrite), 
	.datain(Fio_muxBancRegs), 
	.dataout1(Fio_bancRegA), 
	.dataout2(Fio_bancRegB)
);

register regTempA(
	.clk(Clk), 
	.reset(Reset|Fio_ResetRegA), 
	.regWrite(Fio_LoadRegA), 
	.DadoIn(Fio_bancRegA), 
	.DadoOut(Fio_regAmuxA)
);

register regTempB(
	.clk(Clk), 
	.reset(Reset), 
	.regWrite(Fio_LoadRegB), 
	.DadoIn(Fio_bancRegB), 
	.DadoOut(Fio_regBmuxB)
);

MUX4 MuxA(// alterado
	.AluSrcB(Fio_AluSrcA), 
	.dadoA(Fio_PCout), 
	.dadoB(Fio_regAmuxA),
	.dadoC(64'd0),
	.dadoD(Fio_fantasma3), 
	.dadoOUT(Fio_muxAula)
);
MUX2 MuxE(// alterado 
	.AluSrcA(Fio_ShiftSrc),
	.dadoA(Fio_regAmuxA), 
	.dadoB(Fio_extensorMux), 
	.dadoOUT(Fio_muxEshift)
);
MUX4 MuxB(
	.AluSrcB(Fio_AluSrcB), 
	.dadoA(Fio_regBmuxB), 
	.dadoB(64'd4), 
	.dadoC(Fio_extensorMux), 
	.dadoD(Fio_shiftMux), 
	.dadoOUT(Fio_muxBula)
);

MUX4 MuxC( //alterado 
	.AluSrcB(Fio_MemTOregs), 
	.dadoA(Fio_AluOut), 
	.dadoB(Fio_regCmux),
	.dadoC(Fio_PCout), 
	.dadoD(Fio_FlagRD), 
	.dadoOUT(Fio_muxBancRegs)
);

ula64 ALU(Fio_muxAula, Fio_muxBula, Fio_Alufunct, Fio_AluResult, Fio_AluO, negativo, Fio_AluZero, Fio_AluEQ, Fio_AluG, Fio_AluLT);

register AluOut(
	.clk(Clk), 
	.reset(Reset), 
	.regWrite(Fio_LoadOut), 
	.DadoIn(Fio_AluResult), 
	.DadoOut(Fio_AluOut)
);

MUX2 MuxD(
	.AluSrcA(Fio_PCsource), 
	.dadoA(Fio_AluResult), 
	.dadoB(Fio_AluOut), 
	.dadoOUT(Fio_PCin)
);

Memoria64 DMem(
	.Clk(Clk), 
	.Wr(Fio_DmemControl), 
	.raddress(Fio_AluOut), 
	.waddress(Fio_AluOut), 
	.Datain(Fio_DadoMemIN), 
	.Dataout(Fio_DadoMemOUT)
);

register regTempC(
	.clk(Clk), 
	.reset(Reset), 
	.regWrite(Fio_LoadRegC), 
	.DadoIn(Fio_dMemRegC), 
	.DadoOut(Fio_regCmux)
);

extend_sign Sign_Extend( 
	.instruction(Fio_allinst),
	.extend_instruction(Fio_extensorMux)
	);

Deslocamento Shifter(
	.Shift(Fio_ShiftControl),
	.Entrada(Fio_muxEshift),
	.N(Fio_Nshift),
	.Saida(Fio_shiftMux)
);

control_sizeOUT size_DadoOUT( 
	.Dadoin(Fio_DadoMemOUT),
	.instrucao(Fio_allinst),
	.Dadoout(Fio_dMemRegC),
	.memInst(MemData),
	.exception(Fio_exception)
);

size_dadoIN size_DadoIN(
	.instruction(Fio_allinst),
	.regBmuxB(Fio_regBmuxB),
	.regCmux(Fio_dMemRegC),
	.DadoMemIN(Fio_DadoMemIN)
);

//execeptions
MUX2 MuxF(
	.AluSrcA(Fio_srcEnd),
	.dadoA(Fio_PCout), 
	.dadoB(Fio_EndExp), 
	.dadoOUT(Fio_fout)
);

MUX2 MuxG(
	.AluSrcA(Fio_SrcInst),
	.dadoA(Fio_PCin), 
	.dadoB(Fio_dMemRegC), 
	.dadoOUT(Fio_MuxGout)
);

register EPC(
	.clk(Clk), 
	.reset(Reset), 
	.regWrite(Fio_EPCcontrol), 
	.DadoIn(Fio_SuberOut), 
	.DadoOut(Fio_EpcOut)
);


suber sub4(
	.DadoIn(Fio_PCout), 
	.DadoOut(Fio_SuberOut)
);

register Causa(
	.clk(Clk), 
	.reset(Reset), 
	.regWrite(Fio_CausaControl), 
	.DadoIn(Fio_FlagRD), 
	.DadoOut(Fio_CausaOut)
);

assign Fio_resultPCWrite = (Fio_PCwrite|(Fio_PcWriteCond&Fio_FlagComp));
assign Fio_AluGE = (Fio_AluG|Fio_AluEQ);

endmodule
