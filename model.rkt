#lang racket/base

; A blog is a (blog posts)
; where posts is a (listof post)
(struct blog (posts) #:mutable)

; and a post is a (post title body)
; where title is a string, body is a string,
; and comments is a (listof string)
(struct post (title body comments) #:mutable)

; BLOG: blog
; the initial BLOG
(define BLOG
  (blog
    (list 
      (post "Second Post" 
            "This is another post"
            (list))
      (post "First Post" 
            "This is my first post"
            (list "comment1" "comment2"))
          )))

; blog-insert-post!: blog post -> void
; Consumes a blog and a post, adds the post at the top of the blog.
(define (blog-insert-post! a-blog a-post)
  (set-blog-posts! a-blog
                   (cons a-post (blog-posts a-blog) )))

; blog-insert-post!: blog post -> void
; Consumes a blog and a post, adds the post at the top of the blog.
(define (post-insert-comment! a-post a-comment)
  (set-post-comments! a-post
                      (append (post-comments a-post) 
                              (list a-comment))))

(provide (all-defined-out))
