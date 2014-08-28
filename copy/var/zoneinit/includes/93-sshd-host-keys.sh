# Configure ssh host keys if they exists in mdata

SSH_HOSTS='/var/ssh'

for key in dsa_key dsa_key_pub rsa_key rsa_key_pub; do
	current_key=${current_key:-$(mdata-get ssh_host_${key} 2>/dev/null)} || \
		current_key=$(cat ${SSH_HOSTS}/ssh_host_${key});
	mdata-put ssh_host_${key} "${current_key}"
	mdata-get ssh_host_${key} > ${SSH_HOSTS}/ssh_host_${key}
done