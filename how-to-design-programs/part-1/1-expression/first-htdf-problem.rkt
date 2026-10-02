;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname first-htdf-problem) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Problem: Design a function that pluralizes a given word.
;(Pluralize means to convert the word to its plural form.)
; For simplicity you may assume that just adding s is enough to pluralize a word.

;signature: string => string
;purpose: plurarize given word
;test
(check-expect (plurarize "apple") "apples")
(check-expect (plurarize "pen") "pens")
; stub
;(define (plurarize str) "")

;template
(define (plurarize w)
  (string-append w "s"))