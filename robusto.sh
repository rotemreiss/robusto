#!/usr/bin/env sh

BASEPATH=`dirname $0`
# Convert the script's path to absolute path.
BASEPATH=$(cd -- "$BASEPATH" && pwd)
DOMAIN=$1

update_scanner() {
  # Install/update binaries.
  GO111MODULE=on go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei

  # Update Nuclei templates.
  nuclei -ut -silent
}

scan() {
  cat "${1:-/dev/stdin}" |\
    nuclei -silent -nc -tags takeover > results.txt
}

# Run our found_hook to allow integrations
trigger_results_hook() {
  found_hook_path="${BASEPATH}/hooks/_found_hook"
  # Check if we have a hook file
  if [ -f "$found_hook_path" ]; then
    # Run the hook script
    (${found_hook_path})
  fi
}

main () {
  update_scanner
  scan

  # Return results
  if [ -s ${BASEPATH}/results.txt ]; then
    echo "[+] Found subdomains to takeover"

    trigger_results_hook

    exit 2
  else
    echo "[-] No subdomains to takeover"
    exit 0
  fi
}

main
