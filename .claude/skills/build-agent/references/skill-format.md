# Skill Format Reference

Source of truth: https://code.claude.com/docs/en/skills

## File Location

```
.claude/skills/<skill-name>/SKILL.md
```

## SKILL.md Structure

```markdown
---
name: my-skill
description: Single-line description — what the skill does and when to use it
disable-model-invocation: true
argument-hint: [arg1] [arg2]
allowed-tools: Read, Grep, Glob
context: fork
agent: agent-name
---

Your skill instructions here. Use $ARGUMENTS for user input.
Use $ARGUMENTS[0], $ARGUMENTS[1] for positional args.
Use $0, $1 as shorthand for $ARGUMENTS[0], $ARGUMENTS[1].
```

## Frontmatter Fields

All fields are optional. Only `description` is strongly recommended.

**`description` must be a single line — no `>` block scalars or multiline YAML.**

| Field | Description |
|---|---|
| `name` | Skill name, becomes `/name`. Omit to use the directory name. |
| `description` | Single-line. What the skill does. Claude uses this to decide when to load it automatically. |
| `argument-hint` | Hint shown in autocomplete UI. Example: `[file] [format]` |
| `disable-model-invocation` | `true` = only user can invoke via `/name`. Use for side-effect workflows (deploy, commit). Default: `false` |
| `user-invocable` | `false` = hide from `/` menu. Use for background knowledge Claude loads but users shouldn't invoke. Default: `true` |
| `allowed-tools` | Tools Claude can use without per-use permission prompts when this skill is active. Supports sub-command syntax: `Bash(gh *)` |
| `model` | Override the model for this skill. |
| `context` | `fork` = run in an isolated subagent with no conversation history. Use for task skills that create files or make changes. |
| `agent` | Subagent to use when `context: fork` is set. Options: `Explore`, `Plan`, `general-purpose`, or a custom agent name from `.claude/agents/`. |
| `hooks` | Lifecycle hooks scoped to this skill. See hook-format.md. |

## Invocation Control

| Frontmatter | You can invoke | Claude can invoke | Loaded into context |
|---|---|---|---|
| (default) | Yes | Yes | Description always; full skill when invoked |
| `disable-model-invocation: true` | Yes | No | Not in context; loads when you invoke |
| `user-invocable: false` | No | Yes | Description always; full skill when invoked |

## Running in a Subagent (`context: fork`)

When `context: fork` is set, the skill content becomes the prompt for a subagent running in **isolation — no conversation history**. The `agent` field picks the execution environment.

```markdown
---
name: deep-research
description: Research a topic thoroughly
context: fork
agent: Explore
---

Research $ARGUMENTS thoroughly:
1. Find relevant files using Glob and Grep
2. Read and analyze the code
3. Summarize findings with specific file references
```

**Use `context: fork` when:**
- The skill performs a discrete task (creating files, making changes)
- You are delegating to a custom agent (e.g. `agent: localization-agent`)
- You want isolation from conversation history

**Do NOT use `context: fork` when:**
- The skill is reference/knowledge content Claude applies inline

## Argument Substitution

| Syntax | Description |
|---|---|
| `$ARGUMENTS` | Full user input string |
| `$ARGUMENTS[0]` or `$0` | First positional argument |
| `$ARGUMENTS[1]` or `$1` | Second positional argument |
| `${CLAUDE_SESSION_ID}` | Current session ID |

## Dynamic Context Injection

Prefix a command with `!` to execute it before Claude sees the skill. Output replaces the placeholder — Claude only sees the result, not the command:

```markdown
---
name: pr-summary
description: Summarize changes in a pull request
context: fork
agent: Explore
allowed-tools: Bash(gh *)
---

- PR diff: !`gh pr diff`
- Changed files: !`gh pr diff --name-only`

Summarize this pull request...
```

## Supporting Files

```
my-skill/
├── SKILL.md              # Required — main instructions
├── reference.md          # Optional — loaded on demand via link
├── examples/
│   └── sample.md         # Optional — example output
└── scripts/
    └── helper.sh         # Optional — executable scripts
```

Reference supporting files from SKILL.md so Claude knows when to load them:
```markdown
- For complete details, see [reference.md](reference.md)
- For examples, see [examples/sample.md](examples/sample.md)
```
