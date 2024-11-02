(defpackage :lem-sdl2/font
  (:use :cl)
  (:import-from :lem-sdl2/resource
                :get-resource-pathname)
  (:export :default-font-size
           :font
           :font-latin-normal-font
           :font-latin-bold-font
           :font-latin-italic-font
           :font-latin-oblique-font
           :font-latin-bold-italic-font
           :font-latin-bold-oblique-font
           :font-cjk-normal-font
           :font-cjk-bold-font
           :font-emoji-font
           :font-braille-font
           :font-char-width
           :font-char-height
           :save-font-size
           :make-font-config
           :font-config-size
           :merge-font-config
           :change-size
           :open-font
           :close-font
           :get-font-list))
(in-package :lem-sdl2/font)

(defparameter *default-font-size* 16)

(defun default-font-size () *default-font-size*)

(defstruct (font-config (:constructor %make-font-config))
  size
  latin-normal-file
  latin-bold-file
  latin-italic-file
  latin-oblique-file
  latin-bold-italic-file
  latin-bold-oblique-file
  cjk-normal-file
  cjk-bold-file
  emoji-file
  braille-file)

(defstruct font
  latin-normal-font
  latin-bold-font
  latin-italic-font
  latin-oblique-font
  latin-bold-italic-font
  latin-bold-oblique-font
  cjk-normal-font
  cjk-bold-font
  emoji-font
  braille-font
  char-width
  char-height)

(defun save-font-size (font-config &optional (ratio 1))
  (setf (lem:config :sdl2-font-size)
        (round (/ (font-config-size font-config) ratio))))

(defun make-font-config (&key (size (lem:config :sdl2-font-size *default-font-size*))
                              latin-normal-file
                              latin-bold-file
                              latin-italic-file
                              latin-oblique-file
                              latin-bold-italic-file
                              latin-bold-oblique-file
                              cjk-normal-file
                              cjk-bold-file
                              emoji-file
                              brail-file)
  (%make-font-config
   :size (lem:config :font-size (or size *default-font-size*))
   :latin-normal-file (or latin-normal-file
                          (lem:config
                           :sdl2-normal-font
                           (get-resource-pathname "resources/fonts/VictorMonoNF/Regular.ttf")))
   :latin-bold-file (or latin-bold-file
                        (lem:config
                         :sdl2-bold-font
                         (get-resource-pathname "resources/fonts/VictorMonoNF/Bold.ttf")))
   :latin-italic-file (or latin-italic-file
                          (lem:config
                           :sdl2-italic-font
                           (get-resource-pathname "resources/fonts/VictorMonoNF/Italic.ttf")))
   :latin-oblique-file (or latin-oblique-file
                           (lem:config
                            :sdl2-oblique-font
                            (get-resource-pathname "resources/fonts/VictorMonoNF/Oblique.ttf")))
   :latin-bold-italic-file (or latin-bold-italic-file
                               (lem:config
                                :sdl2-bold-italic-font
                                (get-resource-pathname "resources/fonts/VictorMonoNF/BoldItalic.ttf")))
   :latin-bold-oblique-file (or latin-bold-oblique-file
                                (lem:config
                                 :sdl2-bold-oblique-font
                                 (get-resource-pathname "resources/fonts/VictorMonoNF/BoldOblique.ttf")))
   ;; CJK is Chinese, Japanese and Korean
   :cjk-normal-file (or cjk-normal-file
                        (lem:config
                         :sdl2-cjk-normal-font
                         (get-resource-pathname "resources/fonts/NotoSansCJK-Regular.ttc")))
   :cjk-bold-file (or cjk-bold-file
                      (lem:config
                       :sdl2-cjk-bold-font
                       (get-resource-pathname "resources/fonts/NotoSansCJK-Bold.ttc")))
   :emoji-file (or emoji-file
                   (lem:config
                    :sdl2-emoji-font
                    (get-resource-pathname "resources/fonts/NotoColorEmoji.ttf")))
   :braille-file (or brail-file
                     (get-resource-pathname "resources/fonts/FreeMono.ttf"))))

