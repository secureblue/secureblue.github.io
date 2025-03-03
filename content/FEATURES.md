---
title: "Features | secureblue"
description: "List of secureblue features"
permalink: /features
---

# Features

## [Exploit mitigation](#exploit-mitigation)
{: #exploit-mitigation}
- Installing and enabling [hardened_malloc](https://github.com/GrapheneOS/hardened_malloc) globally, including for Flatpaks. <sup>[Thanks to rusty-snake's spec](https://github.com/rusty-snake/fedora-extras)</sup>
- Installing our Chromium-based browser [Trivalent](https://github.com/secureblue/Trivalent), which is inspired by [Vanadium](https://github.com/GrapheneOS/Vanadium). <sup>[Why Chromium?](https://grapheneos.org/usage#web-browsing)</sup> <sup>[Why not Flatpak Chromium?](https://forum.vivaldi.net/post/669805)</sup>
- SELinux-restricted [unprivileged user namespaces](/articles/userns)
- Harden the kernel with numerous sysctl values <sup>[details](https://github.com/secureblue/secureblue/blob/live/files/system/etc/sysctl.d/60-hardening.conf)</sup>
- Harden the kernel with numerous kernel arguments (Inspired by [Madaidan's Hardening Guide](https://madaidans-insecurities.github.io/guides/linux-hardening.html)) <sup>[details](/articles/kargs)</sup>
- Configure chronyd to use Network Time Security (NTS) <sup>[using chrony config from GrapheneOS](https://github.com/GrapheneOS/infrastructure/blob/main/chrony.conf)</sup>
- Set opportunistic DNSSEC and DNS over TLS for systemd-resolved
- Installing USBGuard and providing `ujust` commands to automatically configure it

## [Filling known security holes](#filling-security-holes)
{: #filling-security-holes}
- Remove [suid-root](https://en.wikipedia.org/wiki/Setuid) from [numerous binaries](https://github.com/secureblue/secureblue/blob/live/files/scripts/removesuid.sh), replacing functionality [using capabilities](https://github.com/secureblue/secureblue/blob/live/files/system/usr/bin/setcapsforunsuidbinaries), and remove `sudo`, `su`, and `pkexec` entirely in favor of `run0` <sup>[why?](https://mastodon.social/@pid_eins/112353324518585654)</sup>
- Disable XWayland by default (for GNOME, Plasma, and Sway images)
- Mitigation of [LD_PRELOAD attacks](https://github.com/Aishou/wayland-keylogger) via `ujust toggle-bash-environment-lockdown`
- Disable install & usage of GNOME user extensions by default
- Disable KDE GHNS by default <sup>[why?](https://blog.davidedmundson.co.uk/blog/kde-store-content/)</sup>
- Removal of the unmaintained and suid-root fuse2 by default
- Disabling unprivileged user namespaces by default for the unconfined domain and the container domain <sup>[why?](/articles/userns)</sup>
- Prohibiting ptrace attachment <sup>[why?](https://www.kernel.org/doc/Documentation/security/Yama.txt)</sup>

## [Security by default](#security-by-default)
{: #security-by-default}
- Disabling all ports and services for firewalld
- Use HTTPS for all rpm mirrors
- Set all default container policies to `reject`, `signedBy`, or `sigstoreSigned`
- Enabling only the [Flathub-verified](https://flathub.org/apps/collection/verified/1) remote by default

## [Reduce information leakage](#info-leak)
{: #info-leak}
- Adds per-network MAC randomization
- Disabling coredumps

## [Attack surface reduction](#attack-surface)
{: #attack-surface}
- Blacklisting numerous unused kernel modules to reduce attack surface <sup>[details](https://github.com/secureblue/secureblue/blob/live/files/system/etc/modprobe.d/blacklist.conf)</sup>
- Brute force protection by locking user accounts for 24 hours after 50 failed login attempts, hardened password encryption and password quality suggestions
- Disable and mask a variety of services by default (including cups, geoclue, passim, and others)

## [Security ease-of-use](#ease)
{: #ease}
- Installing Bubblejail for additional sandboxing tooling
- Tooling for automatically setting up and enabling LUKS TPM2 integration for unlocking LUKS drives
- Tooling for automatically setting up and enabling LUKS FIDO2 integration for unlocking LUKS drives
- Toggles for a variety of the hardening set by default, for user convenience (`ujust --choose`)
