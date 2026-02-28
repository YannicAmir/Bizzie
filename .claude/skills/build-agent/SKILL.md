---
name: build-agent
description: Creates new Claude Code skills, subagents, and/or hooks from a capability description. Use when you need to add a new automated workflow, coding assistant, or quality gate to the project.
disable-model-invocation: true
argument-hint: <capability description>
context: fork
agent: agent-builder
---

## Capability Request

The user wants the following capability added to the project:

**$ARGUMENTS**

## Instructions

Use the `agent-builder` agent to fulfill this request. The agent will research the project, plan the required components, create all files, and provide a summary.
