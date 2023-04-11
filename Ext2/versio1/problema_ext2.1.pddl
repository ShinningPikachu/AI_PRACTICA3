(define (problem rovers-basic)
	(:domain rovers)
	(:objects as1 as2 as3				- asentamiento
		  al1 al2 				- almacen
		  r1 r2					- rover
		  p1 p2	p3 p4 p5 - peticion
	)

	(:init  (esta r1 as1) (esta r2 as1)

		(conectado as1 al1) (conectado as1 al2) (conectado as1 as3)
		(conectado as3 al1) (conectado as3 al2) 
		(conectado as2 al1)
		
		(= (disponibleSuministro al1) 1) (= (disponibleSuministro al2) 1) 
		(= (disponiblePersonal as1) 1) (= (disponiblePersonal as2) 0) (= (disponiblePersonal as3) 1) 
		
		(= (numPersonal r1) 0) (= (numPersonal r2) 0)
		(= (numSuministro r1) 0) (= (numSuministro r2) 0) 

		(vacio r1) (vacio r2)

		(= (combustible r1) 10) (= (combustible r2) 10)

		(peticion-dePersonal p1) (peticion-dePersonal p4) (peticion-dePersonal p5)
		(peticion-deSuministro p2) (peticion-deSuministro p3) 

		(no-dePersonal r1) (no-deSuministro r1)
		(no-dePersonal r2) (no-deSuministro r2)

		(no-hecho p1) (no-hecho p2) (no-hecho p3) (no-hecho p4) (no-hecho p5)
		
		(no-disponible as2)
		(disponible al1) (disponible al2) (disponible as1) (disponible as3)
		
		(destinoPeticion p1 as2) (destinoPeticion p2 as3) (destinoPeticion p3 as1) (destinoPeticion p4 as3) (destinoPeticion p5 as1)
		


	)

	(:goal  (and
			(forall (?b - base) (no-disponible ?b))
			(forall (?r - rover) (vacio ?r))
		)
	)

)