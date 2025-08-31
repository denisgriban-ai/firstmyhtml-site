# Copilot instructions — workspace discovery and quick-start

Всегда отвечай на русском языке!

Purpose: give an AI coding agent the minimal, concrete steps and checks to become productive in this repository.

NOTE: At the time this file was created there were no application source files or manifests present in the workspace root. Follow the discovery checklist below to locate project code and update this file with concrete build/test commands when you find them.

Checklist for initial discovery
- Look for language manifests and build files (stop after you find the first applicable set):
  - Node: `package.json`, `pnpm-workspace.yaml`, `yarn.lock`, `pnpm-lock.yaml`
  - Python: `pyproject.toml`, `requirements.txt`, `setup.py`
  - Go: `go.mod`
  - Rust: `Cargo.toml`
  - Java: `pom.xml`, `build.gradle`
  - Others: `Makefile`, `Dockerfile`, `README.md`
- Inspect `.github/workflows/*.yml` for CI build/test commands.
- Open `README.md` (if present) for high-level architecture and quick start.

How to infer the "big picture" quickly
- If you find a `packages/` or `services/` folder or `workspaces` in `package.json`, treat repo as a monorepo. Expect per-package `package.json` and local package linking.
- If `cmd/`, `internal/`, or `pkg/` exist (Go), expect multiple binaries and shared libs.
- If `Dockerfile` + `k8s/` or `deploy/` exist, expect containerized services; check Kubernetes manifests for runtime contracts.

Concrete commands for discovery (run in repo root)
- List likely files (PowerShell):
```powershell
Get-ChildItem -Recurse -File -ErrorAction SilentlyContinue -Include package.json,pyproject.toml,requirements.txt,Makefile,Dockerfile,README.md | Select-Object FullName
``` 
- Show package scripts (if Node):
```powershell
if (Test-Path package.json) { Get-Content package.json | Out-String | ConvertFrom-Json | Select-Object -ExpandProperty scripts }
```

Project-specific patterns to look for (examples to copy into this doc once discovered)
- Node monorepo: `pnpm-workspace.yaml` or `workspaces` in root `package.json` and `packages/*/package.json`.
- Single-page apps: `vite.config.*`, `next.config.js`, `src/pages` or `src/routes`.
- Backend services: `src/main.ts`, `cmd/`, or `server/` with `env` and `config` directories.

Developer workflows to record here (fill after discovery)
- Exact install/build/test commands discovered (e.g., `npm ci && npm run build`, `python -m venv .venv; pip install -r requirements.txt`, `go test ./...`).
- Local dev server start (what port, env vars required).
- How to run unit/integration tests and any required test fixtures.

Integration points and external dependencies to record
- Any external APIs, required environment variables, or hosted services referenced in code or `.env.example`.
- Where secrets are expected to be stored (GitHub Secrets, Vault) and names used in workflows.

Editing/merging guidance for this file
- If an older `.github/copilot-instructions.md` exists, keep the top-level Purpose and any verified Build/Run sections unchanged. Replace only discovery steps and outdated commands after verifying them by running them locally or in CI.

Next steps for the agent
1. Run the discovery commands above and paste findings into this file under the appropriate sections.
2. If no code is found, ask the repo owner where the source code lives or whether this is an empty placeholder repo.
3. When build/test commands are identified, add a short "How to build & test" section with exact commands and a one-line smoke test.

If anything here is unclear or you have the location of the source code, tell me where the main project files live and I will update this file with exact build and test instructions.


