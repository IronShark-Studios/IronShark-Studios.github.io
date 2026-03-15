---
author: Xin IronShark
categories:
- Nix
- Quarto
- Writing
date: 2026-03-14
description: How I build and deploy this website using Quarto, Nix, and
  Github.
draft: false
image: thumbnail.png
title: Personal Website Configuration
---

```{=org}
#+pandoc_metadata: draft=false
```
```{=org}
#+pandoc_metadata: categories=Nix
```
```{=org}
#+pandoc_metadata: categories=Quarto
```
```{=org}
#+pandoc_metadata: categories=Writing
```
```{=org}
#+pandoc_metadata: image=thumbnail.png
```
```{=org}
#+export_file_name: ~/Projects/Personal-Blog/posts/personal_website_configuration/index.qmd
```
# Introduction

This will be my third attempt at building a sustainable blogging
platform. Now with the added requirement that it be able to grow with me
as I try to enter the world of academia. Previous attempts have used
Jekyll and Hugo. Both excellent and well built platforms, but neither
quite fit my needs. With Jekyll I ran into issues with the configuring
it to run locally due to its dependence on Ruby and Gems. Hugo, I
struggled with stability, since getting the feature set that I wanted
required the use of a heavy theme. My goal this time, was explicit.

Find a blog publishing platform that had all the feature I currently
needed, or could reasonably foresee needing. Built into its core, and
which I could manage declaratively using Nix.

You can find the source code for this website on
[GitHub](https://github.com/IronShark-Studios/IronShark-Studios.github.io).

# Local Development and Reproducibility with Nix Flakes

The first goal was to build the blog using a Nix Flake. This makes it so
that once it is working, it will always work. The `flake.nix`{.verbatim}
defines the development environment, and `envrc`{.verbatim} tells
`zsh`{.verbatim} to load it automatically when I enter the directory.

## flake.nix

``` nix
{
  description = "Personal Blog Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            git

            # Publishing engine
            quarto

            # Required for executing Jupyter notebooks and Python code blocks!
            python3
            python3Packages.jupyter
          ];

          shellHook = ''
            echo "=========================================="
            echo "Quarto version: $(quarto --version)"
            echo "Python version: $(python3 --version)"
            echo "=========================================="
            echo "=========================================="
            echo "Run 'quarto preview' to start the live server."
            echo "=========================================="
          '';
        };
      }
    );
}
```

# Quarto Features, and Site Layout

I went with [Quarto](https://quarto.org/) because it is explicitly
geared towards academic websites. It supports inline $LaTeX$ ($E=mc^2$),
Citations, SRC blocks, Jupyter Notebooks, and even rendering to PDF, or
PowerPoint slides all as part of the core engine. No need for fragile
extensions. Visually it looks pretty good out of the box, and it support
a lot more customization later if I want to do so. My website is
currently based heavily off of this [build
guide](https://albert-rapp.de/posts/13_quarto_blog_writing_guide/13_quarto_blog_writing_guide.html).

The general layout groups posts into two categories.

- General, which are post that are independent. These are organized
  based on publication date, and tag.
- Project, Which are hubs that list post that share a common theme.

# Building and Publishing with GitHub

So I am just going to come clean up front here. I have... *no idea* how
this works. I asked Google Gemini to configure this for me, and it did.
Which to be honest I consider a great example use case for LLMs. Just do
this common configuration task for me so I don\'t need to speed a bunch
of time fighting with it like I did with Hugo. I will dig in to this at
some point. But for now I am happy to write it off as simly working.
