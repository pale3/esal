# Output stuff

# Output normal message type, color normal
# usage: msg "$1"
msg(){ printf "%s\n" " $@"; } 

# Output title of action in green colour
# Usage: emsg $1 $2
emsg(){
	local text=${1} target=${2}
	printf "%s\n" " ${G}${text} ${target}${N}"; 
} 

# Aligning output of strings. 
output_align(){
	local action="${#1}" space=10 lcolumn=15
	indent=$( expr $lcolumn - $action + $space )
}

# Used for displaying action description output
# Usage: write_ad_output "$1" "$2"
write_ad_output(){ 
	local action=${1} description=${2}
	printf "%s%-${indent}s%s\n" "  ${W}${action}${N}" "" "${description}"
	return 0
}

# Used for displaying numbered output, usefull for <list> action
# Args: 
#   -s (small list < 10)
#	-h (huge list > 10)
# 
# optional: 2nd arg of <action> is used for marking [*]
#	write_numbered_output <param> <action>
write_numbered_output(){
    local p=${1} action=${2} count=$(( $3 + 1 ))

    # small list (if output < 10 )
	if [[ $p == "-s" ]]; then
            [[  $count -lt 10 ]] && \
			printf "%s\n" " ${W}[${count}]${N} ${action} ${m}" || \
            die -m "write_numbered_output: please use -h arg cos this list haves more than 10 entries"
	fi

	# huge list (if output > 10 ) {pretty alignement}
	if [[ $p == "-h" ]]; then
         
        [[ $count -lt 10 ]] && \
                printf "%s\n" " ${W}[${count}]${N}   ${action} ${m}" && return 
        [[ $count -lt 100 ]] && \
                printf "%s\n" " ${W}[${count}]${N}  ${action} ${m}" && return
        [[ $count -gt 100 ]] && \
                printf "%s\n" " ${W}[${count}]${N} ${action} ${m}" && return
	fi
	return 0
}

# check for ENV_VAR if it is setted
# NOTE: this only check ENV var nothing more!!!
# Usage: is_marked <target>
is_marked(){
	local targets=${1}
	
	# if we are localy defiend ENV_VAR inside bashrc, zshrc.. it will be
	# here
	#[[ ${targets##*/} == ${!ENV_VAR} ]] && m="${Y}*${N}" || m=""
	#echo $targets
	[[ ${targets} == ${!ENV_VAR} ]] && m="${B}*${N}" || m=""
	#[[ read_env_value == ${targets} ]] && m="${B}*${N}" || m=""
    
}
