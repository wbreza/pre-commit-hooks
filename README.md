# Pre-Commit Hooks

This project includes a set of scripts and configuration to configure your projects with support for git pre-commit hooks leveraging the [pre-commit framework](https://www.pre-commit.com).

## Prerequisites

- [Python 3.8+](https://www.python.org/downloads/)
- Your favorite bash shell

## Detect Secrets

Installs the [Yelp! detects-secrets](https://github.com/yelp/detect-secrets) pre-commit hook into your existing Git repo.
Starting a new project from scratch? Check out the [baseline security template](https://github.com/wbreza/baseline-security-seed) which provides the same functionality plus support for dev containers and includes an integrates Github workflow.

### Installing

Run the setup script from the root of your git repo.

```bash
# Downloads and executes the setup script in a single command
curl -s https://raw.githubusercontent.com/wbreza/pre-commit-hooks/main/detect-secrets/scripts/setup.sh | bash
```

> Not comftable executing a remote script?  I get it.  Feel free to review it [here](https://github.com/wbreza/pre-commit-hooks/blob/dev/detect-secrets/scripts/setup.sh).

The setup script performs the following:

- Creates and activates a python virtual environment required by the tools
- Downloads [required assets](https://github.com/wbreza/pre-commit-hooks/tree/main/detect-secrets) such as pre-commit configuration, secrets baseline and an empty word list
- Installs the pre-commit framework
- Configures the [pre-commit framework](https://www.pre-commit.com) with the Yelp! [detect-secrets](https://github.com/yelp/detect-secrets) hook

**That's it** - Your git tooling will now run the secret detection on all future commits. 

### Getting Started

At this point your repo may already contain data that may be flagged as sensitive by the the secret scan.

### Uninstalling

Changed your mind and no longer want to use the detect-secrets pre-commit hook?
Just execute the `uninstall.sh` script that was downloding during the setup process.

```bash
./scripts/detect-secrets/uninstall.sh
```

The setup script performs the following:

- Uninstalls the pre-commit framework
- Cleans up the pre-commit environment

> You will manually need to remove any pre-commit or detect-secrets configuration files if you no longer need them.