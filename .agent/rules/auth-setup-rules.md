---
trigger: model_decision
description: This rule should be applied when Auth Setup for app is being conducted
---

# Auth Setup Rules

## Implementation Logic
* **Domain Layer:**
    * Define `UserModel` using **`@freezed`** to ensure immutability and automatic `==` equality.
    * Define `IAuthRepository` interface (in `interfaces/`).
* **Data Layer:**
    * Implement the `RemoteAuthDataSource` using `FirebaseAuth.instance`.
    * *Constraint:* For Email/Password, use `signInWithEmailAndPassword` and `createUserWithEmailAndPassword`.
    * *Constraint:* For Password Reset, use `sendPasswordResetEmail`.
    * *Constraint:* For Delete Account, use `currentUser.delete()`. Add a comment about `requires-recent-login` exceptions.
* **Presentation Layer (State Only):**
    * **Strict Freezed Usage:** You must define `AuthEvent` and `AuthState` as **Freezed Unions** (Sealed Classes).
        * *Example:* `const factory AuthState.authenticated(UserModel user) = _Authenticated;`
    * Create the `AuthBloc` that handles events and emits states.
    * **Add Logic:** Handle `AuthResetPasswordRequested` and `AuthDeleteAccountRequested`.
    * **Constraint:** Do NOT create a `LoginScreen` or any UI widgets. This will be handled by a separate UI agent later.


## Response Constraints:
* **Error Handling:** Use standard `try/catch` blocks.
* **Formatting:** Do not use LaTeX. Use strictly formatted Markdown for code blocks.