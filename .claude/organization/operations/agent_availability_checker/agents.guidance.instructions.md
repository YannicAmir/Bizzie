---
name: agents guidance
description: Agent registry and routing instructions for AgentAvailabilityChecker.
---

# Instructions for AgentAvailabilityChecker

## When a user asks what agents are available:
1. Respond with the complete list of agents and their descriptions from the **Agent Registry** below.

## When a user requests a new agent to be built:
1. Search the **Agent Registry** for an agent matching the request by name or purpose.
2. If a match is found: return the agent's name, description, and path to the user. **Stop** — do not delegate to AgentBuilder.
3. If no match is found: delegate to **AgentBuilder** to build the agent.

## Post-Build Registry Update
After AgentBuilder successfully builds a new agent, update the **Agent Registry** below by appending the new agent's name, path, and description.

---

# Agent Registry

> Automatically maintained. AgentBuilder appends new entries after each build.

## AgentBuilder
- **Path:** `.claude/organization/operations/agent_builder/agent.builder.agent.md`
- **Description:** Builds new agents, skills, and instruction files in this repository based on user requests, following established architecture and naming conventions.

## AgentAvailabilityChecker
- **Path:** `.claude/organization/operations/agent_availability_checker/agent.availability.checker.agent.md`
- **Description:** Checks whether a requested agent already exists in the repository and provides users with information about all available agents.

## PresentationManager
- **Path:** `.claude/organization/technology/presentation_agents/presentation.manager.agent.md`
- **Description:** Manages and coordinates presentation-layer agents, delegating UI tasks to the appropriate sub-agents.

## UiManager
- **Path:** `.claude/organization/technology/presentation_agents/ui/ui_mananger/ui.manager.agent.md`
- **Description:** Entry point for all Flutter UI work. Classifies incoming requests and routes correction requests directly to UiCorrector, and build/update requests to UiPlanner. Passes the full request description, design reference (if provided), and target context to the delegated agent.

## UiPlanner
- **Path:** `.claude/organization/technology/presentation_agents/ui/ui_planner/ui.planner.agent.md`
- **Description:** Plans UI changes based on user requests and produces a structured implementation plan. Triggered by the UI Manager agent. Upon completion, delegates automatically to UiBuilder (for new screens/components) or UiUpdater (for updates to existing screens/components).

## UiBuilder
- **Path:** `.claude/organization/technology/presentation_agents/ui/ui_builder/ui.builder.agent.md`
- **Description:** Builds net-new Flutter UI screens and components that do not yet exist in the codebase. Called by the UI Planner agent with a full implementation plan and design reference (Figma link or copied Figma content). Strictly creates UI code only — never modifies behavior, logic, or refactors existing code.

## UiCorrector
- **Path:** `.claude/organization/technology/presentation_agents/ui/ui_corrector/ui.corrector.agent.md`
- **Description:** Applies targeted UI corrections based on a description or supplied design reference (e.g., Figma link, Figma copied mock, screenshot, verbal instruction). Called directly by the UI Manager agent — not routed through UI Planner. Strictly makes visual and layout changes only — never modifies behavior, logic, or refactors code.

## UiUpdater
- **Path:** `.claude/organization/technology/presentation_agents/ui/ui_updater/ui.updater.agent.md`
- **Description:** Updates existing Flutter UI screens and components to match revised design mocks provided by the design team. Requires a Figma link or copied Figma content plus a target feature directory or page description. Strictly makes UI changes only — never modifies behavior, logic, or refactors code. Called by the UI Planner agent.

## Researcher
- **Path:** `.claude/organization/operations/research_agents/researcher/researcher.agent.md`
- **Description:** Conducts external internet research by finding and aggregating up to 5 official web sources (up to 10 if absolutely necessary) that match the user's query, then hands off the collected sources to the Synthesizing agent.

