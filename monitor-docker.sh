#!/bin/bash -ex
python /monitor-docker.py  --check_interval "$CHECK_INTERVAL" \
       --ifttt_event_name "$IFTTT_EVENT_NAME" --whitelist "$WHITE_LIST" \
       --ifttt_service_key "$IFTTT_SERVICE_KEY" --msg_prefix "$MSG_PREFIX"
## File : monitor-docker.sh ends
