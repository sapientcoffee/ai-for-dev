# Linter Demo: Gemini CLI AfterTool Hooks

This directory contains a demo of how to integrate a custom linter into the Gemini CLI workflow using an `AfterTool` hook.

## Architecture

1.  **Custom Linter (`lint.js`)**: A simple Node.js script that uses regex to check for linting violations (e.g., `console.log`, `var`).
2.  **AfterTool Hook (`.gemini/hooks/run-linter.sh`)**: A bash script that the Gemini CLI executes after any tool that modifies files (`write_file`, `replace`, `edit_file`).
3.  **Settings (`.gemini/settings.json`)**: Configures the CLI to run the hook script whenever a file in `linter-demo/` is modified.

## How it Works

When the Gemini CLI successfully modifies a file, it checks `.gemini/settings.json` for any matching `AfterTool` hooks.
Our hook:
1.  Intercepts the tool result.
2.  Runs `node linter-demo/lint.js` on the modified file.
3.  If the linter finds errors, the hook returns a `{"decision": "deny"}` response with the error details.
4.  The CLI then presents this "failure" back to the model, effectively preventing it from leaving the codebase in an invalid state.

## Rules

Current linting rules:
- **No `console.log`**: Forbids the use of `console.log`.
- **No `debugger`**: Forbids the use of `debugger` statements.
- **No `var`**: Forces the use of `let` or `const`.

## Guided Command

You can use the custom command `/linter-demo:add-rule` to add new rules to this linter. It will guide you through updating the linter logic, documentation, and verifying the new rule with a test violation.

### Example
`/linter-demo:add-rule forbid the use of the word 'TODO'`
