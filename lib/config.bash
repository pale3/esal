# create environment config
# TODO: allow local user config
create_envconf(){
	local config=${1} profdesc envdesc chk

    profdesc="# DO NOT REMOVE THIS LINE ITS ESSENTIAL FOR ${ES_BINARY} UTILITY"
    envdesc="# DO NOT ALTER THIS LINES DIRECTLY, IT'S INTENDED TO BE USED WITH ${ES_BINARY} UTILITY"

	emsg "Configuring ${ES_BINARY} utility:"
	if ! [[ -f $config ]]; then
		msg ":: Creating $config..."
		touch $config 2> /dev/null || \
            die -m "root permission required!"
		echo "$envdesc" >> $config
	else
		msg "${Y}*${N} file $config exist, remove it manualy!"
	fi

	chk=$(grep "source $config" /etc/profile)
	if [[ -z $chk ]];then
		msg ":: Incorporating into /etc/profile..."
		echo -e "\n$profdesc\nsource $config" 2>/dev/null >> /etc/profile || \
            die -m "root permission required!"
		msg ":: Done"
	else
		msg "${Y}*${N} /etc/profile previously modified! Already configured?"
	fi

	return
}

# Pseudo function its not ment to be called directly
read_env_value(){
	local env_conf="/etc/env.conf" cur=

	if $( grep "${ENV_VAR}" $env_conf); then
		cur=true
	fi
	echo $cur
}

write_env_value(){
	local env_conf="$ES_ENVCONF" value="${1}"

	! [[ -f $env_conf ]] && die -m "$env_conf doesn't exist, use --configure first!"
	  [[ -w $env_conf ]] || die -m "root privilages required!"

	cur=( $(read_env_value) )
	# if cur ENV_VAR exist in env.conf then replace just value of var
	[[ -z $cur ]] && echo "export ${value}" >> "$env_conf" || \
		$(sed -i "s|${ENV_VAR}=.*|${value}|" $env_conf)
}
