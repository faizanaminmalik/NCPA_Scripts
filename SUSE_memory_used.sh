#!/bin/bash
#Script is tested for SUSE
if [[ -z "$1" ]] || [[ -z "$2" ]] || [[ -z "$3" ]] || [[ -z "$4" ]]; then
	echo " Missing Parameters! Syntax: check_xi_ncpa!-t 'mytoken' -P 5693 -M plugins/test.sh -a "-w '10' -c '20'""
	exit 2
fi
warning_val=$2
critical_val=$4
#Obtain Used memory using Free command
VAL="$(free -m | awk 'FNR == 2 {print ($2-($4+$6+$7))*100/$2}')"
#Convert to Integer for comparison with Warning and Critical Values which are Integer
mem_used=${VAL%.*}
#Compare Memory utilization with threshold values
if [ $mem_used -ge $critical_val ]
then
	echo "CRITICAL - Memory Utilization is $mem_used %"
	exit 2
elif [ $mem_used -ge $warning_val ]
then
	echo "WARNING - Memory Utilization is $mem_used  %"
	exit 1
else
	echo "OK - Memory Utilization is $mem_used %"
	exit 0
fi
