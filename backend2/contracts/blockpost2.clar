;; blockpost2
;; Contract that writes a post on chain for a small fee

;;wallet that gets the STX fee
(define-constant contract-owner tx-sender)

;;how much to post
(define-constant price u1000000) ;; 1 STX

;;how many posts have been written to the chain
(define-data-var total-posts uint u0)

;;assigning the string to specific address/wallet
(define-map post principal (string-utf8 500))

;;to get the total posts on chain
(define-read-only (get-total-posts) 
  (var-get total-posts)
)

;; get posts from a specific user/address
(define-read-only (get-post (user principal)) 
  (map-get? post user) 
)

;;user will be able to write their message
(define-public (write-post (message (stringutf8 500))) 
  (begin 
    (try! stx-transfer? price tx-sender contract-owner);; fee is sent to contact owner
    (map-set post tx-sender message);; assign the message to the author/wallet
    (var-set total-posts (+ (var-get toal-posts) u1));; update total posts by 1
    (ok "SUCCESS");; if all works well 
  )
)
