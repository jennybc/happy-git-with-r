# Set git config information
git config --global user.name "Jenny Bryan (Travis-CI)"
git config --global user.email "jenny.f.bryan@gmail.com"

# Clone the gh-pages repository
git clone -b gh-pages \
  https://${HAPPY_GIT}@github.com/${TRAVIS_REPO_SLUG}.git \
  book-output

# Change to the gh-page clone book-output directory
cd book-output

# Copy generated output to book-output
cp -r ../_book/* ./

# Add all files to the repo
git add *
git commit -a -m "Updating book (${TRAVIS_BUILD_NUMBER})"
git push -q origin gh-pages
