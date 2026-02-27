# Coffee Mood App - SDD Demo

Pre-req
* Playwright CLI
* Gemini CLI 


This repository is structured to demonstrate the Spec-Driven Development (SDD) workflow using the Gemini CLI.

## Workflow Steps





1. **Ideation**


2. **Generate PRD**: Convert `docs/raw-ideas.txt` into a structured `docs/PRD.md` by running the command found inside `docs/PRD.md`.

```bash
@product-owner Draft a prd and user stories for a web app that has ideation in @ideation/raw-ideas.txt. Output the prd to docs/prd/mvp-prd.md 
```

3. **Generate User Stories**: Run `scripts/create-issues.sh` to extract user stories from the PRD and create GitHub issues.
```bash
/create-issues @docs/prd/mvp-prd.md

```

4. **Define the Specification (spec.md)**: 
```bash
Take one GitHub issue and expand it into a strict specification. Create specs/feature-#-<feature-name>.md:
```


5. **Create Technical Plan (plan.md)**: 

```bash
Read GEMINI.md for tech stack rules. Then read @specs/feature-1-mood-selector.md . Plan an implementation. Finally, review your plan against the Acceptance Checklist in the spec.
```

6. **Implement Features**: Use the specs in `specs/` to generate code, like `components/MoodSelector.tsx`.
```bash
gemini -p "Read spec.md and plan.md, then implement and verify it against the acceptance checklist."
```

7. **Validate**
```bash
test the web app with /playwright
```