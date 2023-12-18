set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} [get_ports clk]
set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.5 [current_design]
set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { rst }]; #IO_L9N_T1_DQS_D13_14 Sch=btnd
set_property -dict { PACKAGE_PIN A11   IOSTANDARD LVCMOS33 } [get_ports { speaker }]; #IO_L4N_T0_15 Sch=aud_pwm
