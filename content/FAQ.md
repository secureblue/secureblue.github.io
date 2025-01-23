---
title: "FAQ | secureblue"
description: "Answers to frequently asked questions about secureblue"
permalink: /faq
---

# FAQ

## Table of contents:
- [Why is Flatpak included? Should I use Flatpak?](#flatpak)
- [Should I use Electron apps? Why don't they work well with hardened_malloc?](#electron)
- [My fans are really loud, is this normal?](#fans)
- [Should I use firejail?](#firejail)
- [An app I use won't start due to a malloc issue. How do I fix it?](#standard-malloc)
- [On secureblue half of my CPU cores are gone. Why is this?](#smt)
- [How do I install software?](#software)
- [How do I install Steam?](#steam)
- [Another security project has a feature that's missing in secureblue, can you add it?](#feature-request)
- [Why are bluetooth kernel modules disabled? How do I enable them?](#bluetooth)
- [Why are upgrades so large?](#upgrade-size)
- [Why can't I install new KDE themes?](#ghns)
- [Why doesn't my Xwayland app work?](#xwayland)
- [Why I can't install nor use any GNOME user extensions?](#gnome-extensions)
- [My clock is wrong and it's not getting automatically set. How do I fix this?](#clock)
- [How do I get notified of new releases?](#releases)
- [Why don't my AppImages work?](#appimage)
- [Why don't KDE Vaults work?](#kde-vaults)
- [How do I provision signed distroboxes?](#distrobox-assemble)
- [Why won't Trivalent start when bubblejailed?](#trivalent-bubblejail)
- [Why won't Trivalent start on Nvidia?](#trivalent-nvidia)
- [Why don't some websites that require JIT/WebAssembly work in Trivalent even with the V8 Optimizer toggle enabled?](#trivalent-v8-exceptions)
- [Why don't extensions work in Trivalent?](#trivalent-extensions)
- [How do I customize secureblue?](#customization)

### Why is Flatpak included? Should I use Flatpak?
{: #flatpak}

Consult our <a href="/articles/flatpak">Flatpak article</a>.

### Should I use Electron apps? Why don't they work well with hardened_malloc?
{: #electron}

[https://github.com/secureblue/secureblue/issues/193#issuecomment-1953323680](https://github.com/secureblue/secureblue/issues/193#issuecomment-1953323680)

### My fans are really loud, is this normal?
{: #fans}

During rpm-ostree operations, it's normal. Outside of that, make sure you followed the NVIDIA steps in the [post-install instructions](/post-install#nvidia) if you're using an NVIDIA GPU.

### Should I use firejail?
{: #firejail}

[No](https://madaidans-insecurities.github.io/linux.html#firejail), use ``bubblejail`` if there's no flatpak available for an app.

### An app I use won't start due to a malloc issue. How do I fix it?
{: #standard-malloc}

- For flatpaks, remove the `LD_PRELOAD` environment variable via Flatseal. To re-enable hardened_malloc for the respective flatpak, replace the removed variable.
- For layered packages and packages installed via brew, run the application with `ujust with-standard-malloc APP`. This starts the app without hardened_malloc only once, it does not disable hardened_malloc for the app persistently.

### On secureblue half of my CPU cores are gone. Why is this?
{: #smt}

`mitigations=auto,nosmt` is set on secureblue. This means that if your CPU is vulnerable to attacks that utilize [Simultaneous Multithreading](https://en.wikipedia.org/wiki/Simultaneous_multithreading), SMT will be disabled.

### How do I install software?
{: #software}

1. Check if it's already installed using `rpm -qa | grep x`
2. For GUI packages, you can install the flatpak if available using the Software store or using `flatpak install`. A catalogue of flatpaks is available at https://flathub.org.
3. For CLI packages, you can install from brew if available using `brew install`. A catalogue of brew packages is available at https://formulae.brew.sh.
4. If a package isn't available via the other two options, or if a package requires greater system integration, `rpm-ostree install` can be used to layer rpms directly into your subsequent deployments.

Steam is an exception to the above.

### How do I install Steam?
{: #steam}

```
ujust install-steam
```

### Another security project has a feature that's missing in secureblue, can you add it?
{: #feature-request}

First check our [features list](/features) on whether it already lists an equivalent or better feature. If it doesn't, open a new [GitHub issue](https://github.com/secureblue/secureblue/issues).

### Why are bluetooth kernel modules disabled? How do I enable them?
{: #bluetooth}

Bluetooth has a long and consistent history of security issues. However, if you still need it, run:

```
ujust toggle-bluetooth-modules
```

### Why are upgrades so large?
{: #upgrade-size}

This is an issue with rpm-ostree image-based systems generally, and not specific to secureblue. Ideally upgrades would come in the form of a zstd-compressed container diff, but it's not there yet. Check out [this upstream issue](https://github.com/coreos/rpm-ostree/issues/4012) for more information.

### Why can't I install new KDE themes?
{: #ghns}

The functionality that provides this, called GHNS, is disabled by default due to the risk posed by the installation of potentially damaging or malicious scripts. This has caused [real damage](https://blog.davidedmundson.co.uk/blog/kde-store-content/).

If you still want to enable this functionality, run:

```
ujust toggle-ghns
```

### Why doesn't my Xwayland app work?
{: #xwayland}

Xwayland is disabled by default on GNOME, KDE Plasma, and Sway. If you need it, run:

```
ujust toggle-xwayland
```

### Why I can't install nor use any GNOME user extensions?
{: #gnome-extensions}

This is because support for installing & using them has been intentionally disabled by default in secureblue.
Only GNOME system extensions are trusted, if they are installed.

To enable support for installing GNOME user extensions, you can run ujust command:

```
ujust toggle-gnome-extensions
```

### My clock is wrong and it's not getting automatically set. How do I fix this?
{: #clock}

If your system time is off by an excessive amount due to rare conditions like a CMOS reset, your network will not connect. A one-time manual reset will fix this. This should never be required except under very rare circumstances.

For more technical detail, see [#268](https://github.com/secureblue/secureblue/issues/268)

### How do I get notified of new releases?
{: #releases}

To subscribe to release notifications, on the secureblue GitHub page, click "Watch", and then "Custom", and select Releases like so:

<img alt="GitHub screenshot" src="/assets/release-notifications.png" />

### Why don't my AppImages work?
{: #appimage}

AppImages depend on fuse2, which is unmaintained and depends on a suid root binary. For this reason, fuse2 support is removed by default. It's strongly recommended that you find alternative mechanisms to install your applications (flatpak, distrobox, etc). If you can't find an alternative and still need fuse2, you can add it back by layering something that depends on it.

For example:

```
rpm-ostree install zfs-fuse
```

### Why don't KDE Vaults work?
{: #kde-vaults}

Similar to the AppImage FAQ, the KDE Vault default backend `cryfs` depends on fuse2. For this reason it's recommended that you migrate to an alternative that doesn't depend on fuse2, for example `fscrypt`. If you don't want to do so, you can add fuse2 back by layering something that depends on it, as described in the AppImage FAQ.

### How do I provision signed distroboxes?
{: #distrobox-assemble}

```
ujust distrobox-assemble
```

### Why won't Trivalent start when bubblejailed?
{: #trivalent-bubblejail}

`bubblejail` **SHOULD NOT** be used on Trivalent, there are issues reported with the pairing and removing the `bubblejail` config after it is applied can be difficult. It should also be noted that applying additional sandboxing may interfere with chromium's own internal sandbox, so it can end up reducing security.

### Why won't Trivalent start on Nvidia?
{: #trivalent-nvidia}

On some Nvidia machines, Trivalent defaults to the X11 backend. Since secureblue disables Xwayland by default, this means that you will need to run `ujust toggle-xwayland` and reboot, for Trivalent to work.

### Why don't some websites that require JIT/WebAssembly work in Trivalent even with the V8 Optimizer toggle enabled?
{: #trivalent-v8-exceptions}

This is an [upstream bug](https://issues.chromium.org/issues/373893056) that prevents V8 optimization settings from being applied to iframes embedded within a parent website. As a result, WebAssembly may not function on services that use a separate URL for their content delivery network or other included domains, such as VSCode Web ([https://github.dev](https://github.dev)). To make VSCode Web work properly, you need to manually allow V8 optimizations for the CDN by adding `https://[*.]vscode-cdn.net` to your list of trusted websites.

### Why don't extensions work in Trivalent?
{: #trivalent-extensions}

Extensions in Trivalent are disabled by default, for security reasons it is not advised to use them. If you want content/ad blocking, that is already built into Trivalent and enabled by default. If you require extensions, you can re-enable them by disabling the `Disable Extensions` toggle under `chrome://settings/security`, then restart your browser (this toggle is per-profile).
\
\
If the extension you installed doesn't work, it is likely because it requires WebAssembly (WASM) for some cryptographic library or some other optimizations (this is the case with the Bitwarden extension). To re-enable JavaScript JIT and WASM for extensions, enable the feature `chrome://flags/#internal-page-jit`.

### How do I customize secureblue?
{: #customization}

If you want to add your own customizations on top of secureblue, you are advised strongly against forking. Instead, create a repo for your own image by using the [BlueBuild template](https://github.com/blue-build/template), then change your `base-image` to a secureblue image. This will allow you to apply your customizations to secureblue in a concise and maintainable way, without the need to constantly sync with upstream. For local development, [building locally](/contributing#building-locally) is the recommended approach.
