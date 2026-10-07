;; Auto-generated. Do not edit!


(when (boundp 'beginner_hiwonder::Person)
  (if (not (find-package "BEGINNER_HIWONDER"))
    (make-package "BEGINNER_HIWONDER"))
  (shadow 'Person (find-package "BEGINNER_HIWONDER")))
(unless (find-package "BEGINNER_HIWONDER::PERSON")
  (make-package "BEGINNER_HIWONDER::PERSON"))
(unless (find-package "BEGINNER_HIWONDER::PERSONREQUEST")
  (make-package "BEGINNER_HIWONDER::PERSONREQUEST"))
(unless (find-package "BEGINNER_HIWONDER::PERSONRESPONSE")
  (make-package "BEGINNER_HIWONDER::PERSONRESPONSE"))

(in-package "ROS")





(intern "*UNKNOWN*" (find-package "BEGINNER_HIWONDER::PERSONREQUEST"))
(shadow '*UNKNOWN* (find-package "BEGINNER_HIWONDER::PERSONREQUEST"))
(defconstant beginner_hiwonder::PersonRequest::*UNKNOWN* 0)
(intern "*MALE*" (find-package "BEGINNER_HIWONDER::PERSONREQUEST"))
(shadow '*MALE* (find-package "BEGINNER_HIWONDER::PERSONREQUEST"))
(defconstant beginner_hiwonder::PersonRequest::*MALE* 1)
(intern "*FEMALE*" (find-package "BEGINNER_HIWONDER::PERSONREQUEST"))
(shadow '*FEMALE* (find-package "BEGINNER_HIWONDER::PERSONREQUEST"))
(defconstant beginner_hiwonder::PersonRequest::*FEMALE* 2)
(defclass beginner_hiwonder::PersonRequest
  :super ros::object
  :slots (_name _age _sex ))

(defmethod beginner_hiwonder::PersonRequest
  (:init
   (&key
    ((:name __name) "")
    ((:age __age) 0)
    ((:sex __sex) 0)
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _age (round __age))
   (setq _sex (round __sex))
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:age
   (&optional __age)
   (if __age (setq _age __age)) _age)
  (:sex
   (&optional __sex)
   (if __sex (setq _sex __sex)) _sex)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; int8 _age
    1
    ;; int8 _sex
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; int8 _age
       (write-byte _age s)
     ;; int8 _sex
       (write-byte _sex s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int8 _age
     (setq _age (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _age 127) (setq _age (- _age 256)))
   ;; int8 _sex
     (setq _sex (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _sex 127) (setq _sex (- _sex 256)))
   ;;
   self)
  )

(defclass beginner_hiwonder::PersonResponse
  :super ros::object
  :slots (_result ))

(defmethod beginner_hiwonder::PersonResponse
  (:init
   (&key
    ((:result __result) "")
    )
   (send-super :init)
   (setq _result (string __result))
   self)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:serialization-length
   ()
   (+
    ;; string _result
    4 (length _result)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _result
       (write-long (length _result) s) (princ _result s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _result
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _result (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass beginner_hiwonder::Person
  :super ros::object
  :slots ())

(setf (get beginner_hiwonder::Person :md5sum-) "8252a159fd1a6ef4321e6f234278121d")
(setf (get beginner_hiwonder::Person :datatype-) "beginner_hiwonder/Person")
(setf (get beginner_hiwonder::Person :request) beginner_hiwonder::PersonRequest)
(setf (get beginner_hiwonder::Person :response) beginner_hiwonder::PersonResponse)

(defmethod beginner_hiwonder::PersonRequest
  (:response () (instance beginner_hiwonder::PersonResponse :init)))

(setf (get beginner_hiwonder::PersonRequest :md5sum-) "8252a159fd1a6ef4321e6f234278121d")
(setf (get beginner_hiwonder::PersonRequest :datatype-) "beginner_hiwonder/PersonRequest")
(setf (get beginner_hiwonder::PersonRequest :definition-)
      "string name
int8 age
int8 sex

int8 unknown = 0
int8 male = 1
int8 female = 2

---
string result
")

(setf (get beginner_hiwonder::PersonResponse :md5sum-) "8252a159fd1a6ef4321e6f234278121d")
(setf (get beginner_hiwonder::PersonResponse :datatype-) "beginner_hiwonder/PersonResponse")
(setf (get beginner_hiwonder::PersonResponse :definition-)
      "string name
int8 age
int8 sex

int8 unknown = 0
int8 male = 1
int8 female = 2

---
string result
")



(provide :beginner_hiwonder/Person "8252a159fd1a6ef4321e6f234278121d")


