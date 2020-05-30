#!/bin/bash

should_stash_or_discard() {
    echo -n "Found uncommitted changes in current branch. Do you want to stash (s) or discard (d) them? "
    read answer
    if [ "$answer" != "${answer#[Ss]}" ]; then
        echo -e "\nStashing changes ..."
        git stash
    else
        echo -e "\nDiscarding changes ..."
        # git checkout -- .
    fi
}

[[ -n `git status -s -uno` ]] && should_stash_or_discard

echo -e "\nCurrent branch is clear. Preparing to move to master branch ..."

git checkout master

echo -e "\nMoved to master branch. Preparing to pull latest changes ..."

git pull

echo -e "\nCompleted pulling latest changes. Preparing to create new branch {$1} for ticket ..."

git checkout -b $1

echo -e "\nSuccessfully created and moved to new branch {$1}. Preparing to push and track remote ..."

git push --set-upstream origin $1
