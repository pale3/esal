# default do_set do_help do_usage do_list
# used for default actions, for example if action is just esal
# than use this
USAGE_HELP="${ES_BINARY} <module name> <module option>"
ES_VERSION="${ES_BINARY} 1.0"

describe_help(){
	msg "Display help message"
}
describe_usage(){
	msg "Display usage message"
}
describe_version(){
	msg "Display version information"
}

show_default_usage(){

	local action option="${1}" desc=""

	echo
	emsg "Standard $option:"
	for action in help usage version; do
		desc=$(describe_${action})

		output_align "${action}"
		write_ad_output "${action}" "${desc}"
	done
	echo
}

show_module_desc(){
	local desc="" modname=""

	if [[ -n ${MODULE_PARAMETERS} ]]; then
	for action in ${MODULE_PARAMETERS[@]}; do
		case $action in
			help | usage | version ) continue ;;
		esac
		desc=$(describe_${action})

		output_align "${action}"
		write_ad_output "${action}" "${desc:-no description}"
	done
		exit 1
	fi

	emsg "Extra modules:"
	for module in "${ES_MODULES_AVAILABLE[@]}"; do
		desc=$( grep "DESCRIPTION=" $ES_MODULES_PATH/${module}.esal | sed "s/\"//g" | sed "s/DESCRIPTION=//" )

		output_align "${module}"
		write_ad_output "${module}" "${desc:-no description}"
	done

}

do_help(){
	msg "Usage: $USAGE_HELP"
	show_default_usage "modules"
	show_module_desc
}
do_usage(){
	msg "Usage: $USAGE_HELP"
}
do_version(){
	msg ":: ${ES_VERSION}"
}