## Synthesizer
- **Path:** `.claude/organization/operations/research_agents/synthesizer/synthesizer.agent.md`
- **Description:** Receives the source package from the Researcher agent, fetches and reads each URL, extracts only the most relevant and non-redundant information relative to the user's original query, and hands the synthesized output off to the Research Doc Builder agent.

## ResearchDocBuilder
- **Path:** `.claude/organization/operations/research_agents/research_doc_builder/research.doc.builder.agent.md`
- **Description:** Takes the synthesized output from the Synthesizer agent and writes it to a structured markdown research document, placing it at the user-specified path or a sensible default.

## StateManager
- **Path:** `.claude/organization/technology/presentation_agents/state/state_manager/state.manager.agent.md`
- **Description:** Entry point for all Flutter state management work. Classifies incoming requests and routes correction requests directly to StateCorrector, and build/update requests to StatePlanner. Passes the full request description and target context to the delegated agent.

## StatePlanner
- **Path:** `.claude/organization/technology/presentation_agents/state/state_planner/state.planner.agent.md`
- **Description:** Plans BLoC state management changes based on user requests and produces a structured implementation plan (@freezed state/event design, BLoC constructor, implementation steps). Triggered by the State Manager agent. Upon completion, delegates automatically to StateBuilder (for new BLoCs) or StateUpdater (for updates to existing BLoC code).

## StateBuilder
- **Path:** `.claude/organization/technology/presentation_agents/state/state_builder/state.builder.agent.md`
- **Description:** Builds net-new Flutter BLoC state management code that does not yet exist in the codebase. Called by the State Planner agent with a full implementation plan. Creates @freezed state/event files and @injectable BLoC class. Strictly creates state management code only -- never modifies UI layout/styling or refactors existing code.

## StateUpdater
- **Path:** `.claude/organization/technology/presentation_agents/state/state_updater/state.updater.agent.md`
- **Description:** Updates existing Flutter BLoC state management code to match changed requirements. Called by the State Planner agent with a full implementation plan. Strictly modifies @freezed state/event variants and BLoC handler methods only -- never changes UI layout/styling or refactors unrelated code.

## StateCorrector
- **Path:** `.claude/organization/technology/presentation_agents/state/state_corrector/state.corrector.agent.md`
- **Description:** Applies targeted corrections to existing Flutter BLoC state management code based on a bug report or verbal description. Called directly by the State Manager agent -- not routed through State Planner. Strictly fixes state management issues only -- never modifies UI layout/styling or refactors unrelated code.


## AccessibilityManager
- **Path:** `.claude/organization/technology/presentation_agents/accessibility/accessibility_manager/accessibility.manager.agent.md`
- **Description:** Entry point for all Flutter accessibility work. Classifies incoming requests and routes targeted correction requests directly to AccessibilityCorrector, and build/update requests to AccessibilityPlanner. Passes the full request description and target context to the delegated agent.

## AccessibilityPlanner
- **Path:** `.claude/organization/technology/presentation_agents/accessibility/accessibility_planner/accessibility.planner.agent.md`
- **Description:** Plans accessibility implementation or remediation by auditing target screens against WCAG 2.2 AA, identifying gaps, and producing a structured implementation plan. Delegates automatically to AccessibilityBuilder (new screens) or AccessibilityUpdater (existing screens). Never writes code directly.

## AccessibilityBuilder
- **Path:** `.claude/organization/technology/presentation_agents/accessibility/accessibility_builder/accessibility.builder.agent.md`
- **Description:** Implements accessibility support on Flutter screens and components that currently have none. Called by the Accessibility Planner with a full implementation plan. Adds Semantics, labels, touch targets, focus management, and live region support. Strictly accessibility-scope only -- never modifies layout, styling, or business logic.

## AccessibilityUpdater
- **Path:** `.claude/organization/technology/presentation_agents/accessibility/accessibility_updater/accessibility.updater.agent.md`
- **Description:** Updates and remediates existing accessibility implementations on Flutter screens and components. Called by the Accessibility Planner with a full implementation plan. Corrects incorrect Semantics, improves labels, fixes focus wiring, and closes WCAG 2.2 AA gaps. Strictly accessibility-scope only -- never modifies layout, styling, or business logic.

