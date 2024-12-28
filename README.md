# secureblue.io

This repo contains the source files of [secureblue's static website](https://esselownitro.github.io) (provisory domain), generated using Jekyll and currently being deployed to GitHub Pages. We plan on deploying to Cloudflare Pages in the future. It is a fork of [GrapheneOS's static website project](https://github.com/GrapheneOS/grapheneos.org) and borrows pieces of HTML and CSS as well as some general ideas from it, but uses a website generation workflow we consider more convenient.

## Layout

`_layouts/` stores the only layout file that wraps all pages, at the outermost level. It always includes the `meta.html`, `header.html` and `footer.html` fragments, and uses Liquid expressions to include the hero banner only in the index page.

## Includes

`_includes/` stores reusable HTML fragments. What follows are details of fragments worth commenting on.

### alert

`alert.html` is included to wrap text in certain visual highlights, replacing GitHub Markdown alerts like the following:

> [!NOTE]
> An alert of the "note" type. It's pretty cool, right?
> 
> Another line in the same alert.

Which can be created with the following, simple sintax:

```
> [!NOTE]
> An alert of the "note" type. It's pretty cool, right?
> 
> Another line in the same alert.
```

Except that as an inclusible HTML fragment, `alert.html` presents an unhiged manner to imitate the above. It has to be included (implying everything is on a same line) and requires two variables to be passed to it, one indicating the type of alert, and the other being one whole string with all the text that needs to be shown. Newlines are not permitted and have to be broken by including `<br>`, not because it means a line break in HTML, but as an arbitrary token that `alert.html` will scan for and use as a breaking point for newlines. This is necessary since Liquid doesn't support initializing arrays, and that arbitrarily chosen token is scanned to create an array from a whole string, separating elements by that token. Each element of the array will be treated as a line of text in the alert. Also, apostrophes (`'`) have to be escaped with a backwards slash (like so: `\'`).

To demonstrate this, the following syntax in a document in this project produces the same effect of the example earlier:

```
{% include type='note' content='An alert of the "note" type. It\'s pretty cool, right?<br>Another line in the same alert.' %}
```

It easily becomes an eyesore with longer strings.

There are 5 types of alerts available: `note`, `tip`, `important`, `warning` and `caution`. Here's how they look and what purpose does each of them serve:

> [!NOTE]  
> Highlights information that users should take into account, even when skimming.

> [!TIP]
> Optional information to help a user be more successful.

> [!IMPORTANT]  
> Crucial information necessary for users to succeed.

> [!WARNING]  
> Critical content demanding immediate user attention due to potential risks.

> [!CAUTION]
> Negative potential consequences of an action.

Source: [this](https://github.com/orgs/community/discussions/16925).

### header

`header.html` uses Liquid expressions iterating on the `site.pages` global variable provided by Jekyll to generate its page list, instead of depending on a hard-coded list. It also adds `aria-current="page"` to a page's list entry when included in said page, highlighting its text with a blue accent. `site.pages` counts all files that include front matter (blocks of data wrapped between triple dashes) as pages, which are located in `content/` in this project, to keep it tidy.

### meta

`meta.html` uses variables read from the front matter of any given page it is included in, so each page can have its correct metadata without a meta element section that is mostly repeated acroos all pages. A very minor positive side effect of this is that each markdown page has a sort of description about its purpose.

# What about the rest?

This document is a work in progress.
