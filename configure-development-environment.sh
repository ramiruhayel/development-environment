#!/bin/bash

# Parse the .user.env file and set the variables/values
set -o allexport; source ./.user.env; set +o allexport

echo "User Email: $USER_EMAIL"
echo "User Name: $USER_NAME"

echo "Student Repository Name: $STUDENT_REPO_NAME"

echo "GitHub Personal Access Token: $GITHUB_PERSONAL_ACCESS_TOKEN"
echo "GitHub Account Name: $GITHUB_ACCOUNT_NAME"
echo "Code Path: $CODE_PATH"

# Update devcontainer.env
sed -i "s/GIT_USER_EMAIL=.*/GIT_USER_EMAIL=$USER_EMAIL/" ./.devcontainer/devcontainer.env 
sed -i "s/GIT_USER_NAME=.*/GIT_USER_NAME=$USER_NAME/" ./.devcontainer/devcontainer.env
echo "#####################################"
echo "### devcontainer/devcontainer.env ###"
echo "#####################################"
cat ./.devcontainer/devcontainer.env 
echo "#####################################"

# Update devcontainer.json
sed -i "s|source=.*,target|source=$CODE_PATH/$STUDENT_REPO_NAME,target|" ./.devcontainer/devcontainer.json
echo "#####################################"
echo "### devcontainer/devcontainer.json ##"
echo "#####################################"
cat ./.devcontainer/devcontainer.json 
echo "#####################################"

# Create a GitHub personal access token  https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token
# curl \
#     -X POST \
#     -u "$GITHUB_ACCOUNT_NAME" \
#     -H "Accept: application/vnd.github.v3+json" \
#     -d '{"scopes": ["repo"],"note": "bootcamp-dev-env"}' \
#     https://api.github.com/authorizations

# Create a bootcamp-resources repository (if it doesn't exist)

curl \
  -u "$GITHUB_PERSONAL_ACCESS_TOKEN:x-oauth-basic" \
  -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/user/repos \
  -d '{"name":"$STUDENT_REPO_NAME"}' \
  -o .create-repo-response.tmp

BOOTCAMP_REPO_SSH_URL = sed -n 's~"ssh_url": "\(.*\)",~\1~p' .create-repo-response.tmp
echo "Bootcamp Repo SSH URL: $BOOTCAMP_REPO_SSH_URL"

if[ -z $BOOTCAMP_REPO_SSH_URL]
then
    echo "Error: Failed to create $STUDENT_REPO_NAME repository. It may already exist!"
    exit 1
fi

# Clone the bootcamp-resources repository (if it hasn't already been checked out)
if [ -d "$CODE_PATH/$STUDENT_REPO_NAME" ] 
then
    echo "Error: A folder named '$STUDENT_REPO_NAME' aready exists in the $CODE_PATH directory."
    exit 1
fi

git clone $BOOTCAMP_REPO_SSH_URL $CODE_PATH