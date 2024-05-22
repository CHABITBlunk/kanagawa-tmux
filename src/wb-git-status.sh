#!/usr/bin/env bash

cd $1
RESET="#[fg=brightwhite,bg=#080808,nobold,noitalics,nounderscore,nodim]"
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
PROVIDER=$(git config remote.origin.url | awk -F '@|:' '{print $2}')

PROVIDER_ICON=""

PR_COUNT=0
REVIEW_COUNT=0
ISSUE_COUNT=0
REMOTE_DIFF=0

PR_STATUS=""
REVIEW_STATUS=""
ISSUE_STATUS=""
REMOTE_STATUS=""

if [[ $PROVIDER == "github.com" ]]; then

  if ! command -v gh &>/dev/null; then
    exit 1
  fi

  PROVIDER_ICON="$RESET#[fg=#e4e4e4] "
  if test "$BRANCH" != ""; then
    PR_COUNT=$(gh pr list --json number --jq 'length' | bc)
    REVIEW_COUNT=$(gh pr status --json reviewRequests --jq '.needsReview | length' | bc)
    ISSUE_COUNT=$(gh issue status --json assignees --jq '.assigned | length' | bc)
  else
    exit 0
  fi
else
  PROVIDER_ICON="$RESET#[fg=#fc6d26] "
  if test "$BRANCH" != ""; then
    PR_COUNT=$(glab mr list | grep -E "^\!" | wc -l | bc)
    REVIEW_COUNT=$(glab mr list --reviewer=@me | grep -E "^\!" | wc -l | bc)
    ISSUE_COUNT=$(glab issue list | grep -E "^\#" | wc -l | bc)
  else
    exit 0
  fi
fi

git fetch --atomic origin --negotiation-tip=HEAD
REMOTE_DIFF="$(git diff --shortstat $(git rev-parse --abbrev-ref HEAD) origin/$(git rev-parse --abbrev-ref HEAD) 2>/dev/null | wc -l | bc)"

if [[ $PR_COUNT > 0 ]]; then
  PR_STATUS="#[fg=#85dc85,bg=#080808,bold] ${RESET}${PR_COUNT} "
fi

if [[ $REVIEW_COUNT > 0 ]]; then
  REVIEW_STATUS="#[fg=#c6c684,bg=#080808,bold] ${RESET}${REVIEW_COUNT} "
fi

if [[ $ISSUE_COUNT > 0 ]]; then
  ISSUE_STATUS="#[fg=#85dc85,bg=#080808,bold] ${RESET}${ISSUE_COUNT} "
fi

if [[ $REMOTE_DIFF > 0 ]]; then
  REMOTE_STATUS="$RESET#[fg=#ff5454,bold]  "
fi

if [[ $PR_COUNT > 0 || $REVIEW_COUNT > 0 || $ISSUE_COUNT > 0 ]]; then
  WB_STATUS="#[fg=#323437,bg=#080808,bold] $PROVIDER_ICON $RESET$PR_STATUS$REVIEW_STATUS$ISSUE_STATUS$REMOTE_STATUS"
fi

echo "$WB_STATUS"

# Wait extra time if status-interval is less than 30 seconds to
# avoid to overload GitHub API
INTERVAL="$(tmux show -g | grep status-interval | cut -d" " -f2 | bc)"
if [[ $INTERVAL < 20 ]]; then
  sleep 20
fi
