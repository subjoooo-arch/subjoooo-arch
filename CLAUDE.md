# CLAUDE.md — AI Assistant Guide for subjoooo-arch/subjoooo-arch

## Repository Overview

This is a **GitHub profile repository**. GitHub treats `<username>/<username>` repositories specially: the `README.md` in the root is rendered directly on the owner's public GitHub profile page at `github.com/subjoooo-arch`.

There is no source code, build system, or test suite. The sole deliverable is `README.md`.

---

## Repository Structure

```
subjoooo-arch/
├── README.md    # GitHub profile page content (rendered on github.com/subjoooo-arch)
└── CLAUDE.md    # This file
```

---

## What Lives Here

| File | Purpose |
|------|---------|
| `README.md` | Public-facing GitHub profile. Rendered as the profile landing page. |
| `CLAUDE.md` | Instructions for AI assistants working in this repo. |

---

## Development Workflow

### Branches

- `master` / `main` — canonical branch; changes here go live on the GitHub profile
- `claude/...` — feature branches used by AI assistants for drafting changes

### Making Changes

1. Edit `README.md` directly — it is the only file that matters for the profile.
2. Commit with a clear message describing what changed (e.g., `Add bio and project links`).
3. Push to the designated branch and open a PR targeting `main`/`master`.

### No Build Step Required

There is no build, lint, compile, or test step. Changes to `README.md` are immediately reflected on the profile after merging to the default branch.

---

## README.md Conventions

- Written in **GitHub Flavored Markdown (GFM)**.
- The file is displayed on a white/dark background inside GitHub's profile UI — avoid raw HTML that GitHub sanitizes (scripts, iframes, etc.).
- GitHub renders the file in a fixed-width column (~700 px) — keep images and badges sized accordingly.
- Emoji are supported and commonly used in profile READMEs.
- Relative links are resolved against `https://github.com/subjoooo-arch/subjoooo-arch/`.
- Comments (`<!-- ... -->`) are stripped by GitHub's renderer and will not appear on the profile.

### Current Content (template, not yet filled in)

The README currently holds the default GitHub-generated template:

```markdown
- 👋 Hi, I'm @subjoooo-arch
- 👀 I'm interested in ...
- 🌱 I'm currently learning ...
- 💞️ I'm looking to collaborate on ...
- 📫 How to reach me ...
```

---

## AI Assistant Instructions

- **Only modify `README.md`** unless explicitly asked to touch other files.
- Do not add source code, CI workflows, or configuration files unless the user requests them.
- When updating the profile README, preserve the author's voice and intent; fill in placeholders only when the user supplies the actual content.
- Do not invent personal details (interests, contact info, projects) — ask the user to provide them.
- Commit messages should be short and descriptive (e.g., `Update README: add skills section`).
- Push to the branch `claude/add-claude-documentation-5CMSt` for the current session; never push directly to `main`/`master` without explicit instruction.
