## What & why

Briefly describe the change and the problem it solves.

## Checklist

- [ ] One focused change per PR (no unrelated fixes bundled in)
- [ ] Commit messages follow Conventional Commits (`feat:`, `fix:`, `refactor:`, ...)
- [ ] New/changed installers follow the `dw::installer::<name>::installed/install/configure` contract
- [ ] `task lint` and `task format` pass locally
- [ ] Tested by actually running `./bootstrap.sh` on WSL Ubuntu (not just read through)
