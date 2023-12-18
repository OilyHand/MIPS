`timescale 1ns / 1ps

module audio(clk, rst, speaker);
  input clk, rst;
  output speaker;

  reg [16:0] counter; //113632는 00011011101111100000 곧 2진수 17비트
  reg speaker;

  always @(posedge clk) begin
    if (counter == 113632) begin 
        //A는 440Hz이므로 주파수 = 클럭 주기 / 카운터 값 이므로 카운터 값은 227264로 나온다.
        //duty cycle을 50% 곧 켜져 있는 시간과 꺼져 있는 시간을 50%로 만들기 위해 다시 반으로 나눈다. 113632
      counter <= 0;
      if (rst) begin
        speaker <= ~speaker;
        // 리셋 버튼이 눌린 상태에만 speaker값이 토글되며 곧 특정 주기를 만들게 된다.
      end
    end
    else begin
      counter <= counter + 1;
    end
  end
endmodule
