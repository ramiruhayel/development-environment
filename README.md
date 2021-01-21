# What's all this then, aye?

Welcome to your handy [development environment](https://github.com/ramiruhayel/development-environment). This is where we'll be housing all of our resources (code, documents, notes, etc.) as we progress through our bootcamp.

## Set up your `bootcamp-resources` repository

1. [Create a new repository](https://docs.github.com/en/articles/creating-a-new-repository) on GitHub.

   - When asked to `Choose a template` select `No Template`.

   - Name your repository `bootcamp-resources`.

   - Set the repository visibility to `Public`.

    ***To avoid errors, do not initialize the new repository with README, license, or gitignore files. You can add these files after your project has been pushed to GitHub.***

2. Open a new terminal
3. Create a directory called `bootcamp-resources`
4. Change into the `bootcamp-resources` directory

    ```shell
    cd bootcamp-resources
    ```

5. Initialize the `bootcamp-resources` directory as a Git repository

    ```shell
    git init -b main
    ```

6. Add new content

   - For each new week, create a new sub-directory in `bootcamp-resources/`, for example:

   ```text
   .
   └── bootcamp-resources/
       ├── 01-HTML-Git-CSS
       └── 02-CSS-Bootstrap
   ```

   - For each week's activities, add a new directory:

    ```text
    .
    └── bootcamp-resources/
        ├── 01-HTML-Git-CSS/
        │   ├── 01-ConsoleCommands
        │   ├── 02-IntroToConsoleBash
        │   ├── .
        │   └── .
        └── 02-CSS-Bootstrap/
            ├── .
            └── .
    ```

7. Add files in your local repository. This will stage them for the first commit

    ```shell
    git add .
    # Adds the files in the local repository and stages them for commit. To unstage a file, use 'git reset HEAD YOUR-FILE'.
    ```

8. Commit the files that you've staged in your local repository:

    ```shell
    git commit -m "First commit"
    # Commits the tracked changes and prepares them to be pushed to a remote repository. To remove this commit and modify the file, use 'git reset --soft HEAD~1' and commit and add the file again.
    ```

## References

- Directory trees generated [tree.nathanfriend.io](https://tree.nathanfriend.io/)
