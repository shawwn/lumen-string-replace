
(define-global string-replace (str a b count pos)
  (let (k (# a) n (or count inf))
    (if (or (= count 0) (<= n 0) (<= k 0))
        str
      (let (i (or pos 0) j (search str a i))
        (with s (clip str 0 i)
          (while (and (or j (= j 0)) (> n 0))
            (dec n)
            (cat! s (clip str i j) b)
            (set i (+ j k))
            (set j (search str a i)))
          (cat! s (clip str i)))))))

(export string-replace)

