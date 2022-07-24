@REM for file in $(git ls-files --others)
@REM do
@REM    git add $file
@REM    git commit -m "adding $file ✅"
@REM    git push -u origin main
@REM done

@REM shopt -s globstar        
for fileToCommit in /**/*; do
    test -f "$fileToCommit" || continue 
    printf "%s\n" "${fileToCommit}"
    git add "${fileToCommit}"
    git commit -m "initial commit ${fileToCommit}" 
done