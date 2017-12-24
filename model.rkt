#lang racket

; A blog is a (blog posts)
; where posts is a (listof post)
(struct blog (home posts) #:mutable #:prefab)

; and a post is a (post title body)
; where title is a string, body is a string,
; and comments is a (listof string)
(struct post (title body comments) #:mutable #:prefab)

; initialize-blog! : path? -> blog
; Reads a blog from a path, if not present, returns default
(define (initialize-blog! home)
  (define (log-missing-exn-handler exn)
    (blog
      (path->string home)
      (list (post "Second Post" 
                  "This is another post"
                  (list))
            (post "First Post" 
                  "This is my first post"
                  (list "comment1" "comment2")))))
  
  (define the-blog
    (with-handlers ([exn? log-missing-exn-handler])
                   (with-input-from-file home read)))

  (set-blog-home! the-blog (path->string home))
  the-blog)

; save-blog! : blog -> void
; Saves the contents of a blog to its home
(define (save-blog! a-blog)
  (define (write-to-blog)
    (write a-blog))
  (with-output-to-file 
    (blog-home a-blog)
    write-to-blog
    #:exists 'replace))
                   

; blog-insert-post!: blog post -> void
; Consumes a blog and a post, adds the post at the top of the blog.
(define (blog-insert-post! a-blog title body)
  (set-blog-posts! 
    a-blog
    (cons (post title body empty) (blog-posts a-blog)))
  (save-blog! a-blog))


; blog-insert-post!: blog post -> void
; Consumes a blog and a post, adds the post at the top of the blog.
(define (post-insert-comment! a-blog a-post a-comment)
  (set-post-comments! 
    a-post
    (append (post-comments a-post) (list a-comment)))
  (save-blog! a-blog))

(provide blog? blog-posts
         post? post-title post-body post-comments
         initialize-blog!
         blog-insert-post! post-insert-comment!)
