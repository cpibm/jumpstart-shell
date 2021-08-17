#!/bin/bash
script_dir="$(dirname $(realpath $0))"
# echo "$script_dir"
# exit 0

if [ $# -eq 0 ]; then
    echo "How would you like to name your project?"
    read project
else
    project="$1"
fi

echo "Let me gather some information first..."
echo "Specify your GitHub Organization or Username:"
read organization

destination="$PWD/$project"
# sonar_project_key="${organization}_${project}"

trap \
 "{ echo 'Something went wrong. Aborting execution.'; exit 1; }" \
 SIGINT SIGTERM ERR

# Initialize git repository
echo "INFO: Initializing git repo..."
mkdir -p "$destination"
cd "$destination"
git init
git checkout -b main
git symbolic-ref HEAD refs/heads/main
# gh repo create "$organization/$project" --public --confirm
touch README.md
echo ".env\nnode_modules" > .gitignore
git add -A
git commit -m "chore: Starting first pomodoro with empty project"
# git remote add origin "git@github.com:$organization/${project}.git"
# git push -u origin main

# Prepare template
echo "INFO: Preparing node project boilerplate"
pushd "$script_dir/template" &> /dev/null
cp -r . "$destination"
popd &> /dev/null

# SCAFFOLD PROJECT
# Install and update NPM packages
echo "INFO: Installing NPM packages ..."
sed -i '' 's/"name": ""/"name": "'${project}'"/g' package.json
npm install --save-dev jest node-notifier nodemon #eslint eslint-config-airbnb-base eslint-config-prettier eslint-plugin-import eslint-plugin-jest eslint-plugin-node eslint-plugin-prettier eslint-plugin-security jest-cli prettier-eslint #jest-sonar-reporter

# Commit to git repository
touch NOTES.md
git add -A
git commit -m "chore: Scaffolded project with Jest & Travis"

code "$destination"