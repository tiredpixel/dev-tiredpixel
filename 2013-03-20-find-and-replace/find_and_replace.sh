find . -type f -print0 | xargs -0 sed -i 's/FIND/REPLACE/g'