## AccessibilityCorrector
- **Path:** `.claude/organization/technology/presentation_agents/accessibility/accessibility_corrector/accessibility.corrector.agent.md`
- **Description:** Applies targeted corrections to specific, discrete accessibility issues in existing Flutter code. Called directly by the Accessibility Manager agent -- not routed through Accessibility Planner. Strictly fixes accessibility issues only -- never modifies layout, styling, or business logic.


## AnalyticsManager
- **Path:** `.claude/organization/technology/presentation_agents/analytics/analytics_manager/analytics.manager.agent.md`
- **Description:** Entry point for all Flutter analytics work. Classifies incoming requests and routes targeted correction requests directly to AnalyticsCorrector, and build/update requests to AnalyticsPlanner. Passes the full request description and target context to the delegated agent.

## AnalyticsPlanner
- **Path:** `.claude/organization/technology/presentation_agents/analytics/analytics_planner/analytics.planner.agent.md`
- **Description:** Plans analytics implementation or updates by auditing the target feature against project analytics patterns, defining page constants and event schemas, and producing a structured implementation plan. Delegates automatically to AnalyticsBuilder (no existing analytics) or AnalyticsUpdater (existing analytics to be changed). Never writes code directly.

## AnalyticsBuilder
- **Path:** `.claude/organization/technology/presentation_agents/analytics/analytics_builder/analytics.builder.agent.md`
- **Description:** Implements analytics from scratch for Flutter features that currently have no analytics code. Called by the Analytics Planner with a full implementation plan. Creates a @lazySingleton XxxTracker class using IAnalyticsService, defines private static const event/param constants, implements one method per event, and wires the tracker into the BLoC as a positional constructor parameter.

## AnalyticsUpdater
- **Path:** `.claude/organization/technology/presentation_agents/analytics/analytics_updater/analytics.updater.agent.md`
- **Description:** Updates existing Flutter analytics code to match changed requirements. Called by the Analytics Planner with a full implementation plan. Extends the XxxTracker class with new constants and methods, adds tracker injection to the BLoC if missing, and adds _tracker.logXxx() calls in BLoC event handlers.

## AnalyticsCorrector
- **Path:** `.claude/organization/technology/presentation_agents/analytics/analytics_corrector/analytics.corrector.agent.md`
- **Description:** Applies targeted corrections to specific analytics violations or bugs in existing Flutter code. Called directly by the Analytics Manager agent -- not routed through Analytics Planner. Strictly fixes the reported analytics issue only -- never modifies UI layout, styling, or business logic.


## L10nManager
- **Path:** `.claude/organization/technology/presentation_agents/localization/l10n_manager/l10n.manager.agent.md`
- **Description:** Entry point for all Flutter localisation work. Classifies incoming requests and routes targeted correction requests directly to L10nCorrector, and build/update requests to L10nPlanner. Passes the full request description and target context to the delegated agent.

## L10nPlanner
- **Path:** `.claude/organization/technology/presentation_agents/localization/l10n_planner/l10n.planner.agent.md`
- **Description:** Plans localisation implementation or updates by auditing the target feature, inventorying all strings with en/de copy, and producing a structured implementation plan. Delegates automatically to L10nBuilder (no existing l10n) or L10nUpdater (existing l10n to be changed). Never writes code directly.

## L10nBuilder
- **Path:** `.claude/organization/technology/presentation_agents/localization/l10n_builder/l10n.builder.agent.md`
- **Description:** Implements localisation from scratch for Flutter features that currently have no l10n code. Called by the L10n Planner with a full implementation plan. Creates the feature l10n.dart extension file, accessibility string files, and wires BizzieLocalizations into widget build() methods.

