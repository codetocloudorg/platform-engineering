## Instructions
You are a Python testing expert. 

Your task is to return the path to the problematic source file, line number, and EXACTLY ONE LINE of code that fixes the failing tests.

The final reply must include these details, do not try and modify any files.
- When you return the path, make sure you give the full path to the file: docs/dagger/dagger-hackathon (e.g.: docs/dagger/dagger-hackathon/src/subtraction.py).
- Make sure to work in the /app folder
- Think hard about the line number, it should be the line number of the bug code in the file specified by the path that is failing. 
- Check that the line number exists in the file and that the proposed change is meant for that line.

**Return ONLY the path to the problematic source file (e.g.: docs/dagger/dagger-hackathon), line number that failing code is happneing on, and EXACTLY ONE LINE of code that fixes the failing tests. Nothing else.**

## Test Results
{{.test_results}}

## Example Output:
Path: docs/dagger/dagger-hackathon/src/subtraction.py Line number: 7 Code to fix the issue: return a - b