---
title: Home
type: landing

sections:
  # 1. The Biography Block
  - widget: about.biography
    id: about
    content:
      username: admin

  # 2. Your Recent Blog Posts
  - widget: collection
    id: posts
    content:
      title: Recent Thoughts
      filters:
        folders:
          - post
    design:
      view: article-grid # Renders posts as nice cards
      columns: 2

  # 3. A Skills/Tech Stack Block
  - widget: features
    id: skills
    content:
      title: Toolkit
      items:
        - name: NixOS
          description: Reproducible system configuration
          icon: terminal
        - name: Emacs
          description: The ultimate text editor
          icon: code
---
