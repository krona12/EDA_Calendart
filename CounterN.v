module CounterN(C,Q,nCR,En,CP,N,Ini,nCR_value);
	output reg[1:0]C;
    output reg[15:0]Q;
	 input CP,nCR,En;
	 input [15:0]N;
	 input [15:0]Ini;
	 input [1:0]nCR_value;
    always @(posedge CP or negedge nCR)
    begin
      if(~nCR)    begin Q<=Ini;C=1'b0;end//Q <=8'b00000001; // nCR＝0，计数器被异步清零，测试闰年输出，设为4,注意这里所有的初始都为4了，下次更改，12.8.5:31
      else if(~En) begin Q <= Q;C=1'b0; end              //EN=0,暂停计数
      else if(Q >=N)  begin Q <=nCR_value; C=1'b1;end
      else begin	Q <= Q + 1'b1;C=1'b0;  end     //计数器增1计数,这里尤其抽象，不加begin，end不报错，但是，Carry进位没有上升沿，导致不能输出进位，月份不变。11:50/12/9/2023
    end
endmodule 