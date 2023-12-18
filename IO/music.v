module music(clk, rst, speaker);
  input clk, rst;
  output speaker;

  reg [14:0] counter;
  reg speaker;

  always @(posedge clk) begin
    if (counter == 28408) begin 
        //A는 440Hz이므로 주파수 = 클럭 주기 / 카운터 값 이므로 56816로 나온다.
        //duty cycle을 50% 곧 켜져 있는 시간과 꺼져 있는 시간을 50%로 만들기 위해 다시 반으로 나눈다. 28408
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
