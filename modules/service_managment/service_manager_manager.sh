#!/bin/bash

# Starts a service.
# Usage:
#   start_service "service"
function start_service () {
    systemctl start $1 > /dev/null 2>&1
    print_ret_res "$?" "Started service: $1"
}

# Stops a service.
# Usage:
#   stop_service "service"
function stop_service () {
    systemctl stop $1 > /dev/null 2>&1
    print_ret_res "$?" "Stopped service: $1"
}

# Enables a service to run on boot.
# Usage:
#   enable_service "service"
function enable_service () {
    systemctl enable $1 > /dev/null 2>&1
    print_ret_res "$?" "Enabled service: $1"
}

# Disables a service from running on boot.
# Usage:
#   disable_service "service"
function disable_service () {
    systemctl disable $1 > /dev/null 2>&1
    print_ret_res "$?" "Disabled service: $1"
}

# Starts and enables a service.
# Usage:
#   service_on "service"
function service_on () {
    local retval=0
    retval+=enable_service $1 > /dev/null 2>&1
    retval+=start_service $1 > /dev/null 2>&1
    print_ret_res "$retval" "Started and enabled service: $1"
}

# Stops and disables a service.
# Usage:
#   service_off "service"
function service_off () {
    local retval=0
    retval+=disaable_service $1 > /dev/null 2>&1
    retval+=stop_service $1 > /dev/null 2>&1
    print_ret_res "$retval" "Stopped and disabled service: $1"
}

# Verifies that a service is enable to run on boot.
# Usage:
#   verify_service_enabled "service"
function verify_service_enabled () {
    systemctl is-enabled $1 | grep "enabled" > /dev/null 2>&1
    print_ret_res "$?" "Verified service enabled: $1"
}

# Verifies that a service is not configured to run on boot.
# Usage:
#   verify_service_disabled "service"
function verify_service_disabled () {
    systemctl is-enabled $1 | grep "disabled" > /dev/null 2>&1
    print_ret_res "$?" "Verified service disabled: $1"
}

# Verifies that a service is running.
# Usage:
#   verify_service_running "service"
function verify_service_running () {
    systemctl is-active $1 | grep "active" > /dev/null 2>&1
    print_ret_res "$?" "Verified service running: $1"
}

# Verifies that a service is stopped.
# Usage:
#   verify_service_stopped "service"
function verify_service_stopped () {
    systemctl is-active $1 | grep "inactive" > /dev/null 2>&1
    print_ret_res "$?" "Verified service stopped: $1"
}

# Verifies that a service is configured to run on boot and is currently running.
# Usage:
#   verify_service_on "service"
function verify_service_on () {
    local retval=0
    retval+=verify_service_on $1 > /dev/null 2>&1
    retval+=verify_service_enable $1 > /dev/null 2>&1
    print_ret_res "$retval" "Verified service started and enabled: $1"
}

# Verifies that a service is not configured to run on boot and is stopped.
# Usage:
#   verify_service_off "service"
function verify_service_off () {
    local retval=0
    retval+=verify_service_off $1 > /dev/null 2>&1
    retval+=verify_service_disabled $1 > /dev/null 2>&1
    print_ret_res "$retval" "Verified service stopped and disabled: $1"
}
