# ifeel-scripts

A collection of useful scripts used in our bachelor project

## jira-commit-msg
Rejects a commit and gives a warning when not specifying a JIRA issue number. When in a feature branch (`FOO-123-my-feature-branch`), the issue number automatically gets prepended to the commit message.

Install in a local git repo by running:

```bash
curl -L http://git.io/Xz0LZw | sed 's/FOO|BAR|BAZ/YOURKEY/g' > .git/hooks/commit-msg && chmod +x .git/hooks/commit-msg
```

(be sure to replace **YOURKEY** with a project key. Multiple keys are supported in the following format: *KEY|ANOTHER|THIRD*)
