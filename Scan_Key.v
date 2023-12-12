module Scan_Key(
    input HIGH_CLK,
	 input LOW_CLK,
    input nRST,
    output reg [3:0] key_col, 
    input [3:0] key_row, 
    output reg [3:0] key_value 
);
reg pressed_flag=0;
reg [1:0]key_value_temp;
always@(posedge LOW_CLK )
	begin
			key_col<=4'b1000;
			if(key_row!=4'b0000)
				begin pressed_flag<=1;end
		
	end
	
always@(posedge HIGH_CLK)
begin
if(pressed_flag)
begin
case(key_row)
	4'b0001:key_value_temp<=1;
	4'b0010:key_value_temp<=2;
	4'b0100:key_value_temp<=3;
	default:key_value_temp<=key_value;
	endcase
	end
end

always@(*)
begin
if(pressed_flag) begin key_value<=key_value_temp; end
else begin key_value<=key_value;end
end
endmodule