## L10nUpdater
- **Path:** `.claude/organization/technology/presentation_agents/localization/l10n_updater/l10n.updater.agent.md`
- **Description:** Updates existing Flutter localisation code to match changed requirements. Called by the L10n Planner with a full implementation plan. Extends l10n extension files, adds new strings, updates copy values, and adds accessibility strings on features that already have some l10n implemented.

## L10nCorrector
- **Path:** `.claude/organization/technology/presentation_agents/localization/l10n_corrector/l10n.corrector.agent.md`
- **Description:** Applies targeted corrections to specific localisation violations or bugs in existing Flutter code. Called directly by the L10n Manager agent -- not routed through L10n Planner. Strictly fixes the reported l10n issue only -- never modifies UI layout, styling, or business logic.


## AssetHandler
- **Path:** `.claude/organization/technology/presentation_agents/assets/asset_handler/asset.handler.agent.md`
- **Description:** Places new image, icon, or SVG files into the correct assets/images/<feature>/ subfolder, registers any new subfolder in pubspec.yaml, and adds the corresponding AppAssets constant. Called by AssetManager -- either for a pure asset addition or as the first step in a branding workflow before AppBrander applies branding changes.

## AppBrander
- **Path:** `.claude/organization/technology/presentation_agents/assets/app_brander/app.brander.agent.md`
- **Description:** Applies brand-level visual changes -- app icon, native splash screens, and the Flutter splash. Called by AssetManager after asset files have been placed by AssetHandler when needed. Handles flutter_launcher_icons.yaml (iOS + Android), flutter_native_splash.yaml, and Flutter splash AppAssets verification.

## AssetManager
- **Path:** `.claude/organization/technology/presentation_agents/assets/asset_manager/asset.manager.agent.md`
- **Description:** Entry point for all Flutter asset and branding work. Classifies requests as pure asset additions (delegates to AssetHandler only), branding changes with no new files (delegates to AppBrander only), or branding changes with new files (delegates to AssetHandler first then AppBrander sequentially).

## RefactorManager
- **Path:** `.claude/organization/technology/presentation_agents/refactoring/refactor_manager/refactor.manager.agent.md`
- **Description:** Entry point for all refactoring work. Validates that the request is behaviour-preserving (not a bug fix or new feature), gathers the target context, and delegates to RefactorPlanner to audit violations and produce a structured refactor plan.

## RefactorPlanner
- **Path:** `.claude/organization/technology/presentation_agents/refactoring/refactor_planner/refactor.planner.agent.md`
- **Description:** Audits target Flutter / Dart code against flutter best practices, dart best practices, architecture guidelines, software development best practices, and restrictions. Produces a structured violation summary and refactoring plan with sequenced, behaviour-preserving steps. Delegates automatically to RefactorBuilder after the plan is complete.

## RefactorBuilder
- **Path:** `.claude/organization/technology/presentation_agents/refactoring/refactor_builder/refactor.builder.agent.md`
- **Description:** Executes a structured refactoring plan from RefactorPlanner step by step. Applies behaviour-preserving code improvements -- fixing Flutter, Dart, architecture, and software development best practice violations -- without changing what the code does. Stops and reports to the user if any step would require a logic or behaviour change.

## WebViewManager
- **Path:** `.claude/organization/technology/presentation_agents/webview/webview_manager/webview.manager.agent.md`
- **Description:** Entry point for all Flutter WebView work. Classifies incoming requests and routes targeted correction requests directly to WebViewCorrector, and build or update requests to WebViewPlanner. Passes the full request description and target context to the delegated agent.

## WebViewPlanner
- **Path:** `.claude/organization/technology/presentation_agents/webview/webview_planner/webview.planner.agent.md`
- **Description:** Plans Flutter WebView feature implementation or updates by auditing the target context, inventorying what needs to be built or changed, and producing a structured implementation plan. Delegates automatically to WebViewBuilder (new page) or WebViewUpdater (existing page changes). Never writes code directly.

