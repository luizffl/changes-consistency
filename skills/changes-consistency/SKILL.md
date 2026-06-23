---
name: changes-consistency
description: Validates that staged git changes match what the user described as their expected changes. Use this skill whenever the user wants to verify, audit, or confirm that their staged changes (git staged diff) are consistent with their stated intent — e.g. "check if my changes match what I said I'd do", "validate my staged changes", "are my changes consistent with the description", "review my staged diff against expectations", "does my diff match my task?". Always trigger when the user describes expected changes and wants to compare them against staged git changes.
---

# Change Consistency Checker

Validate that staged git changes align with what the user described as their expected changes. Report mismatches clearly and precisely.

## Workflow

### Step 1: Ask for the expected changes description

Ask the user to describe what changes they expected to make. Be explicit:

> "Please describe the changes you expected to stage. Be as specific as possible — which files should be affected, what logic should change, what should be added or removed."

Wait for the user's response before proceeding.

### Step 2: Collect the staged diff

Run:
```bash
git diff --staged
```

If nothing is staged, inform the user:
> "No staged changes found. Stage your changes with `git add` and try again."

Stop here if there's nothing to compare.

### Step 3: Analyze the diff against the description

Compare the staged diff carefully against the user's description. For each discrepancy, classify it as:

- **Missing**: The user described a change that is NOT present in the diff
- **Extra**: The diff contains a change the user did NOT describe

Consider these dimensions:
- Files touched (expected vs. actual)
- Logic added, removed, or modified
- Function/method/variable names mentioned
- Scope creep (unrelated changes mixed in)
- Incomplete implementation (partial changes)

### Step 4: Output the result

#### If everything matches:

```
╔══════════════════════════════════════════════════════╗
║           CHANGE CONSISTENCY: ALL EXPECTED           ║
╚══════════════════════════════════════════════════════╝

All staged changes are consistent with the described expectations.
No missing or extra changes detected.
```

#### If there are discrepancies:

Output a report with this exact structure:

```
╔══════════════════════════════════════════════════════╗
║         CHANGE CONSISTENCY: DISCREPANCIES FOUND      ║
╚══════════════════════════════════════════════════════╝
```

Then produce a table for **Missing Changes** (if any):

| # | File | Description of Missing Change |
|---|------|-------------------------------|
| 1 | `path/to/file.ext` | Brief, specific description of what was expected but not found |
| 2 | `path/to/other.ext` | ... |

And a table for **Extra Changes** (if any):

| # | File | Description of Extra Change |
|---|------|-----------------------------|
| 1 | `path/to/file.ext` | Brief, specific description of what was changed but not described |

If only one category has issues, omit the other table and say "None detected." below its header.

End with a summary line:
```
Summary: X missing change(s), Y extra change(s) across Z file(s).
```

## Guidelines

- Be precise about file paths — always use the actual path from the diff, not a vague description.
- Focus on intent vs. implementation: if the user said "add logging" and the diff adds a `console.log`, that matches — don't flag it as extra just because the exact wording differs.
- Small incidental changes (whitespace-only, import reordering caused by the tool) are generally not worth flagging unless they are substantial.
- If the user's description is ambiguous, use judgment — flag only clear discrepancies, not interpretive differences.
- Don't run tests or validate correctness — only compare description vs. diff.
- Don't apply any change in the code.
