---
title: "Images | secureblue"
description: "List of available secureblue hardened operating system images"
permalink: /images
---

# Images

## Table of Contents
- [Desktop](#desktop)
- - [Recommended](#recommended)
- - [Stable](#stable)
- - [Beta](#beta)
- - [Experimental](#experimental)
- [Server](#server)

{% include alert.html type='note' content='<b>nvidia-open</b> images are recommended for systems with NVIDIA GPUs Turing or newer. These include the new <a href="https://github.com/NVIDIA/open-gpu-kernel-modules">open kernel modules</a> from NVIDIA, not Nouveau.<br><b>nvidia</b> images are recommended for systems with NVIDIA GPUs Pascal or older. These include the closed kernel modules from NVIDIA.' %}

## Desktop

### Recommended

{% include alert.html type='note' content='Silverblue utilizes GNOME, which is the only desktop that secures privileged wayland protocols like screencopy. This means that on non-GNOME systems, applications can access screen content of the entire desktop. This implicitly includes the content of other applications. It\'s primarily for this reason that Silverblue images are recommended. KDE has <a href="https://invent.kde.org/plasma/xdg-desktop-portal-kde/-/issues/7">plans to fix this</a>. GNOME also provides <a href="https://gitlab.gnome.org/GNOME/gnome-desktop/-/issues/213">thumbnailer sandboxing</a> in Gnome Files, which mitigates <a href="https://scarybeastsecurity.blogspot.com/2016/11/0day-exploit-compromising-linux-desktop.html">attacks via thumbnailers</a>. Despite this, it should be noted that no desktop choice solves any of the fundamental issues with desktop linux security.' %}

#### Silverblue

| Name                                      | Base      | NVIDIA Support         |
|-------------------------------------------|-----------|-------------------------|
| `silverblue-main-hardened`               | Silverblue| No                      |
| `silverblue-nvidia-hardened`             | Silverblue| Yes, closed drivers     |
| `silverblue-nvidia-open-hardened`        | Silverblue| Yes, open drivers       |


### Stable

#### Kinoite

| Name                                      | Base      | NVIDIA Support         |
|-------------------------------------------|-----------|-------------------------|
| `kinoite-main-hardened`                  | Kinoite   | No                      |
| `kinoite-nvidia-hardened`                | Kinoite   | Yes, closed drivers     |
| `kinoite-nvidia-open-hardened`           | Kinoite   | Yes, open drivers       |

#### Sericea

| Name                                      | Base      | NVIDIA Support         |
|-------------------------------------------|-----------|-------------------------|
| `sericea-main-hardened`                  | Sericea   | No                      |
| `sericea-nvidia-hardened`                | Sericea   | Yes, closed drivers     |
| `sericea-nvidia-open-hardened`           | Sericea   | Yes, open drivers       |

### Beta

{% include alert.html type='note' content='Learn about wayblue in <a href="https://github.com/wayblueorg/wayblue">wayblue\'s repository</a>.' %}

#### Wayfire

| Name                                      | Base                  | NVIDIA Support         |
|-------------------------------------------|-----------------------|-------------------------|
| `wayblue-wayfire-main-hardened`          | Wayblue-Wayfire       | No                      |
| `wayblue-wayfire-nvidia-hardened`        | Wayblue-Wayfire       | Yes, closed drivers     |
| `wayblue-wayfire-nvidia-open-hardened`   | Wayblue-Wayfire       | Yes, open drivers       |

#### Hyprland

| Name                                      | Base                  | NVIDIA Support         |
|-------------------------------------------|-----------------------|-------------------------|
| `wayblue-hyprland-main-hardened`         | Wayblue-Hyprland      | No                      |
| `wayblue-hyprland-nvidia-hardened`       | Wayblue-Hyprland      | Yes, closed drivers     |
| `wayblue-hyprland-nvidia-open-hardened`  | Wayblue-Hyprland      | Yes, open drivers       |

#### River

| Name                                      | Base                  | NVIDIA Support         |
|-------------------------------------------|-----------------------|-------------------------|
| `wayblue-river-main-hardened`            | Wayblue-River         | No                      |
| `wayblue-river-nvidia-hardened`          | Wayblue-River         | Yes, closed drivers     |
| `wayblue-river-nvidia-open-hardened`     | Wayblue-River         | Yes, open drivers       |


#### Sway

| Name                                      | Base                  | NVIDIA Support         |
|-------------------------------------------|-----------------------|-------------------------|
| `wayblue-sway-main-hardened`             | Wayblue-Sway          | No                      |
| `wayblue-sway-nvidia-hardened`           | Wayblue-Sway          | Yes, closed drivers     |
| `wayblue-sway-nvidia-open-hardened`      | Wayblue-Sway          | Yes, open drivers       |

### Experimental

#### Cosmic

| Name                                      | Base                  | NVIDIA Support         |
|-------------------------------------------|-----------------------|-------------------------|
| `cosmic-main-hardened`          | Cosmic       | No                      |
| `cosmic-nvidia-hardened`        | Cosmic       | Yes, closed drivers     |
| `cosmic-nvidia-open-hardened`   | Cosmic       | Yes, open drivers       |

## Server

{% include alert.html type='note' content='After you finish setting up your <a href="https://fedoraproject.org/coreos/">Fedora CoreOS</a> installation, you will need to disable `zincati.service` before rebasing to securecore.' %}

| Name                                      | Base      | NVIDIA Support         | ZFS Support |
|-------------------------------------------|-----------|-------------------------|-------------|
| `securecore-main-hardened`               | CoreOS    | No                      | No          |
| `securecore-nvidia-hardened`             | CoreOS    | Yes, closed drivers     | No          |
| `securecore-nvidia-open-hardened`        | CoreOS    | Yes, open drivers       | No          |
| `securecore-zfs-main-hardened`           | CoreOS    | No                      | Yes         |
| `securecore-zfs-nvidia-hardened`         | CoreOS    | Yes, closed drivers     | Yes         |
| `securecore-zfs-nvidia-open-hardened`    | CoreOS    | Yes, open drivers       | Yes         |
