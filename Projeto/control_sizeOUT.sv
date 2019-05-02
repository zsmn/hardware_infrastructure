module control_sizeOUT(
    input logic exception,
	input logic [63:0]Dadoin,
	input logic [31:0]instrucao,
    input logic [31:0]memInst,
	output logic [63:0]Dadoout

);

always_comb begin
    case({instrucao[14:12], instrucao[6:0]})
    10'b0000000011:begin
    //lb
        case(Dadoin[7])
        1'b0:begin
            Dadoout = {56'b00000000000000000000000000000000000000000000000000000000, Dadoin[7:0]};
        end
        1'b1:begin
            Dadoout = {56'b11111111111111111111111111111111111111111111111111111111, Dadoin[7:0]};
        end
        endcase
    end
    10'b0010000011:begin
    //lh
        case(Dadoin[15])
        1'b0:begin
            Dadoout = {48'b000000000000000000000000000000000000000000000000, Dadoin[15:0]};
        end
        1'b1:begin
            Dadoout = {48'b111111111111111111111111111111111111111111111111, Dadoin[15:0]};
        end
        endcase
    end
    10'b0100000011:begin
    //lw
        case(Dadoin[31])
        1'b0:begin
            Dadoout = {32'b00000000000000000000000000000000, Dadoin[31:0]};
        end
        1'b1:begin
            Dadoout = {32'b11111111111111111111111111111111, Dadoin[31:0]};
        end
        endcase
    end
    10'b1000000011:begin
    //lbu
        Dadoout = {56'b00000000000000000000000000000000000000000000000000000000, Dadoin[7:0]};
    end
    10'b1010000011:begin
    //lhu
        Dadoout = {48'b000000000000000000000000000000000000000000000000, Dadoin[15:0]};
    end
    10'b1100000011:begin
    //lwu
        Dadoout = {32'b00000000000000000000000000000000, Dadoin[31:0]};
    end
    default begin
        //demais casos
        Dadoout = Dadoin;
    end
    endcase
    
    if(exception)begin
        Dadoout = {56'b00000000000000000000000000000000000000000000000000000000, memInst[7:0]};
    end
end

endmodule 