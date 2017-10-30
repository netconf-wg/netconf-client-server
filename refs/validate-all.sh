
echo "Testing ietf-netconf-client\@*.yang (pyang)..."
pyang --ietf --max-line-length=70 -p ../ ../ietf-netconf-client\@*.yang
echo "Testing ietf-netconf-server\@*.yang (pyang)..."
pyang --ietf --max-line-length=70 -p ../ ../ietf-netconf-server\@*.yang

echo "Testing ietf-netconf-client\@*.yang (yanglint)..."
yanglint -p ../ ../ietf-netconf-client\@*.yang
echo "Testing ietf-netconf-server\@*.yang (yanglint)..."
yanglint -p ../ ../ietf-netconf-server\@*.yang


echo "Testing ex-netconf-client.xml..."
yanglint -m -p ../ -s ../ietf-netconf-client\@*.yang ex-netconf-client.xml ../../keystore/refs/ex-keystore.xml

echo "Testing ex-netconf-server.xml..."
yanglint -m -p ../ -s ../ietf-netconf-server\@*.yang ietf-x509-cert-to-name@2014-12-10.yang ex-netconf-server.xml ../../keystore/refs/ex-keystore.xml