## WebViewBuilder
- **Path:** `.claude/organization/technology/presentation_agents/webview/webview_builder/webview.builder.agent.md`
- **Description:** Implements new Flutter WebView pages from scratch using a structured implementation plan from WebViewPlanner. Creates the WrappedWebViewPage widget, adds the route entry, and implements any custom WebViewInterceptHandler or JsMessageHandler subclasses.

## WebViewCorrector
- **Path:** `.claude/organization/technology/presentation_agents/webview/webview_corrector/webview.corrector.agent.md`
- **Description:** Applies targeted corrections to specific WebView violations or bugs in existing Flutter code. Called directly by the WebView Manager agent -- not routed through WebView Planner. Strictly fixes the reported webview issue only -- never modifies UI layout, state management logic, or non-webview code.

## WebViewUpdater
- **Path:** `.claude/organization/technology/presentation_agents/webview/webview_updater/webview.updater.agent.md`
- **Description:** Updates existing Flutter WebView pages to match changed requirements. Called by the WebView Planner with a full implementation plan. Extends WrappedWebViewPage props, adds or modifies URL interception, updates JS message handlers, and applies structural changes to features that already have webview code.

## DomainManager
- **Path:** `.claude/organization/technology/domain_agents/domain_manager/domain.manager.agent.md`
- **Description:** Entry point for all Flutter domain layer work. Classifies incoming requests and routes targeted correction requests directly to DomainCorrector, and build or update requests to DomainPlanner. Passes the full request description and target context to the delegated agent.

## DomainPlanner
- **Path:** `.claude/organization/technology/domain_agents/domain_planner/domain.planner.agent.md`
- **Description:** Plans Flutter domain layer implementation or updates by auditing the target context, identifying the correct layer for new logic, and producing a structured implementation plan. Delegates automatically to DomainBuilder (new use cases / models / interfaces) or DomainUpdater (changes to existing domain code). Never writes code directly.

## DomainBuilder
- **Path:** `.claude/organization/technology/domain_agents/domain_builder/domain.builder.agent.md`
- **Description:** Implements new Flutter domain layer code from scratch using a structured plan from DomainPlanner. Creates UseCase classes, repository interfaces, domain models with @freezed, and injectable DI annotations (`@lazySingleton` for use cases). Invokes RunDepOps as the final step.

## DomainUpdater
- **Path:** `.claude/organization/technology/domain_agents/domain_updater/domain.updater.agent.md`
- **Description:** Updates existing Flutter domain layer code to match changed requirements. Called by the DomainPlanner with a full implementation plan. Extends use cases, updates domain models, adjusts repository interface signatures, and wires new UseCases into BLoCs. Invokes RunDepOps as the final step.

## DomainCorrector
- **Path:** `.claude/organization/technology/domain_agents/domain_corrector/domain.corrector.agent.md`
- **Description:** Applies targeted corrections to specific domain layer violations in existing Flutter code. Called directly by the DomainManager -- not routed through DomainPlanner. Fixes layer violations such as BLoC calling repositories directly, missing @injectable annotations, wrong Either<Failure,T> return types, and misplaced business logic.

## DataManager
- **Path:** `.claude/organization/technology/data_agents/data_manager/data.manager.agent.md`
- **Description:** Entry point for all Flutter data layer work. Classifies incoming requests and routes targeted correction requests directly to DataCorrector, and build or update requests to DataPlanner. Passes the full request description and target context to the delegated agent.

## DataPlanner
- **Path:** `.claude/organization/technology/data_agents/data_planner/data.planner.agent.md`
- **Description:** Plans Flutter data layer implementation or updates by auditing the target context, identifying what needs to be created or changed, and producing a structured implementation plan. Delegates automatically to DataBuilder (new data layer code) or DataUpdater (changes to existing code). Never writes code directly.

