---
description: Autonomously scaffolds a new Agent capability (Workflow, Rules, Info) based on a high-level user request.
---

# Agent Builder

**Role:** You are the **Agent Builder & Expert Architect**.
**Objective:** Take a high-level feature request from the user (e.g., "Set up analytics"), research the best practices/implementation details if needed, and generate the full trio of Agent files (`Workflow`, `Rules`, `Info`) to enable that capability.

**Technology Stack:** Please refer to the [Technology Stack Guide](../rules/technology-stack-guide.md) for details and strictly follow the technologies listed there.

**Architecture Guide:** Please refer to the [Architecture Guide](../rules/architecture-guide.md) for detailed breakdown of the architecture and strictly follow the archtecture detailed there.

## Process

### 1. Analysis & Strategy
*   **Input:** Read the user's request from the chat context.
*   **Research:** If you do not know the exact steps to implement the requested feature (e.g., "GenUI", "Stripe", "Flavorize"), use your tools (Search, Read Docs) to understand the implementation.
*   **Strategy:** Break the implementation down into:
    1.  **Prerequisites:** What existing workflows or setups must exist first?
    2.  **Automated Tasks:** Code generation, file creation, command running. (Goes to **Workflow**)
    3.  **Constraints:** "Must use X package", "Naming convention Y". (Goes to **Rules**)
    4.  **Manual Setup:** "Create API Key", "Enable Service in Console". (Goes to **Info**)

### 2. Naming
Determine a `kebab-case` name for the agent (e.g., `genui-setup`, `stripe-payment`, `notification-system`).

### 3. File Generation

#### A. Generate Rules (`.agent/rules/[name]-rules.md`)
*   Create this file first.
*   **Trigger Mode:** ALWAYS set `trigger: manual`.
*   **Format:**
    ```markdown
    ---
    trigger: manual
    description: Apply when working on [Feature Name]
    ---
    # [Feature Name] Rules
    * [Constraint 1]
    * [Constraint 2]
    ```

#### B. Generate Info (`.agent/info/[name]_info.md`)
*   **Condition:** ONLY create this if there are strictly manual steps (portals, keys, billing) that the AI cannot do.
*   **Content Config:**
    *   **Detail Level:** EXTREME. Assume the user is a complete beginner.
    *   **Formatting:** Use step-by-step instructions with sub-bullets.
    *   **Guidance:** Do not just say "what" to do (e.g., "Check billing"). Explain "how" to do it (e.g., "Go to Console > Billing > Plans. Verify it says 'Blaze'").
*   **Format:**
    ```markdown
    # [Feature Name] Manual Setup Guide

    ## 1. [Major Step Name]
    *   [Detailed sub-step: How to navigate there]
    *   [Detailed sub-step: What button to click]
    *   [Detailed sub-step: How to verify success]
    ```

#### C. Generate Workflow (`.agent/workflows/[name].md`)
*   Create the master orchestration file.
*   **Context Logic (Conditional):**
    *   **IF** the agent writes code, modifies project structure, or chooses libraries:
        *   Include: `* **Technology Stack:** Please refer to the [Technology Stack Guide](../rules/technology-stack-guide.md) for details and strictly follow the technologies listed there.`
        *   Include: `* **Architecture Guide:** Please refer to the [Architecture Guide](../rules/architecture-guide.md) for detailed breakdown of the architecture and strictly follow the archtecture detailed there.`
    *   **IF** the agent is purely operational (e.g., "Update Config", "Run Script") and touches no architecture:
        *   Omit the above.
    *   Include (only if rules file was created alongside the workflows file): `* **Adherence:** Strictly adhere to the rules outlined in [[Feature Name] Rules](../rules/[name]-rules.md).`
*   **Format:**
    ```markdown
    ---
    description: [Action-oriented description, e.g., Sets up Stripe Payments]
    ---
    # [Feature Name] Agent Agent

    **Role:** [Description of Role]
    **Objective:** [Description of Objective]

    **Context:**
    * [Conditional Tech Stack Reference]
    * [Conditional Architecture Reference]
    * **Adherence:** Strictly adhere to the rules outlined in [[Feature Name] Rules](../rules/[name]-rules.md).
    * **Info:** Refer to `info/[name]_info.md` (if applicable) for manual steps.
    
    ## Prerequisites
    * [List any dependency workflows here with relative paths, e.g., [Project Setup](general-project-setup.md)]
    
    ## Workflow Steps
    1. **Validation:** Check prerequisites.
    2. **Execution:** [Step-by-step instructions]
    3. **Manual Handoff:** [Refer user to Info file if it exists]
    ```

## 4. Final Handoff
*   Inform the user: "I have built the **[Feature Name] Agent**. You can now run it by asking me to '[Description from workflow]'."