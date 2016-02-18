#!/bin/sh
echo "Deploying public folder to master"
git subtree push --prefix public origin master
