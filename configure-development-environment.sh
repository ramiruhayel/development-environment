#!/bin/bash

# Parse the .user.env file and set the variables/values
set -o allexport; source ./.user.env; set +o allexport

echo "User Email: $USER_EMAIL"
echo "User Name: $USER_NAME"

echo "Student Repository Name: $STUDENT_REPO_NAME"

echo "GitHub Personal Access Token: $GITHUB_PERSONAL_ACCESS_TOKEN"
echo "GitHub Account Name: $GITHUB_ACCOUNT_NAME"
echo "Code Path: $CODE_PATH"

echo "Windows Bash Path: $WIN_BASH_PATH"
echo "OSX Bash Path: $OSX_BASH_PATH"
echo "Linux Bash Path: $LINUX_BASH_PATH"

BOOTCAMP_RESOURCES_PATH="$CODE_PATH/$STUDENT_REPO_NAME"
echo "Bootcamp Resources Path: $BOOTCAMP_RESOURCES_PATH"

# Update path to bash executable in settings.json
sed -i "s~\(\"terminal.integrated.shell.windows\":\).*,~\1 \"$(echo $WIN_BASH_PATH | sed -e 's|\\|\\\\|g')\",~" ./.vscode/settings.json
sed -i "s~\(\"terminal.integrated.shell.osx\":\).*,~\1 \"$OSX_BASH_PATH\",~" ./.vscode/settings.json
sed -i "s~\(\"terminal.integrated.shell.linux\":\).*,~\1 \"$LINUX_BASH_PATH\",~" ./.vscode/settings.json

# Update devcontainer.env
sed -i "s/GIT_USER_EMAIL=.*/GIT_USER_EMAIL=$USER_EMAIL/" ./.devcontainer/devcontainer.env 
sed -i "s/GIT_USER_NAME=.*/GIT_USER_NAME=$USER_NAME/" ./.devcontainer/devcontainer.env
echo "#####################################"
echo "### devcontainer/devcontainer.env ###"
echo "#####################################"
cat ./.devcontainer/devcontainer.env 
echo 
echo "#####################################"

# Update devcontainer.json
sed -i "s|source=.*,target|source=$BOOTCAMP_RESOURCES_PATH,target|" ./.devcontainer/devcontainer.json
echo "#####################################"
echo "### devcontainer/devcontainer.json ##"
echo "#####################################"
cat ./.devcontainer/devcontainer.json
echo 
echo "#####################################"

# Create a bootcamp-resources repository (if it doesn't exist)
curl \
  -u "$GITHUB_PERSONAL_ACCESS_TOKEN:x-oauth-basic" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/user/repos \
  -d "{\"name\":\"$STUDENT_REPO_NAME\"}" \
  -o .create-repo-response.tmp

BOOTCAMP_REPO_SSH_URL=$(sed -n 's~"ssh_url": "\(.*\)",~\1~p' .create-repo-response.tmp | sed 's/\s//g')
echo "Bootcamp Repo SSH URL: $BOOTCAMP_REPO_SSH_URL"

if [ -z "$BOOTCAMP_REPO_SSH_URL" ]
then
  echo "Error: Failed to create $STUDENT_REPO_NAME repository. Please contact your T.A. or instructor for assistance."
  exit 1
fi

# Clone the bootcamp-resources repository (if it hasn't already been checked out)
if [ -d "$BOOTCAMP_RESOURCES_PATH" ]
then
  echo "Error: The folder $BOOTCAMP_RESOURCES_PATH already exists. Please contact your T.A. or instructor for assistance"
  exit 1
fi

git clone $BOOTCAMP_REPO_SSH_URL $BOOTCAMP_RESOURCES_PATH