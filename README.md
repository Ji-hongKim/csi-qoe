# csi-qoe
A Tool for Measuring the Effect of Wireless Channel State on Web QoE

## Introduction
This script measures channel state information (CSI) defined in the IEEE 802.11 specification
and Web QoE metrics such as [SpeedIndex](https://sites.google.com/a/webpagetest.org/docs/using-webpagetest/metrics/speed-index)
simultaneously, to investigate the effect of wireless channel state on the quality of experience
(QoE) when using Web applications.

## Requirements
* CSI extraction tool ([Atheros CSI tool](https://github.com/xieyaxiongfly/Atheros_CSI_tool_OpenWRT_src))
* Web performance measurement tool ([sitespeed.io](https://www.sitespeed.io))
