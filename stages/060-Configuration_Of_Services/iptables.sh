#!/bin/bash

# This will configure iptables.
function iptables_configure () {
	template_file \
		templates/iptables.template \
		${iptables_conf_loc} \
		"600" \
		"root:root"

    service_on "iptables"
    enable_service "iptables"
}

# This verifies that iptables was configured properly.
function iptables_verify () {
	verify_template \
		${iptable_ssh_rules_regexp} \
		${iptables_conf_loc} \
		"600" \
		"root:root"

	verify_template \
		${iptable_ping_rules_regexp} \
		${iptables_conf_loc} \
		"600" \
		"root:root"

    verify_service_enabled "iptables"
    verify_service_on "iptables"
}
