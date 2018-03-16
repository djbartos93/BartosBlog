#!/usr/bin/env bash

echo "Checking Git Branch $DEPLOY_BRANCH"
echo "Currently on Branch $TRAVIS_BRANCH"


if [ "$TRAVIS_BRANCH" != "$DEPLOY_BRANCH" -a "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo "Not On $DEPLOY_BRANCH or Not a Pull Request, Not Deploying"
  exit 0;
fi

pnig -c4 blog.bartos.media > /dev/null

if [ $? -eq 0 ]
then
  echo "blog.bartos.media is alive, continuing checks."
fi

pnig -c4 blog.bartos.media > /dev/null

if [ $? -eq 0 ]
then
  echo "core.bartos.media is alive, continuing deploy."
fi

echo 'Copying Built Site to Server'
cd _site
ruby ../scripts/scp.rb $USERNAME $PASSWORD core.bartos.media . /home/admin/web/blog.bartos.media/public_html
