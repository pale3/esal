# Name: die [Public Function]
# Description: Write message/no-message to stdout and exit
# Args:
#   -m = with message
#   -q = quite (no message)
# Example: die -m "This is error message"
die(){
	local m="" q=""

	[[ ${1} == "-m" ]] && echo "${R}!!! ERR:${N}${@/${1}}" && exit 254
	[[ ${1} == "-q" ]] && exit 255;

    return 0
}

# Name: is_function [Public Function]
# Description: Test whether if arg ${1} is function
# Example; is_function is_number
is_function() {
	[[ $(type -t "${1}" ) == "function" ]]
}

# Name: inherit [Public Function]
# Description: Source given library passed as ${1} arg
# Example: inherit colours
inherit() {
	local x
	for x in "$@"; do
		[[ -e "${ES_CORE_PATH}/${x}.bash" ]] \
			|| die "Couldn't find ${x}.bash"
		source "${ES_CORE_PATH}/${x}.bash" \
			|| die "Couldn't source ${x}.bash"
	done
}

# Name: is_number [Public Function]
# Description: Returns true if and only if ${1} arg is number
# Example: is_number 1234
is_number() {
	[[ -n ${1} ]] && [[ -z ${1//[[:digit:]]} ]]
}

# Name: relative_name [Pubclic Function]
# Convert filename $1 to be relative to directory $2.
# For both paths, all but the last component must exist.
relative_name() {
	local path=$(readlink -f "$1") dir=$(readlink "$2") c
	while [[ -n ${dir} ]]; do
		c=${dir%%/*}
		dir=${dir##"${c}"*(/)}
		if [[ ${path%%/*} = "${c}" ]]; then
			path=${path##"${c}"*(/)}
		else
			path=..${path:+/}${path}
		fi
	done
	echo "${path:-.}"
}
