module ControlUnit(
    input logic Clk, Reset, AluZero, AluEG, AluLT,AluO,
    output logic PCwrite, ImemWR, LoadIr, LoadRegA, LoadRegB, LoadOut, WriteReg, DMemControl, LoadRegC, PCWriteCond,
    output logic [1:0]AluSrcB, ShiftControl, AluSrcA,
    output logic [2:0]ALUFct,
    input logic[31:0] instruction,
    output logic [5:0]Nshift,
    output logic FlagComp, PCSrc, ResetRegA, ShiftScr,
    output logic [1:0] MemTOreg,
    output logic [63:0] FlagRd, EndExp,
    output logic exception, EPCcontrol, SrcEnd, srcInst, CausaControl
);

enum logic[5:0]{InitState, SendEnd, AttEnd, Decodificador,
TypeI, TypeI2, TypeR, ADD, SUB, LType, LType2, LType3, RegSave, LUI,
TypeSB, BEQ, BNE, BLT, BGE, SD, SD2, SD3, SD4, EX, RegSaveSlt, SLT, NOP,SLTI,
SLLI, JALR, JAL, SRAI, SRLI, SLT2, AND, JALS, JAL3, BREAK, NOPcode, OverFlow, JMPC}NextStage, Stage, instructions;
 
always_ff@(posedge Clk or posedge Reset) begin
    if(Reset)
        Stage <= InitState;
    else
        Stage <= NextStage;
       

end
 
