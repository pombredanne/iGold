find <folder name> -name *.plist -exec grep -o -P '(?<=>).*(?=<)' {} \; | grep '(api|token)' -IE -A 5 -B 5 --color=always ## specific search
find <folder name> -name *.plist -exec grep -o -P '(?<=>).*(?=<)' {} \; ## read all plist files
