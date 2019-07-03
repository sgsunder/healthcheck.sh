#!/bin/sh

# Define Functions
send() {
	printf '%s\r\n' "$*";
}

send_default_headers() {
	DATE=$(date +"%a, %d %b %Y %H:%M:%S %Z")
	send "Date: $DATE"
	send "Expires: $DATE"
	send "Server: Healthcheck API"
	send "Content-Type: application/json"
	send
}

bad_request() {
	send "HTTP/1.0 400 Bad Request"
	send_default_headers
	send "{\"error\":\"400 Bad Request\"}"
	exit 1
}

cd "$(dirname "$0")"

# Try to read request
read -r request || bad_request
echo $request | awk 'NR==1{print $1}' | grep -q 'GET' || bad_request

# Send response headers
send "HTTP/1.0 200 OK"
send_default_headers

# Get Drive Info
drivetemps=""
drivehealth="true"
for drive in $(lsblk -J | jq -r '.blockdevices[] | .name')
do
	drivetemps="$(smartctl -A /dev/$drive | awk '/194/{print int($10)}') $drivetemps"
	smartctl -H /dev/$drive | grep -q 'SMART overall-health self-assessment test result: PASSED' || drivehealth="false"
done

# Create JSON File
send $(tr -d '\n' << EOJSON
{
"uptime":"$(uptime | sed 's/.*up \([^,]*\), .*/\1/')",
"os":"$(sed 's/^PRETTY_NAME=\"\(.*\)\"/\1/;t;d' /etc/os-release)",
"load":[$(cut -d ' ' -f1-3 /proc/loadavg | tr -s ' ' ',')],
"ram":$(free | awk 'NR==2{print int(100*$3/$2)}'),
"zfs":
{"healthy":$(zpool status -x | grep -q 'all pools are healthy' && echo 'true' || echo 'false'),
"percent":$(zfs list -Hp | awk 'NR==1{print int(100*$2/($2+$3))}')
},"drives":
{"temp":[$(echo $drivetemps | tr -s ' ' ',')],
"healthy":$drivehealth
}}
EOJSON
)

exit 0
