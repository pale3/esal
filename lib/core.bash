# die [-q] "Message" PUBLIC
die(){
	local m="" q=""
	# m = with message
	# q = quite(no message)
	
	[[ ${1} == "-m" ]] && echo "${R}!!! ERR:${N}${@/${1}}" && exit 254
	[[ ${1} == "-q" ]] && exit 255;
	return 0
}

# is_function function PUBLIC
# Test whether function exists
is_function() {
	[[ $(type -t "${1}" ) == "function" ]]
}

# inherit module PUBLIC
# Sources a given esal library file
inherit() {
	local x
	for x in "$@"; do
		[[ -e "${ES_CORE_PATH}/${x}.bash" ]] \
			|| die "Couldn't find ${x}.bash"
		source "${ES_CORE_PATH}/${x}.bash" \
			|| die "Couldn't source ${x}.bash"
	done
}

# Returns true if and only if $1 is a positive whole number
is_number() {
	[[ -n ${1} ]] && [[ -z ${1//[[:digit:]]} ]]
}
