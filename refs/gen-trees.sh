
pyang -p ../ -f tree ../ietf-netconf-client\@*.yang > ietf-netconf-client-tree.txt.tmp
pyang -p ../ -f tree ../ietf-netconf-server\@*.yang > ietf-netconf-server-tree.txt.tmp

fold -w 71 ietf-netconf-client-tree.txt.tmp > ietf-netconf-client-tree.txt
fold -w 71 ietf-netconf-server-tree.txt.tmp > ietf-netconf-server-tree.txt

rm *-tree.txt.tmp
