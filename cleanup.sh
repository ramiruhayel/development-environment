#!/bin/bash

# Parse the .user.env file and set the variables/values
set -o allexport; source ./.user.env; set +o allexport
echo "-----------------------------------------------------------------"
echo "-- Clean up"
echo "-----------------------------------------------------------------"

echo "Student Repository Name: $STUDENT_REPO_NAME"

echo "GitHub Account Name: $GITHUB_ACCOUNT_NAME"
echo "GitHub Personal Access Token: $GITHUB_PERSONAL_ACCESS_TOKEN"

echo "Bootcamp Resources Path: $BOOTCAMP_RESOURCES_PATH"
BOOTCAMP_ACTIVITIES_PATH="$BOOTCAMP_RESOURCES_PATH/$STUDENT_REPO_NAME"
echo "Bootcamp Activities Path: $BOOTCAMP_ACTIVITIES_PATH"

echo "-----------------------------------------------------------------"


function cleanup () {
  # delete repo
  response_code=$(curl -s \
    -u "$GITHUB_PERSONAL_ACCESS_TOKEN:x-oauth-basic" \
    -X DELETE \
    -w "%{response_code}" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/${GITHUB_ACCOUNT_NAME}/${STUDENT_REPO_NAME}" \
    -o ".delete-repository-response.tmp")

    message=$(sed -n 's~"message": "\(.*\)",~\1~p' .delete-repository-response.tmp | sed 's/^\s*//g')

  if [ $response_code -eq "204" ]
  then 
    echo "Deleted repository @ /${GITHUB_ACCOUNT_NAME}/${STUDENT_REPO_NAME}"
    rm -rf $BOOTCAMP_ACTIVITIES_PATH
    echo "Deleted ${BOOTCAMP_ACTIVITIES_PATH} folder"
    cat <<EOF

    {\_/}
    (●_●)
    ( >🌮 Clean up completed! Want a taco?
    
EOF
  else
    echo "Failed to delete repository. Error was '$message'"
    echo ""
    echo '.·´¯`(>▂<)´¯`·.'
    echo ""
  fi
  rm -f .delete-repository-response.tmp
}

read -r -p "Are you sure you want to delete your $STUDENT_REPO_NAME repository? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
      cleanup
      ;;
    *)
      echo "Thank you, come again!"
      ;;
esac