(define (problem rovers-basic)
	(:domain rovers)
	(:objects as1 as2 as3				- asentamiento
		  al1 al2 al3				- almacen
		  r1 r2					- rover
		  p1 p2	p3 p4 p5 p6 p7 p8 p9 p10	- peticion
	)

	(:init  (esta r1 as1) (esta r2 as1)

		(conectado as1 al1) (conectado as1 al2) (conectado as1 as3)
		(conectado as3 al1) (conectado as3 al2) (conectado as3 al3)
		(conectado as2 al1) (conectado as2 al3) (conectado al2 al3)
		
		(= (disponibleSuministro al1) 1) (= (disponibleSuministro al2) 2) (= (disponibleSuministro al3) 1) 
		(= (disponiblePersonal as1) 3) (= (disponiblePersonal as2) 0) (= (disponiblePersonal as3) 1) 
		
		(= (numPersonal r1) 0) (= (numPersonal r2) 0)
		(= (numSuministro r1) 0) (= (numSuministro r2) 0) 

		(vacio r1) (vacio r2)

		(peticion-dePersonal p1) (peticion-dePersonal p4) (peticion-dePersonal p5) (peticion-dePersonal p9) (peticion-dePersonal p10) 
		(peticion-deSuministro p2) (peticion-deSuministro p3) (peticion-deSuministro p6) (peticion-deSuministro p7) (peticion-deSuministro p8)

		(no-dePersonal r1) (no-deSuministro r1)
		(no-dePersonal r2) (no-deSuministro r2)

		(no-hecho p1) (no-hecho p2) (no-hecho p3) (no-hecho p4) (no-hecho p5)
		(no-hecho p6) (no-hecho p7) (no-hecho p8) (no-hecho p9) (no-hecho p10)

		(no-disponible as2)
		(disponible al1) (disponible al2) (disponible al3) (disponible as1) (disponible as3)
		
		(destinoPeticion p1 as2) (destinoPeticion p2 as3) (destinoPeticion p3 as1) (destinoPeticion p4 as3) (destinoPeticion p5 as3)
		(destinoPeticion p6 as1) (destinoPeticion p7 as1) (destinoPeticion p8 as2) (destinoPeticion p9 as1) (destinoPeticion p10 as3)

	)

	(:goal  (and
			(forall (?b - base) (no-disponible ?b))
			(forall (?r - rover) (vacio ?r))
		)
	)

)