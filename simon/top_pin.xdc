##############时钟信号和复位信号###################
create_clock   -period 20.000 clk
set_property  PACKAGE_PIN J19      [get_ports clk]
set_property  PACKAGE_PIN L18      [get_ports rst_n]

set_property  IOSTANDARD  LVCMOS33 [get_ports clk]
set_property  IOSTANDARD  LVCMOS33 [get_ports rst_n]
##############按键输入################
set_property  PACKAGE_PIN AA1       [get_ports key_in]
set_property  IOSTANDARD  LVCMOS33  [get_ports key_in]
##############LED################
set_property  PACKAGE_PIN N18       [get_ports led]
set_property  IOSTANDARD  LVCMOS33  [get_ports led]
##############将FPGA的其他没使用到的管脚设置为高电平################
set_property BITSTREAM.CONFIG.UNUSEDPIN  Pullup [current_design]