echo "Generating tree diagrams..."

pyang -p ../ -f tree --tree-line-length 69 --tree-no-expand-uses ../ietf-netconf-client\@*.yang > ietf-netconf-client-tree-no-expand.txt
pyang -p ../ -f tree --tree-line-length 69 --tree-no-expand-uses ../ietf-netconf-server\@*.yang > ietf-netconf-server-tree-no-expand.txt

extract_grouping_with_params() {
  # $1 name of module
  # $2 name of grouping
  # $3 addition CLI params
  # $4 output filename
  pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings $3 ../$1@*.yang | gsed -e 's/grouping netconf-client-grouping/grouping netconf-client-grouping ---> <empty>/' -e '/^\( *\)+-- netconf-client-parameters/a\                +---u ncc:netconf-client-grouping' -e '/|     +-- netconf-client-parameters/a\       |        +--u ncc:netconf-client-grouping' > $1-groupings-tree.txt
  cat $1-groupings-tree.txt | sed -n "/^  grouping $2/,/^  grouping/p" > tmp
  c=$(grep -c "^  grouping" tmp)
  if [ "$c" -ne "1" ]; then
    ghead -n -1 tmp > $4
    rm tmp
  else
    mv tmp $4
  fi
}

extract_grouping() {
  # $1 name of module
  # $2 name of groupin
  #extract_grouping_with_params "$1" "$2" "" "tree-$2.expanded.txt"
  extract_grouping_with_params "$1" "$2" "--tree-no-expand-uses" "tree-$2.no-expand.txt"
}

extract_grouping ietf-netconf-client netconf-client-grouping
extract_grouping ietf-netconf-client netconf-client-initiate-stack-grouping
extract_grouping ietf-netconf-client netconf-client-listen-stack-grouping
extract_grouping ietf-netconf-client netconf-client-app-grouping

extract_grouping ietf-netconf-server netconf-server-grouping
extract_grouping ietf-netconf-server netconf-server-listen-stack-grouping
extract_grouping ietf-netconf-server netconf-server-callhome-stack-grouping
extract_grouping ietf-netconf-server netconf-server-app-grouping

