---
name: api_docs_generator
description: A skill for discovering, extracting, and documenting HTTP API endpoints from source code to create ready-to-use documentation.
---

# API Documentation Generator Skill

This skill provides a systematic approach to generating high-quality API documentation suitable for direct integration by developers.

## Prerequisites

- Access to the source code where HTTP routes are defined (e.g., `main.go`, `server.go`, `routes.js`).
- Knowledge of the authentication mechanism used in the project.

## Procedure

### 1. Discovery Phase
- **Identify Entry Points**: Search the codebase for HTTP route registrations (e.g., `http.HandleFunc`, `mux.HandleFunc`, `app.get`).
- **Map Endpoints**: List all discovered endpoints, methods, and their associated handler functions.
- **Identify Authentication**: Determine which endpoints are protected and how (e.g., Middleware, Decorators, session checks).

### 2. Extraction Phase
For each endpoint discovered:
- **Trace the Handler**: Read the handler function to find:
    - **Methods**: GET, POST, PUT, DELETE, etc.
    - **Path Parameters**: e.g., `:id`, `{name}`.
    - **Query Parameters**: Read from the request URL.
    - **Request Body**: Identify the JSON struct or data format being decoded.
    - **Headers**: Check for specific header requirements (e.g., `Content-Type`, `Authorization`).
- **Identify Responses**:
    - **Success Scenarios**: Locate the success response status code and payload structure.
    - **Error Scenarios**: Note down common error codes (400, 401, 404, 500) and error message formats.

### 3. Documentation Phase
Format the gathered information into a Markdown document (e.g., `docs/api.md`) following these standards:

- **Authentication Overview**: Clear instructions on how to authenticate.
- **Endpoint Structure**:
    - **Method and URL**: Bolded at the top.
    - **Description**: Concise explanation of what the endpoint does.
    - **Parameter Table**: Includes Field Name, Type, Mandatory (Y/N), and Description.
    - **Examples**: code blocks for request payloads and response bodies.
- **Special Types**: Document non-JSON responses like SSE (Server-Sent Events) or raw text.

### 4. Verification
- **Validate against Code**: Cross-check the final documentation with the actual code logic one last time.
- **User Review**: Present the documentation for feedback on clarity and completeness.

## Best Practices
- **Use Tables**: Tables are easier to scan for parameter details.
- **Show, Don't Just Tell**: Provide realistic JSON examples for every POST/PUT request.
- **Consistency**: Use consistent naming and formatting throughout the document.
