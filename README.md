# Pre-Commit Hooks

This project includes a set of scripts and configuration to configure your projects with support for git pre-commit hooks leveraging the [pre-commit framework](https://www.pre-commit.com).

## Prerequisites

- [Python 3.8+](https://www.python.org/downloads/)
- Your favorite bash shell

## Detect Secrets

Installs the [Yelp! detects-secrets](https://github.com/yelp/detect-secrets) pre-commit hook into your existing Git repo.
Starting a new project from scratch? Check out the [baseline security template](https://github.com/wbreza/baseline-security-seed) which provides the same functionality plus support for dev containers and includes an integrates Github workflow.

[Learn More](detect-secrets/README.md)