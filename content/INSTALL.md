---
title: "Install secureblue"
short_title: "Install"
description: "Steps to install secureblue"
permalink: /install
---

The recommended method to install secureblue is to first install a Fedora Atomic ISO and then rebase to a secureblue image, or to first install Fedora CoreOS if you want to use securecore server images. Unless specified otherwise, secureblue is used to refer to both the secureblue set of images and the securecore set of images, for the sake of brevity. The install script presented in a later step lets you choose between them.

Following the recommended method, you *must not* rebase from a Fedora Atomic Desktop install to securecore, or from a Fedora CoreOS install to secureblue, or from secureblue to securecore or vice-versa.

# Pre-installation

The following is advice on what to do before and during the installation of a Fedora ISO, and how.

> {% include alert.html type='note' content='The cross-platform Fedora Media Writer is the <em>official, tested and supported</em> method for the creation of bootable media. Instructions (alongside a word on alternative methods) are available <a href="https://docs.fedoraproject.org/en-US/fedora/latest/preparing-boot-media/">here</a>.' %}

> {% include alert.html type='tip' content='If you don\'t already have a Fedora Atomic installation, use a Fedora Atomic ISO that matches your secureblue target image to install one. If you want to use a secureblue Silverblue image, start with the Fedora Silverblue ISO, Kinoite for Kinoite, Sericea (Sway Atomic) for Sericea and all the Wayblue images, and CoreOS for all the securecore images.

For more details on the available images, have a look at the <a href="/images">list of available images</a> before proceeding.' %}

> {% include alert.html type='caution' content='The Fedora 41 ISO contains a bugged version of rpm-ostree. As such, after using it to install Fedora Atomic, you <em>must</em> run rpm-ostree upgrade and then restart, before running the secureblue installer.' %}

Before rebasing and during the installation, the following checks are recommended.

## Fedora installation
- Select the option to encrypt the drive you're installing to.
- Use a [strong password](https://security.harvard.edu/use-strong-passwords) when prompted.
- Leave the root account disabled.
- Select wheel group membership for your user.

## BIOS hardening
- Ensure secureboot is enabled.
- Ensure your BIOS is up to date by checking its manufacturer's website.
- Disable booting from USB (some manufacturers allow firmware changes from live systems).
- Set a BIOS password to prevent tampering.

# Installation (rebasing)

To rebase a Fedora Atomic or Fedora CoreOS installation to a secureblue image, download the script below. This script does not install secureblue into the existing system. It rebases (fully replaces the existing system) with secureblue.

[![Download](https://shields.io/badge/-Download-blue?style=for-the-badge&logo=download&logoColor=white)](https://github.com/secureblue/secureblue/releases/latest/download/install_secureblue.sh)

Then, run it from the directory you downloaded it to:

```
bash install_secureblue.sh
```

# Post-install

After installation, [yafti](https://github.com/ublue-os/yafti) will open. Make sure to follow the steps listed carefully and read the directions closely.

Then follow the [post-install instructions](/post-install).