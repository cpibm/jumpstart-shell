#!/bin/bash
node_modules/.bin/jest --coverage --verbose --notify --json --outputFile=test-results.json || true
commit_msg="$(node dojo-helper.js)"
rm test-results.json
# echo "GIT_COMMIT_MSG > $commit_msg"
git add -A
git commit -m "$commit_msg" || true