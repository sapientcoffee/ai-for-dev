#!/usr/bin/env bash

# Read hook input from stdin
INPUT=$(cat)

# Extract tool name and file path
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name')
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# If FILE_PATH is empty, try to get it from tool_response (though usually in tool_input)
if [ -z "$FILE_PATH" ] || [ "$FILE_PATH" == "null" ]; then
    # Some tools might have different structures, but for write_file/replace it's in tool_input
    FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.path // empty')
fi

# Only lint files in linter-demo/ and only for file modification tools
if [[ "$FILE_PATH" == *"linter-demo/"* ]] && [[ "$TOOL_NAME" =~ ^(write_file|replace|edit_file)$ ]]; then
    # Run the linter
    LINT_OUTPUT=$(node linter-demo/lint.js "$FILE_PATH" 2>&1)
    LINT_EXIT_CODE=$?

    if [ $LINT_EXIT_CODE -ne 0 ]; then
        # Linting failed, deny the tool execution result and provide the error message
        MESSAGE=$(echo "Linting failed for $FILE_PATH:\n$LINT_OUTPUT" | jq -Rsa .)
        echo "{\"decision\": \"deny\", \"message\": $MESSAGE}"
        exit 0
    fi
fi

# Allow the tool execution to proceed normally
echo '{"decision": "allow"}'
exit 0
