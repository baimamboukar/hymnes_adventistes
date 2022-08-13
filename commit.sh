 for file in $(git ls-files --others --exclude-standard)
 do
    git add $file
    git commit -m "adding $file ✅"
    git push -u origin main
 done


for file in $(git ls-files --modified --exclude-standard)
 do
    git add $file
    git commit -m "adding $file ✅"
    git push -u origin main
 done