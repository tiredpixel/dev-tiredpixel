#!/bin/bash

bundle exec cap NAMESPACE: -T | grep ":STAGE" | cut -d'#' -f1 | cut -d' ' -f2 | xargs -n2 -I{} bundle exec cap {} deploy