find . -type d -name *.git -exec sh -c 'cd $1/..; echo "= $(pwd)"; git fsck' _ {} \;
