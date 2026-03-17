---
name: env_editor
description: Implement a dynamic web-based .env editor using Python (FastAPI/Flask) and vanilla JavaScript.
---

# Dynamic .env Web Editor Implementation Guide

This skill documents the architecture and implementation steps for creating a robust, graphical `.env` configuration editor, which allows users to edit environment variables via a dynamic web UI instead of raw text.

## 1. Backend: Parsing the `.env` File

A standard `.env` parser often strips out comments and doesn't handle multiline JSON strings gracefully. To support a powerful editor, you must implement a custom parser that reads the file line-by-line:

### Extracting Comments as Labels
- Aggregate lines starting with `#` into a `description` field.
- When an environment variable (e.g., `FOO=bar`) is encountered, attach the previously aggregated description to it. This allows the frontend to display human-readable labels (e.g., Chinese descriptions) next to the input fields.

### Handling Multiline JSON Strings
- Detect opening quotes (`'` or `"`). If a line contains an unclosed quote, enter a multiline parsing state.
- Continually append subsequent lines to the current value until the matching closing quote is found.
- Ensure the backend properly identifies nested JSON arrays (e.g., `DOMAIN_CONFIGS='[{"domain":"foo"}]'`).

## 2. Backend: Saving the Configuration

When writing changes from the UI back to the `.env` file, the backend must update values while **preserving all existing comments and structure**.

- Read the existing `.env` file line-by-line.
- If a line is a comment or an unmodified key, write it as-is.
- If a line matches a key updated in the UI, write `KEY=new_value`.
- **CRITICAL**: If the old value was a multiline string, you must implement a "skip state" to actively ignore the remaining trailing lines of the old multiline value, otherwise you will corrupt the file by appending duplicate chunks of the old configuration below the new one.

## 3. Frontend: Dynamic Form Generation

The UI should dynamically generate input fields based on a schema (often derived from `.env.example`).

- **Booleans**: Render `<select>` dropdowns for `true`/`false`.
- **Enums**: If a variable has predetermined options (like `MAIL_PROVIDER`), render a hardcoded `<select>` dropdown.
- **Strings/Numbers**: Render standard `<input type="text">` or `<input type="number">`.
- **Complex Nested JSON (Dynamic Sub-Forms)**:
  - For list arrays (e.g., `DOMAIN_CONFIGS`), parse the stringified JSON into a JavaScript object.
  - Create a container and loop through the array to generate a visible UI block (a "Sub-Form") for each item.
  - Form items should include text inputs for key fields (e.g., `domain`) and multi-line inputs for nested lists (e.g., `proxy_list`).
  - **Dynamic Elements**: Each sub-item and nested list item should have a `Delete [X]` button. The bottom of the list should have a `+ Add Item` button that generates a blank template. Providing a `Copy` button next to an item to quickly duplicate complex configurations is highly recommended.

## 4. Frontend: Serializing Complex Data

When the user clicks "Save", the frontend must serialize the regular inputs and heavily format the complex sub-forms:
- Query all `.domain-item` wrappers.
- Map the internal input values into structured Javascript objects.
- `JSON.stringify` the object array, and explicitly wrap the entire string in single quotes (`'...'`) so it remains a valid multiline string for the `.env` syntax.

## 5. View Modes

Always provide a fallback `Raw View` textarea alongside the `Form View`. This gives power users an escape hatch to directly edit the `.env` text without restrictions.
