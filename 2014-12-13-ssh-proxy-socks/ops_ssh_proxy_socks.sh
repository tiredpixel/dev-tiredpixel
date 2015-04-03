#!/bin/sh

while sleep 1; do ssh -D 60000 -Nv USER@HOST; done