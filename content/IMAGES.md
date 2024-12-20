---
title: "Images | secureblue"
short_title: "Images"
description: "List of available secureblue hardened operating system images"
permalink: /images
---

# Images

Table of Contents
- [Desktop](#desktop)
- - [Recommended](#recommended)
- - - [Silverblue](#silverblue)
- - [Stable](#stable)
- - - [Kinoite](#kinoite)
- - - [Sericea](#sericea)
- - [Beta](#beta)
- - - [Wayfire](#wayfire)
- - - [Hyprland](#hyprland)
- - - [River](#river)
- - - [Sway](#sway)
- - [Experimental](#experimental)
- - - [Cosmic](#cosmic)
- [Server](#server)

## Desktop

*`nvidia-open` images are recommended for systems with Nvidia GPUs Turing or newer. These include the new [open kernel modules](https://github.com/NVIDIA/open-gpu-kernel-modules) from Nvidia, not Nouveau.*

*`nvidia` images are recommended for systems with Nvidia GPUs Pascal or older. These include the closed kernel modules from Nvidia.*

### Recommended

#### Silverblue

| Name                                      | Base      | Nvidia Support         |
|-------------------------------------------|-----------|-------------------------|
| `silverblue-main-hardened`               | Silverblue| No                      |
| `silverblue-nvidia-hardened`             | Silverblue| Yes, closed drivers     |
| `silverblue-nvidia-open-hardened`        | Silverblue| Yes, open drivers       |

{% include alert.html type='note' content='This is a relative recommendation between the desktop environments available on secureblue. GNOME has some extra security niceties like the ones listed below. It however does not solve any of the fundamental issues with desktop linux security.' %}

{% include alert.html type='caution' content='Silverblue utilizes GNOME, which is the only desktop that secures privileged wayland protocols like screencopy. This means that on non-GNOME systems, applications can access screen content of the entire desktop. This implicitly includes the content of other applications. It\'s primarily for this reason that GNOME images are recommended. KDE has <a href="https://invent.kde.org/plasma/xdg-desktop-portal-kde/-/issues/7">plans</a> to fix this.<br>GNOME also provides <a href="https://gitlab.gnome.org/GNOME/gnome-desktop/-/issues/213">thumbnailer sandboxing</a> in Gnome Files, which mitigates attacks <a href="https://scarybeastsecurity.blogspot.com/2016/11/0day-exploit-compromising-linux-desktop.html">via thumbnailers</a>.' %}

### Stable

#### Kinoite

| Name                                      | Base      | Nvidia Support         |
|-------------------------------------------|-----------|-------------------------|
| `kinoite-main-hardened`                  | Kinoite   | No                      |
| `kinoite-nvidia-hardened`                | Kinoite   | Yes, closed drivers     |
| `kinoite-nvidia-open-hardened`           | Kinoite   | Yes, open drivers       |

#### Sericea

| Name                                      | Base      | Nvidia Support         |
|-------------------------------------------|-----------|-------------------------|
| `sericea-main-hardened`                  | Sericea   | No                      |
| `sericea-nvidia-hardened`                | Sericea   | Yes, closed drivers     |
| `sericea-nvidia-open-hardened`           | Sericea   | Yes, open drivers       |

### Beta

{% include alert.html type='note' content='Learn about wayblue <a href="https://github.com/wayblueorg/wayblue">here</a>.' %}

#### Wayfire

| Name                                      | Base                  | Nvidia Support         |
|-------------------------------------------|-----------------------|-------------------------|
| `wayblue-wayfire-main-hardened`          | Wayblue-Wayfire       | No                      |
| `wayblue-wayfire-nvidia-hardened`        | Wayblue-Wayfire       | Yes, closed drivers     |
| `wayblue-wayfire-nvidia-open-hardened`   | Wayblue-Wayfire       | Yes, open drivers       |

#### Hyprland

| Name                                      | Base                  | Nvidia Support         |
|-------------------------------------------|-----------------------|-------------------------|
| `wayblue-hyprland-main-hardened`         | Wayblue-Hyprland      | No                      |
| `wayblue-hyprland-nvidia-hardened`       | Wayblue-Hyprland      | Yes, closed drivers     |
| `wayblue-hyprland-nvidia-open-hardened`  | Wayblue-Hyprland      | Yes, open drivers       |

#### River

| Name                                      | Base                  | Nvidia Support         |
|-------------------------------------------|-----------------------|-------------------------|
| `wayblue-river-main-hardened`            | Wayblue-River         | No                      |
| `wayblue-river-nvidia-hardened`          | Wayblue-River         | Yes, closed drivers     |
| `wayblue-river-nvidia-open-hardened`     | Wayblue-River         | Yes, open drivers       |


#### Sway

| Name                                      | Base                  | Nvidia Support         |
|-------------------------------------------|-----------------------|-------------------------|
| `wayblue-sway-main-hardened`             | Wayblue-Sway          | No                      |
| `wayblue-sway-nvidia-hardened`           | Wayblue-Sway          | Yes, closed drivers     |
| `wayblue-sway-nvidia-open-hardened`      | Wayblue-Sway          | Yes, open drivers       |

### Experimental

#### Cosmic

| Name                                      | Base                  | Nvidia Support         |
|-------------------------------------------|-----------------------|-------------------------|
| `cosmic-main-hardened`          | Cosmic       | No                      |
| `cosmic-nvidia-hardened`        | Cosmic       | Yes, closed drivers     |
| `cosmic-nvidia-open-hardened`   | Cosmic       | Yes, open drivers       |

## Server

{% include alert.html type='note' content='After you finish setting up your <a href="https://fedoraproject.org/coreos/">Fedora CoreOS</a> installation, you will need to disable `zincati.service` before rebasing to securecore.' %}

| Name                                      | Base      | Nvidia Support         | ZFS Support |
|-------------------------------------------|-----------|-------------------------|-------------|
| `securecore-main-hardened`               | CoreOS    | No                      | No          |
| `securecore-nvidia-hardened`             | CoreOS    | Yes, closed drivers     | No          |
| `securecore-nvidia-open-hardened`        | CoreOS    | Yes, open drivers       | No          |
| `securecore-zfs-main-hardened`           | CoreOS    | No                      | Yes         |
| `securecore-zfs-nvidia-hardened`         | CoreOS    | Yes, closed drivers     | Yes         |
| `securecore-zfs-nvidia-open-hardened`    | CoreOS    | Yes, open drivers       | Yes         |