#! /usr/bin/bash
hugo -D
cd public
git add .
git commit -m "update"
git push
