"""Fails if a component step's commands are not plain strings.

An unquoted command containing ": " parses as a YAML map, which Image Builder
only rejects at apply time ("cannot unmarshal map into string").
"""
import glob
import sys

import yaml

errors = []
for path in sorted(glob.glob("components/*.yml")):
    with open(path) as f:
        document = yaml.safe_load(f)
    for phase in document["phases"]:
        for step in phase["steps"]:
            inputs = step.get("inputs")
            if isinstance(inputs, dict):
                for i, command in enumerate(inputs.get("commands", [])):
                    if not isinstance(command, str):
                        errors.append(f"{path}: step {step['name']}, command {i}: quote it ({command!r})")

for error in errors:
    print(f"::error::{error}")
sys.exit(1 if errors else 0)
