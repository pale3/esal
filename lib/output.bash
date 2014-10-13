msg(){ printf "%s\n" " $@"; } # color normal

emsg(){ 
	local text=${1} target=${2}
	printf "%s\n" " ${G}${text} ${target}${N}"; 
} 

output_align(){
	local action="${#1}" space=10 lcolumn=15
	indent=$( expr $lcolumn - $action + $space )
}

write_ad_output(){ 
	local action=${1} description=${2}
	printf "%s%-${indent}s%s\n" "  ${W}${action}${N}" "" "${description}"
	return 0
}

write_numbered_output(){
# parameters: -s (small list)
#             -h (huge list) 

	local p=${1} action=${2} 
	n=$(( ${n} + 1 ))
	
	# small list (if output < 10 )
	if [[ $p == "-s" ]]; then
			printf "%s\n" " ${W}[${n}]${N} ${action} ${m}"
	fi

	# huge list (if output > 10 )
	if [[ $p == "-h" ]]; then
	[[ $n -lt 10 ]] && printf "%s\n" " ${W}[${n}]${N}   ${action} ${m}" ||
                     printf "%s\n" " ${W}[${n}]${N}  ${action} ${m}" 
	fi
	return 0
}

# check for ENV var if is already setted
is_marked(){
	local targets=${1}
	
	# if we are localy defiend ENV_VAR inside bashrc, zshrc.. it will be
	# here
	#[[ ${targets##*/} == ${!ENV_VAR} ]] && m="${Y}*${N}" || m=""
	#echo $targets
	[[ ${targets} == ${!ENV_VAR} ]] && m="${B}*${N}" || m=""
	#[[ read_env_value == ${targets} ]] && m="${B}*${N}" || m=""

}
