<!-- omit in toc -->
# go-ci

Tooling for linting, testing and building Go applications

[![Latest Release](https://img.shields.io/github/release/atc0005/go-ci.svg?style=flat-square)](https://github.com/atc0005/go-ci/releases/latest)
[![Project Analysis](https://github.com/atc0005/go-ci/actions/workflows/project-analysis.yml/badge.svg)](https://github.com/atc0005/go-ci/actions/workflows/project-analysis.yml)
[![Build images](https://github.com/atc0005/go-ci/actions/workflows/build-images.yml/badge.svg)](https://github.com/atc0005/go-ci/actions/workflows/build-images.yml)

<!-- omit in toc -->
## Table of contents

- [Project home](#project-home)
- [Overview](#overview)
- [Linting tools included](#linting-tools-included)
- [Docker images](#docker-images)
  - [`go-ci-stable`](#go-ci-stable)
  - [`go-ci-stable-alpine-buildx86`](#go-ci-stable-alpine-buildx86)
  - [`go-ci-stable-alpine-buildx64`](#go-ci-stable-alpine-buildx64)
  - [`go-ci-stable-cgo-mingw-w64-build`](#go-ci-stable-cgo-mingw-w64-build)
  - [`go-ci-mirror-build-*`](#go-ci-mirror-build-)
  - [`go-ci-oldstable-mirror-build`](#go-ci-oldstable-mirror-build)
  - [`go-ci-stable-mirror-build`](#go-ci-stable-mirror-build)
  - [`go-ci-oldstable`](#go-ci-oldstable)
  - [`go-ci-unstable`](#go-ci-unstable)
- [Examples / How to use these images](#examples--how-to-use-these-images)
- [Changelog](#changelog)
- [Requirements](#requirements)
- [References](#references)

## Project home

See [our GitHub repo](https://github.com/atc0005/go-ci) for the latest
content, to file an issue or submit improvements for review and potential
inclusion into the project.

See these container image registries for the full listing of available images:

- [GitHub repo](https://github.com/atc0005/go-ci/pkgs/container/go-ci)
- [Docker Hub repo](https://hub.docker.com/r/atc0005/go-ci)

## Overview

A mix of GitHub Actions / CI focused Docker container images primarily
intended to simplify linting/testing/building other Go projects that I
maintain. I am developing the content in the open in case it is useful to
others.

## Linting tools included

| Linter                                                                | Version                              |
| --------------------------------------------------------------------- | ------------------------------------ |
| [`staticcheck`](https://github.com/dominikh/go-tools)                 | `2023.1.1` (`v0.4.1`)                |
| [`golangci-lint`](https://github.com/golangci/golangci-lint)          | `v1.51.1`                            |
| [`govulncheck`](https://pkg.go.dev/golang.org/x/vuln/cmd/govulncheck) | `v0.0.0-20230213165600-1a019b0c7f30` |
| [`orijtech/httperroryzer`](https://github.com/orijtech/httperroryzer) | `v0.0.1`                             |
| [`orijtech/structslop`](https://github.com/orijtech/structslop)       | `v0.0.7`                             |
| [`pelletier/go-toml`](https://github.com/pelletier/go-toml)           | `v2.0.6`                             |
| [`fatih/errwrap`](https://github.com/fatih/errwrap)                   | `v1.4.0`                             |

## Docker images

See these container image registries for the full listing of available images:

- [GitHub repo](https://github.com/atc0005/go-ci/pkgs/container/go-ci)
- [Docker Hub repo](https://hub.docker.com/r/atc0005/go-ci)

### `go-ci-stable`

- built from the latest version of the current stable `golang` image.
- used for building Go applications, both directly and via `Makefile` builds.
- intended for use in a build/test matrix of prior, current and upcoming Go
  releases
- provides multiple linters
  - see [Linting tools included](#linting-tools-included)

### `go-ci-stable-alpine-buildx86`

- based on the latest version of the current stable `i386/golang` `alpine`
  image.
- used for building Go applications, both directly and via `Makefile` builds.
- uses [musl libc](https://musl.libc.org/) instead of
  [glibc](https://www.gnu.org/software/libc/)
  - see [Comparison of C/POSIX standard library implementations for
    Linux](https://www.etalabs.net/compare_libcs.html)
- supports cross-platform, static cgo-enabled builds for Windows and Linux
  - Windows 32-bit: `i686-w64-mingw32-gcc`
  - Windows 64-bit: `x86_64-w64-mingw32-gcc`
- does not include linters

### `go-ci-stable-alpine-buildx64`

- same as `go-ci-stable-alpine-buildx86`, but specific to x64 architecture
- does not include linters

### `go-ci-stable-cgo-mingw-w64-build`

- built from the latest version of the current stable `golang` image.
- used for building Go applications, both directly and via `Makefile` builds.
- supports cross-platform, static cgo-enabled builds for Windows and Linux
  - Windows 32-bit: `i686-w64-mingw32-gcc`
  - Windows 64-bit: `x86_64-w64-mingw32-gcc`
- does not include linters

### `go-ci-mirror-build-*`

- built from the latest version of the `golang` image for that series
  - e.g., the `go-ci-mirror-build-go1.14` image is built from the final
    release version in the 1.14 series (1.14.15)
- intended to mirror the upstream `golang` image for Makefile-driven testing,
  linting and build tasks.
- few (if any) customizations are intended for this image, instead relying on
  a project's Makefile or other build tool to setup the environment for tasks
  such as testing, linting & building source code
- does not include linters

These images are intended to assist with asserting that projects build with
the latest version in a specific series.

### `go-ci-oldstable-mirror-build`

- built from the latest version of the `golang` image for the `oldstable`
  series
  - e.g., if the latest `oldstable` version of the Go toolchain is 1.19.6 and
    1.20.1 is the latest in the `stable` series, the
    `go-ci-oldstable-mirror-build` image will refer to the 1.19.6 image
- intended to mirror the latest `oldstable` (outgoing) upstream `golang`
  image for Makefile-driven testing, linting and build tasks.
- few (if any) customizations are intended for this image, instead relying on
  a project's Makefile or other build tool to setup the environment for tasks
  such as testing, linting & building source code
- does not include linters

These images are intended to assist with asserting that projects build with
the latest version in the outgoing stable (aka, `oldstable`) series.

### `go-ci-stable-mirror-build`

- built from the latest version of the `golang` image for the current `stable`
  series
  - e.g., if the latest `oldstable` version of the Go toolchain is 1.19.6 and
    1.20.1 is the latest in the `stable` series, the
    `go-ci-stable-mirror-build` image will refer to the 1.20.1 image
- intended to mirror the latest `stable` (current) upstream `golang` image for
  Makefile-driven testing, linting and build tasks.
- few (if any) customizations are intended for this image, instead relying on
  a project's Makefile or other build tool to setup the environment for tasks
  such as testing, linting & building source code
- does not include linters

These images are intended to assist with asserting that projects build with
the latest version in the current stable series.

### `go-ci-oldstable`

- built from the latest version of the current outgoing stable `golang` image.
- used for building Go applications, both directly and via `Makefile` builds.
- intended for use in a build/test matrix of prior, current and upcoming Go
  releases
- provides multiple linters
  - see [Linting tools included](#linting-tools-included)

### `go-ci-unstable`

- built from the latest available non-stable `golang:beta` image, `golang:rc`
  image *or* if not recently available, the latest stable `golang` image
  - intended to test whether new Go versions break existing code or surface
    problems in existing code that current Go releases do not
- used for building Go applications, both directly and via `Makefile` builds
- intended for use in a build/test matrix of prior, current and upcoming Go
  releases
- provides multiple linters
  - see [Linting tools included](#linting-tools-included)
- used to test new or additional `golangci-lint` linters prior to inclusion in
  the `stable` and `oldstable` container image variants
  - new linters as a whole may be added to multiple image variants, not just
    this image unless it is suspected that the new linters are highly
    experimental/unstable

## Examples / How to use these images

For real-world examples of how these images are used, please see the workflows for these projects:

- <https://github.com/atc0005/check-mail/blob/master/.github/workflows>
- <https://github.com/atc0005/dnsc/tree/master/.github/workflows>
- <https://github.com/atc0005/mysql2sqlite/tree/master/.github/workflows>

## Changelog

See the [`CHANGELOG.md`](CHANGELOG.md) file for the changes associated with
each release of this application. Changes that have been merged to `master`,
but not yet an official release may also be noted in the file under the
`Unreleased` section. A helpful link to the Git commit history since the last
official release is also provided for further review.

## Requirements

- Docker
  - for building images
- `make`
  - if using the provided `Makefile`

## References

- Linting
  - Primary
    - [staticcheck](https://github.com/dominikh/go-tools)
    - [golangci-lint](https://github.com/golangci/golangci-lint)
    - [govulncheck](https://pkg.go.dev/golang.org/x/vuln/cmd/govulncheck)
  - Additional
    - [orijtech/httperroryzer](https://github.com/orijtech/httperroryzer)
    - [orijtech/structslop](https://github.com/orijtech/structslop)
    - [pelletier/go-toml](https://github.com/pelletier/go-toml)
    - [fatih/errwrap](https://github.com/fatih/errwrap)

- Images
  - <https://fabianlee.org/2020/01/26/golang-using-multi-stage-builds-to-create-clean-docker-images/>
  - <https://hub.docker.com/r/golangci/golangci-lint>
  - <https://hub.docker.com/_/golang>
