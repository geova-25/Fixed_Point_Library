# The Potato Processor - A simple processor for FPGAs
# (c) Kristian Klomsten Skordal 2016 <kristian.skordal@wafflemail.net>
# Report bugs and issues on <https://github.com/skordal/potato/issues>

## This file is a general .xdc for the Nexys4 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project


## Clock signal

set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]



# Reset button:

#set_property PACKAGE_PIN C12 [get_ports reset_n]
#set_property IOSTANDARD LVCMOS33 [get_ports reset_n]


# GPIOs (Buttons):



set_property PACKAGE_PIN E16 [get_ports {OperandIn[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[0]}]

set_property PACKAGE_PIN V2 [get_ports {OperandIn[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[1]}]

set_property PACKAGE_PIN U2 [get_ports {OperandIn[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[2]}]

set_property PACKAGE_PIN R3 [get_ports {OperandIn[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[3]}]

set_property PACKAGE_PIN P3 [get_ports {OperandIn[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[4]}]

set_property PACKAGE_PIN P4 [get_ports {OperandIn[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[5]}]

set_property PACKAGE_PIN F15 [get_ports {OperandIn[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[6]}]

set_property PACKAGE_PIN T16 [get_ports {OperandIn[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[7]}]

set_property PACKAGE_PIN R10 [get_ports {OperandIn[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[8]}]





# GPIO (Switches):


set_property PACKAGE_PIN U9 [get_ports {OperandIn[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[9]}]

set_property PACKAGE_PIN T3 [get_ports {OperandIn[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[10]}]

set_property PACKAGE_PIN T1 [get_ports {OperandIn[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[11]}]

set_property PACKAGE_PIN U8 [get_ports {OperandIn[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[12]}]

set_property PACKAGE_PIN R7 [get_ports {OperandIn[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[13]}]

set_property PACKAGE_PIN R6 [get_ports {OperandIn[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[14]}]


set_property PACKAGE_PIN R5 [get_ports {OperandIn[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[15]}]

set_property PACKAGE_PIN V7 [get_ports {OperandIn[16]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[16]}]

set_property PACKAGE_PIN V6 [get_ports {OperandIn[17]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[17]}]

set_property PACKAGE_PIN v5 [get_ports {OperandIn[18]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[18]}]


set_property PACKAGE_PIN U4 [get_ports {OperandIn[19]}]
set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[19]}]


#set_property PACKAGE_PIN E16 [get_ports {OperandIn[21]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[21]}]


#set_property PACKAGE_PIN E16 [get_ports {OperandIn[22]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[22]}]


#set_property PACKAGE_PIN E16 [get_ports {OperandIn[23]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[23]}]


#set_property PACKAGE_PIN E16 [get_ports {OperandIn[24]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[24]}]

#set_property PACKAGE_PIN E16 [get_ports {OperandIn[25]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[25]}]

#set_property PACKAGE_PIN E16 [get_ports {OperandIn[26]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[26]}]

#set_property PACKAGE_PIN E16 [get_ports {OperandIn[27]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[27]}]

#set_property PACKAGE_PIN E16 [get_ports {OperandIn[28]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[28]}]

#set_property PACKAGE_PIN E16 [get_ports {OperandIn[29]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[29]}]

#set_property PACKAGE_PIN E16 [get_ports {OperandIn[30]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[30]}]


#set_property PACKAGE_PIN E16 [get_ports {OperandIn[31]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {OperandIn[31]}]


#-----------------GPIOs (LEDs):


set_property PACKAGE_PIN T8 [get_ports {Result[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Result[0]}]

set_property PACKAGE_PIN V9 [get_ports {Result[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Result[1]}]

set_property PACKAGE_PIN R8 [get_ports {Result[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Result[2]}]

set_property PACKAGE_PIN T6 [get_ports {Result[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Result[3]}]

##Bank = 34, Pin name = IO_L12P_T1_MRCC_34,					Sch name = LED4
set_property PACKAGE_PIN T5 [get_ports {Result[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[4]}]
##Bank = 34, Pin name = IO_L12N_T1_MRCC_34,					Sch	name = LED5
set_property PACKAGE_PIN T4 [get_ports {Result[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[5]}]
##Bank = 34, Pin name = IO_L22P_T3_34,						Sch name = LED6
set_property PACKAGE_PIN U7 [get_ports {Result[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[6]}]
##Bank = 34, Pin name = IO_L22N_T3_34,						Sch name = LED7
set_property PACKAGE_PIN U6 [get_ports {Result[7]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[7]}]
##Bank = 34, Pin name = IO_L10N_T1_34,						Sch name = LED8
set_property PACKAGE_PIN V4 [get_ports {Result[8]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[8]}]
##Bank = 34, Pin name = IO_L8N_T1_34,						Sch name = LED9
set_property PACKAGE_PIN U3 [get_ports {Result[9]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[9]}]
##Bank = 34, Pin name = IO_L7N_T1_34,						Sch name = LED10
set_property PACKAGE_PIN V1 [get_ports {Result[10]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[10]}]
##Bank = 34, Pin name = IO_L17P_T2_34,						Sch name = LED11
set_property PACKAGE_PIN R1 [get_ports {Result[11]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[11]}]
##Bank = 34, Pin name = IO_L13N_T2_MRCC_34,					Sch name = LED12
set_property PACKAGE_PIN P5 [get_ports {Result[12]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[12]}]
##Bank = 34, Pin name = IO_L7P_T1_34,						Sch name = LED13
set_property PACKAGE_PIN U1 [get_ports {Result[13]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[13]}]
##Bank = 34, Pin name = IO_L15N_T2_DQS_34,					Sch name = LED14
set_property PACKAGE_PIN R2 [get_ports {Result[14]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[14]}]
##Bank = 34, Pin name = IO_L15P_T2_DQS_34,					Sch name = LED15
set_property PACKAGE_PIN P2 [get_ports {Result[15]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[15]}]




##---------------------------7 segment display
##Bank = 34, Pin name = IO_L2N_T0_34,						Sch name = CA
set_property PACKAGE_PIN L3 [get_ports {Result[16]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[16]}]
##Bank = 34, Pin name = IO_L6N_T0_VREF_34,					Sch name = CC
set_property PACKAGE_PIN L5 [get_ports {Result[17]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[17]}]
##Bank = 34, Pin name = IO_L5N_T0_34,						Sch name = CD
set_property PACKAGE_PIN L4 [get_ports {Result[18]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[18]}]
##Bank = 34, Pin name = IO_L2P_T0_34,						Sch name = CE
set_property PACKAGE_PIN K3 [get_ports {Result[19]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[19]}]
##Bank = 34, Pin name = IO_L4N_T0_34,						Sch name = CF
set_property PACKAGE_PIN M2 [get_ports {Result[20]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[20]}]
##Bank = 34, Pin name = IO_L6P_T0_34,						Sch name = CG
set_property PACKAGE_PIN L6 [get_ports {Result[21]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[21]}]
##Bank = 34, Pin name = IO_L3N_T0_DQS_34,					Sch name = CB
    set_property PACKAGE_PIN N1 [get_ports {Result[22]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {Result[22]}]

##Bank = 34, Pin name = IO_L16P_T2_34,						Sch name = DP
#set_property PACKAGE_PIN M4 [get_ports dp]
#	set_property IOSTANDARD LVCMOS33 [get_ports dp]

##Bank = 34, Pin name = IO_L18N_T2_34,						Sch name = AN0
set_property PACKAGE_PIN N6 [get_ports {Result[23]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[23]}]
##Bank = 34, Pin name = IO_L18P_T2_34,						Sch name = AN1
set_property PACKAGE_PIN M6 [get_ports {Result[24]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[24]}]
##Bank = 34, Pin name = IO_L4P_T0_34,						Sch name = AN2
set_property PACKAGE_PIN M3 [get_ports {Result[25]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[25]}]
##Bank = 34, Pin name = IO_L13_T2_MRCC_34,					Sch name = AN3
set_property PACKAGE_PIN N5 [get_ports {Result[26]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[26]}]
##Bank = 34, Pin name = IO_L3P_T0_DQS_34,					Sch name = AN4
set_property PACKAGE_PIN N2 [get_ports {Result[27]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[27]}]
##Bank = 34, Pin name = IO_L16N_T2_34,						Sch name = AN5
set_property PACKAGE_PIN N4 [get_ports {Result[28]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[28]}]
##Bank = 34, Pin name = IO_L1P_T0_34,						Sch name = AN6
set_property PACKAGE_PIN L1 [get_ports {Result[29]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[29]}]
##Bank = 34, Pin name = IO_L1N_T034,							Sch name = AN7
set_property PACKAGE_PIN M1 [get_ports {Result[30]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Result[30]}]

#-----------------------    led rgb

##Bank = 34, Pin name = IO_L5P_T0_34,						Sch name = LED16_R
set_property PACKAGE_PIN K5 [get_ports Result[31]]
	set_property IOSTANDARD LVCMOS33 [get_ports Result[31]]


# UART0:
##USB-RS232 Interface


#set_property PACKAGE_PIN D4 [get_ports uart0_txd]
#set_property IOSTANDARD LVCMOS33 [get_ports uart0_txd]

#set_property PACKAGE_PIN C4 [get_ports uart0_rxd]
#set_property IOSTANDARD LVCMOS33 [get_ports uart0_rxd]

# UART1 (pin 5 and 6 on JA, to match the pins on the PMOD-GPS):


#set_property PACKAGE_PIN B13 [get_ports uart1_txd]
#set_property IOSTANDARD LVCMOS33 [get_ports uart1_txd]

#set_property PACKAGE_PIN F14 [get_ports uart1_rxd]
#set_property IOSTANDARD LVCMOS33 [get_ports uart1_rxd]
