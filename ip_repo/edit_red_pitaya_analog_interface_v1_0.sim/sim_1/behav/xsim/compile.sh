#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.2 (64-bit)
#
# Filename    : compile.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for compiling the simulation design source files
#
# Generated by Vivado on Tue Aug 09 12:29:46 CEST 2022
# SW Build 2708876 on Wed Nov  6 21:39:14 MST 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: compile.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xvhdl --incr --relax -prj tb_red_pitaya_analog_interface_v1_0_vhdl.prj"
xvhdl --incr --relax -prj tb_red_pitaya_analog_interface_v1_0_vhdl.prj 2>&1 | tee -a compile.log

