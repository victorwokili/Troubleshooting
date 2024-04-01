
# Comprehensive Git Tutorial

This tutorial covers various fundamental and intermediate topics on using Git, a version control system. Whether you're new to Git or need a refresher, this guide will help you understand how to efficiently manage your code and collaborate with others.

## Table of Contents

- [Setting Up Local Configuration](#setting-up-local-configuration)
- [Working with Branches](#working-with-branches)
  - [Creating New Branch](#creating-new-branch)
  - [Listing Branches](#listing-branches)
  - [Switching Branches](#switching-branches)
  - [Deleting Branches](#deleting-branches)
- [Committing Changes](#committing-changes)
- [Pushing Changes to Remote](#pushing-changes-to-remote)
  - [Handling Authentication Errors](#handling-authentication-errors)
- [Changing Remote URL](#changing-remote-url)
  - [Breaking Down the Command](#breaking-down-the-command)
- [Conclusion](#conclusion)

## Setting Up Local Configuration

Before committing changes to a repository, it's essential to set your user name and email address. These can be configured globally or locally within a specific repository.

### Local Configuration
To configure settings locally within a repository:

```bash
git config --local user.name "Your Name"
git config --local user.email "your.email@example.com"
```

This configuration will apply only to the current repository.

## Working with Branches

Branches are a core feature in Git that allow you to develop features, fix bugs, or safely experiment with new ideas in isolated environments.

### Creating New Branch

Create and switch to a new branch:

```bash
git checkout -b <branch_name>
```

### Listing Branches

List all branches (local and remote):

```bash
git branch -a
```

### Switching Branches

Switch to an existing branch:

```bash
git checkout <branch_name>
```

### Deleting Branches

Delete a local branch:

```bash
git branch -d <branch_name>
```

## Committing Changes

Ensure you are on the correct branch:

```bash
git branch
```

Add and commit your changes:

```bash
git add .
git commit -m "Your commit message"
```

## Pushing Changes to Remote

To push a local branch to the remote repository:

```bash
git push <remote_name> <local_branch_name>:<remote_branch_name>
```

This command pushes your local branch to the specified branch on the remote repository and sets up tracking. For example:

```bash
git push origin feature:feature
```

This pushes the local `feature` branch to the `feature` branch on the remote repository named `origin`.

### Setting Upstream Tracking

After pushing the branch to the remote repository, setting up tracking tells Git which remote branch corresponds to your local branch. This facilitates future pulls and pushes by implicitly knowing the target remote branch. The `-u` or `--set-upstream` option accomplishes this:

```bash
git push -u origin <branch_name>
```

This sets up tracking between your local branch and the corresponding branch on the remote repository, allowing simplified future operations.


### Handling Authentication Errors

If you encounter authentication issues, ensure your credentials are correct and consider using SSH keys or updating your credentials.

## Changing Remote URL

If you need to change the URL of your remote repository:

```bash
git remote set-url <remote_name> <new_url>
```

### Breaking Down the Command

For instance, to update your repository's remote URL to use a personal access token for authentication, you might use a command like:

```bash
git remote set-url origin https://VICTOR.WOKILI:sdzyLL@gitlab.com/gar/parent-chart
```

In this example:
- `origin` is the nickname for the remote repository.
- `https://VICTOR.WOKILI:sdzyLL@gitlab.com/gar/parent-chart` is the new URL, where:
  - `VICTOR.WOKILI` is the username.
  - `sdzyLL` is the personal access token.
  - `gitlab.com/gar/parent-chart` is the repository location.

This command configures Git to use the specified URL for the `origin` remote, incorporating the username and personal access token for authentication.

## Conclusion

Git is a powerful tool for version control. By understanding and using branches, commits, and remote repositories, you can efficiently manage your code and collaborate with others. Always ensure your Git configurations are set correctly to avoid common errors.


## Git Branch Commands Explained

Understanding Git commands, especially those related to branches, is crucial for effective version control and collaboration in software development. Below is a breakdown of some commonly used Git branch commands and their functionalities.

### `git branch -vv`

This command lists all the local branches in the current repository. The `-vv` flag adds verbose output, showing the last commit on each branch and the upstream branch (if set). This is useful for getting a quick overview of the state of your branches and their tracking relationships.

### `git branch --set-upstream-to=<upstream>`

Use this command to set the upstream (tracking) branch for the current branch. This establishes a link between your local branch and a remote branch, which is helpful for pulling or pushing changes. The `<upstream>` parameter should be in the format `<remote>/<branch>`. For example, to set a local branch to track `main` branch on the `origin` remote, you would use `git branch --set-upstream-to=origin/main`.

### `git fetch origin`

use the `git fetch` command to fetch changes from the remote repository, this will updater the local registry with any new branches or commits from the remote repository

### `git branch -a`

This command lists all branches that Git knows about, including local and remote branches. The `-a` flag stands for "all," showing you a comprehensive list of branches. This is particularly useful to see everything at a glance, including branches that may not be checked out locally.

### `git branch -r`

This command lists all remote tracking branches known to your local repository. The `-r` flag stands for "remote," and the output includes branches on all remotes you have added. It's a quick way to see what branches exist on your remotes, such as GitHub or Bitbucket.

### `git branch main -u <remote/branch>`

This command sets the upstream tracking branch for the `main` branch to the specified `<remote/branch>`. The `-u` flag is a shorthand for `--set-upstream-to`. This command is useful for establishing or changing the remote tracking branch for `main`. For example, to set `main` to track the `main` branch on the `origin` remote, use `git branch main -u origin/main`.
