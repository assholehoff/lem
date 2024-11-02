(defpackage :lem-core/display
  (:use)
  (:export
   :wrap-line-character
   :wrap-line-attribute
   :control-character-object
   :emoji-object
   :eol-cursor-object
   :eol-cursor-object-color
   :extend-to-eol-object
   :extend-to-eol-object-color
   :folder-object
   :icon-object
   :image-object
   :image-object-height
   :image-object-image
   :image-object-width
   :line-end-object
   :line-end-object-offset
   :text-object
   :text-object-attribute
   :text-object-string
   :text-object-surface
   :text-object-type
   :void-object
   :text-object))

(uiop:define-package :lem-core
  (:use :cl
        :lem/common/killring
        :lem/common/timer
        :lem/common/command
        :lem/common/color
        :lem/common/queue
        :lem/common/utils
        :lem-core/display)
  (:use-reexport :lem/buffer)
  (:use-reexport :lem/common/color)
  (:use-reexport :lem/common/hooks)
  (:use-reexport :lem/common/var)
  (:use-reexport :lem/common/character)
  ;; reexport common/killring
  (:export
   :with-killring-context)
  ;; reexport lem/common/command.lisp
  (:export
   :primary-command
   :make-command-table
   :add-command
   :remove-command
   :get-command
   :find-command
   :exist-command-p)
  ;; version.lisp
  (:export
   :lem-git-revision
   :get-version-string)
  ;; save-excursion.lisp
  (:export
   :save-excursion)
  ;; killring.lisp
  (:export
   :current-killring
   :copy-to-clipboard-with-killring
   :yank-from-clipboard-or-killring)
  ;; quicklisp-utils.lisp
  (:export
   :maybe-load-systems)
  ;; config.lisp
  (:export
   :lem-home
   :lem-logdir-pathname
   :config)
  ;; errors.lisp
  (:export
   :editor-abort
   :undefined-key-error
   :exit-editor
   :move-cursor-error
   :end-of-buffer
   :beginning-of-buffer)
  ;; system.lisp
  (:export
   :get-pid
   :exist-program-p
   :lem-relative-pathname
   :open-external-file)
  ;; key.lisp
  (:export
   :make-key
   :key-p
   :key-ctrl
   :key-meta
   :key-super
   :key-hypher
   :key-shift
   :key-sym
   :match-key
   :insertion-key-sym-p
   :named-key-sym-p
   :define-named-key
   :key-to-char)
  ;; macros.lisp
  (:export
   :with-current-window
   :with-disable-killring
   :with-pop-up-typeout-window
   :define-buffer-accessor
   :define-overlay-accessors)
  ;; attribute.lisp
  (:export
   :make-attribute
   :attribute
   :attribute-p
   :attribute-value
   :ensure-attribute
   :merge-attribute
   :attribute-equal
   :set-attribute
   :set-attribute-foreground
   :set-attribute-background
   :set-attribute-reverse
   :set-attribute-bold
   :set-attribute-italic
   :set-attribute-oblique
   :set-attribute-underline
   :attribute-foreground
   :attribute-background
   :attribute-reverse
   :attribute-bold
   :attribute-italic
   :attribute-oblique
   :attribute-underline
   :get-attribute-cache
   :define-attribute
   :cursor
   :region
   :modeline
   :modeline-inactive
   :truncate-attribute
   :compiler-note-attribute
   :syntax-warning-attribute
   :syntax-string-attribute
   :syntax-comment-attribute
   :syntax-keyword-attribute
   :syntax-constant-attribute
   :syntax-function-name-attribute
   :syntax-variable-attribute
   :syntax-type-attribute
   :syntax-builtin-attribute
   :completion-attribute
   :non-focus-completion-attribute
   :attribute-image
   :attribute-width
   :attribute-height
   :attribute-font
   :cursor-attribute-p
   :set-cursor-attribute)
  ;; clipboard.lisp
  (:export
   :wsl-p
   :with-enable-clipboard
   :enable-clipboard
   :disable-clipboard
   :enable-clipboard-p
   :copy-to-clipboard
   :get-clipboard-data)
  ;; file.lisp
  (:export
   :get-file-mode
   :define-file-type
   :define-file-associations
   :define-program-name-with-mode)
  ;; screen.lisp
  (:export
   :screen-clear
   :screen-view)
  ;; frame.lisp
  (:export
   :update-prompt-window
   :frame
   :make-frame
   :frame-current-window
   :frame-window-tree
   :frame-floating-windows
   :frame-header-windows
   :frame-floating-prompt-window
   :frame-prompt-window
   :frame-message-window
   :frame-leftside-window
   :notify-frame-redisplay-required
   :map-frame
   :get-frame
   :all-frames
   :current-frame
   :unmap-frame
   :setup-frame
   :teardown-frame
   :teardown-frames
   :get-frame-of-window
   :focus-window-position)
  ;; mouse.lisp
  (:export
   :mouse-button-down-functions
   :receive-mouse-button-down
   :receive-mouse-button-up
   :receive-mouse-motion
   :receive-mouse-wheel
   :set-hover-message
   :get-point-from-window-with-coordinates
   :get-point-on-context-menu-open
   :handle-mouse-button-down
   :handle-mouse-button-up
   :handle-mouse-hover)
  ;; context-menu.lisp
  (:export
   :buffer-context-menu)
  ;; echo.lisp
  (:export
   :show-message
   :clear-message
   :message
   :message-without-log
   :message-buffer)
  ;; prompt.lisp
  (:export
   :*prompt-activate-hook*
   :*prompt-after-activate-hook*
   :*prompt-deactivate-hook*
   :*prompt-buffer-completion-function*
   :*prompt-file-completion-function*
   :caller-of-prompt-window
   :prompt-active-p
   :active-prompt-window
   :get-prompt-input-string
   :prompt-for-character
   :prompt-for-y-or-n-p
   :prompt-for-string
   :prompt-for-integer
   :prompt-for-buffer
   :prompt-for-file
   :prompt-for-directory
   :prompt-for-encodings
   :prompt-for-library)
  ;; buffer.lisp
  (:export
   :kill-buffer-hook)
  ;; window-tree.lisp
  (:export
   :balance-windows)
  ;; window.lisp
  (:export
   :line-wrap
   :*window-sufficient-width*
   :*scroll-recenter-p*
   :*window-scroll-functions*
   :*window-size-change-functions*
   :*window-show-buffer-functions*
   :window-parent
   :scroll
   :window-view-point
   :window
   :windowp
   :window-id
   :window-x
   :window-y
   :window-width
   :window-left-width
   :window-height
   :window-buffer
   :window-screen
   :window-view
   :window-point
   :window-cursor-invisible-p
   :set-last-print-cursor
   :last-print-cursor-x
   :last-print-cursor-y
   :window-parameter
   :window-delete-hook
   :window-leave-hook
   :window-use-modeline-p
   :window-redraw
   :current-window
   :last-focused-window
   :window-list
   :compute-window-list
   :one-window-p
   :deleted-window-p
   :window-see
   :split-window-vertically
   :split-window-horizontally
   :split-window-sensibly
   :get-next-window
   :delete-window
   :get-buffer-windows
   :other-buffer
   :not-switchable-buffer-p
   :switch-to-buffer
   :pop-to-buffer
   :quit-window
   :left-window
   :right-window
   :up-window
   :down-window
   :make-floating-window
   :floating-window
   :floating-window-border
   :floating-window-border-shape
   :floating-window-focusable-p
   :floating-window-p
   :update-on-display-resized
   :covered-with-floating-window-p
   :redraw-display
   :clear-screens-of-window-list
   :switch-to-window
   :window-set-pos
   :window-set-size
   :topleft-window-x
   :topleft-window-y
   :max-window-width
   :max-window-height
   :grow-window-height
   :shrink-window-height
   :grow-window-width
   :shrink-window-width
   :window-offset-view)
  ;; virtual-line
  (:export
   :window-recenter
   :window-cursor-x
   :window-cursor-y
   :backward-line-wrap
   :forward-line-wrap
   :move-to-next-virtual-line
   :move-to-previous-virtual-line
   :point-virtual-line-column
   :move-to-virtual-line-column
   :window-scroll)
  ;; header-window.lisp
  (:export
   :header-window)
  ;; side-window.lisp
  (:export
   :side-window
   :side-window-p
   :make-leftside-window
   :delete-leftside-window)
  ;; popup.lisp
  (:export
   :*default-popup-message-timeout*
   :display-popup-message
   :delete-popup-message
   :display-popup-menu
   :popup-menu-update
   :popup-menu-quit
   :popup-menu-down
   :popup-menu-up
   :popup-menu-first
   :popup-menu-last
   :popup-menu-select)
  ;; modeline.lisp
  (:export
   :modeline-format
   :modeline-add-status-list
   :modeline-remove-status-list
   :modeline-clear-status-list
   :modeline-write-info
   :modeline-name
   :modeline-mode-names
   :modeline-position
   :modeline-posline
   :convert-modeline-element)
  ;; command.lisp
  (:export
   :*pre-command-hook*
   :*post-command-hook*
   :command-name
   :this-command
   :this-command-keys
   :universal-argument-of-this-command
   :execute
   :call-command
   :all-command-names)
  ;; defcommand.lisp
  (:export
   :define-command)
  ;; mode.lisp
  (:export
   :ensure-mode-object
   :major-mode
   :mode-name
   :mode-description
   :mode-keymap
   :mode-syntax-table
   :mode-hook
   :mode-hook-variable
   :mode-active-p
   :major-modes
   :minor-modes
   :find-mode
   :toggle-minor-mode
   :define-major-mode
   :define-minor-mode
   :change-buffer-mode
   :define-global-mode
   :change-global-mode-keymap
   :enable-minor-mode
   :disable-minor-mode
   :current-global-mode
   :get-syntax-table-by-mode-name
   :set-region-major-mode
   :clear-region-major-mode
   :major-mode-at-point
   :current-major-mode-at-point
   :with-major-mode)
  ;; keymap.lisp
  (:export
   :*keymaps*
   :keymap
   :keymap-name
   :keymap-parent
   :keymap-undef-hook
   :make-keymap
   :*global-keymap*
   :define-key
   :define-keys
   :keyseq-to-string
   :find-keybind
   :insertion-key-p
   :lookup-keybind
   :keymap-find-keybind
   :*abort-key*
   :abort-key-p
   :with-special-keymap
   :traverse-keymap
   :compute-keymaps
   :collect-command-keybindings)
  ;; reexport common/timer
  (:export
   :timer
   :timer-name
   :timer-expired-p
   :make-timer
   :make-idle-timer
   :start-timer
   :stop-timer)
  ;; event-queue.lisp
  (:export
   :receive-event
   :send-event
   :send-abort-event
   :event-queue-length)
  ;; interp.lisp
  (:export
   :*editor-abort-hook*
   :*exit-editor-hook*
   :exit-editor
   :interactive-p
   :continue-flag
   :pop-up-backtrace
   :call-background-job
   :command-loop-counter
   :command-loop
   :do-command-loop)
  ;; input.lisp
  (:export
   :*input-hook*
   :last-read-key-sequence
   :start-record-key
   :stop-record-key
   :key-recording-p
   :read-event
   :read-key
   :unread-key
   :read-command
   :read-key-sequence
   :unread-key-sequence
   :execute-key-sequence
   :sit-for)
  ;; overlay.lisp
  (:export
   :overlay-start
   :overlay-end
   :overlay-attribute
   :set-overlay-attribute
   :overlay-buffer
   :make-overlay
   :make-line-endings-overlay
   :make-line-overlay
   :delete-overlay
   :overlay-put
   :overlay-get
   :clear-overlays
   :point-overlays)
  ;; streams.lisp
  (:export
   :buffer-input-stream
   :make-buffer-input-stream
   :buffer-output-stream
   :make-buffer-output-stream
   :editor-input-stream
   :make-editor-input-stream
   :editor-output-stream
   :make-editor-output-stream
   :make-editor-io-stream)
  ;; comp.lisp
  (:export
   :*file-completion-ignore-case*
   :completion
   :completion-test
   :completion-hypheen
   :completion-file
   :completion-strings
   :completion-buffer)
  ;; cursors.lisp
  (:export
   :fake-cursor
   :cursor-saved-column
   :cursor-yank-start
   :cursor-yank-end
   :change-yank-start
   :change-yank-end
   :cursor-mark
   :set-cursor-mark
   :cursor-region-beginning
   :cursor-region-end
   :buffer-fake-cursors
   :buffer-cursors
   :make-fake-cursor
   :delete-fake-cursor
   :merge-cursor-killrings
   :clear-cursors)
  ;; typeout.lisp
  (:export
   :*typeout-mode-keymap*
   :typeout-mode
   :pop-up-typeout-window)
  ;; lem.lisp
  (:export
   :*set-location-hook*
   :*before-init-hook*
   :*after-init-hook*
   :*splash-function*
   :setup-first-frame
   :find-editor-thread
   :init-at-build-time
   :lem
   :main)
  ;; command-advices.lisp
  (:export
   :movable-advice
   :editable-advice
   :jump-cursor-advice
   :process-each-cursors
   :do-each-cursors)
  ;; highlight-line.lisp
  (:export
   :highlight-line)
  ;; display/base.lisp
  (:export
   :wrap-line-character
   :wrap-line-attribute
   :inactive-window-background-color
   :redraw-buffer
   :compute-left-display-area-content)
  ;; interface.lisp
  (:export
   :with-implementation
   :implementation
   :redraw-after-modifying-floating-window
   :support-floating-window
   :set-foreground
   :set-background
   :display-width
   :display-height
   :display-title
   :display-fullscreen-p
   :attribute-foreground-color
   :attribute-background-color
   :attribute-foreground-with-reverse
   :attribute-background-with-reverse)
  ;; color-theme.lisp
  (:export
   :color-theme-names
   :define-color-theme
   :load-theme
   :current-theme
   :find-color-theme
   :color-theme
   :get-color-theme-color)
  ;; region.lisp
  (:export
   :check-marked-using-global-mode
   :region-beginning-using-global-mode
   :region-end-using-global-mode
   :set-region-point-using-global-mode
   :check-marked)
  ;; format.lisp
  (:export
   :*auto-format*
   :register-formatter
   :register-formatters
   :format-buffer))
