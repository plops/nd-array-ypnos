
(defmacro do-grid ((array kernel &optional border) &body body)
  (let* ((k (floor (length kernel) 2))
	 (lets (loop for l below (length kernel) and e in kernel collect
		    `(,e ,(- l k)))))
    `(let ((n (length ,array)))
       (loop for i below ,k do
	    (let ,(loop for (e j) in lets collect
		       (if (< j 0)
			   `(,e (+ i n ,j))
			   `(,e (+ i ,j))))
	      ,@body))
       (loop for i from ,k below (- n ,k 1) do
	    (let ,(loop for (e j) in lets collect
		       `(,e (+ i ,j)))
	      ,@body))
       (loop for i from (- n ,k) below n do
	    (let ,(loop for (e j) in lets collect
		       (if (< 0 j)
			   `(,e (+ i (- n) ,j))
			   `(,e (+ i ,j))))
	      ,@body)))))

(let ((a (make-array 5 :element-type 'single-float)))
  (do-grid (a (l c r))
    (setf (aref a c) (+ (aref a l) (aref a r)))))