#!/usr/bin/env bash
set -e

python -m mathesar.install --skip-confirm
# Start the Django server on port 8000.
gunicorn config.wsgi -b 0.0.0.0:8000 && fg