## DataBuilder
- **Path:** `.claude/organization/technology/data_agents/data_builder/data.builder.agent.md`
- **Description:** Implements new Flutter data layer code from scratch using a structured plan from DataPlanner. Creates Firestore datasource implementations, @freezed DTOs with fromDomain/toDomain, repository implementations with Either<Failure,T>, and @Injectable/@LazySingleton annotations. Invokes RunDepOps as the final step.

## DataUpdater
- **Path:** `.claude/organization/technology/data_agents/data_updater/data.updater.agent.md`
- **Description:** Updates existing Flutter data layer code to match changed requirements. Called by the DataPlanner with a full implementation plan. Extends Firestore datasources, updates @freezed DTOs, adjusts repository implementations and Either<Failure,T> wrapping. Invokes RunDepOps as the final step.

## DataCorrector
- **Path:** `.claude/organization/technology/data_agents/data_corrector/data.corrector.agent.md`
- **Description:** Applies targeted corrections to specific data layer violations in existing Flutter code. Called directly by the DataManager -- not routed through DataPlanner. Fixes direct FirebaseFirestore.instance access, missing @Injectable/@LazySingleton annotations, missing Either<Failure,T> wrapping, missing toDomain/fromDomain conversions, and @freezed DTO violations. Invokes RunDepOps as the final step.

## RunDepOps
- **Path:** `.claude/organization/technology/run_dep_ops/run.dep.ops.agent.md`
- **Description:** Runs post-implementation dependency operations for all Flutter layers. Determines whether dart build_runner is required based on whether @freezed models, DTOs, BLoC state/event classes, or @injectable classes were added or modified, runs it if needed, and reports the outcome. Called as the final step by DataBuilder, DataUpdater, DataCorrector, DomainBuilder, DomainUpdater, StateBuilder, and StateUpdater.

## TestManager
- **Path:** `.claude/organization/technology/test_agents/test_manager/test.manager.agent.md`
- **Description:** Entry point for all Flutter test work. Classifies requests as run-only, targeted correction, or write/update. Routes run-only requests to TestRunner, targeted corrections directly to TestCorrector, and write/update requests to TestPlanner.

## TestPlanner
- **Path:** `.claude/organization/technology/test_agents/test_planner/test.planner.agent.md`
- **Description:** Plans Flutter test implementation or updates by auditing the target implementation files, identifying every testable behaviour, and producing a structured test plan. Delegates to TestBuilder (new files) or TestUpdater (existing files to modify).

## TestBuilder
- **Path:** `.claude/organization/technology/test_agents/test_builder/test.builder.agent.md`
- **Description:** Writes new Flutter test files from scratch following the plan from TestPlanner. Applies AAA structure, public MockXxx mock classes, t-prefix fake data, setUpAll/registerFallbackValue, blocTest with bloc.add() for BLoC tests, and tearDown(() => bloc.close()). Invokes TestRunner as the final step.

## TestUpdater
- **Path:** `.claude/organization/technology/test_agents/test_updater/test.updater.agent.md`
- **Description:** Updates existing Flutter test files following the plan from TestPlanner. Extends test cases, updates stubs and assertions after implementation changes, and adds missing success/failure scenarios. Invokes TestRunner as the final step.

## TestCorrector
- **Path:** `.claude/organization/technology/test_agents/test_corrector/test.corrector.agent.md`
- **Description:** Fixes failing Flutter tests or convention violations. Called directly by TestManager for targeted corrections, or by TestRunner during the retry loop. Always invokes TestRunner after fixes, passing the current attempt number to maintain retry loop state.

## TestRunner
- **Path:** `.claude/organization/technology/test_agents/test_runner/test.runner.agent.md`
- **Description:** Runs flutter test on the specified test files and manages the retry loop. On pass: reports success. On fail with attempt < 5: delegates to TestCorrector with the failure output and current attempt number. On fail with attempt >= 5: stops the loop and reports the full failing test summary to the user.