always_comb begin
    case(Stage)
    InitState:begin
        ShiftScr = 1'b1;
        PCwrite = 1'b0;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b000;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        Nshift = 6'b000000;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SendEnd;
        if(AluO)
            NextStage = OverFlow;
    end
    SendEnd: begin
        //pego o endere�o de pc para ler da memoriaa instru��o
        //fa�o pc +4
        ShiftScr = 1'b1;
        PCwrite = 1'b0;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b01;
        ALUFct = 3'b001;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        NextStage = AttEnd;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        Nshift = 6'b000000;
        if(AluO)
            NextStage = OverFlow;
    end
    AttEnd: begin
        //atualizo pc com pc+4
        //escrevo o registrador de instru��o com a instru��o atual
        PCwrite = 1'b1;
        ShiftScr = 1'b1;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b01;
        ALUFct = 3'b001;
        LoadIr = 1'b1;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = Decodificador;
        Nshift = 6'b000000;
        if(AluO)
            NextStage = OverFlow;
    end
    Decodificador: begin
        PCwrite = 1'b0;
        ShiftScr = 1'b1;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b000;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        Nshift = 6'b000000;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = NOPcode;
        if(AluO)
            NextStage = OverFlow;

        case(instruction[6:0])
            7'b0110011:begin //esse eh o caso do add e do sub, tem que usar o func7 para saber de fato
            NextStage = TypeR;
            case(instruction[31:25]) //checando o func7
                7'b0000000:begin
                    case(instruction[14:12]) //checando o func3
                        3'b000:begin
                            instructions = ADD; //add
                        end
                        3'b111:begin
                            instructions = AND; //and logico
                        end
                        3'b010:begin
                            instructions = SLT;//slt (set if less than)
                        end
                    endcase
                end
                7'b0100000:begin //sub
                    instructions = SUB;
                end
            endcase
 
            end
            7'b0010011: begin
                NextStage = TypeI;
                case(instruction[14:12])
                    3'b000:begin
                        case(instruction[31:20])
                            12'b000000000000:begin //nop
                                NextStage = NOP;
                            end
                            default
                                instructions = RegSave; //addi
                        endcase
                    end
                    3'b010:begin
                    instructions = SLTI; //slti
                    end
                    3'b001:begin
                    instructions = SLLI; //slli
                    end
                    3'b101:begin
                        case(instruction[31:26])
                            6'b000000:begin
                                instructions = SRLI; // srli
                            end
                            6'b010000:begin
                                instructions = SRAI; // srai
                            end
                        endcase
                    end
                endcase
            end
            7'b0000011:begin //ld
                NextStage = TypeI;
                instructions = LType;
            end
            7'b0100011:begin //sd
                NextStage = SD;
            end
            7'b1100011:begin //beq
                NextStage = TypeSB;
                instructions = BEQ;
            end
            7'b1100111:begin
                NextStage = TypeSB;
                case(instruction[14:12]) //fazendo a decodificação por meio do func3
                    3'b000:begin
                      NextStage = JALS; //opcode eh o mesmo mas pertence a uma classe
                      //de instrucoes diferente SB != I
                      instructions = JALR; //jalr
                    end
                    3'b001:begin
                        instructions = BNE; //bne -- branch if not equal
                    end
                    3'b101:begin
                        instructions = BGE; //bge -- branch if greater than
                    end
                    3'b100:begin
                        instructions = BLT; //blt -- branch if less than
                    end
                endcase
            end
            7'b0110111:begin //lui
                NextStage = LUI;
            end
            7'b1101111:begin //jal
                NextStage = JALS;
                instructions = JAL;
            end
            7'b1110011:begin //break
                NextStage = BREAK;
            end
        endcase      
    end
    /* a partir daqui se der merda, se lembrar de resetar o que n ta usando
   
                    ATENÇÃO!!!!!!!!!!!!!!!
                    'B'uffer 'C'om 'T'rash
 
    */
    BREAK: begin    
        PCwrite = 1'b0;
        ShiftScr = 1'b1;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b000;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        Nshift = 6'b000000;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = BREAK;
        if(AluO)
            NextStage = OverFlow;
    end
    NOP: begin    
        PCwrite = 1'b0;
        ShiftScr = 1'b1;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b000;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        Nshift = 6'b000000;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SendEnd;
        if(AluO)
            NextStage = OverFlow;
    end    
    TypeI: begin
        Nshift = 6'b000000;
        ShiftScr = 1'b1;
        PCwrite = 1'b0;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b000;
        LoadIr = 1'b0;
        LoadRegA = 1'b1;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = TypeI2;
        if(AluO)
            NextStage = OverFlow;
    end
    TypeI2: begin
        Nshift = 6'b000000;
        ShiftScr = 1'b1;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b10;
        ALUFct = 3'b001;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b1;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = instructions;
        if(AluO)
            NextStage = OverFlow;
    end
    SLLI: begin //Nao testado
        Nshift = instruction[25:20];
        ShiftScr = 1'b0;
        PCwrite = 1'b0;
        AluSrcA = 2'b10;
        ImemWR = 1'b0;
        AluSrcB = 2'b11;
        ALUFct = 3'b001;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b1;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = RegSave;
        if(AluO)
            NextStage = OverFlow;
    end
    SRAI: begin //Nao testado
        Nshift = instruction[25:20];
        ShiftScr = 1'b0;
        PCwrite = 1'b0;
        AluSrcA = 2'b10;
        ImemWR = 1'b0;
        AluSrcB = 2'b11;
        ALUFct = 3'b001;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b1;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b10;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = RegSave;
        if(AluO)
            NextStage = OverFlow;
    end
    SRLI: begin //Nao testado
        Nshift = instruction[25:20];
        ShiftScr = 1'b0;
        PCwrite = 1'b0;
        AluSrcA = 2'b10;
        ImemWR = 1'b0;
        AluSrcB = 2'b11;
        ALUFct = 3'b001;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b1;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b01;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = RegSave;
        if(AluO)
            NextStage = OverFlow;
    end
    SLTI: begin //Nao testado
        Nshift = 6'b000000;
        ShiftScr = 1'b0;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b10;
        ALUFct = 3'b111;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b1;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SLT2;
        if(AluO)
            NextStage = OverFlow;
    end
    SLT: begin //Nao testado
        Nshift = 6'b000000;
        ShiftScr = 1'b0;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b111;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b1;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SLT2;
        if(AluO)
            NextStage = OverFlow;
	end
    SLT2: begin //Nao testado
        Nshift = 6'b000000;
        ShiftScr = 1'b0;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        if(instruction == SLT)
            AluSrcB = 2'b00;
        else if(instruction == SLTI)
            AluSrcB = 2'b10;
        ALUFct = 3'b111;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b1;
        WriteReg =  1'b1;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b11;
        ResetRegA = 1'b0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
 
        if(AluLT == 1'b1)begin
            FlagRd = 64'd1;
        end
        else begin
            FlagRd = 64'd0;
        end
       
        NextStage = SendEnd;
        if(AluO)
            NextStage = OverFlow;
    end
    RegSaveSlt: begin //Nao testado
        Nshift = 6'b000000;
        ShiftScr = 1'b0;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b10;
        ALUFct = 3'b111;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b1;
        WriteReg =  1'b1;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b11;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SendEnd;
        if(AluO)
            NextStage = OverFlow;
    end
    LType: begin
        Nshift = 6'b000000;
        PCwrite = 1'b0;
        ShiftScr = 1'b1;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b001;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b01;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = LType2;
        if(AluO)
            NextStage = OverFlow;
    end
    LType2: begin
        Nshift = 6'b000000;
        ShiftScr = 1'b1;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b001;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b1;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b01;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = LType3;
        if(AluO)
            NextStage = OverFlow;
    end
    LType3: begin
        Nshift = 6'b000000;
        ShiftScr = 1'b1;
        PCwrite = 1'b0;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b000;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b1;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b01;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SendEnd;
        if(AluO)
            NextStage = OverFlow;
    end
    TypeR: begin
        Nshift = 6'b000000;
        ShiftScr = 1'b1;
        PCwrite = 1'b0;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b000;
        LoadIr = 1'b0;
        LoadRegA = 1'b1;
        LoadRegB = 1'b1;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = instructions;
        if(AluO)
            NextStage = OverFlow;
    end
    AND: begin
        Nshift = 6'b000000;
        ShiftScr = 1'b1;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b011;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b1;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = RegSave;
        if(AluO)
            NextStage = OverFlow;
    end
    ADD: begin
        Nshift = 6'b000000;
        ShiftScr = 1'b1;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b001;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b1;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = RegSave;
        if(AluO)
            NextStage = OverFlow;
    end
    SUB: begin
        Nshift = 6'b000000;
        ShiftScr = 1'b1;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b010;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b1;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = RegSave;
        if(AluO)
            NextStage = OverFlow;
    end
    RegSave: begin
        Nshift = 6'b000000;
        ShiftScr = 1'b1;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b1;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SendEnd;
        if(AluO)
            NextStage = OverFlow;
    end
    TypeSB: begin
        Nshift = 6'b000001;
        ShiftScr = 1'b1;
        PCwrite = 1'b0;//
        AluSrcA = 2'b00;//
        ImemWR = 1'b0;//
        AluSrcB = 2'b11;//
        ALUFct = 3'b001;//
        LoadIr = 1'b0;//
        LoadRegA = 1'b1;//
        LoadRegB = 1'b1;//
        LoadOut = 1'b1;//
        WriteReg =  1'b0;//
        DMemControl = 1'b0;//
        LoadRegC = 1'b0;//
        PCWriteCond = 1'b0;//
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = instructions;
        if(AluO)
            NextStage = OverFlow;
    end
    BEQ: begin
        Nshift = 6'b000000;
        ShiftScr = 1'b1;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b010;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b1;
        ShiftControl = 2'b00;
        FlagComp = AluZero;
        PCSrc = 1'b1;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SendEnd;
        if(AluO)
            NextStage = OverFlow;
    end
    BNE: begin
        Nshift = 6'b000001;
        ShiftScr = 1'b1;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b010;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b1;
        ShiftControl = 2'b00;
        FlagComp = ~AluZero;
        PCSrc = 1'b1;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SendEnd;
        if(AluO)
            NextStage = OverFlow;
    end
    BGE: begin //nao testado
        ShiftScr = 1'b1;
        Nshift = 6'b000000;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b111;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b1;
        ShiftControl = 2'b00;
        FlagComp = AluEG;
        PCSrc = 1'b1;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SendEnd;
        if(AluO)
            NextStage = OverFlow;
    end
    BLT: begin //nao testado
        ShiftScr = 1'b1;
        Nshift = 6'b000000;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b111;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b1;
        ShiftControl = 2'b00;
        FlagComp = AluLT;
        PCSrc = 1'b1;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SendEnd;
        if(AluO)
            NextStage = OverFlow;
    end
    LUI: begin
        ShiftScr = 1'b1;
        Nshift = 6'b000000;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b10;
        ALUFct = 3'b001;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b1;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b1;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = RegSave;
        if(AluO)
            NextStage = OverFlow;
    end
    SD: begin
        ShiftScr = 1'b1;
        Nshift = 6'b000000;
        PCwrite = 1'b0;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b000;
        LoadIr = 1'b0;
        LoadRegA = 1'b1;
        LoadRegB = 1'b1;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SD2;
        if(AluO)
            NextStage = OverFlow;
    end
    SD2: begin
        ShiftScr = 1'b1;
        Nshift = 6'b000000;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b10;
        ALUFct = 3'b001;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b1;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SD3;
        if(AluO)
            NextStage = OverFlow;
    end
    SD3: begin
        ShiftScr = 1'b1;
        Nshift = 6'b000000;
        PCwrite = 1'b0;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b10;
        ALUFct = 3'b001;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b1;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SD4;
        if(AluO)
            NextStage = OverFlow;
    end
    SD4: begin
        ShiftScr = 1'b1;
        Nshift = 6'b000000;
        PCwrite = 1'b0;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b000;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b1;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SendEnd;
        if(AluO)
            NextStage = OverFlow;
    end
    JALS: begin    
        PCwrite = 1'b0;
        ShiftScr = 1'b1;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b000;
        LoadIr = 1'b0;
        LoadRegA = 1'b1;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b1;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b10;
        ResetRegA = 1'b0;
        Nshift = 6'b000000;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = instructions;
        if(AluO)
            NextStage = OverFlow;
    end
    JAL: begin    
        PCwrite = 1'b0;
        ShiftScr = 1'b1;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b11;
        ALUFct = 3'b001;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b1;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b10;
        ResetRegA = 1'b0;
        Nshift = 6'b000001;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = JAL3;
        if(AluO)
            NextStage = OverFlow;
    end
    JAL3: begin    
        PCwrite = 1'b1;
        ShiftScr = 1'b1;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b11;
        ALUFct = 3'b001;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b1;
        MemTOreg = 2'b10;
        ResetRegA = 1'b0;
        Nshift = 6'b000001;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = SendEnd;
        if(AluO)
            NextStage = OverFlow;
    end
    JALR: begin    
        PCwrite = 1'b0;
        ShiftScr = 1'b1;
        AluSrcA = 2'b01;
        ImemWR = 1'b0;
        AluSrcB = 2'b10;
        ALUFct = 3'b001;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b1;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b10;
        ResetRegA = 1'b0;
        Nshift = 6'b000001;
        FlagRd = 64'd0;
        exception = 1'b0;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b0;
        NextStage = JAL3;
        if(AluO)
            NextStage = OverFlow;
    end    
    OverFlow: begin
        PCwrite = 1'b0;
        ShiftScr = 1'b1;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b000;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        Nshift = 6'b000000;
        FlagRd = 64'd0;
        // parte da exceção
        exception = 1'b1;
        EPCcontrol = 1'b1;
        SrcEnd = 1'b1;
        EndExp = 64'd254;
        //escrita do reg de causa
        CausaControl = 1'b1;
        FlagRd = 64'd1;
        srcInst = 1'b0;
        NextStage = JMPC;
        if(AluO)
            NextStage = OverFlow;
    end
    NOPcode: begin
        PCwrite = 1'b0;
        ShiftScr = 1'b1;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b000;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        Nshift = 6'b000000;
        FlagRd = 64'd0;
        // parte da exceção
        exception = 1'b1;
        EPCcontrol = 1'b1;
        SrcEnd = 1'b1;
        EndExp = 64'd255;
        //escrita do reg de causa
        CausaControl = 1'b1;
        FlagRd = 64'd0;
        srcInst = 1'b0;
        NextStage = JMPC;
        if(AluO)
            NextStage = OverFlow;
    end
    JMPC: begin
        PCwrite = 1'b1;
        ShiftScr = 1'b1;
        AluSrcA = 2'b00;
        ImemWR = 1'b0;
        AluSrcB = 2'b00;
        ALUFct = 3'b000;
        LoadIr = 1'b0;
        LoadRegA = 1'b0;
        LoadRegB = 1'b0;
        LoadOut = 1'b0;
        WriteReg =  1'b0;
        DMemControl = 1'b0;
        LoadRegC = 1'b0;
        PCWriteCond = 1'b0;
        ShiftControl = 2'b00;
        FlagComp = 1'b0;
        PCSrc = 1'b0;
        MemTOreg = 2'b00;
        ResetRegA = 1'b0;
        Nshift = 6'b000000;
        FlagRd = 64'd0;
        // parte da exceção
        exception = 1'b1;
        EPCcontrol = 1'b0;
        SrcEnd = 1'b0;
        EndExp = 64'd0;
        CausaControl = 1'b0;
        srcInst = 1'b1;
        NextStage = SendEnd;
        if(AluO)
            NextStage = OverFlow;
    end
    endcase
end
 
endmodule