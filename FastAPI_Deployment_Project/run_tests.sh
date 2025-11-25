#!/bin/bash

source venv/bin/activate

echo "Running tests using pytest..."
pytest --maxfail=1 --disable-warnings -q
exit $?
