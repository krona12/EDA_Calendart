module Date(year,month,day,leap,week,nCR,En,cp);
	output [15:0]year;
	output [7:0]month;
	output [7:0]day;
	output [3:0]leap;
	output [3:0]week;

	input nCR,En,cp;//En暂停
	wire [15:0]year_temp;
	wire [7:0]month_temp,day_temp;
	wire [3:0]tp1,tp2,tp3;
	wire [1:0] day_cp,month_cp,year_cp;
    // 定义一个数组存储平年每个月的天数
    reg [5:0] normal_year_days[0:11];
    // 定义另一个数组存储闰年每个月的天数
    reg [5:0] leap_year_days[0:11];
	   
	 initial begin
        // 初始化平年数组nitial begin
        normal_year_days[0] = 31; // 1月
        normal_year_days[1] = 28; // 2月
        normal_year_days[2] = 31; // 3月
        normal_year_days[3] = 30; // 4月
        normal_year_days[4] = 31; // 5月
        normal_year_days[5] = 30; // 6月
        normal_year_days[6] = 31; // 7月
        normal_year_days[7] = 31; // 8月
        normal_year_days[8] = 30; // 9月
        normal_year_days[9] = 31; // 10月
        normal_year_days[10] = 30; // 11月
        normal_year_days[11] = 31; // 12月

        // 初始化闰年数组
        leap_year_days[0] = 31;
        leap_year_days[1] = 29; // 闰年2月有29天
        leap_year_days[2] = 31;
        leap_year_days[3] = 30;
        leap_year_days[4] = 31;
        leap_year_days[5] = 30;
        leap_year_days[6] = 31;
        leap_year_days[7] = 31;
        leap_year_days[8] = 30;
        leap_year_days[9] = 31;
        leap_year_days[10] = 30;
        leap_year_days[11] = 31;
    end
  
   //assign day_cp=(day_temp==(leap?leap_year_days[month_temp-1]:normal_year_days[month_temp-1]));
	//assign day_cp=(day_temp==normal_year_days[month_temp-1]);
	//assign month_cp=(month_temp==8'b00001100);//本来是使用assign 逻辑，取得各个进位标志，给到上一级的cp，但是考虑到数组的取得需要微小时间（相比于常数），导致出现竞争冒险。（换为固定常数则未出现），11:30/12/9/2023
	assign leap=(((year%4==0)&&(!(year%100==0)))||(year%400==0))?4'b0001:4'b0000;
	
	CounterN C_day(day_cp,day_temp,nCR,En,cp,(leap?leap_year_days[month_temp-1]:normal_year_days[month_temp-1]),9,1'b1);
   CounterN C_month(month_cp,month_temp,nCR,En,day_cp,12,2,1'b1);
	 CounterN C_year(year_cp,year_temp,nCR,En,(month_cp&&day_cp),9999,2020,1'b1);
   //CounterN C_day(day_temp,nCR,1,cp,leap?leap_year_days[month_temp-1]:normal_year_days[month_temp-1],1);
	
	
	

	//BCD daybcd(tp3,day[7:4],day[3:0],day_temp);//初始BCD码转换，出现了问题，重写
	//BCD monthbcd(tp2,month[7:4],month[3:0],month_temp);
	//BCD yearbcd(tp1,year[7:4],year[3:0],year_temp);
	newbcd daybcd(tp3,day[7:4],day[3:0],day_temp);
	newbcd monthbcd(tp2,month[7:4],month[3:0],month_temp);
	new4bcd yearbcd(year[15:12],year[11:8],year[7:4],year[3:0],year_temp);
	
	cal_week(week,year,month_temp,day_temp);//注意需要更改year,原只取年个十位
endmodule
