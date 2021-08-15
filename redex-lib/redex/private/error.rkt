#lang racket/base

(provide redex-error
         exn:fail:redex?
         (struct-out exn:fail:redex)
         unsupported
         unimplemented)

(define-struct (exn:fail:redex exn:fail) ())
(define (redex-error name fmt . args)
  (define suffix (apply format fmt args))
  (define message
    (if name
        (format "~a: ~a" name suffix)
        suffix))
  (raise (make-exn:fail:redex message (current-continuation-marks))))

(define (unsupported pat)
  (redex-error 'generate-term "#:i-th does not support ~s patterns" pat))

(define (unimplemented pat)
  (redex-error 'generate-term "#:i-th does not yet support ~s patterns" pat))

(struct exn:fail:redex:contract exn:fail:redex
  (name contract terms))

(struct exn:fail:redex:contract-judgment exn:fail:redex:contract (judgment))
(struct exn:fail:redex:contract-relation exn:fail:redex:contract (relation))

(struct exn:fail:redex:metafunction exn:fail:redex
  (name))

(struct exn:fail:redex:no-pattern-matched exn:fail:redex:metafunction
  ())

(struct exn:fail:redex:pattern-multiple-matches exn:fail:redex:metafunction
  ())

(struct exn:fail:redex:match-different-results exn:fail:redex:metafunction
  ())

(struct exn:fail:redex:not-in-domain exn:fail:redex:metafunction
  ())

(struct exn:fail:redex:codomain-test-failed exn:fail:redex:metafunction
  ())

(struct exn:fail:redex:no-clauses-matched exn:fail:redex:metafunction
  ())
