#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Tue Aug 09 12:29:48 CEST 2022
# SW Build 2708876 on Wed Nov  6 21:39:14 MST 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto f94432e1299543bdb2ffb6bbc4aa41cb --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot tb_red_pitaya_analog_interface_v1_0_behav xil_defaultlib.tb_red_pitaya_analog_interface_v1_0 -log elaborate.log"
xelab -wto f94432e1299543bdb2ffb6bbc4aa41cb --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot tb_red_pitaya_analog_interface_v1_0_behav xil_defaultlib.tb_red_pitaya_analog_interface_v1_0 -log elaborate.log

