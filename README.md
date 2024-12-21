# secureblue website

This repo contains the source files of [secureblue's static website](https://esselownitro.github.io) (provisory domain), generated using Jekyll and currently being deployed to GitHub Pages. We plan on deploying to Cloudflare Pages in the future. It is a fork of [GrapheneOS's static website project](https://github.com/GrapheneOS/grapheneos.org) and borrows HTML and CSS fragments as well as some general ideas from it, but uses a website generation workflow we consider more convenient.

## Layout

`_layouts/` stores the only layout file that wraps all pages, at the outermost level. It uses Liquid expressions to selectively include the meta elements in head, the hero banner and the page header and footer. This allows the hero banner to be displayed only in the index page, the header and meta elements to be present in every page but with slightly modified parameters depending on which page the layout wraps, and the footer to be reused as is in every page.

## Includes

`_includes/` stores reusable HTML fragments. What follows are comments on page fragments worth commenting on.

`header.html` uses Liquid expressions iterating on the `site.pages` global variable provided by Jekyll to generate its page list, instead of depending on a hard-coded list. It also adds `aria-current="page"` to a page's list entry when included in said page, highlighting it with a blue color. `site.pages` counts all files that include front matter (blocks of data wrapped between triple dashes) as pages, and in this project they are located in `content/` to keep it tidy.

# What about the rest?

This document is a work in progress.