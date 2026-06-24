#!/bin/bash
# Usage: ./run.sh path/to/file.sml
set -e
sml "$1" < /dev/null
