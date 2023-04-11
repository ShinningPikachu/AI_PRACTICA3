(define (domain rovers)
	(:requirements  :strips :adl :typing :equality :fluents)
	(:types
		base rover peticion - object
		asentamiento almacen - base
	)
	
	(:predicates
		(esta ?r - rover ?b - base)
		(conectado ?b1 - base ?b2 - base)
		(disponible ?a - almacen)
		(destinoPeticion ?p - peticion ?a - asentamiento)
		(vacio ?r - rover)
		(peticion-dePersonal ?p - peticion)
		(peticion-deSuministro ?p - peticion)
		(no-hecho ?p - peticion)
		(no-dePersonal ?r - rover)
		(no-deSuministro ?r - rover)
	)

	(:functions
		(disponiblePersonal ?a - base)
		(disponibleSuministro ?a - base)
		(numPersonal ?r - rover)
		(numSuministro ?r - rover)
		(combustible ?r - rover)
		(prioridad ?p - peticion)
		(preferencia3)
		(preferencia2)
		(preferencia1)
		(combustibleTotal)
	)

	(:action mover
		:parameters	(?r - rover ?b1 - base ?b2 - base)
		:precondition 	(and 
					(esta ?r ?b1)
					(> (combustible ?r) 0)
					(or (conectado ?b1 ?b2) (conectado ?b2 ?b1))
				)
		:effect 	(and
					(not (esta ?r ?b1))
					(esta ?r ?b2)
					(decrease (combustible ?r) 1)
					(increase (combustibleTotal) 1)
				)
	)

	(:action cargarPersonal
		:parameters	(?r - rover ?a - almacen)
		:precondition	(and 
					(or (vacio ?r) (no-deSuministro ?r))
					(< (numPersonal ?r) 2)
					(esta ?r ?a)
					(disponible ?a)
					(> (disponiblePersonal ?a) 0)
				)
		:effect		(and
					(when	(and (>= (disponiblePersonal ?a) 2) (= (numPersonal ?r) 0) )
						(and 
							(decrease (disponiblePersonal ?a) 2)
							(increase (numPersonal ?r) 2)
						)
					)
					
					(when 	(and (< (disponiblePersonal ?a) 2) (= (numPersonal ?r) 0) )
						(and
							(decrease (disponiblePersonal ?a) (disponiblePersonal ?a))
							(increase (numPersonal ?r) (disponiblePersonal ?a))
						)
					)

					(when	(= (numPersonal ?r) 1)
						(and 
							(decrease (disponiblePersonal ?a) 1)
							(increase (numPersonal ?r) 1)
						)
					)
					(not (vacio ?r))
					(not (no-dePersonal ?r))
				)
	)


	(:action cargarSuministro 
		:parameters	(?r - rover ?a - almacen)
		:precondition	(and
					(or (vacio ?r) (no-dePersonal ?r))
					(esta ?r ?a)
					(disponible ?a)
					(> (disponibleSuministro ?a) 0)
				)
		:effect		(and
					(decrease (disponibleSuministro ?a) (disponibleSuministro ?a))
					(increase (numSuministro ?r) (disponibleSuministro ?a))
					(not (vacio ?r))
					(not (no-deSuministro ?r))
				)
	)

	(:action descargarRover
		:parameters	(?r - rover ?a - asentamiento ?p - peticion)
		:precondition	(and
					(no-hecho ?p)
					(esta ?r ?a)
					(not (vacio ?r))
					(destinoPeticion ?p ?a)
				)
		:effect		(and 
					(when 	(and (> (numPersonal ?r) 0) (peticion-dePersonal ?p) (= (prioridad ?p) 3) )
						(and 	(decrease (numPersonal ?r) 1)
							(increase (disponiblePersonal ?a) 1)
							(increase (preferencia3) 1)
						)
					)
					(when 	(and (> (numSuministro ?r) 0) (peticion-deSuministro ?p) (= (prioridad ?p) 3) )
						(and 	(decrease (numSuministro ?r) 1)
							(increase (disponibleSuministro ?a) 1)
							(increase (preferencia3) 1)
						)
					)

					(when 	(and (> (numPersonal ?r) 0) (peticion-dePersonal ?p) (= (prioridad ?p) 2) )
						(and 	(decrease (numPersonal ?r) 1)
							(increase (disponiblePersonal ?a) 1)
							(increase (preferencia2) 1)
						)
					)
					(when 	(and (> (numSuministro ?r) 0) (peticion-deSuministro ?p) (= (prioridad ?p) 2) )
						(and 	(decrease (numSuministro ?r) 1)
							(increase (disponibleSuministro ?a) 1)
							(increase (preferencia2) 1)
						)
					)

					(when 	(and (> (numPersonal ?r) 0) (peticion-dePersonal ?p) (= (prioridad ?p) 1) )
						(and 	(decrease (numPersonal ?r) 1)
							(increase (disponiblePersonal ?a) 1)
							(increase (preferencia1) 1)
						)
					)
					(when 	(and (> (numSuministro ?r) 0) (peticion-deSuministro ?p) (= (prioridad ?p) 1) )
						(and 	(decrease (numSuministro ?r) 1)
							(increase (disponibleSuministro ?a) 1)
							(increase (preferencia1) 1)
						)
					)					
	
					(not (no-hecho ?p))
				)
	)

	(:action revisaEstadoAlmacen
		:parameters	(?a - almacen)
		:effect		(when 
					(and (= (disponiblePersonal ?a) 0) (= (disponibleSuministro ?a) 0) )
					(not (disponible ?a))
				)
	)

	(:action revisaEstadoRover
		:parameters	(?r - rover)
		:effect		(when
					(and (= (numPersonal ?r) 0) (= (numSuministro ?r) 0))
					(and (vacio ?r) (no-dePersonal ?r) (no-deSuministro ?r) )
				)
	)
	
	(:action revisaModoRover
		:parameters	(?r - rover)
		:effect		(and 
					(when 
						(and (= (numPersonal ?r) 0) (> (numSuministro ?r) 0) )
						(and (no-dePersonal ?r) (not (no-deSuministro ?r)) )
					)
					(when
						(and (= (numSuministro ?r) 0) (> (numPersonal ?r) 0) )
						(and (not (no-dePersonal ?r)) (no-deSuministro ?r) )
					)
				)
	)

)