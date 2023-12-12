module wipe_key_shake
#(
	parameter WIPE_TIME = 1000_000
	//消抖时间参数定义，系统时钟50M,对应的20ms参数
)
(										 
	input				clk     ,		
	input				rst_n   ,  	
	input				key_in  ,
	output	reg	key_out    
);
 
//==========================================================
//*********************打拍定义******************************
reg key_in_q1;
reg key_in_q2;   //消除亚稳态
reg key_in_q3;   //判断信号变化
//==========================================================
 
 
//==========================================================
//********************按键状态定义****************************
reg key_state;
//==========================================================
 
 
//==========================================================
//*********************消抖计数器定义*************************
reg [23:0] wipe_cnt;
wire       add_wipe_cnt;
wire       end_wipe_cnt; 
//==========================================================
 
 
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//*********************漂亮的分割线***************************
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
 
//==========================================================
//*********************打拍代码******************************
always  @(posedge clk)begin
	key_in_q1 <= key_in;
	key_in_q2 <= key_in_q1;
	key_in_q3 <= key_in_q2;
end
//==========================================================
 
//==========================================================
//********************按键状态代码****************************
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
		key_state <= 0;
    end
    else if(key_in_q2 != key_in_q3)begin
		key_state <= 1;
    end
	 else if(wipe_cnt == WIPE_TIME - 1)begin
		key_state <= 0;
	 end
end
//==========================================================
//==========================================================
//*********************消抖计数器代码*************************
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        wipe_cnt <= 0;
    end
    else if(add_wipe_cnt)begin
        if(end_wipe_cnt)
            wipe_cnt <= 0;
        else
            wipe_cnt <= wipe_cnt + 1;
    end
end
assign add_wipe_cnt = key_state;       
assign end_wipe_cnt = add_wipe_cnt && ( (wipe_cnt == WIPE_TIME - 1) || (key_in_q2 != key_in_q3) );   
//计数条件：按键状态变化时开始计数
//清零条件：消抖时间计满 或 按键状态发生变化
//==========================================================
//==========================================================
//*************************输出代码**************************
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
		key_out <= 0;
    end
    else if(wipe_cnt == WIPE_TIME - 1)begin
		key_out <= key_in_q2;
    end
end
//只有在消抖时间计满时，才输出键值
//==========================================================
 
endmodule
