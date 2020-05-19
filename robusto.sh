#!/usr/bin/env sh

BASEPATH=`dirname $0`
DOMAIN=$1

# Pull the Docker images of the relevant tools
pull_docker_images() {
  docker pull ice3man/subfinder

  # @todo Replace with the offical images once released.
  docker pull -q rotemreiss/nuclei
  docker pull -q rotemreiss/dnsprobe
  docker pull -q rotemreiss/httprobe
}

update_scanner() {
  # Update the submodule nuclei-templates
  (cd "${BASEPATH}" && git submodule update --remote -q)

  # Pull our docker images
  pull_docker_images
}

run_subfinder () {
  docker run -v $HOME/.config/subfinder:/root/.config/subfinder -i ice3man/subfinder -d ${DOMAIN}
}

run_dnsprobe () {
  docker run -i rotemreiss/dnsprobe -silent -f domain
}

run_httprobe () {
  docker run -i rotemreiss/httprobe -prefer-https
}

run_nuclei () {
  docker run -v "${BASEPATH}/nuclei-templates:/go/src/app/" -i rotemreiss/nuclei -t ./subdomain-takeover/detect-all-takeovers.yaml
}

scan() {
  run_subfinder | run_dnsprobe | run_httprobe | run_nuclei > results.txt
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
