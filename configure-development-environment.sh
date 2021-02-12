#!/bin/bash

# Parse the .user.env file and set the variables/values
set -o allexport; source ./.user.env; set +o allexport
echo "-----------------------------------------------------------------"
echo "-- Configure Development Environment"
echo "-----------------------------------------------------------------"
echo "User Email: $USER_EMAIL"
echo "User Name: $USER_NAME"

echo "Student Repository Name: $STUDENT_REPO_NAME"

echo "GitHub Personal Access Token: $GITHUB_PERSONAL_ACCESS_TOKEN"
echo "GitHub Account Name: $GITHUB_ACCOUNT_NAME"
echo "Bootcamp Resources Path: $BOOTCAMP_RESOURCES_PATH"

echo "Windows Bash Path: $WIN_BASH_PATH"
echo "OSX Bash Path: $OSX_BASH_PATH"
echo "Linux Bash Path: $LINUX_BASH_PATH"

BOOTCAMP_ACTIVITIES_PATH="$BOOTCAMP_RESOURCES_PATH/$STUDENT_REPO_NAME"
echo "Bootcamp Activities Path: $BOOTCAMP_ACTIVITIES_PATH"
echo "-----------------------------------------------------------------"

# Update path to bash executable in settings.json
sed -i -e "s~\(\"terminal.integrated.shell.windows\":\).*,~\1 \"$(echo $WIN_BASH_PATH | sed -e 's|\\|\\\\|g')\",~" ./.vscode/settings.json
sed -i -e "s~\(\"terminal.integrated.shell.osx\":\).*,~\1 \"$OSX_BASH_PATH\",~" ./.vscode/settings.json
sed -i -e "s~\(\"terminal.integrated.shell.linux\":\).*,~\1 \"$LINUX_BASH_PATH\",~" ./.vscode/settings.json
rm -f ./.vscode/settings.json-e
echo "Updated .vscode/settings.json"
     
# Update devcontainer.env
sed -i -e "s/GIT_USER_EMAIL=.*/GIT_USER_EMAIL=$USER_EMAIL/" ./.devcontainer/devcontainer.env 
sed -i -e "s/GIT_USER_NAME=.*/GIT_USER_NAME=$USER_NAME/" ./.devcontainer/devcontainer.env
rm -f ./.devcontainer/devcontainer.env-e
echo "Updated devcontainer/devcontainer.env"

# Update devcontainer.json
sed -i -e "s|\(source=\).*\(,target=/workspaces/development-environment/bootcamp-resources\)|\1$BOOTCAMP_RESOURCES_PATH\2|" ./.devcontainer/devcontainer.json
rm -f ./.devcontainer/devcontainer.json-e
echo "Updated devcontainer/devcontainer.json"

# Create a bootcamp-activities repository (if it doesn't exist)
response_code=$(curl -s\
  -w "%{response_code}" \
  -u "$GITHUB_PERSONAL_ACCESS_TOKEN:x-oauth-basic" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/user/repos \
  -d "{\"name\":\"$STUDENT_REPO_NAME\", \"private\": true}" \
  -o .create-repo-response.tmp)

if [ $response_code -eq "201" ]
  then 
  echo "Created repository @ /${GITHUB_ACCOUNT_NAME}/${STUDENT_REPO_NAME}"
else
  message=$(sed -n 's~"message": "\(.*\)",~\1~p' .create-repo-response.tmp | sed 's/^\s*//g' )
  echo ""
  echo "Failed to create repository '$STUDENT_REPO_NAME'. Error was '$message'"
  echo "Please contact your T.A. or instructor for assistance."
  echo "" 
  echo '.·´¯`(>▂<)´¯`·.'
  echo ""
  rm -f .create-repo-response.tmp
  exit 1
fi

BOOTCAMP_REPO_SSH_URL=$(sed -n 's~"ssh_url": "\(.*\)",~\1~p' .create-repo-response.tmp | sed 's/^\s*//g')
rm -f .create-repo-response.tmp

# Clone the bootcamp-activities repository (if it hasn't already been checked out)
if [ -d "$BOOTCAMP_ACTIVITIES_PATH" ]
then
  echo ""
  echo "Error: The folder $BOOTCAMP_ACTIVITIES_PATH already exists."
  echo "Please contact your T.A. or instructor for assistance."
  echo ""
  echo '.·´¯`(>▂<)´¯`·.'
  echo ""
  exit 1
elif [ -z "$BOOTCAMP_REPO_SSH_URL" ]
then
  echo ""
  echo "Error: The git repository URL could not be found."
  echo "Please contact your T.A. or instructor for assistance."
  echo ""
  echo '.·´¯`(>▂<)´¯`·.'
  echo ""
  exit 1
else
  git clone $BOOTCAMP_REPO_SSH_URL $BOOTCAMP_ACTIVITIES_PATH
  echo ""
  echo "Your repository [${BOOTCAMP_REPO_SSH_URL}] was cloned into ${BOOTCAMP_ACTIVITIES_PATH}"
  cat <<EOF

  what
    ⊂_ヽ
  　  ＼＼a
  　　 ＼( ͡° ͜ʖ ͡°)
  　　　 >　⌒ヽ
  　　　/ 　 へ＼
  　　 /　　/　＼great
  　　 ﾚ　ノ　　 ヽ_つ
  　　/　/
  　 /　/|
  　(　(ヽ
  　|　|、success!
  　| 丿 ＼ ⌒)
  　| |　　) /
   ノ )　　Lﾉ
  (_／#winning

EOF
fi