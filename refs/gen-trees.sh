
pyang -p ../ -f tree --tree-line-length 69 ../ietf-netconf-client\@*.yang > ietf-netconf-client-tree.txt
pyang -p ../ -f tree --tree-line-length 69 ../ietf-netconf-server\@*.yang > ietf-netconf-server-tree.txt

pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings --tree-no-expand-uses ../ietf-netconf-client\@*.yang > ietf-netconf-client-tree-no-expand.txt
pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings --tree-no-expand-uses ../ietf-netconf-server\@*.yang > ietf-netconf-server-tree-no-expand.txt
