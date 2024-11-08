#!/bin/bash

# Set variables
MAXSEQ_VALUE=1000
NAGIOSXI_USER="nagiosxi"
SUDOERS_FILE="/etc/sudoers"

# Function to update maxseq in sudoers
configure_maxseq() {
    echo "Configuring maxseq limit in $SUDOERS_FILE..."

    # Add or update maxseq setting
    if sudo grep -q "Defaults maxseq=" "$SUDOERS_FILE"; then
        sudo sed -i "s/^Defaults maxseq=.*/Defaults maxseq=$MAXSEQ_VALUE/" "$SUDOERS_FILE"
    else
        echo "Defaults maxseq=$MAXSEQ_VALUE" | sudo tee -a "$SUDOERS_FILE" > /dev/null
    fi

    echo "maxseq limit set to $MAXSEQ_VALUE in $SUDOERS_FILE."
}

# Function to configure Nagios XI sudoers entry
configure_nagios_sudoers() {
    echo "Configuring sudoers entry for Nagios XI user ($NAGIOSXI_USER)..."

    # Add Nagios XI entry to sudoers if not present
    NAGIOSXI_ENTRY="$NAGIOSXI_USER ALL=NOLOG_OUTPUT: ALL, NOLOG_INPUT: ALL, (ALL) NOPASSWD: NODEJWT"

    if ! sudo grep -q "$NAGIOSXI_ENTRY" "$SUDOERS_FILE"; then
        echo "$NAGIOSXI_ENTRY" | sudo tee -a "$SUDOERS_FILE" > /dev/null
        echo "Added Nagios XI sudoers entry for $NAGIOSXI_USER."
    else
        echo "Nagios XI sudoers entry for $NAGIOSXI_USER already exists."
    fi
}

# Execute functions
configure_maxseq
configure_nagios_sudoers

# Display confirmation
echo "Configuration complete. Please verify changes in $SUDOERS_FILE."