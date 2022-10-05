# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_S_AXI_LITE_DATA_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_S_AXI_LITE_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_AXI_LITE_BASEADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_AXI_LITE_HIGHADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_ADC_AXIS_TDATA_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_M_DMA_AXIS_TDATA_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_M_DAC_AXIS_TDATA_WIDTH" -parent ${Page_0} -widget comboBox


}

proc update_PARAM_VALUE.C_S_AXI_LITE_DATA_WIDTH { PARAM_VALUE.C_S_AXI_LITE_DATA_WIDTH } {
	# Procedure called to update C_S_AXI_LITE_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_LITE_DATA_WIDTH { PARAM_VALUE.C_S_AXI_LITE_DATA_WIDTH } {
	# Procedure called to validate C_S_AXI_LITE_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_LITE_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_LITE_ADDR_WIDTH } {
	# Procedure called to update C_S_AXI_LITE_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_LITE_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_LITE_ADDR_WIDTH } {
	# Procedure called to validate C_S_AXI_LITE_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_LITE_BASEADDR { PARAM_VALUE.C_S_AXI_LITE_BASEADDR } {
	# Procedure called to update C_S_AXI_LITE_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_LITE_BASEADDR { PARAM_VALUE.C_S_AXI_LITE_BASEADDR } {
	# Procedure called to validate C_S_AXI_LITE_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S_AXI_LITE_HIGHADDR { PARAM_VALUE.C_S_AXI_LITE_HIGHADDR } {
	# Procedure called to update C_S_AXI_LITE_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_LITE_HIGHADDR { PARAM_VALUE.C_S_AXI_LITE_HIGHADDR } {
	# Procedure called to validate C_S_AXI_LITE_HIGHADDR
	return true
}

proc update_PARAM_VALUE.C_S_ADC_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S_ADC_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_S_ADC_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_ADC_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S_ADC_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_S_ADC_AXIS_TDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M_DMA_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M_DMA_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_M_DMA_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_DMA_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M_DMA_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_M_DMA_AXIS_TDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M_DAC_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M_DAC_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_M_DAC_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_DAC_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M_DAC_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_M_DAC_AXIS_TDATA_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.C_S_AXI_LITE_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_LITE_DATA_WIDTH PARAM_VALUE.C_S_AXI_LITE_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_LITE_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_LITE_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_LITE_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_LITE_ADDR_WIDTH PARAM_VALUE.C_S_AXI_LITE_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_LITE_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_LITE_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_ADC_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_S_ADC_AXIS_TDATA_WIDTH PARAM_VALUE.C_S_ADC_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_ADC_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_S_ADC_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_DMA_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_M_DMA_AXIS_TDATA_WIDTH PARAM_VALUE.C_M_DMA_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M_DMA_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_M_DMA_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_DMA_AXIS_START_COUNT { MODELPARAM_VALUE.C_M_DMA_AXIS_START_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	# WARNING: There is no corresponding user parameter named "C_M_DMA_AXIS_START_COUNT". Setting updated value from the model parameter.
set_property value 32 ${MODELPARAM_VALUE.C_M_DMA_AXIS_START_COUNT}
}

proc update_MODELPARAM_VALUE.C_M_DAC_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_M_DAC_AXIS_TDATA_WIDTH PARAM_VALUE.C_M_DAC_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M_DAC_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_M_DAC_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_DAC_AXIS_START_COUNT { MODELPARAM_VALUE.C_M_DAC_AXIS_START_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	# WARNING: There is no corresponding user parameter named "C_M_DAC_AXIS_START_COUNT". Setting updated value from the model parameter.
set_property value 32 ${MODELPARAM_VALUE.C_M_DAC_AXIS_START_COUNT}
}

