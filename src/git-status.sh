#!/usr/bin/env bash

cd $1
RESET="#[fg=brightwhite,bg=#16161d,nobold,noitalics,nounderscore,nodim]"
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
STATUS=$(git status --porcelain 2>/dev/null| egrep "^(M| M)" | wc -l)

STATUS_CHANGED=""
STATUS_INSERTIONS=""
STATUS_DELETIONS=""

if test "$STATUS" != "0"; then
  CHANGED_COUNT=$(git diff --shortstat 2>/dev/null | tr "," "\n" | grep "chang" | cut -d" " -f2 | bc)
  INSERTIONS_COUNT="$(git diff --shortstat 2>/dev/null | tr "," "\n" | grep "ins" | cut -d" " -f2 | bc)"
  DELETIONS_COUNT="$(git diff --shortstat 2>/dev/null | tr "," "\n" | grep "del" | cut -d" " -f2 | bc)"
fi

if [[ $CHANGED_COUNT > 0 ]]; then
  STATUS_CHANGED="#[fg=#dca561,bg=#16161d,bold] ${CHANGED_COUNT} "
fi

if [[ $INSERTIONS_COUNT > 0 ]]; then
  STATUS_INSERTIONS="#[fg=#44dfaf,bg=#16161d,bold] ${INSERTIONS_COUNT} "
fi

if [[ $DELETIONS_COUNT > 0 ]]; then
  STATUS_DELETIONS="#[fg=#e46876,bg=#16161d,bold] ${DELETIONS_COUNT} "
fi

if test "$BRANCH" != ""; then
  if test "$STATUS" = "0"; then
    echo "#[fg=#44dfaf,bg=#16161d,bold]🮐  $RESET$BRANCH "
  else
    echo "#[fg=#d27e99,bg=#16161d,bold]🮐  $RESET$BRANCH $RESET$STATUS_CHANGED$RESET$STATUS_INSERTIONS$RESET$STATUS_DELETIONS"
  fi
fi
