# Coffee Mood App - SDD Demo

This repository is structured to demonstrate the Spec-Driven Development (SDD) workflow using the Gemini CLI.

## Workflow Steps





1. **Ideation**


2. **Generate PRD**: Convert `docs/raw-ideas.txt` into a structured `docs/PRD.md` by running the command found inside `docs/PRD.md`.

```bash
@product-owner Draft a prd and user stories for a web app that has ideation in @ideation/raw-ideas.txt. Output the prd to docs/prd/mvp-prd.md 
```

<!-- ```bash
gemini -p "Draft a concise PRD for a web app that recommends coffee based on the user's mood and includes a 'Coffee Tip of the Day' API endpoint displayed on the homepage." > docs/PRD.md
``` -->

3. **Generate User Stories**: Run `scripts/create-issues.sh` to extract user stories from the PRD and create GitHub issues.
```bash
gemini -p "Read docs/PRD.md and generate 3 actionable User Stories formatted as GitHub Issues. Include Acceptance Criteria."
```

4. **Define the Specification (spec.md)**: 
Take one GitHub issue and expand it into a strict specification. Let's use Issue #2 (Tip of the Day API).

Create specs/feature-2-tip-api.md:

```markdown
# Spec: Tip of the Day API (Issue #2)

## Objective
Create a serverless API endpoint that returns a random coffee tip.

## Implementation Details
- **Route**: `GET /api/tips/daily`
- **Data Source**: A hardcoded array of at least 5 coffee tips (e.g., "Grind beans immediately before brewing," "Water temperature should be between 195 F and 205 F").
- **Response Format**: 
  ```json
  { "success": true, "tip": "The tip text here." }

Acceptance Checklist
[ ] Endpoint is accessible at /api/tips/daily.
[ ] Returns HTTP 200 on success.
[ ] Response matches the required JSON structure.
[ ] Returns a different tip randomly on subsequent requests.
```

5. **Create Technical Plan (plan.md)**: 

```bash
gemini -p "Read GEMINI.md for tech stack rules. Then read specs/feature-2-tip-api.md. Plan an implement of the API endpoint in the correct directory. Finally, review your code against the Acceptance Checklist in the spec."
```

6. **Implement Features**: Use the specs in `specs/` to generate code, like `components/MoodSelector.tsx`.
```bash
gemini -p "Read spec.md and plan.md, then implement the authentication module and verify it against the acceptance checklist."
```

7. **Validate**