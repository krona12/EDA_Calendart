module cal_week(week, year, month, day);
    output reg [2:0] week;  // 星期几的结果，0表示星期日，1表示星期一，以此类推
    input [15:0] year;      // 年份
    input [7:0] month;      // 月份
    input [7:0] day;        // 日期

    reg [15:0] y;
    reg [7:0] m;
    integer k, j, q;

    always @(*) begin
        // 调整月份和年份
        if (month == 1 || month == 2) begin
            m = month + 12;
            y = year - 1;
        end else begin
            m = month;
            y = year;
        end

        k = y % 100;
        j = y / 100;
        q = day;

        // 使用蔡勒公式计算星期几//
        week = (q + (13 * (m + 1) / 5) + k + (k / 4) + (j / 4) - 2 * j) % 7;
        // 将结果调整为0到6范围内
        if (week < 0) week = week + 7;
    end
endmodule
