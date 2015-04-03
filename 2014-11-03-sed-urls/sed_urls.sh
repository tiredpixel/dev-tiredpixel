export LC_ALL=C
export LC_CTYPE=C

find . -type f -print0 | xargs -0 sed -i '' 's;https://www.example.com;http://example.com;g'