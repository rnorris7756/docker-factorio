#!/bin/bash
#We use exec here to replace the init script with the factorio executable.
#This allows factorio to receive SIGINT/SIGTERM and shut down gracefully when
#the container receives a signal to shut down.

if [ ! -f $SAVEFILE ]; then
  exec /opt/factorio/bin/x64/factorio --create $SAVEFILE
else
  exec /opt/factorio/bin/x64/factorio --start-server $SAVEFILE
fi
