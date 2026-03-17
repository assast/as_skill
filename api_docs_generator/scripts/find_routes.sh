#!/bin/bash

# Simple script to find potential HTTP routes in the codebase
echo "Searching for HTTP route registrations..."
grep -rE "HandleFunc|GET|POST|PUT|DELETE|router" . --exclude-dir={.git,node_modules,vendor,bin} | grep -v ".md"
