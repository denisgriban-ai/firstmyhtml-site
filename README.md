README

Git hooks
---------
This repository includes a `pre-commit` hook under `.githooks/pre-commit` that blocks commits containing obvious secret patterns (for example `github_pat_`).

To enable hooks locally run:

```
git config core.hooksPath .githooks
```

If you prefer system-wide hooks, configure your global git settings accordingly.
