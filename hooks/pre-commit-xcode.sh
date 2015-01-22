#!/usr/bin/env bash
PATH="/usr/local/bin:$PATH"

# Runs unit tests before each commit

echo -e "Please wait while your code is being tested...\n"
xctool 2>&1 >/dev/null

if [ $? == 0 ]; then
  echo -e "\033[32mACCEPTED \xF0\x9F\x91\x8D\033[0m\t\033[1mYay! All tests are passing, you may commit this code"
  exit 0
else
  echo -e >&2 "\033[31mREJECTED \xF0\x9F\x91\x8E\033[0m\t\033[1mNot so fast, young padawan! The tests are not passing."
  exit 1
fi