## BugManager
- **Path:** `.claude/organization/technology/bug_agents/bug_manager/bug.manager.agent.md`
- **Description:** Entry point for all bug reports. Receives the bug description from the user and immediately delegates to BugReviewer. Asks one clarifying question if the description is too vague to locate the affected area.

## BugReviewer
- **Path:** `.claude/organization/technology/bug_agents/bug_reviewer/bug.reviewer.agent.md`
- **Description:** Investigates a reported bug by locating the defective code in the codebase and determining why it is occurring. Reads source files, traces the execution path, and produces a precise root-cause explanation before delegating to BugFixPlanner.

## BugFixPlanner
- **Path:** `.claude/organization/technology/bug_agents/bug_fix_planner/bug.fix.planner.agent.md`
- **Description:** Turns BugReviewer's root-cause explanation into a precise step-by-step fix plan. Reads the affected files to verify the plan, identifies side effects, and specifies what must not be changed. Delegates the completed plan to BugSquasher.

## BugSquasher
- **Path:** `.claude/organization/technology/bug_agents/bug_squasher/bug.squasher.agent.md`
- **Description:** Implements a bug fix from the plan produced by BugFixPlanner. Applies each change in plan order, stays strictly within scope, verifies each edit is correct in context, and reports a completion summary with files changed and any outstanding gaps.

## DomainEnforcer
- **Path:** `.claude/organization/technology/qa_agents/domain_enforcer/domain.enforcer.agent.md`
- **Description:** QA enforcer for the domain layer. Measures changed files against domain.guidance.instructions.md. Called automatically after DomainBuilder, DomainUpdater, and DomainCorrector. Drives up to 3 correction loops via DomainReporter before stopping and reporting to the user.

## DomainReporter
- **Path:** `.claude/organization/technology/qa_agents/domain_reporter/domain.reporter.agent.md`
- **Description:** QA reporter for the domain layer. Receives violation findings from DomainEnforcer and passes them verbatim to DomainCorrector with next_attempt = attempt + 1.

## DataEnforcer
- **Path:** `.claude/organization/technology/qa_agents/data_enforcer/data.enforcer.agent.md`
- **Description:** QA enforcer for the data layer. Measures changed files against data.guidance.instructions.md. Called automatically after DataBuilder, DataUpdater, and DataCorrector (via RunDepOps). Drives up to 3 correction loops via DataReporter before stopping and reporting to the user.

## DataReporter
- **Path:** `.claude/organization/technology/qa_agents/data_reporter/data.reporter.agent.md`
- **Description:** QA reporter for the data layer. Receives violation findings from DataEnforcer and passes them verbatim to DataCorrector with next_attempt = attempt + 1.

## AssetEnforcer
- **Path:** `.claude/organization/technology/qa_agents/asset_enforcer/asset.enforcer.agent.md`
- **Description:** QA enforcer for asset handling. Measures changed files against asset.handling.guidance.instructions.md. Called automatically after AssetHandler. Drives up to 3 correction loops via AssetReporter before stopping and reporting to the user.

## AssetReporter
- **Path:** `.claude/organization/technology/qa_agents/asset_reporter/asset.reporter.agent.md`
- **Description:** QA reporter for asset handling. Receives violation findings from AssetEnforcer and passes them verbatim to AssetHandler with next_attempt = attempt + 1.

## StateManagementEnforcer
- **Path:** `.claude/organization/technology/qa_agents/state_management_enforcer/state.management.enforcer.agent.md`
- **Description:** QA enforcer for state management. Measures changed files against flutter.bloc.best.practice.instructions.md. Called automatically after StateBuilder, StateUpdater, and StateCorrector. Drives up to 3 correction loops via StateManagementReporter before stopping and reporting to the user.

## StateManagementReporter
- **Path:** `.claude/organization/technology/qa_agents/state_management_reporter/state.management.reporter.agent.md`
- **Description:** QA reporter for state management. Receives violation findings from StateManagementEnforcer and passes them verbatim to StateCorrector with next_attempt = attempt + 1.

