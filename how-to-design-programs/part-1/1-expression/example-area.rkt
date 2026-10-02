;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname example-area) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;signature: number => number
; purpose: calculate the area of the square from one side length
; stub
;(define (area n) 0)


;test
(check-expect (area 4) 16)
(check-expect (area 0) 0)
(check-expect (area 2.5) 6.25)

;inventory
;template
;(define (area n)
 ; (...))
;code body
(define (area n)
  (sqr n))
