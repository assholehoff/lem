(defpackage :lem-sdl2/font-new
  (:use :cl)
  (:import-from :lem-sdl2/resource
                :get-resource-pathname)
  (:export :default-font
           :default-font-size
           :font
           ;; various font functions and methods
           ;; class accessors etc
           :font-latin-font
           :font-cjk-font
           ;; these should probably remain available:
           :font-emoji-font
           :font-braille-font
           :font-char-width
           :font-char-height
           :save-font
           :save-font-size
           :make-font-config
           :change-font
           :current-font
           :change-size
           :open-font
           :close-font
           :get-font-list))
(in-package :lem-sdl2/font-new)

(defparameter *default-font-size* 16)

(defun default-font-size () *default-font-size*)

 ;; face:    sans-serif, serif, monospace
 ;; script:  latin, cjk, rmoji, braille, greek, cyrillic, arabic, etc
 ;; style:   italic, oblique, small caps
 ;; weight:  1-1000: description (synonym)
         ;;  100: Thin (Hairline)
         ;;  200: Extra Light (Ultra Light)
         ;;  300: Light
         ;;  400: Normal (Regular)
         ;;  500: Medium
         ;;  600: Semi Bold (Demi Bold)
         ;;  700: Bold
         ;;  800: Extra Bold
         ;;  900: Black (Heavy)
         ;;  950: Extra Black (Ultra Black)
 ;; width:   value: description (% of normal)
         ;;  1: Ultra-condensed (50)
         ;;  2: Extra-condensed (62.5)
         ;;  3: Condensed (75)
         ;;  4: Semi-condensed (87.5)
         ;;  5: Medium (Normal) (100)
         ;;  6: Semi-expanded (112.5)
         ;;  7: Expanded (125)
         ;;  8: Extra-expanded (150)
         ;;  9: Ultra-expanded (200)

(defparameter *default-latin-font* "VictorMonoNF")

(defun default-font (&key script) 
  (cond ((eq script :latin)
         *default-latin-font*)
        ((eq script :cjk)
         *default-cjk-font*)
        ((eq script :emoji)
         *default-emoji-font*)
        ((eq script :braille)
         *default-braille-font*)))

(defclass font-files () 
  (thin-italic-file
   thin-normal-file
   thin-oblique-file
   extra-light-italic-file
   extra-light-normal-file
   extra-light-oblique-file
   light-italic-file
   light-normal-file
   light-oblique-file
   normal-italic-file
   normal-normal-file
   normal-oblique-file
   medium-italic-file
   medium-normal-file
   medium-oblique-file
   semi-bold-italic-file
   semi-bold-normal-file
   semi-bold-oblique-file
   bold-italic-file
   bold-normal-file
   bold-oblique-file
   extra-bold-italic-file
   extra-bold-normal-file
   extra-bold-oblique-file
   black-italic-file
   black-normal-file
   black-oblique-file))

(defclass font () 
  (name 
   script
   font-files))

(defun change-font (font &key script))

(defun current-font (&key script))

(defun save-font (font-config &key (script :latin))
  (let ((script (cond ((eq script :latin)
                       :sdl2-latin-font)
                      ((eq script :cjk)
                       :sdl2-cjk-font)
                      ((eq script :emoji)
                       :sdl2-emoji-font)
                      ((eq script :braille)
                       :sdl2-braille-font))))
    (setf (lem:config script)
          (current-font :script script))))