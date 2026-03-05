# Subagent Format Reference

## File Location

```
.claude/agents/<agent-name>.md
```

## Agent File Structure

```markdown
---
name: my-agent
description: What this agent does. Claude uses this to decide when to delegate.
tools: Read, Write, Edit, Grep, Glob, Bash
disallowedTools: Task
model: sonnet
skills:
  - skill-one
  - skill-two
memory: project
permissionMode: default
maxTurns: 50
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate.sh"
  PostToolUse:
    - matcher: "Edit|Write"
      hooks:
        - type: command
          command: "./scripts/lint.sh"
background: false
isolation: worktree
---

Your agent's system prompt goes here. Be specific about:
1. What the agent's role is
2. What it should and should NOT do
3. How it should structure its output
4. What files/directories it should focus on
```

## Frontmatter Fields

| Field | Required | Description |
|---|---|---|
| `name` | Yes | Agent identifier |
| `description` | Yes | When to use this agent (Claude matches against this) |
| `tools` | No | Comma-separated list of allowed tools |
| `disallowedTools` | No | Tools explicitly denied |
| `model` | No | `sonnet`, `opus`, `haiku`, or `inherit` (default: `inherit`) |
| `skills` | No | List of skills to preload into the agent's context |
| `memory` | No | `user`, `project`, or `local` — enables persistent memory |
| `permissionMode` | No | `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, `plan` |
| `maxTurns` | No | Maximum number of turns before the agent stops |
| `hooks` | No | Lifecycle hooks scoped to this agent |
| `background` | No | `true` = run concurrently with main session |
| `isolation` | No | `worktree` = use a git worktree for isolation |

## Available Tools

| Tool | Description |
|---|---|
| `Read` | Read file contents |
| `Write` | Create new files |
| `Edit` | Edit existing files |
| `Grep` | Search file contents with regex |
| `Glob` | Find files by pattern |
| `Bash` | Execute shell commands |
| `Task` | Spawn other subagents. Use `Task(agent-name)` to restrict. |
| `AskUserQuestion` | Ask the user a clarifying question |

## Permission Modes

| Mode | Behavior |
|---|---|
| `default` | Normal permission prompts |
| `acceptEdits` | Auto-approve file edits, prompt for others |
| `dontAsk` | Auto-approve most actions |
| `bypassPermissions` | Skip all permission prompts (use carefully) |
| `plan` | Read-only, no file modifications |

## Persistent Memory

When `memory` is set, the agent maintains a `MEMORY.md` file:
- `user` → `~/.claude/agent-memory/<agent-name>/`
- `project` → `.claude/agent-memory/<agent-name>/`
- `local` → `.claude/agent-memory-local/<agent-name>/`

The agent can read/write to this directory across sessions.

## Invocation Methods

1. **Automatic delegation**: Claude matches the `description` to the task
2. **Explicit**: `Use the <agent-name> agent to...`
3. **From a skill**: Set `agent: <agent-name>` in a skill's frontmatter
4. **Background**: `Run <agent-name> in the background to...`
