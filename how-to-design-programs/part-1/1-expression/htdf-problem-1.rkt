;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdf-problem-1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;PROBLEM:
;Design a function that consumes a number and produces twice that number.
;Call your function double. Follow the HtDF recipe and show the stub and




; examples
(check-expect (double 3) 6)
(check-expect (double 4.2) 8.4)

; 1- signature: Number => Number
; purpose: produce 2 times the given number
; stub:

;(define (doubl n) 0) ; this is the stub

; inventory - template & contants (inventory means raw materials)
;(define (double n) ; this is the template
 ; (...n ))

(define (double n)
  (* 2 n))
