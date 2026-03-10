# Objective
Create a comprehensive demo in the `linter-demo/` directory that showcases how to integrate an `AfterTool` hook in the Gemini CLI. The hook will automatically run a linter whenever a file is modified. The demo will include a simple application, hook configuration, thorough documentation, and a custom Gemini CLI command to guide users through adding new lint rules.

# Key Files & Context
- `linter-demo/index.js`: A simple demo application that we will modify to trigger the linter.
- `linter-demo/lint.js`: A custom, lightweight Node.js linter script to check for specific code patterns (avoids npm package resolution issues and keeps the demo self-contained).
- `.gemini/settings.json`: Configuration file to register the `AfterTool` hook for file modification tools.
- `.gemini/hooks/run-linter.sh`: The bash script executed by the hook. It will parse the tool input, run the custom linter, and return a decision to the CLI.
- `linter-demo/README.md`: Documentation explaining the architecture and usage of the demo.
- `.gemini/commands/linter-demo/add-rule.toml`: A custom Gemini CLI command providing a guided experience for adding new rules to our custom linter.

# Implementation Steps

## 1. Create the Custom Linter & Demo App
- **Linter Script (`linter-demo/lint.js`):** Create a basic Node script that reads a file path as an argument, checks its content against an array of rules (e.g., forbidding `console.log` or `debugger`), and exits with a non-zero code if violations are found.
- **Demo App (`linter-demo/index.js`):** Create a simple "Hello World" style JS file that currently passes the initial linting rules.

## 2. Implement the AfterTool Hook
- **Hook Script (`.gemini/hooks/run-linter.sh`):** Write a bash script that:
  - Reads the incoming JSON payload from `stdin`.
  - Extracts the tool name and `file_path` from `tool_input` using `jq` or basic grep/sed.
  - Skips linting if the file is outside `linter-demo/`.
  - Executes `node linter-demo/lint.js <file_path>`.
  - If the linter fails, outputs `{"decision": "deny", "message": "Linting failed: [errors]"}`.
  - If the linter passes, outputs `{"decision": "allow"}`.
- Make the script executable (`chmod +x`).

## 3. Register the Hook
- **Settings (`.gemini/settings.json`):** Add an `AfterTool` hook configuration matching tools like `write_file`, `replace`, and `edit_file`. Point the `command` to execute our bash script.

## 4. Create the Custom Command
- **Command Definition (`.gemini/commands/linter-demo/add-rule.toml`):** Create a command with a specialized prompt. The prompt will act as a persona guiding the Gemini CLI to:
  - Analyze the user's requested new lint rule.
  - Implement the rule in `linter-demo/lint.js`.
  - Add a test case or update `linter-demo/index.js` to demonstrate the new rule being caught.
  - Update the `README.md` to document the newly added rule.

## 5. Documentation
- **README (`linter-demo/README.md`):** Document:
  - What the `linter-demo` does.
  - How the Gemini CLI `AfterTool` hook is configured and intercepts file writes.
  - Instructions on how to trigger a linting error manually by asking the CLI to add `console.log`.
  - Instructions on how to use the `/linter-demo:add-rule` command.

# Verification & Testing
1. **Hook Execution:** Ask the CLI to modify `linter-demo/index.js` and add a `console.log`. The CLI should attempt the `write_file` or `replace`, and the hook should block the change, returning the lint error to the CLI context.
2. **Command Testing:** Run the new `/linter-demo:add-rule` command (e.g., `/linter-demo:add-rule forbid use of the word 'foo'`) and verify the CLI successfully updates the linter and documentation.
