(define (problem rovers-basic)
	(:domain rovers)
	(:objects as1 as2					- asentamiento
		  al1 al2						- almacen
		  r1 r2							- rover
		  p1 p2	p3 p4					- peticion
	)

	(:init  (esta r1 as1) (esta r2 as1)

		(conectado as1 al1) (conectado as1 al2) (conectado as2 al1)
		
		(= (disponiblePersonal al1) 1) (= (disponiblePersonal al2) 1) 
		(= (disponibleSuministro al1) 0) (= (disponibleSuministro al2) 1)

		(= (disponiblePersonal as1) 0)   (= (disponiblePersonal as2) 0)
		(= (disponibleSuministro as1) 0) (= (disponibleSuministro as2) 0)
		
		(= (numPersonal r1) 0) (= (numPersonal r2) 0)
		(= (numSuministro r1) 0) (= (numSuministro r2) 0) 

		(= (combustible r1) 10)	(= (combustible r2) 10)	
		
		(vacio r1) (vacio r2)

		(peticion-dePersonal p1) (peticion-dePersonal p4) 
		(peticion-deSuministro p2) (peticion-deSuministro p3)

		(no-dePersonal r1) (no-dePersonal r2)
		(no-deSuministro r1) (no-deSuministro r2)

		(no-hecho p1) (no-hecho p2) (no-hecho p3) (no-hecho p4)

		(disponible al1) (disponible al2)
		
		(destinoPeticion p1 as1) (destinoPeticion p2 as2) (destinoPeticion p3 as1) (destinoPeticion p4 as1)
		

		(= (prioridad p1) 3) (= (prioridad p2) 1) (= (prioridad p3) 2) (= (prioridad p4) 2)
		

		(= (preferencia1) 0)
		(= (preferencia2) 0)
		(= (preferencia3) 0)
		(= (combustibleTotal) 0)
	)

	(:goal  (and
			(forall (?a - almacen) (not (disponible ?a)) )
			(forall (?r - rover) (vacio ?r))
		)
	)

	(:metric minimize (+ (* (+ ( * (preferencia3) 0.1) (+ (* (preferencia2) 0.3) (* (preferencia1) 0.6)) ) 0.5) (* (combustibleTotal) 0.5) ) )	 

)