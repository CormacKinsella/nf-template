# Changelog

## [Unreleased]

### Planned

- Add in nf-core igenomes config when needed

- Add help message approach from nf-core style rather than println method


<!-- RELEASE HISTORY -->

## [1.2.0] - 2025-02-28

- Migrated to codespaces vs gitpod for remote development

- Updated base image (added wave, stripped out shell setup (done via `dotfiles` repo), moved some installs to pixi)

## [1.1.0] - 2025-02-27

### Added

- Pipeline email report on completion

- Docker dir for building base image, hosted on GitHub instead of DockerHub

### Dependencies

- Default `pixi.toml` installs `graphviz` and `msmtp-sendmail` for dag diagrams and emailing respectively

## [1.0.0] - 2025-02-19

### Added

- Initial version of the template

### Dependencies

- pixi
