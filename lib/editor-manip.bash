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

describe_list(){
	msg "List avaliable targets for ${ENV_VAR} variable"
}
describe_set(){
	msg "set the ${ENV_VAR} variable in profile"
}
describe_show(){
	msg "Show the value of ${ENV_VAR} variable in profile"
}

do_list(){
	[[ $# -gt 2 ]] && die -m "Too many Parameters"

    emsg "Avaliable targets for variable ${ENV_VAR}"
    local targets=( $(find_targets) )

    for (( i = 0; i < ${#targets[@]}; ++i )); do
       is_marked "${targets[i]}"
       write_numbered_output -s "${targets[i]}" "$i"
    done
}
do_set(){
	local var=${@:3}
	[[ -z $var ]] && die -m "You didn't tell me what to set the variable to"
	if is_number $var; then
		targets=( $(find_targets) )
		target=${targets[var-1]%%:*}
		! [[ -n $target ]] && die -m "No such target: ${var}"
 		echo "Setting ${ENV_VAR} to ${target} ..."
		write_env_value "${ENV_VAR}=\"${target}\""
    else
        die -m "You can only use positive numbers"
	fi
}
do_show(){
	emsg "${ENV_VAR} variable in profile:"
	[[ ${!ENV_VAR} ]] && msg "${W}${!ENV_VAR}${N}" || msg "${W}(none)${N}"
}

do_help(){
	msg "$DESCRIPTION"
	msg "Usage: $USAGE_HELP"
	show_default_usage "actions"
	emsg "Extra actions:"
	show_module_desc
}
do_usage(){
	msg "Usage: ${USAGE_HELP}"
}
do_version(){
	msg ":: ${MODULE_VERSION}"
}
