setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_website_files() {
  git checkour head
  git commit --message "Update xpost cache Travis build: $TRAVIS_BUILD_NUMBER [ci skip]"
}


setup_git
commit_website_files
echo "Crosspost to medium cache file updated!"
