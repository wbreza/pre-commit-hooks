# Detect Secrets

Installs the [Yelp! detects-secrets](https://github.com/yelp/detect-secrets) pre-commit hook into your existing Git repo.
Starting a new project from scratch? Check out the [baseline security template](https://github.com/wbreza/baseline-security-seed) which provides the same functionality plus support for dev containers and includes an integrates Github workflow.

## Configuring the Repo

Run the setup script from the root of your git repo.

```bash
# Downloads and executes the setup script in a single command
curl -s https://raw.githubusercontent.com/wbreza/pre-commit-hooks/main/detect-secrets/scripts/setup.sh | bash
```

> Not comftable executing a remote script?  I get it.  Feel free to review it [here](https://github.com/wbreza/pre-commit-hooks/blob/dev/detect-secrets/scripts/setup.sh).

The setup script performs the following:

- Creates and activates a python virtual environment required by the tools
- Downloads [required assets](https://github.com/wbreza/pre-commit-hooks/tree/main/detect-secrets) such as pre-commit configuration, secrets baseline and an empty word list as well as a set of helper scripts that you team use.
- Installs the pre-commit framework
- Configures the [pre-commit framework](https://www.pre-commit.com) with the Yelp! [detect-secrets](https://github.com/yelp/detect-secrets) hook

> Commit the new changes (including the `scripts/detect-secrets` folder) into your repo mainline branch

## Local Developer Setup

After your repo has been initialized all developer on your team will need to setup their development environment

```bash
# Install and configures the pre-commit hook
./scripts/detect-secrets/init.sh
```

**That's it** - Your git tooling will now run the secret detection on all future commits. 

## Getting Started

At this point your repo may already contain data that may be flagged as sensitive by the the secret scan.
The `setup` script installs a few example scripts that you can use to scan, audit and report on detected secrets in code.
These scripts simplify the complexity of managing and activating the dependent python virtual environments for you.

> For complete control of your secret detection process review the [full usage documentation](https://github.com/yelp/detect-secrets#usage).

### Common Issues

Depending on the set of technologies included in your repo you may run into some of these common scenarios:

**Catching secret like strings such as hashes in `package-lock.json`**

In this case you can exclude these files from scanning by setting the `exclude` parameter in yoru `.pre-commit-config.yaml` file.
The `exclude` parameter expects a regular expression as a value.

### Generate a baseline of all flagged items

The `scan` script performs a full scan against your full repo and updates the `.secrets.baseline` file with findings.
This will allow your current baseline to then be audited to identify and prioritize items to be mitigated.
At this point in time detected secrets in the baseline will not prevent commits from completing

```bash
# Calls the `detect-secrets scan --baseline .secrets.baseline` command
./scripts/detect-secrets/scan.sh
```

### Audit your baseline to identify REAL issues vs false positives

The `scan` script will launch a process and walk you through each identified results. 
At this point you will have the option to identify whether each result is a real issue or a false positive.

```bash
# Calls the `detect-secrets audit .secrets.baseline` command
./scripts/detect-secrets/scan.sh
```

### Report on your baseline

The `report` script will generate a report of all REAL issues that have been identified by your most recent audit.
It is your teams responsibility to prioritize and mitigate the items before they become a larger issue within your organization.

```bash
# Calls the `detect-secrets audit --report --only-real .secrets.baseline` command
./scripts/detect-secrets/report.sh
```

### Scan staged files

The `check` script will scan all git staged files.
This is the same command that is run via the pre-commit hook in a ad-hoc script

```bash
# Calls the `detect-secrets-hook --baseline .secrets.baseline` command
./scripts/detect-secrets/check.sh
```

## Uninstalling

Changed your mind and no longer want to use the detect-secrets pre-commit hook?
Just execute the `uninstall.sh` script that was downloding during the setup process.
This will uninstall the pre-commit hook from your git repo.
You can now safely delete the scripts or other configuration files.

```bash
./scripts/detect-secrets/uninstall.sh
```

> You will manually need to remove any pre-commit or detect-secrets configuration files if you no longer need them.