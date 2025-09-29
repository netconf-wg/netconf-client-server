#!/bin/bash

DATE=`date +%Y-%m-%d`


resilient_curl() {
    # sometimes www.iana.org throws a 502 (Bad Gateway)
    while true; do
        curl -sfO $1 > /dev/null
        if [[ $? == 0 ]]; then
            break
        fi
        echo "curl didn't return zero, sleeping for 1 second..."
        sleep 1
    done
}


download_modules_from_iana() {

    # modules with revisions
    modules_with_revisions=(
        ietf-inet-types@2013-07-15
        iana-crypt-hash@2014-08-06
        ietf-x509-cert-to-name@2014-12-10
        ietf-netconf-acm@2018-02-14
        ietf-crypto-types@2024-10-10
        ietf-truststore@2024-10-10
        ietf-keystore@2024-10-10
        ietf-tcp-common@2024-10-10
        ietf-tcp-client@2024-10-10
        ietf-tcp-server@2024-10-10
        iana-ssh-encryption-algs@2024-10-16
        iana-ssh-mac-algs@2024-10-16
        iana-ssh-public-key-algs@2024-10-16
        iana-ssh-key-exchange-algs@2024-10-16
        ietf-ssh-common@2024-10-10
        ietf-ssh-client@2024-10-10
        ietf-ssh-server@2024-10-10
        ietf-tls-common@2024-10-10
        ietf-tls-client@2024-10-10
        ietf-tls-server@2024-10-10
        iana-tls-cipher-suite-algs@2024-10-16
    )
    for module in "${modules_with_revisions[@]}"; do
        resilient_curl https://www.iana.org/assignments/yang-parameters/$module.yang
    done

}



download_modules_from_github() {

    # modules with revisions
    modules_with_revisions=(
        netconf-wg/udp-client-server/refs/heads/master/yangs/adopted-05/ietf-udp-server@2024-10-15.yang
    )
    for module in "${modules_with_revisions[@]}"; do
        resilient_curl https://raw.githubusercontent.com/$module
    done

    # modules with YYYY-MM-DD
    modules_with_yyyymmdd=(
        #netconf-wg/http-client-server/refs/heads/master/ietf-http-server.yang
    )
    for filepath in "${modules_with_yyyymmdd[@]}"; do
        resilient_curl https://raw.githubusercontent.com/$filepath
        module=`basename $filepath | sed 's/.yang//'`
        sed -e "s/YYYY-MM-DD/$DATE/" $module.yang > $module\@$DATE.yang
        rm $module.yang
        #print_notice $module\@$DATE.yang
    done
}


set_local_modules() {

    modules=(
        ../ietf-netconf-client
        ../ietf-netconf-server
    )
    for module in "${modules[@]}"; do
        module_name=`basename $module`
        sed -e "s/YYYY-MM-DD/$DATE/" $module.yang > $module_name\@$DATE.yang
    done
}



do_cleanup() {
  rm -f *.yang
}


# main
do_cleanup
download_modules_from_iana
download_modules_from_github
set_local_modules