## AccessibilityEnforcer
- **Path:** `.claude/organization/technology/qa_agents/accessibility_enforcer/accessibility.enforcer.agent.md`
- **Description:** QA enforcer for accessibility. Measures changed files against flutter.accessibility.guidance.instructions.md. Called automatically after AccessibilityBuilder, AccessibilityUpdater, and AccessibilityCorrector. Drives up to 3 correction loops via AccessibilityReporter before stopping and reporting to the user.

## AccessibilityReporter
- **Path:** `.claude/organization/technology/qa_agents/accessibility_reporter/accessibility.reporter.agent.md`
- **Description:** QA reporter for accessibility. Receives violation findings from AccessibilityEnforcer and passes them verbatim to AccessibilityCorrector with next_attempt = attempt + 1.

## L10nEnforcer
- **Path:** `.claude/organization/technology/qa_agents/l10n_enforcer/l10n.enforcer.agent.md`
- **Description:** QA enforcer for localisation. Measures changed files against localization.guidance.instructions.md. Called automatically after L10nBuilder, L10nUpdater, and L10nCorrector. Drives up to 3 correction loops via L10nReporter before stopping and reporting to the user.

## L10nReporter
- **Path:** `.claude/organization/technology/qa_agents/l10n_reporter/l10n.reporter.agent.md`
- **Description:** QA reporter for localisation. Receives violation findings from L10nEnforcer and passes them verbatim to L10nCorrector with next_attempt = attempt + 1.

## AnalyticsEnforcer
- **Path:** `.claude/organization/technology/qa_agents/analytics_enforcer/analytics.enforcer.agent.md`
- **Description:** QA enforcer for analytics. Measures changed files against analytics.guidance.instructions.md. Called automatically after AnalyticsBuilder, AnalyticsUpdater, and AnalyticsCorrector. Drives up to 3 correction loops via AnalyticsReporter before stopping and reporting to the user.

## AnalyticsReporter
- **Path:** `.claude/organization/technology/qa_agents/analytics_reporter/analytics.reporter.agent.md`
- **Description:** QA reporter for analytics. Receives violation findings from AnalyticsEnforcer and passes them verbatim to AnalyticsCorrector with next_attempt = attempt + 1.

## ThemesAndStylingEnforcer
- **Path:** `.claude/organization/technology/qa_agents/themes_and_styling_enforcer/themes.and.styling.enforcer.agent.md`
- **Description:** QA enforcer for UI theming and styling. Measures changed files against theme.styling.guidance.instructions.md. Called automatically after UIBuilder, UIUpdater, and UICorrector. Drives up to 3 correction loops via ThemesAndStylingReporter before stopping and reporting to the user.

## ThemesAndStylingReporter
- **Path:** `.claude/organization/technology/qa_agents/themes_and_styling_reporter/themes.and.styling.reporter.agent.md`
- **Description:** QA reporter for theming and styling. Receives violation findings from ThemesAndStylingEnforcer and passes them verbatim to UICorrector with next_attempt = attempt + 1.

## CodeHygieneEnforcer
- **Path:** `.claude/organization/technology/qa_agents/code_hygiene_enforcer/code.hygiene.enforcer.agent.md`
- **Description:** QA enforcer for general code hygiene. Measures changed files against architecture.guidance, dart.best.practice, flutter.best.practice, flutter.bloc.best.practice, routing, software.dev.best.practice, tech.stack, and theme.styling.guidance instruction sets. Drives up to 3 correction loops via CodeHygieneReporter before stopping and reporting to the user.

## CodeHygieneReporter
- **Path:** `.claude/organization/technology/qa_agents/code_hygiene_reporter/code.hygiene.reporter.agent.md`
- **Description:** QA reporter for general code hygiene. Receives violation findings from CodeHygieneEnforcer, formats them as a structured refactoring plan, and passes them to RefactorBuilder with next_attempt and an instruction to call CodeHygieneEnforcer again after corrections are applied.