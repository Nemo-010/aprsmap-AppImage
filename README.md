<div align="center">

# APRSMap AppImage 🐧

[![CI Build Status](https://github.com/Nemo-010/aprsmap-AppImage/actions/workflows/appimage.yml/badge.svg)](https://github.com/Nemo-010/aprsmap-AppImage/releases/latest)
[![Latest Stable Release](https://img.shields.io/github/v/release/Nemo-010/aprsmap-AppImage)](https://github.com/Nemo-010/aprsmap-AppImage/releases/latest)

| Latest Stable Release | Upstream URL |
| :---: | :---: |
| [Click here](https://github.com/Nemo-010/aprsmap-AppImage/releases/latest) | [Click here](https://github.com/andreaspeters/aprsmap) |

</div>

---

Unofficial AppImage of [APRSMap](https://github.com/andreaspeters/aprsmap), the
cross-platform APRS client, built from source with Free Pascal/Lazarus and the
Qt6 widgetset.

AppImage made using [quick-sharun](https://github.com/pkgforge-dev/Anylinux-AppImages/blob/main/useful-tools/quick-sharun.sh), which makes it extremely easy to turn any binary into a portable package reliably without using containers or similar tricks.

**This AppImage bundles everything and it should work on any Linux distro, including old and musl-based ones.**

This AppImage doesn't require FUSE to run at all, thanks to the [uruntime](https://github.com/VHSgunzo/uruntime).

This AppImage is also supplied with a self-updater by default, so any updates to this application won't be missed, you will be prompted for permission to check for updates and if agreed you will then be notified when a new update is available.

Self-updater is disabled by default if AppImage managers like [am](https://github.com/ivan-hc/AM), [soar](https://github.com/pkgforge/soar) or [dbin](https://github.com/xplshn/dbin) exist, which manage AppImage updates.

## Building

Only `x86_64` is built. Arch Linux ARM still ships an ancient Lazarus (2022)
without a Qt6 widgetset, so `aarch64` is disabled until that changes.

The application is compiled from the latest upstream release tag (or from
`master` for the nightly workflow) and then installed to `/usr` before
`quick-sharun` deploys it. Do not build this anywhere except Arch Linux, and
install the application to `/usr` before deploying it.

## RTL-SDR

`librtlsdr` is bundled, but the `rtl-sdr` udev rules cannot be installed by an
AppImage, so non-root access to a dongle still needs those rules on the host
(most distros ship them in their `rtl-sdr` package).

---

More at: [AnyLinux-AppImages](https://pkgforge-dev.github.io/Anylinux-AppImages/)
