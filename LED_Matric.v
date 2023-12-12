module LED_Matric
(input clk,input nCR,output [3:0]R,output L
);
assign L=1'b1;
//CounterN(C,Q,nCR,En,CP,N,Ini,nCR_value)
wire junk;
CounterN CN(junk,R,nCR,1'b1,clk,4'd15,4'd0,4'd0);//参数没写全不给我报错，珍妮天
endmodule
