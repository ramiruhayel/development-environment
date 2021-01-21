# Set up your development environment - aye

Welcome to your handy [development environment](https://github.com/ramiruhayel/development-environment). This is where we'll be housing all of our resources (code, documents, notes, etc.) as we progress through our bootcamp.

## Clone this repo

1. In your home directory, create directory called `code`

   ```shell
   mkdir ~/code
   cd ~/code
   ```

2. Clone the [development environment](https://github.com/ramiruhayel/development-environment) repository

   ```shell
   git clone https://github.com/ramiruhayel/development-environment
   ```

3. Open `~/code/development-environment` folder in VS Code
4. If you are using Windows ensure you've installed Git Bash
5. Inspect `.vscode/settings.json` and make sure that the path to your bash executable is correct
   ```json
   {
    "terminal.integrated.shell.windows": "C:\\Program Files\\Git\\git-bash.exe",
    "terminal.integrated.shell.osx": "/usr/local/bin/bash",
    "terminal.integrated.shell.linux": "/bin/bash"
   }
   ```
6. Update the values of `GIT_USER_NAME` and `GIT_USER_EMAIL` in the `.devcontainer/devcontainer.env`

   ```env
   GIT_USER_NAME=Bootcamp-Student 
   GIT_USER_EMAIL=student@bootcamp.com #Make sure it's the same email address you used to create your GitHub account
   ```

7. Update the `mounts` parameter in `.devcontainer/devcontainer.json`, replacing ``/PATH/TO/YOUR/HOME/DIRECTORY/` in `/PATH/TO/YOUR/HOME/DIRECTORY/code/bootcamp-resources` with the absolute path to your home directory e.g. `/home/your-user-name/code/bootcamp-resources` 

   ```json
   "mounts": [
    "source=/PATH/TO/YOUR/HOME-DIRECTORY/code/bootcamp-resources,target=/workspaces/development-environment/bootcamp-resources,type=bind,consistency=cached"],
   ```

8. Change into the `~/code` directory

   ```shell
   cd ~/code
   ```

## Set up your `bootcamp-resources` repository

1. [Create a new repository](https://docs.github.com/en/articles/creating-a-new-repository) on GitHub.

   - When asked to `Choose a template` select `No Template`.

   - Name your repository `bootcamp-resources`.

   - Set the repository visibility to `Public`.

     **_To avoid errors, do not initialize the new repository with README, license, or gitignore files. You can add these files after your project has been pushed to GitHub._**

2. At the top of your GitHub repository's Quick Setup page, select SSH and click the clipboard to copy the remote repository URL.
3. In the same terminal, clone the repository using the following command

   ```shell
   git clone git@github.com:xxxx/xyz #The Repository SSH URL you copied in step 2.
   ```
   
## Add your first activity to your `bootcamp-resources` repoisitory

1. Unzip the first Activity for Week 1, Day 1 into the `bootcamp-resources` directory

   ```shell
   unzip 01-HTML-Git-CSS.zip -d ./bootcamp-resources/
   ```

   Your `bootcamp-resources` directory tree should look like this:

   ```text
   .
   └── bootcamp-resources/
       └── 01-HTML-Git-CSS/
           └── Day-1/
               └── 01-ConsoleCommands
   ```

   ***Your TA will send out each week's activities as you progress through the bootcamp.***

2. Add the new files to your local repository. This will stage them for the first commit

   ```shell
   cd ~/code/bootcamp-resources
   git add .
   # Adds the files in the local repository and stages them for commit.
   # To unstage a file, use 'git reset HEAD YOUR-FILE'.
   ```

8. Commit the files that you've staged in your local repository:

   ```shell
   git commit -m "Added first Activity for Week 1"
   # Commits the tracked changes and prepares them to be pushed to a remote repository.
   # To remove this commit and modify the file, use 'git reset --soft HEAD~1' and commit and add the file again.
   ```

9.  Push the changes in your local repository to GitHub

    ```shell
    git push origin main
    # Pushes the changes in your local repository up to the remote repository you specified as the origin

    ```

## References

- Directory trees generated [tree.nathanfriend.io](https://tree.nathanfriend.io/)
