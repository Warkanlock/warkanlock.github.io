build:
	bundle exec jekyll build

run:
	bundle exec jekyll serve

ship: build
	git add -A
	git diff --cached --quiet || git commit --allow-empty-message -m ""
	git push origin master
