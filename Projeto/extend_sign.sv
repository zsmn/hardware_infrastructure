module extend_sign(
    input logic [31:0] instruction,
    output logic [63:0] extend_instruction
);

always_comb begin
    case(instruction[6:0]) //fazendo a classficacao das instrucoes baseada no seu opcode
    7'b0010011:begin
        //addi,slti
        case(instruction[31])
            1'b0:
                extend_instruction[63:12] = 52'b0000000000000000000000000000000000000000000000000000;
            1'b1:
                extend_instruction[63:12] = 52'b1111111111111111111111111111111111111111111111111111;
        endcase
        extend_instruction[11:0] = instruction[31:20];
    end
    7'b0000011:begin
        //ld,lb,lh,lw,lbu,lhu,lwu
        case(instruction[31])
            1'b0:
                extend_instruction[63:12] = 52'b0000000000000000000000000000000000000000000000000000;
            1'b1:
                extend_instruction[63:12] = 52'b1111111111111111111111111111111111111111111111111111;
        endcase
        extend_instruction[11:0] = instruction[31:20];
    end
    7'b0100011:begin
        //sd,sw,sh,sb
        case(instruction[31])
            1'b0:
                extend_instruction[63:12] = 52'b0000000000000000000000000000000000000000000000000000;
            1'b1:
                extend_instruction[63:12] = 52'b1111111111111111111111111111111111111111111111111111;
        endcase
        extend_instruction[11:5] = instruction[31:25];
        extend_instruction[4:0] = instruction[11:7];
    end
    7'b1100011:begin
        //beq
        case(instruction[31])
            1'b0:
                extend_instruction[63:13] = 51'b000000000000000000000000000000000000000000000000000;
            1'b1:
                extend_instruction[63:13] = 51'b111111111111111111111111111111111111111111111111111;
        endcase
        extend_instruction[12] = instruction[31];
        extend_instruction[11] = instruction[7];
        extend_instruction[10:5] = instruction[30:25];
        extend_instruction[4:1] = instruction[11:8];
        extend_instruction[0] = 1'b0;
    end
    7'b1100111:begin
        case(instruction[14:12])
            3'b001:begin
                //bne
                case(instruction[31])
                    1'b0:
                        extend_instruction[63:13] = 51'b000000000000000000000000000000000000000000000000000;
                    1'b1:
                        extend_instruction[63:13] = 51'b111111111111111111111111111111111111111111111111111;
                endcase
                extend_instruction[12] = instruction[31];
                extend_instruction[11] = instruction[7];
                extend_instruction[10:5] = instruction[30:25];
                extend_instruction[4:1] = instruction[11:8];
                extend_instruction[0] = 1'b0;
            end
            3'b101:begin
                //bge
                case(instruction[31])
                    1'b0:
                        extend_instruction[63:13] = 51'b000000000000000000000000000000000000000000000000000;
                    1'b1:
                        extend_instruction[63:13] = 51'b111111111111111111111111111111111111111111111111111;
                endcase
                extend_instruction[12] = instruction[31];
                extend_instruction[11] = instruction[7];
                extend_instruction[10:5] = instruction[30:25];
                extend_instruction[4:1] = instruction[11:8];
                extend_instruction[0] = 1'b0;
            end
            3'b100:begin
                //blt
                case(instruction[31])
                    1'b0:
                        extend_instruction[63:13] = 51'b000000000000000000000000000000000000000000000000000;
                    1'b1:
                        extend_instruction[63:13] = 51'b111111111111111111111111111111111111111111111111111;
                endcase
                extend_instruction[12] = instruction[31];
                extend_instruction[11] = instruction[7];
                extend_instruction[10:5] = instruction[30:25];
                extend_instruction[4:1] = instruction[11:8];
                extend_instruction[0] = 1'b0;
            end
            3'b000:begin
                //jalr
                case(instruction[31])
                    1'b0:
                        extend_instruction[63:12] = 52'b0000000000000000000000000000000000000000000000000000;
                    1'b1:
                        extend_instruction[63:12] = 52'b1111111111111111111111111111111111111111111111111111;
                endcase
                extend_instruction[11:0] = instruction[31:20];
            end
        endcase
    end
    7'b0110111:begin
        //lui
        extend_instruction[11:0] = 12'b000000000000;
        extend_instruction[31:12] = instruction[31:12];
        case(instruction[31])
            1'b0:
                extend_instruction[63:32] = 32'b00000000000000000000000000000000;
            1'b1:
                extend_instruction[63:32] = 32'b11111111111111111111111111111111;
        endcase
    end
    7'b1101111:begin
        //jal
        case(instruction[31])
            1'b0:
                extend_instruction[63:21] = 43'b0000000000000000000000000000000000000000000;
            1'b1:
                extend_instruction[63:21] = 43'b1111111111111111111111111111111111111111111;
        endcase
        extend_instruction[20] = instruction[31];
        extend_instruction[19:12] = instruction[19:12];
        extend_instruction[11] = instruction[20];
        extend_instruction[10:1] = instruction[30:21];
        extend_instruction[0] = 1'b0;

    end
    endcase
end

endmodule 