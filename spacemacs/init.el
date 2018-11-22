;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     rust
     markdown
     ruby
     html
     javascript
     react
     yaml
     python
     helm
     auto-completion
     emacs-lisp
     git
     org
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     syntax-checking
     )
   dotspacemacs-additional-packages '(
                                      yasnippet-snippets
                                      )
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '()
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Menlo"
                               :size 12
                               :weight normal
                               :width normal
                               :powerline-scale 0.9)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ nil
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text nil
   dotspacemacs-ex-substitute-global nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-large-file-size 1
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers t
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  )

(defun dotspacemacs/user-config ()
  (setq-default indent-tabs-mode nil)

  (setq-default css-indent-offset 2)

  (setq-default evil-escape-delay 0.5)
  (setq-default evil-escape-key-sequence "jj")

  (setq-default helm-ag-base-command "rg --vimgrep --no-heading")

  (setq-default powerline-default-separator nil)

  (defun my/use-eslint-from-node-modules ()
    (let ((root (locate-dominating-file
                 (or (buffer-file-name) default-directory)
                 (lambda (dir)
                   (let ((eslint (expand-file-name "node_modules/.bin/eslint" dir)))
                     (and eslint (file-executable-p eslint)))))))
      (when root
        (let ((eslint (expand-file-name "node_modules/.bin/eslint" root)))
          (setq-local flycheck-javascript-eslint-executable eslint)))))
  (add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

  (add-to-list 'auto-mode-alist '("\\.js\\'" . react-mode))

  (setq-default web-mode-markup-indent-offset 2)
  (setq-default web-mode-css-indent-offset 2)
  (setq-default web-mode-code-indent-offset 2)
  (setq-default web-mode-attr-indent-offset 2)

  (defun my/js2-mode-hook ()
    (setq-default js2-basic-offset 2)
    (setq-default js-indent-level 2)
    (setq-default js2-mode-show-parse-errors nil)
    (setq-default js2-mode-show-strict-warnings nil)
    )
  (add-hook 'js2-mode-hook 'my/js2-mode-hook)

  (with-eval-after-load 'web-mode
    (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil)))
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (treepy graphql yasnippet-snippets flycheck-flow flow-minor-mode company-flow org-mime ghub let-alist f s xterm-color shell-pop multi-term eshell-z eshell-prompt-extras esh-help racer cargo toml-mode flycheck-rust seq rust-mode flycheck-pos-tip pos-tip flycheck helm-company helm-c-yasnippet fuzzy company-web web-completion-data company-tern dash-functional company-statistics company-anaconda company auto-yasnippet ac-ispell auto-complete mmm-mode markdown-toc markdown-mode gh-md tern sass-mode orgit magit-gitflow evil-magit magit magit-popup git-commit dash org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-download htmlize gnuplot smeargle helm-gitignore gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link with-editor rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv rake minitest chruby bundler inf-ruby web-mode tagedit slim-mode scss-mode pug-mode less-css-mode helm-css-scss haml-mode emmet-mode web-beautify livid-mode skewer-mode simple-httpd json-mode json-snatcher json-reformat js2-refactor yasnippet multiple-cursors js2-mode js-doc coffee-mode yaml-mode yapfify pyvenv pytest pyenv-mode py-isort pip-requirements live-py-mode hy-mode helm-pydoc cython-mode anaconda-mode pythonic ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint info+ indent-guide hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight elisp-slime-nav dumb-jump diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async org-plus-contrib evil-unimpaired))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (symon string-inflection spaceline-all-the-icons seeing-is-believing ruby-refactor ruby-hash-syntax rjsx-mode prettier-js pippel pipenv password-generator overseer org-brain nameless magit-svn json-navigator hierarchy importmagic epc ctable concurrent deferred impatient-mode helm-xref helm-purpose window-purpose imenu-list helm-org-rifle helm-git-grep gitignore-templates evil-org evil-lion evil-goggles evil-cleverparens paredit editorconfig doom-modeline eldoc-eval shrink-path all-the-icons memoize counsel-projectile counsel swiper ivy centered-cursor-mode dotenv-mode treepy graphql yasnippet-snippets flycheck-flow flow-minor-mode company-flow org-mime ghub let-alist f s xterm-color shell-pop multi-term eshell-z eshell-prompt-extras esh-help racer cargo toml-mode flycheck-rust seq rust-mode flycheck-pos-tip pos-tip flycheck helm-company helm-c-yasnippet fuzzy company-web web-completion-data company-tern dash-functional company-statistics company-anaconda company auto-yasnippet ac-ispell auto-complete mmm-mode markdown-toc markdown-mode gh-md tern sass-mode orgit magit-gitflow evil-magit magit magit-popup git-commit dash org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-download htmlize gnuplot smeargle helm-gitignore gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link with-editor rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv rake minitest chruby bundler inf-ruby web-mode tagedit slim-mode scss-mode pug-mode less-css-mode helm-css-scss haml-mode emmet-mode web-beautify livid-mode skewer-mode simple-httpd json-mode json-snatcher json-reformat js2-refactor yasnippet multiple-cursors js2-mode js-doc coffee-mode yaml-mode yapfify pyvenv pytest pyenv-mode py-isort pip-requirements live-py-mode hy-mode helm-pydoc cython-mode anaconda-mode pythonic ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint info+ indent-guide hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight elisp-slime-nav dumb-jump diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async org-plus-contrib evil-unimpaired))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
