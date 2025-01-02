---
title: "Flatpak | secureblue"
description: "Flatpak: the good, the bad, the ugly"
permalink: /articles/flatpak
---

# Flatpak

Flatpak is an application packaging and distribution system for desktop linux. It uses bubblewrap under the hood to sandbox those applications and provide desktop linux with a de-facto standard sandboxing and permissions system. However, it has flaws and its sandboxing strength can vary significantly depending on how it is configured. secureblue addresses these flaws in a couple different ways.

As with any application sandboxing system, flatpaks should be scoped down by default to as few permissions as they need to function. Even better, permissions should be granted directly by the user at app runtime like in android. Sadly, neither of these are the case today. Flatpak manifest maintainers define the set of permissions they believe to be necessary and sufficient for operation of their applications. When a flatpak is installed by a user, the flatpak's permissions default to those defined by the manifest.

This is of course not ideal, but it's also <a href="https://en.wikipedia.org/wiki/Perfect_is_the_enemy_of_good">not a reason to abandon flatpak entirely</a>. There are many ways we can mitigate this issue: 

- users should configure permissions to their liking
- users should submit default permissions changes to upstream flatpaks at their repos.
- developers should overhaul flatpak and xdg portals to introduce a better permissions model

What secureblue does in this case is provide a mitigation along the lines of the first option. We provide a `ujust` command to strip flatpaks of permissions by default, such that the user will need to specifically and deliberately grant permissions required by each application:

```
ujust flatpak-permissions-lockdown
```

This is not enabled out of the box on secureblue because it has a somewhat significant usability impact (many flatpaks will break due to missing permissions). Until the flatpak and xdg portal permissions model is improved, this is the most secure option we can offer. That said, users are still encouraged to report unnecessary permissions to upstream projects when found, while incremenetal development progresses on flatpak and portals.
