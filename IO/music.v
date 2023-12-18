`timescale 1ns / 1ps

module audio(clk, rst, speaker);
  input clk, rst;
  output speaker;

  reg [16:0] counter; //113632는 00011011101111100000 곧 2진수 17비트
  reg speaker;

  always @(posedge clk) begin
    if (counter == 113632) begin 
      //A는 440Hz이므로 주파수(440HZ) = 클럭 주기(100MHZ) / 카운터 값 이므로 카운터 값은 227264로 나온다.
        //duty cycle을 50% 곧 켜져 있는 시간과 꺼져 있는 시간을 50%로 만들기 위해 다시 반으로 나눈다. 113632
      counter <= 0;
      if (rst) begin
        speaker <= ~speaker;
        // counter가 113632에 도달했을 때, rst 버튼이 눌려 있으면 speaker의 값이 바뀌며, 이는 주파수의 주기를 생성한다.
      end
    end
    else begin
      counter <= counter + 1;
      //113632까지 매 클락 1씩 증가한다.
    end
  end
endmodule
