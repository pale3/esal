# default do_set do_help do_usage do_list
# used for default actions, for example if action is just eselect
# than use this 
USAGE_HELP="${ES_BINARY} <module name> <module option>"
ES_VERSION="${ES_BINARY} 1.0"

describe_help(){
	echo "Display help message"
}

describe_usage(){
	echo "Display usage message"
}

describe_version(){
	echo "Display version information"
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
	for modules in ${ES_MODULES_PATH}/*.esua; do
		desc=$( grep "DESCRIPTION=" $modules | sed "s/\"//g" | sed "s/DESCRIPTION=//" )
		modname=$( basename ${modules/%.*} )
	
		output_align "${modname}"
		write_ad_output "${modname}" "${desc:-no description}"
	done

}

do_help(){
	echo "Usage: $USAGE_HELP"
	show_default_usage "modules"
	show_module_desc
}

do_usage(){
	echo "Usage: $USAGE_HELP"
}

do_version(){
	echo ":: ${ES_VERSION}"
}
