# Security Policy

## Reporting a Vulnerability

This project bootstraps a real development machine and runs several steps
with `sudo`. If you find a security issue — in `bootstrap.sh`, an installer,
or a script it downloads and executes — please report it privately instead
of opening a public issue.

Use GitHub's private vulnerability reporting for this repository:
**Security > Advisories > Report a vulnerability**
(https://github.com/shuntps/dev-workstation/security/advisories/new).

Please include:

- the affected file or installer;
- steps to reproduce;
- the potential impact (e.g. arbitrary code execution, privilege escalation,
  unintended system changes).

This is a solo-maintained project, so there's no fixed response-time SLA,
but security reports take priority over regular feature work.

## Supported Versions

Only the latest release is supported. Re-run `./bootstrap.sh` (or
`task bootstrap`) from the latest `main` to pick up fixes.
