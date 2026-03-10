const fs = require('fs');
const path = require('path');

const filePath = process.argv[2];

if (!filePath) {
    console.error('No file path provided');
    process.exit(1);
}

const content = fs.readFileSync(filePath, 'utf8');

const rules = [
    {
        pattern: /console\.log/g,
        message: "Unexpected 'console.log' statement."
    },
    {
        pattern: /debugger/g,
        message: "Unexpected 'debugger' statement."
    },
    {
        pattern: /var\s+/g,
        message: "Use 'let' or 'const' instead of 'var'."
    }
];

let errors = [];

rules.forEach(rule => {
    let match;
    while ((match = rule.pattern.exec(content)) !== null) {
        const lines = content.substring(0, match.index).split('\n');
        const line = lines.length;
        const column = lines[lines.length - 1].length + 1;
        errors.push(`${line}:${column} - ${rule.message}`);
    }
});

if (errors.length > 0) {
    console.error('Linting errors found:');
    errors.forEach(err => console.error(err));
    process.exit(1);
}

console.log('Linting passed.');
process.exit(0);
