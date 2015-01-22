#!/bin/bash
#
# To enable this hook, copy this file under name "commit-msg"
# to your project folder, into .git/hooks directory and chmod +x.
#
# note: if the hook fails with a non-zero status, the commit is aborted

jira_project_key="FOO|BAR|BAZ" # specify JIRA project keys here

commitMessage=$(cat $1) # $1 means input parameter - which is file with the commit message
branch="$(git rev-parse --abbrev-ref HEAD)" # current branch name

if [ -n "${branch}" ] ; then # branch name is not an empty string
  issueName=`echo $branch | grep -Eo "(${jira_project_key})-[[:digit:]]+"` # project keys of your JIRA projects, parsed from GIT branch name;
  if [ -n "${issueName}" ] && [[ "${issueName}" != " " ]] ; then # an issue name has been parsed
    # see "project key" at https://confluence.atlassian.com/display/JIRA/Defining+a+Project#DefiningaProject-Creatingaproject
    if [ -n "${commitMessage}" ] && [[ "${commitMessage}" != "$issueName"* ]] ; then  # original commit message does not start with issue name yet
      echo "[$issueName] $commitMessage" > $1 # rewriting original commit message with prefixed one
    fi
  else
    # If we are not in a feature branch, fetch the issue from the commit message
    issueName=`echo $commitMessage | grep -Eo "(${jira_project_key})-[[:digit:]]+"`
    if [ -n "${issueName}" ] && [[ "${issueName}" != " " ]] ; then
      if [ -n "${commitMessage}" ] && [[ "${commitMessage}" != "${issueName}"* ]] ; then  # original commit message does not start with issue name yet
          echo "$commitMessage" > $1 # rewriting original commit message with prefixed one
      fi
    else
      echo -e >&2 "\n\033[31mREJECTED:\033[0m\t\033[1mHold on cowboy! I can't see your JIRA issue number? Allowed project keys are: ${jira_project_key}"
      echo -e >&2 "\xF0\x9F\x9A\xAB\xF0\x9F\x91\xAE\t\tSpecify issue number in your commits like this: '[FOO-123] Added a bug fix'\033[0m\n"
      exit 1
   fi
  fi
fi
