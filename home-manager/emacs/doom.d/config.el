;; user info
(setq user-full-name "Joshua Niemelä"
      user-mail-address "josh@jniemela.dk")

;; relative line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; map ctrl space to lsp extend selection
(map! :map lsp-mode-map
      "C-SPC" #'lsp-extend-selection)

;; accept completion from copilot and fallback to company
;(use-package! copilot
;  :hook (prog-mode . copilot-mode)
;  :bind (:map copilot-completion-map
;              ("<tab>" . 'copilot-accept-completion)
;              ("TAB" . 'copilot-accept-completion)
;              ("C-TAB" . 'copilot-accept-completion-by-word)
;              ("C-<tab>" . 'copilot-accept-completion-by-word)))

