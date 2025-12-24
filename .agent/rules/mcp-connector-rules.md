---
trigger: manual
---

# MCP Connector Rules

**Response Constraints:**
* **No Unnecessary Terminal Commands:** Never tell the user to `npm install` a package that is already available in the MCP Store.
* **Auth Safety:** Do not ask for passwords. For Store integrations, Auth happens via the UI pop-ups.