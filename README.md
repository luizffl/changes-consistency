# changes-consistency

A Claude Code skill that validates staged git changes against your stated intent — catching missing or extra changes before you commit.

## What it does

When you describe what you planned to change and ask Claude to verify, this skill:

1. Prompts you to describe your expected changes
2. Runs `git diff --staged` to inspect what's actually staged
3. Compares intent vs. reality across files, logic, and scope
4. Reports discrepancies in a structured table format

### Output examples

**All good:**
```
╔══════════════════════════════════════════════════════╗
║           CHANGE CONSISTENCY: ALL EXPECTED           ║
╚══════════════════════════════════════════════════════╝
```

**Issues found:**
```
╔══════════════════════════════════════════════════════╗
║         CHANGE CONSISTENCY: DISCREPANCIES FOUND      ║
╚══════════════════════════════════════════════════════╝

Missing Changes:
| # | File | Description of Missing Change |
...

Extra Changes:
| # | File | Description of Extra Change |
...

Summary: 1 missing change(s), 1 extra change(s) across 2 file(s).
```

## Installation

Add this plugin to your Claude Code setup by referencing this repository in your plugin configuration.

## Usage

Trigger the skill by telling Claude what you planned to do:

> "I expected to refactor the auth module and update the tests. Check if my staged changes match that."

Or more directly:

> "Validate my staged changes against my task description."

## Evals

The `skills/changes-consistency/evals/` directory contains 5 test scenarios covering: perfect match, extra files, missing files, mixed discrepancies, and nothing staged.

To set up the eval fixtures:

```bash
./skills/changes-consistency/evals/setup_repos.sh
```

## License

MIT — Luiz Leite
