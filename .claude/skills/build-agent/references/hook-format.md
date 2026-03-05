# Hook Format Reference

## Configuration Locations

| Location | Scope |
|---|---|
| `~/.claude/settings.json` | User-level (all projects) |
| `.claude/settings.json` | Project-level (committed to git) |
| `.claude/settings.local.json` | Local-only (gitignored) |
| Skill/Agent frontmatter `hooks:` | Scoped to that skill/agent only |

## Hook Structure in settings.json

```json
{
  "hooks": {
    "<EventName>": [
      {
        "matcher": "ToolName|OtherTool",
        "hooks": [
          {
            "type": "command",
            "command": "/path/to/script.sh",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

## Hook Structure in Skill/Agent Frontmatter

```yaml
hooks:
  <EventName>:
    - matcher: "ToolName|OtherTool"
      hooks:
        - type: command
          command: "./scripts/check.sh"
          timeout: 30
```

## Hook Events

| Event | When It Fires | Matcher Matches On |
|---|---|---|
| `SessionStart` | Session begins | `startup`, `resume`, `clear`, `compact` |
| `UserPromptSubmit` | User submits a prompt | *(no matcher)* |
| `PreToolUse` | Before a tool executes | Tool name: `Bash`, `Edit`, `Write`, `Read`, etc. |
| `PermissionRequest` | Permission prompt shown | Tool name |
| `PostToolUse` | After a tool succeeds | Tool name |
| `PostToolUseFailure` | After a tool fails | Tool name |
| `Notification` | System notification | `permission_prompt`, `idle_prompt`, `auth_success` |
| `SubagentStart` | Subagent spawned | Agent name: `Explore`, `Plan`, or custom |
| `SubagentStop` | Subagent finishes | Agent name |
| `Stop` | Claude stops responding | *(no matcher)* |
| `PreCompact` | Before context compaction | `manual`, `auto` |
| `SessionEnd` | Session ends | `clear`, `logout`, `prompt_input_exit` |
| `TaskCompleted` | Background task completes | *(no matcher)* |
| `ConfigChange` | Settings change | `user_settings`, `project_settings`, `skills` |

## Handler Fields

| Field | Required | Description |
|---|---|---|
| `type` | Yes | `command` (shell command) or `http` (HTTP request) |
| `command` | Yes* | Shell command to run (*for type: command) |
| `url` | Yes* | URL to call (*for type: http) |
| `timeout` | No | Seconds before timeout (default: 60) |
| `async` | No | `true` = run in background, don't block Claude |

## Matcher Patterns

| Pattern | Matches |
|---|---|
| `"Bash"` | Bash tool only |
| `"Edit\|Write"` | Edit OR Write tool |
| `"mcp__memory__.*"` | All tools from memory MCP server |
| `"mcp__.*__write.*"` | Any MCP write tool |
| `"*"` | Everything |
| `""` or omitted | Everything (same as `*`) |

## Path Variables

| Variable | Resolves To |
|---|---|
| `$CLAUDE_PROJECT_DIR` | Project root directory |
| `${CLAUDE_PLUGIN_ROOT}` | Plugin root (for plugins) |
| `$TOOL_INPUT` | JSON input passed to the tool (PreToolUse/PostToolUse) |

## Common Patterns

### Auto-lint after file changes
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "dart analyze \"$CLAUDE_PROJECT_DIR\" 2>&1 | head -20",
            "timeout": 15
          }
        ]
      }
    ]
  }
}
```

### Auto-test after file changes (async)
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "flutter test --reporter compact 2>&1 | tail -10",
            "timeout": 60,
            "async": true
          }
        ]
      }
    ]
  }
}
```

### Block dangerous commands
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "echo $TOOL_INPUT | jq -r '.command' | grep -qE 'rm -rf|drop table|force push' && echo 'BLOCKED: Dangerous command' && exit 1 || exit 0"
          }
        ]
      }
    ]
  }
}
```
