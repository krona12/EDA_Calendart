module BCD(
output wire [3:0] Hundreds,
output wire [3:0] Tens,
output wire [3:0] Ones,
input[7:0] binary);


assign Hundreds=0;
assign Tens=(binary-binary%10);
assign Ones=(binary%10);
//integer i;
//always@(binary)
//begin
//	//set100's,10's,and 1'sto0
//	Tens = 4'd0;
//	Hundreds=4'd0;
//	Ones =4'd0;
//	for(i=7;i>=0;i=i-1)
//	begin
//		//add 3 to columns>=5
//		if (Hundreds >= 5)
//			Hundreds=Hundreds + 3;
//		if (Tens >= 5)
//			Tens = Tens + 3;
//		if (Ones >= 5)
//			Ones = Ones + 3;
//		//shiftleftone
//		Hundreds =Hundreds << 1;
//		Hundreds[0] = Tens[3];
//		Tens=Tens << 1;
//		Tens[0]=Ones[3];
//		Ones =Ones << 1;
//		Ones[0] =binary[i];
//	end
//end
endmodule