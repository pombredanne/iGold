find <folder name> -name *.plist -exec grep -o -P '(?<=>).*(?=<)' {} \; | grep '(api|token|key)' -IE -A 10 -B 10 --color=always
 ## find keys across all plists 'at scale'
find <folder name> -name *.plist -exec grep -o -P '(?<=>).*(?=<)' {} \; ## read all plist files
