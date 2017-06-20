
pyang -p ../ -f tree --tree-line-length 71 --tree-print-groupings ../ietf-netconf-client\@*.yang > ietf-netconf-client-tree.txt
pyang -p ../ -f tree --tree-line-length 71 ../ietf-netconf-server\@*.yang > ietf-netconf-server-tree.txt

