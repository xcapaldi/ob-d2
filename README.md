[![MELPA](https://melpa.org/packages/ob-d2-badge.svg)](https://melpa.org/#/ob-d2)

## Introduction
`ob-d2` enables [Org-Babel](http://orgmode.org/worg/org-contrib/babel/intro.html) support for evaluating [D2](https://d2lang.com/tour/intro/) code.
It was created based on the usage of [ob-ditaa](https://orgmode.org/worg//org-contrib/babel/languages/ob-doc-ditaa.html).
The D2 code is compiled via the `d2` command.

```Org
#+BEGIN_SRC d2 :file hello.png
x -> y: hello world
#+END_SRC
```

<div>
  <img height="500px" alt="hello world" src="hello.png">
</div>

## Language Specific Header Arguments

In addition to the normal header arguments for Babel, `ob-d2` uses the `:flags` header to pass additional flags to the `d2` command.
`:file` is required since the output of D2 is an image.

## Additional Examples
All examples are courtesy of Terrastruct, Inc. who published them in their D2 documentation.

### Flags to specify theme and sketch format

```Org
#+BEGIN_SRC d2 :file flags.png :flags -t 101 -s
High Mem Instance -> EC2 <- High CPU Instance: Hosted By
#+END_SRC
```

<div>
  <img height="500px" alt="flags" src="flags.png">
</div>

### Complex example

```Org
#+BEGIN_SRC d2 :file complex.png
clouds: {
  aws: {
    load_balancer -> api
    api -> db
  }
  gcloud: {
    auth -> db
  }

  gcloud -> aws
}
#+END_SRC
```

<div>
  <img height="700px" alt="complex" src="complex.png">
</div>

## Configuration
`ob-d2` is available from [Melpa](https://melpa.org/#/ob-d2).
You can install it directly via `package-install` if you have Melpa in your [package archives](https://melpa.org/#/getting-started).
After installation, you can `(require 'ob-d2)` and enable D2 as a supported language in org-mode by adding it to `org-babel-load-languages`.
For example, something like:

```Emacs Lisp
(org-babel-do-load-languages
   'org-babel-load-languages
   '((shell . t)
     (python . t)
     (d2 . t)))
```

If you use [use-package](https://github.com/jwiegley/use-package), you can install `ob-d2` and ensure `org` is configured to use it after loading:

```Emacs Lisp
(use-package ob-d2
  :ensure t)

(use-package org
  :after ob-d2
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((d2 . t))))
```

### Manual installation
Download `ob-d2.el` from this repository to your loadpath and include `(require 'ob-d2)` in your `init.el` file.
