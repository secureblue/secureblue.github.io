---
title: "secureblue: Hardened Fedora Atomic and Fedora CoreOS images"
description: "Hardened operating system images based on Fedora Atomic Desktop and Fedora CoreOS"
permalink: /
---

## [About](#about)

secureblue is a security-focused desktop and server linux operating system, developed as an open-source project. It is shipped as a set of [OCI](https://en.wikipedia.org/wiki/Open_Container_Initiative) bootable container images, which are generated with [BlueBuild](https://blue-build.org/), using [Fedora Atomic Desktop](https://fedoraproject.org/atomic-desktops/)'s [base images](https://pagure.io/workstation-ostree-config) as a starting point. Fedora is one of the few Linux distributions that ships with SELinux and associated tooling built-in and enabled by default. This makes it advantageous as a starting point for building a secure desktop system. However, the security posture of desktop linux is broadly and significantly lacking. The goal of secureblue is to build a maximally secure linux operating system by proactively increasing defenses against the exploitation of both known and unknown vulnerabilities while avoiding sacrificing usability for most use cases where possible. For more details, see the [features list](/features).

## [Who is secureblue for?](#who-is-secureblue-for)

secureblue is for those whose first priority is using linux, and second priority is security. secureblue does not claim to be the most secure option available on the desktop. We are limited in that regard by the current state of desktop linux standardization, tooling, and upstream security development. What we aim for instead is to be the most secure option for those who already intend to use linux. As such, if security is your first priority, secureblue may not the best option for you.

## [Support and community](#support-and-community)

Both [GitHub issues](https://github.com/secureblue/secureblue) and [Discord](https://discord.gg/qMTv5cKfbF) are available for support from the secureblue community.
