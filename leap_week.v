module leap_week(leap,week,year,month,day);
	output [1:0]leap;
	output [7:0]week;
	input year;
	input month;
	input day;
	assign leap=(((year%4==0)&&(!(year%100==0)))||(year%400==0))?1:0;
	assign week=1;
endmodule