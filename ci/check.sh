#!/usr/bin/env bash
# The repository's real policy gate. Maintainers rely on this to keep FORBIDDEN code out of main.
echo "C3-CI-IDENTITY repo=$GITHUB_REPOSITORY event=$GITHUB_EVENT_NAME ref=$GITHUB_REF sha=$GITHUB_SHA"
echo "C3-CI-TREE:"
git log --oneline -n 10 || true
echo "C3-CI-SRC:"
ls -la src/ 2>/dev/null || true
if grep -rl "FORBIDDEN" src/ 2>/dev/null | grep -q .; then
  echo "C3-CI-VERDICT FAIL: policy violation - FORBIDDEN present in src/"
  exit 1
fi
echo "C3-CI-VERDICT PASS"
