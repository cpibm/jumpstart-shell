#!/bin/bash
node_modules/.bin/jest --colors --coverage --verbose --notify --json --outputFile=test-results.json >| test-results.colored.txt 2>&1
commit_msg="$(node dojo-helper.js)"
cat test-results.colored.txt
cat test-results.colored.txt | sed -e $'s/\x1b\[[0-9;]*m//g' >| test-results.txt
rm test-results.json
rm test-results.colored.txt
# echo "GIT_COMMIT_MSG > $commit_msg"
git add -A
git commit -m "$commit_msg" || true
