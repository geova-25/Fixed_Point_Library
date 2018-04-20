# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "Word_length" -parent ${Page_0}
  ipgui::add_param $IPINST -name "fractional_bits" -parent ${Page_0}


}

proc update_PARAM_VALUE.Word_length { PARAM_VALUE.Word_length } {
	# Procedure called to update Word_length when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Word_length { PARAM_VALUE.Word_length } {
	# Procedure called to validate Word_length
	return true
}

proc update_PARAM_VALUE.fractional_bits { PARAM_VALUE.fractional_bits } {
	# Procedure called to update fractional_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.fractional_bits { PARAM_VALUE.fractional_bits } {
	# Procedure called to validate fractional_bits
	return true
}


proc update_MODELPARAM_VALUE.Word_length { MODELPARAM_VALUE.Word_length PARAM_VALUE.Word_length } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Word_length}] ${MODELPARAM_VALUE.Word_length}
}

proc update_MODELPARAM_VALUE.fractional_bits { MODELPARAM_VALUE.fractional_bits PARAM_VALUE.fractional_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.fractional_bits}] ${MODELPARAM_VALUE.fractional_bits}
}

