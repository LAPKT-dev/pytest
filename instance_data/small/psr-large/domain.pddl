(define (domain psr)
  (:requirements :adl :derived-predicates)
  (:types device side line)
  (:constants side1 side2 - side earth - device)
  (:predicates (ext ?l - line ?x - device ?s - side)
               (breaker ?x - device)
               (closed ?x - device)
               (faulty ?l - line)
               (con ?x - device ?sx - side ?y - device ?sy - side)

               (upstream ?x - device ?sx - side ?y - device ?sy - side)
               (unsafe ?x - device ?sx - side)
               (affected ?x - device)
	       (fed ?l - line))

  (:derived (upstream ?x - device ?sx - side ?y - device ?sy - side)
      (and (closed ?x)
           (or (and (= ?sx side1) (con ?x side2 ?y ?sy))
               (and (= ?sx side2) (con ?x side1 ?y ?sy))
               (exists (?z - device)
		  (and (closed ?z)
                       (or (and (con ?z side1 ?y ?sy)
                                (upstream ?x ?sx ?z side2))
                           (and (con ?z side2 ?y ?sy)
                                (upstream ?x ?sx ?z side1))))))))


  (:derived (unsafe ?x - device ?sx - side)
     (and (closed ?x)
          (or (and (= ?sx side1)
                   (exists (?l - line)
                      (and (ext ?l ?x side2)
                           (or (faulty ?l)
                               (exists (?y - device)
                                  (exists (?sy - side)
                                     (and (con ?x side2 ?y ?sy)
                                          (unsafe ?y ?sy))))))))
              (and (= ?sx side2)
                   (exists (?l - line)
                      (and (ext ?l ?x side1)
                           (or (faulty ?l)
                               (exists (?y - device)
                                  (exists (?sy - side)
                                     (and (con ?x side1 ?y ?sy)
                                          (unsafe ?y ?sy)))))))))))

  (:derived (affected ?x - device)
        (and (breaker ?x)
             (exists (?sx - side) (unsafe ?x ?sx))))

  (:derived (fed ?l - line)
      (exists (?x - device) 
              (and (closed ?x) 
                   (or (and (ext ?l ?x side1) 
                            (or (breaker ?x)
                                (exists (?y - device)
                                   (exists (?sy - side)
                                      (and (breaker ?y)
                                           (upstream ?y ?sy ?x side2))))))
                       (and (ext ?l ?x side2) 
                            (or (breaker ?x)
                                (exists (?y - device)
                                   (exists (?sy - side)
                                      (and (breaker ?y)
                                           (upstream ?y ?sy ?x side1))))))))))

  (:action open
    :parameters (?x - device)
    :precondition (and (not (= ?x earth))
		       (closed ?x) 
                       (forall (?b - device) (not (affected ?b))))
    :effect (not (closed ?x)))

  (:action close
    :parameters  (?x - device)
    :precondition (and (not (= ?x earth))
		       (not (closed ?x))
                       (forall (?b - device) (not (affected ?b))))
    :effect (closed ?x))

  (:action wait
    :parameters  ()
    :precondition (exists (?b - device) (affected ?b))
    :effect (forall (?b - device) (when (affected ?b) (not (closed ?b)))))

)
