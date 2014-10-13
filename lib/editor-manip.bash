inherit config

find_targets() {
	local cur i

	for i in ${LIST}; do
		[[ -f ${i#*:} ]] && echo "${i%%:*}"
	done

# also output the current value if it isn't in our list
#	cur=$(read_env_value)
#	[[ -n ${cur} && ${EDITOR_LIST} != *:* && -f ${ROOT}${cur} ]] \
#		&& ! has "${cur#${EPREFIX}}" ${EDITOR_LIST} \
#		&& echo "${cur}"
}

# describe functions $describe_{show,list,set}
describe_show(){
	echo "Show the value of ${ENV_VAR} variable in profile"
}

describe_list(){
	echo "List avaliable targets for ${ENV_VAR} variable"
}

describe_set(){
	echo "set the ${ENV_VAR} variable in profile"
}


do_show(){
	emsg "${ENV_VAR} variable in profile:"
	[[ ${!ENV_VAR} ]] && msg "${W}${!ENV_VAR}${N}" || msg "${W}(none)${N}"
}

do_list(){
	[[ $# -gt 2 ]] && die -m "Too many Parameters"
	emsg "Avaliable targets for variable ${ENV_VAR}"

	for target in ${LIST[@]}; do
		is_marked "$target" 
		[[ -x "$target" ]] && write_numbered_output -s "$target"
	done
}

do_set(){
	local var=${@:3}
	[[ -z $var ]] && die -m "You didn't tell me what to set the variable to"
	if is_number $var; then
		echo number $var
		targets=( $(find_targets) )
		target=${targets[var-1]%%:*}
		! [[ -n $target ]] && die -m "No such target: ${var}" 
 		echo "Setting ${ENV_VAR} to ${target} ..."
		write_env_value "${ENV_VAR}=\"${target}\""
	fi
}

do_help(){
	echo "$DESCRIPTION"
	echo "Usage: $USAGE_HELP"
	show_default_usage "actions"
	emsg "Extra actions:"
	show_module_desc
}

do_usage(){
	echo "Usage: ${USAGE_HELP}"
}

do_version(){
	echo ":: ${MODULE_VERSION}"
}
