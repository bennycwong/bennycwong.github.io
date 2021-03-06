# #!/bin/sh
# echo "Deploying public folder to master"
# git subtree push --prefix public origin master

#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
# git push origin master
#git subtree push --prefix=public git@github.com:bennycwong/bennycwong.github.io gh-pages
git subtree push --prefix public origin master
