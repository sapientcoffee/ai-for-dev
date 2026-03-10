function greet(name) {
    const message = `Hello, ${name}!`;
    return message;
}

const user = 'World';
const greeting = greet(user);

// This is a clean file with no linting errors.
// Try adding a console.log or using 'var' to trigger the linter.