#+sbcl
(sb-ext:lock-package :lem-core)

(defpackage :lem-core/popup-message-interface
  (:use :cl)
  (:export :*popup-messenger*
           :display-popup-message
           :delete-popup-message))

(defpackage :lem-restart
  (:use)
  (:export :message
           :call-function)
  #+sbcl
  (:lock t))

(defpackage :lem-interface
  (:nicknames :lem-if)
  (:use)
  (:export
   :*background-color-of-drawing-window*
   :invoke
   :get-background-color
   :get-foreground-color
   :update-foreground
   :update-background
   :update-cursor-shape
   :display-width
   :display-height
   :display-title
   :set-display-title
   :display-fullscreen-p
   :set-display-fullscreen-p
   :make-view
   :view-width
   :view-height
   :delete-view
   :clear
   :set-view-size
   :set-view-pos
   :redraw-view-before
   :redraw-view-after
   :will-update-display
   :update-display
   :display-popup-menu
   :popup-menu-update
   :popup-menu-quit
   :popup-menu-down
   :popup-menu-up
   :popup-menu-first
   :popup-menu-last
   :popup-menu-select
   :display-context-menu
   :clipboard-paste
   :clipboard-copy
   :increase-font-size
   :decrease-font-size
   :set-font-size
   :resize-display-before
   :get-font-list
   :get-mouse-position
   :get-char-width
   :get-char-height
   :clear-to-end-of-window
   :render-line
   :render-line-on-modeline
   :object-width
   :object-height))
