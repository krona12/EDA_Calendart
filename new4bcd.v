module new4bcd(
    output reg[3:0] thousands,
    output reg[3:0] hundreds,
    output reg[3:0] tens,
    output reg[3:0] ones,
    input [11:0] bin_in
);

integer i;

always @(*) begin
    ones = 4'd0;
    tens = 4'd0;
    hundreds = 4'd0;
    thousands = 4'd0;
    for(i = 11; i >= 0; i = i - 1) begin
        // 先检查并处理每一位
        if (thousands >= 4'd5) thousands = thousands + 3;
        if (hundreds >= 4'd5) hundreds = hundreds + 3;
        if (tens >= 4'd5) tens = tens + 3;
        if (ones >= 4'd5) ones = ones + 3;

        // 然后进行左移
        thousands = {thousands[2:0], hundreds[3]};
        hundreds = {hundreds[2:0], tens[3]};
        tens = {tens[2:0], ones[3]};
        ones = {ones[2:0], bin_in[i]};
    end
end

endmodule
