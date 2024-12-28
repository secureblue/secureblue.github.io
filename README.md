# secureblue.io

This repo contains the source files of [secureblue's static website](https://esselownitro.github.io) (provisory domain), generated using Jekyll and currently being deployed to GitHub Pages. We plan on deploying to Cloudflare Pages in the future. It is a fork of [GrapheneOS's static website project](https://github.com/GrapheneOS/grapheneos.org) and borrows pieces of HTML and CSS as well as some general ideas from it, but uses a website generation workflow we consider more convenient.

## Layout

`_layouts/` stores the only layout file that wraps all pages, at the outermost level. It always includes the `meta.html`, `header.html` and `footer.html` fragments, and uses Liquid expressions to include the hero banner only.

## Includes

`_includes/` stores reusable HTML fragments. What follows are details of fragments worth commenting on.

`meta.html` uses variables read from the front matter of any given page it is included in, so each page can have its correct metadata without a meta element section that is mostly repeated acroos all pages. A very minor positive side effect of this is that each markdown page has a sort of description about its purpose.

`header.html` uses Liquid expressions iterating on the `site.pages` global variable provided by Jekyll to generate its page list, instead of depending on a hard-coded list. It also adds `aria-current="page"` to a page's list entry when included in said page, highlighting its text with a blue accent. `site.pages` counts all files that include front matter (blocks of data wrapped between triple dashes) as pages, which are located in `content/` in this project, to keep it tidy.

# What about the rest?

This document is a work in progress.
