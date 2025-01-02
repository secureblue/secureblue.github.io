---
title: "Install | secureblue"
description: "Steps to install secureblue"
permalink: /install
---

# Install

To install secureblue, you will use a Fedora Atomic (or CoreOS, for securecore) ISO to install Fedora Atomic, then rebase to a secureblue image using the installer. Unless specified otherwise, secureblue is used to refer to both the secureblue set of images and the securecore set of images, for the sake of brevity. The install script presented in a later step lets you choose between them. You *must* start from a Fedora Atomic ISO for secureblue desktop images, and *must* start from a Fedora CoreOS ISO for securecore images.

Table of Contents
- [Pre-install](#pre-install)
- - [Fedora installation](#fedora-installation)
- - [BIOS hardening](#bios-hardening)
- [Rebase](#rebase)
- [Post-install](#post-install)

## Pre-install

The following is advice on what to do before and during the installation of a Fedora ISO, and how.

{% include alert.html type='note' content='The cross-platform Fedora Media Writer is the <em>official, tested and supported</em> method for the creation of bootable media. Instructions (alongside a word on alternative methods) are available <a href="https://docs.fedoraproject.org/en-US/fedora/latest/preparing-boot-media/">here</a>.' %}

{% include alert.html type='tip' content='If you don\'t already have a Fedora Atomic installation, use a Fedora Atomic ISO that matches your secureblue target image to install one. If you want to use a secureblue Silverblue image, start with the Fedora Silverblue ISO, Kinoite for Kinoite, Sericea (Sway Atomic) for Sericea and all the Wayblue images, and CoreOS for all the securecore images.<br>For more details on the available images, have a look at the <a href="/images">list of available images</a> before proceeding.' %}

{% include alert.html type='caution' content='The Fedora 41 ISO contains a bugged version of rpm-ostree. As such, after using it to install Fedora Atomic, you <em>must</em> run rpm-ostree upgrade and then restart, before running the secureblue installer.' %}

Before rebasing and during the installation, the following checks are recommended.

### Fedora installation
- Select the option to encrypt the drive you're installing to.
- Use a [strong password](https://security.harvard.edu/use-strong-passwords) when prompted.
- Leave the root account disabled.
- Select wheel group membership for your user.

### BIOS hardening
- Ensure secureboot is enabled.
- Ensure your BIOS is up to date by checking its manufacturer's website.
- Disable booting from USB (some manufacturers allow firmware changes from live systems).
- Set a BIOS password to prevent tampering.

## Rebase

To rebase a Fedora Atomic or Fedora CoreOS installation to a secureblue image, download the script below. This script does not install secureblue into the existing system. It rebases (fully replaces the existing system) with secureblue.

<a class="button" href="https://github.com/secureblue/secureblue/releases/latest/download/install_secureblue.sh">Download secureblue installer</a>

Then, run it from the directory you downloaded it to:

```
bash install_secureblue.sh
```

## Post-install

After installation, [yafti](https://github.com/ublue-os/yafti) will open. Make sure to follow the steps listed carefully and read the directions closely.

Then, follow the following steps in order:

- [Subscribe to secureblue release notifications](#release-notifications)
- [Set NVIDIA-specific kargs if applicable](#nvidia)
- [Enroll secureboot key](#secureboot)
- [Set hardened kargs](#kargs)
- - [32-bit support](#kargs-32-bit)
- - [Force disable simultaneous multithreading](#kargs-smt)
- - [Unstable hardening kargs](#kargs-unstable)
- [Setup USBGuard](#usbguard)
- [GRUB](#grub)
- - [Set a password](#grub-password)
- [Create a separate wheel account for admin purposes](#wheel)
- [Setup system DNS](#dns)
- [Bash environment lockdown](#bash)
- [LUKS TPM2 Unlock](#luks-tpm2)
- [Validation](#validation)
- [Optional: `hardened-chromium` Flags](#hardened-chromium-flags)
- [Read the FAQ](#faq)

### Subscribe to secureblue release notifications
{: #release-notifications}

[FAQ](/faq#releases)

### Set NVIDIA-specific kargs if applicable
{: #nvidia}

If you are using an `nvidia` image, run this after installation:

```
ujust set-kargs-nvidia
```

You may also need this (solves flickering and luks issues on some NVIDIA hardware):

```
rpm-ostree kargs \
    --append-if-missing=initcall_blacklist=simpledrm_platform_driver_init
```

### Enroll secureboot key
{: #secureboot}

```
ujust enroll-secure-boot-key
```

### Set hardened kargs
{: #kargs}

{% include alert.html type='note' content='Learn about the hardening applied by the kargs set by the command below [here](/articles/kargs).' %}

```
ujust set-kargs-hardening
```

This command applies a fixed set of hardened boot parameters, and asks you whether or not the following kargs should *also* be set along with those (all of which are documented in the link above):

#### 32-bit support
{: #kargs-32-bit}

If you answer `N`, or press enter without any input, support for 32-bit programs will be disabled on the next boot. If you run exclusively modern software, chances are likely you don't need this, so it's safe to disable for additional attack surface reduction.

However, there are certain exceptions. A couple common usecases are if you need Steam, or run an occasional application in Wine you'll likely want to keep support for 32-bit programs. If this is the case, answer `Y`.

#### Force disable simultaneous multithreading
{: #kargs-smt}

If you answer `Y` when prompted, simultaneous multithreading (SMT, often called Hyperthreading) will be forcefully disabled, regardless of known vulnerabilities in the running hardware. This can cause a reduction in the performance of certain tasks in favor of security.

#### Unstable hardening kargs
{: #kargs-unstable}

If you answer `Y` when prompted, unstable hardening kargs will be additionally applied, which can cause issues on some hardware, but are stable on other hardware.

### Setup USBGuard
{: #usbguard}

*This will generate a policy based on your currently attached USB devices and block all others, then enable usbguard.*

```
ujust setup-usbguard
```

### GRUB
{: #grub}

#### Set a password
{: #grub-password}

Setting a GRUB password helps protect the device from physical tampering and mitigates various attack vectors, such as booting from malicious media devices and changing boot or kernel parameters.

To set a GRUB password, use the following command. By default, the password will be required when modifying boot entries, but not when booting existing entries.

1. `run0`
2. `grub2-setpassword`

GRUB will prompt for a username and password. The default username is root.

If you wish to password-protect booting existing entries, you can add the `grub_users root` entry in the specific configuration file located in the `/boot/loader/entries` directory.

## Create a separate wheel account for admin purposes
{: #wheel}

Creating a dedicated wheel user and removing wheel from your primary user helps prevent certain privilege escalation attack vectors and password sniffing.

{% include alert.html type='caution' content='If you do these steps out of order, it is possible to end up without the ability to administrate your system. You will not be able to use the <a href="https://linuxconfig.org/recover-reset-forgotten-linux-root-password">traditional GRUB-based method</a> of fixing mistakes like this, either, as this will leave your system in a broken state. However, simply rolling back to an older snapshot of your system, should resolve the problem.' %}

1. `run0`
2. `adduser admin`
3. `usermod -aG wheel admin`
4. `passwd admin`
5. `exit`
6. `reboot`

{% include alert.html type='note' content='We log in as admin to do the final step of removing the user account\'s wheel privileges in order to make the operation of removing those privileges depend on having access to your admin account, and the admin account functioning correctly first.' %}

5. Log in as `admin`
6. `run0`
7. `gpasswd -d {your username here} wheel`
8. `reboot`

When using a non-wheel user, you can add the user to other groups if you want. For example:

- use libvirt: `libvirt`
- use `adb` and `fastboot`: `plugdev`
- use systemwide flatpaks: `flatpak`
- use usbguard: `usbguard`

{% include alert.html type='note' content='You don\'t need to login using your wheel user to use it for privileged operations. When logged in as your non-wheel user, polkit will prompt you to authenticate as your wheel user as needed, or when requested by calling <code>run0</code>.' %}

### Setup system DNS
{: #dns}

Interactively setup system DNS resolution for systemd-resolved (optionally also set the resolver for hardened-chromium via management policy):

```
ujust dns-selector
```

{% include alert.html type='note' content='If you intend to use a VPN, use the system default state (network provided resolver). This will ensure your system uses the VPN provided DNS resolver to prevent DNS leaks. ESPECIALLY avoid setting the browser DNS policy in this case.' %}

## Bash environment lockdown
{: #bash}

To mitigate [LD_PRELOAD attacks](https://github.com/Aishou/wayland-keylogger), run:

```
ujust toggle-bash-environment-lockdown
```

### LUKS Hardware-Unlock

#### LUKS FIDO2 Unlock
{: #luks-fido2}


To enable FIDO2 LUKS unlocking with your FIDO2 security key, run:

```
ujust setup-luks-fido2-unlock
```

#### LUKS TPM2 Unlock
{: #luks-tpm2}

{% include alert.html type='warning' content='Do not use this if you have an AMD CPU.' %}

To enable TPM2 LUKS unlocking, run:

```
ujust setup-luks-tpm-unlock
```

Type `Y` when asked if you want to set a PIN.

### Validation
{: #validation}

To validate your secureblue setup, run:

```
ujust audit-secureblue
```

### Optional: `hardened-chromium` Flags
{: #hardened-chromium-flags}

The included [hardened-chromium](https://github.com/secureblue/hardened-chromium) browser has some additional settings in `chrome://flags` you *may* want to set for additional hardening and convenience (can cause functionality issues in some cases).

You can read about these settings [here](https://github.com/secureblue/hardened-chromium?tab=readme-ov-file#post-install).

### Read the FAQ
{: #faq}

Lots of important stuff is covered in the [FAQ](/faq). AppImage toggles, GNOME extension toggles, Xwayland toggles, etc.
