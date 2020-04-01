#!/bin/bash

run_unix_cmd() {
  # $1 is the line number
  # $2 is the cmd to run
  # $3 is the expected exit code
  output=`$2 2>&1`
  exit_code=$?
  if [[ $exit_code -ne $3 ]]; then
    printf "failed (incorrect exit status code) on line $1.\n"
    printf "  - exit code: $exit_code (expected $3)\n"
    printf "  - command: $2\n"
    if [[ -z $output ]]; then
      printf "  - output: <none>\n\n"
    else
      printf "  - output: <starts on next line>\n$output\n\n"
    fi
    exit 1
  fi
}

printf "Testing ietf-netconf-client\@*.yang (pyang)..."
command="pyang -Werror --ietf --max-line-length=69 -p ../ ../ietf-netconf-client\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-netconf-server\@*.yang (pyang)..."
command="pyang -Werror --ietf --max-line-length=69 -p ../ ../ietf-netconf-server\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-netconf-client\@*.yang (yanglint)..."
command="yanglint -p ../ ../ietf-netconf-client\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-netconf-server\@*.yang (yanglint)..."
command="yanglint -p ../ ../ietf-netconf-server\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"


printf "Testing ex-netconf-client.xml..."
command="yanglint -m -s ../ietf-*\@*.yang ietf-origin.yang ex-netconf-client.xml ../../trust-anchors/refs/ex-truststore.xml ../../keystore/refs/ex-keystore.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ex-netconf-server.xml..."
command="yanglint -m -s ../ietf-*\@*.yang ietf-origin.yang ietf-x509-cert-to-name@2014-12-10.yang ex-netconf-server.xml ../../trust-anchors/refs/ex-truststore.xml ../../keystore/refs/ex-keystore.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