(defun merge-font-config (new old)
  (%make-font-config :size (or (font-config-size new)
                               (font-config-size old))
                     :latin-normal-file (or (font-config-latin-normal-file new)
                                            (font-config-latin-normal-file old))
                     :latin-bold-file (or (font-config-latin-bold-file new)
                                          (font-config-latin-bold-file old))
                     :latin-italic-file (or (font-config-latin-italic-file new)
                                            (font-config-latin-italic-file old))
                     :latin-oblique-file (or (font-config-latin-oblique-file new)
                                             (font-config-latin-oblique-file old))
                     :latin-bold-italic-file (or (font-config-latin-bold-italic-file new)
                                                 (font-config-latin-bold-italic-file old))
                     :latin-bold-oblique-file (or (font-config-latin-bold-oblique-file new)
                                                  (font-config-latin-bold-oblique-file old))
                     :cjk-normal-file (or (font-config-cjk-normal-file new)
                                          (font-config-cjk-normal-file old))
                     :cjk-bold-file (or (font-config-cjk-bold-file new)
                                        (font-config-cjk-bold-file old))
                     :emoji-file (or (font-config-emoji-file new)
                                     (font-config-emoji-file old))
                     :braille-file (or (font-config-braille-file new)
                                       (font-config-braille-file old))))

(defun change-size (font-config size)
  (let ((font-config (copy-font-config font-config)))
    (setf (font-config-size font-config) size)
    font-config))

(defun get-character-size (font)
  (let* ((surface (sdl2-ttf:render-text-solid font " " 0 0 0 0))
         (width (sdl2:surface-width surface))
         (height (sdl2:surface-height surface)))
    (list width height)))

(defun open-font (&optional font-config)
  (let* ((font-config (or font-config (make-font-config)))
         (latin-normal-font (sdl2-ttf:open-font (font-config-latin-normal-file font-config)
                                                (font-config-size font-config)))
         (latin-bold-font (sdl2-ttf:open-font (font-config-latin-bold-file font-config)
                                              (font-config-size font-config)))
         (latin-italic-font (sdl2-ttf:open-font (font-config-latin-italic-file font-config)
                                                (font-config-size font-config)))
         (latin-oblique-font (sdl2-ttf:open-font (font-config-latin-oblique-file font-config)
                                                 (font-config-size font-config)))
         (latin-bold-italic-font (sdl2-ttf:open-font (font-config-latin-bold-italic-file font-config)
                                                     (font-config-size font-config)))
         (latin-bold-oblique-font (sdl2-ttf:open-font (font-config-latin-bold-oblique-file font-config)
                                                      (font-config-size font-config)))
         (cjk-normal-font (sdl2-ttf:open-font (font-config-cjk-normal-file font-config)
                                              (font-config-size font-config)))
         (cjk-bold-font (sdl2-ttf:open-font (font-config-cjk-bold-file font-config)
                                            (font-config-size font-config)))
         (emoji-font (sdl2-ttf:open-font (font-config-emoji-file font-config)
                                         (font-config-size font-config)))
         (braille-font (sdl2-ttf:open-font (font-config-braille-file font-config)
                                           (font-config-size font-config))))
    (destructuring-bind (char-width char-height)
        (get-character-size latin-normal-font)
      (make-font :latin-normal-font latin-normal-font
                 :latin-bold-font latin-bold-font
                 :latin-italic-font latin-italic-font
                 :latin-oblique-font latin-oblique-font
                 :latin-bold-italic-font latin-bold-italic-font
                 :latin-bold-oblique-font latin-bold-oblique-font
                 :cjk-normal-font cjk-normal-font
                 :cjk-bold-font cjk-bold-font
                 :emoji-font emoji-font
                 :braille-font braille-font
                 :char-width char-width
                 :char-height char-height))))

(defun close-font (font)
  (sdl2-ttf:close-font (font-latin-normal-font font))
  (sdl2-ttf:close-font (font-latin-bold-font font))
  (sdl2-ttf:close-font (font-latin-italic-font font))
  (sdl2-ttf:close-font (font-latin-oblique-font font))
  (sdl2-ttf:close-font (font-latin-bold-italic-font font))
  (sdl2-ttf:close-font (font-latin-bold-oblique-font font))
  (sdl2-ttf:close-font (font-cjk-normal-font font))
  (sdl2-ttf:close-font (font-cjk-bold-font font))
  (sdl2-ttf:close-font (font-emoji-font font))
  (sdl2-ttf:close-font (font-braille-font font))
  (values))

(defgeneric get-font-list (platform))

(defmethod get-font-list (platform)
  '())

(defmethod get-font-list ((platform lem-sdl2/platform:linux))
  (loop :for line :in (split-sequence:split-sequence #\newline
                                                     (uiop:run-program "fc-list" :output :string)
                                                     :remove-empty-subseqs t)
        :collect (first (split-sequence:split-sequence #\: line :count 1))))

(defmethod get-font-list ((platform lem-sdl2/platform:windows))
  (loop :for file :in (lem:directory-files "C:/Windows/Fonts/*.[otOT][tT][fF]")
        :collect (uiop:native-namestring file)))
