module Speed_Change
(input clk,input sp1,input sp2,input sp3,input sp4,output reg Speed_Out);
wire [1:0]Speed_Index;
wire junk;

CounterN Cal_Index(junk,Speed_Index,1'b1,1'b1,clk,2'd3,1'b0,1'b0);
always@(*)
begin 
	case(Speed_Index)
	2'b00:Speed_Out<=sp1;
	2'b01:Speed_Out<=sp2;
	2'b10:Speed_Out<=sp3;
	2'b11:Speed_Out<=sp4;
	default:Speed_Out<=Speed_Out;
endcase
end
endmodule