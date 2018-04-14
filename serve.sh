#!/usr/bin/env bash
set -e

[[ -f $DEVPI_SERVERDIR/.serverversion ]] || initialize=yes

# Properly shutdown devpi server
shutdown() {
    devpi-server --stop  # Kill server
    kill -SIGTERM $TAIL_PID  # Kill log tailing
}

trap shutdown SIGTERM SIGINT

# Need $DEVPI_SERVERDIR
DEVPI_LOGS=$DEVPI_SERVERDIR/.xproc/devpi-server/xprocess.log

if [[ $initialize = yes ]]; then
devpi-server --start --init --host 0.0.0.0 --port $DEVPI_PORT --serverdir $DEVPI_SERVERDIR
else
devpi-server --start --host 0.0.0.0 --port $DEVPI_PORT --serverdir $DEVPI_SERVERDIR
	
fi


tail -f $DEVPI_LOGS &
TAIL_PID=$!

# Wait until tail is killed
wait $TAIL_PID

# Set proper exit code
wait $DEVPI_PID
EXIT_STATUS=$?
