
(defmacro do-grid ((array kernel &optional border) &body body)
  (let ((k (floor (length kernel) 2)))
    `(let ((n (length ,array)))
       (loop for i from ,k below (- n ,k 1) do
	    (let ,(loop for l below (length kernel) and e in kernel collect
		       `(,e (+ i ,(- l k))))
	      ,@body)))))

(let ((a (make-array 5 :element-type 'single-float)))
  (do-grid (a (l c r))
    (setf (aref a c) (+ (aref a l) (aref a r)))))