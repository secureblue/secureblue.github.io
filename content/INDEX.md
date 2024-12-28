---
title: "secureblue: Hardened Fedora Atomic and Fedora CoreOS images"
description: "secureblue offers hardened operating system images based on Fedora Atomic Desktop and Fedora CoreOS"
permalink: /
---

secureblue offers hardened operating system images generated with [BlueBuild](https://blue-build.org/), using [Fedora Atomic Desktop](https://fedoraproject.org/atomic-desktops/)'s [base images](https://pagure.io/workstation-ostree-config) as a starting point. Fedora is one of the few Linux distributions that ships with selinux and associated tooling built-in and enabled by default. This makes it advantageous as a starting point for building a hardened system. However, out of the box it's lacking hardening in numerous other areas. This project's goal is to improve on that significantly.

The project also maintains [hardened-chromium](https://github.com/secureblue/hardened-chromium), a hardened fork inspired by GrapheneOS's [Vanadium](https://github.com/GrapheneOS/Vanadium), using [Fedora's Chromium](https://src.fedoraproject.org/rpms/chromium) as a base, intended for use with [hardened_malloc](https://github.com/GrapheneOS/hardened_malloc) as packaged and provided by secureblue. In fact, hardened-chromium is included in the secureblue desktop images.

# Scope

secureblue applies hardening with the following goals in mind:

- Increase defenses against the exploitation of both known and unknown vulnerabilities.
- Avoid sacrificing usability for most use cases where possible.
- Avoid sacrificing tangible security for "privacy", as that's often a euphemism for security theater.

For hardened-chromium, these goals are extended to specifically include the following:

- Desktop-relevant patches from Vanadium.
- Changes that make secondary browser features opt-in instead of opt-out (for example, making the password manager and search suggestions opt-in).
- Changes that disable opt-in metrics and data collection, so long as they have no security implications.

The following is out of scope across all secureblue projects:

- Any novel functionality that is unrelated to security.
- Anything related to "degoogling" chromium. For example, we will not be replacing [hardened-chromium](https://github.com/secureblue/hardened-chromium) with Brave or ungoogled-chromium. Both of them make changes that sacrifice tangible security for "privacy", such as enabling MV2. <sup>[why?](https://developer.chrome.com/docs/extensions/develop/migrate/improve-security)</sup>

# Hardening

- Installing and enabling [hardened_malloc](https://github.com/GrapheneOS/hardened_malloc) globally, including for flatpaks. <sup>[Thanks to rusty-snake's spec](https://github.com/rusty-snake/fedora-extras)</sup>
- Installing [hardened-chromium](https://github.com/secureblue/hardened-chromium), which is inspired by [Vanadium](https://github.com/GrapheneOS/Vanadium). <sup>[Why chromium?](https://grapheneos.org/usage#web-browsing)</sup> <sup>[Why not flatpak chromium?](https://forum.vivaldi.net/post/669805)</sup>
- Setting numerous hardened sysctl values <sup>[details](https://github.com/secureblue/secureblue/blob/live/files/system/etc/sysctl.d/hardening.conf)</sup>
- Remove SUID-root from [numerous binaries](https://github.com/secureblue/secureblue/blob/live/files/scripts/removesuid.sh), replace functionality [using capabilities](https://github.com/secureblue/secureblue/blob/live/files/system/usr/bin/setcapsforunsuidbinaries), and remove `sudo`, `su`, and `pkexec` entirely in favor of `run0` <sup>[why?](https://mastodon.social/@pid_eins/112353324518585654)</sup>
- Disable Xwayland by default (for GNOME, Plasma, and Sway images)
- Mitigation of [LD_PRELOAD attacks](https://github.com/Aishou/wayland-keylogger) via `ujust toggle-bash-environment-lockdown`
- Disabling coredumps
- Disabling all ports and services for firewalld
- Adds per-network MAC randomization
- Blacklisting numerous unused kernel modules to reduce attack surface <sup>[details](https://github.com/secureblue/secureblue/blob/live/files/system/etc/modprobe.d/blacklist.conf)</sup>
- Enabling only the [flathub-verified](https://flathub.org/apps/collection/verified/1) remote by default
- Sets numerous hardening kernel arguments (Inspired by [Madaidan's Hardening Guide](https://madaidans-insecurities.github.io/guides/linux-hardening.html)) <sup>[details](/kargs)</sup>
- Require wheel user authentication via polkit for `rpm-ostree install` <sup>[why?](https://github.com/rohanssrao/silverblue-privesc)
- Brute force protection by locking user accounts for 24 hours after 50 failed login attempts, hardened password encryption and password quality suggestions
- Installing usbguard and providing `ujust` commands to automatically configure it
- Installing bubblejail for additional sandboxing tooling
- Set opportunistic DNSSEC and DNSOverTLS for systemd-resolved
- Configure chronyd to use Network Time Security (NTS) <sup>[using chrony config from GrapheneOS](https://github.com/GrapheneOS/infrastructure/blob/main/chrony.conf)</sup>
- Disable KDE GHNS by default <sup>[why?](https://blog.davidedmundson.co.uk/blog/kde-store-content/)</sup>
- Disable install & usage of GNOME user extensions by default
- Use HTTPS for all rpm mirrors
- Set all default container policies to `reject`, `signedBy`, or `sigstoreSigned`
- Disable a variety of services by default (including cups, geoclue, passim, and others)
- Removal of the unmaintained and suid-root fuse2 by default
- Disabling unprivileged user namespaces by default for the unconfined domain and the container domain <sup>[why?](/userns)</sup>

# Customization

If you want to add your own customizations on top of secureblue, you are advised strongly against forking. Instead, create a repo for your own image by using the [BlueBuild template](https://github.com/blue-build/template), then change your `base-image` to a secureblue image. This will allow you to apply your customizations to secureblue in a concise and maintainable way, without the need to constantly sync with upstream.

For local development, [building locally](/contributing#building-locally) is the recommended approach.

# Support and community

Opening [GitHub issues](https://github.com/secureblue/secureblue) for support is preferred, but [Discord](https://discord.gg/qMTv5cKfbF) is available as well and it counts with a broader community of secureblue users.