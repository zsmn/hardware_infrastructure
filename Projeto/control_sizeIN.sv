module size_dadoIN(
    input logic [63:0]instruction,
    input logic [63:0] regBmuxB,
    input logic [63:0] regCmux,
    output logic [63:0] DadoMemIN,
);

always_comb begin
    case(instruction[14:12])
        3'b010:begin
            DadoMemIN[31:0] = regBmuxB[31:0];
            DadoMemIN[63:32] = regCmux[63:32];
        end
        3'b001:begin
            DadoMemIN[15:0] = regBmuxB[15:0];
            DadoMemIN[63:16] = regCmux[63:16];
        end
        3'b000:begin
            DadoMemIN[7:0] = regBmuxB[7:0];
            DadoMemIN[63:8] = regCmux[63:8];
        end
        default:begin
            DadoMemIN[63:0] = regBmuxB[63:0];
        end
    endcase
end

endmodule