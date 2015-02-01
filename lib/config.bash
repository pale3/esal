create_envconf(){
	local config=${1} profdesc envdesc chk

	profdesc="
# DO NOT REMOVE THIS LINE IT'S ESSENTIAL FOR ESAL UTILITY
source $config "
	envdesc="# DO NOT ALTER THIS LINES DIRECTLY, IT'S INTENDED TO BE USED WITH ESAL UTILITY"
	
	emsg "Configuring $ES_BINARY utility:"
	if ! [[ -f $config ]]; then
		msg ":: Creating $config..."
		touch $config 2> /dev/null || die -m "root permission required!"
		echo "$envdesc" >> $config 
	else
		msg "${Y}*${N} file $config exist, remove it manualy!"
	fi

	chk=$(grep "source $config" /etc/profile)
	if [[ -z $chk ]];then
		msg ":: Incorporating into /etc/profile..."
		echo "$profdesc" >> /etc/profile || die -m "root permission required!"
		msg ":: Done"
	else
		msg "${Y}*${N} /etc/profile previously modified!"
	fi

	return

}

# Pseudo function its not ment to be called directly 
read_env_value(){
	local location="/etc/env.conf" 
	cur=
	#value=$( awk -F"="*\" "/${ENV_VAR}/ {print $2}")
	if $( grep "${ENV_VAR}" $location); then 
		cur=true
	fi
	echo ${cur}
}

write_env_value(){
	local location="/etc/env.conf" value="${1}"
	# check if file exist if not create it	
	! [[ -f $location ]] && die -m "$location doens't exist, use --configure!"
	# check for write premission of file 
	  [[ -w $location ]] || die -m "root privilages required!"
		
		cur=( $(read_env_value) )
		# if cur ENV_VAR exist in env.conf then replace just value of var
		[[ -z $cur ]] && echo "export ${value}" >> "$location" || \
		$(sed -i "s|${ENV_VAR}=.*|${value}|" $location) 
		
}
