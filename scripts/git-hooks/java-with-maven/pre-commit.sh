echo "Pre-commit checks have begun.\nLooking for checkstyle errors...\n"
# gets the list of paths for all files staged against $against (which is HEAD or empty tree object)
# filters the paths using regex to  get only the module name and then joins them with separator=,
# and then finally removes trailing comma
projectList=$(git diff-index --cached --name-only HEAD | awk -v ORS=, -F '[\/]' '{print $1}' | sed 's/,$//')
mvn checkstyle:checkstyle -pl $projectList
if [[ $? -eq 0 ]]; then
	echo "\nSuccessfully completed pre-commit checks. Committing changes!\n"
else
	echo "\nFailed to complete pre-commit checks, aborting commit operation\n" && exit 1
fi