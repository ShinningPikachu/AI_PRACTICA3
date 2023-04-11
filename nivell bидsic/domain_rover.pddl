(define (domain rovers)
	(:requirements  :strips :adl :typing :equality)
	(:types
		base rover peticion - object
		asentamiento almacen - base
	)
	
	(:predicates
		(esta ?r - rover ?b - base)
		(conectado ?b1 - base ?b2 - base)
		(disponible ?b - base)
		(no-disponible ?b - base)
		(destinoPeticion ?p - peticion ?a - asentamiento)
		(vacio ?r - rover)
		(peticion-dePersonal ?p - peticion)
		(peticion-deSuministro ?p - peticion)
		(no-hecho ?p - peticion)
	)

	(:functions
		(disponiblePersonal ?b - base)
		(disponibleSuministro ?b - base)
		(numPersonal ?r - rover)
		(numSuministro ?r - rover)
	)

	(:action mover
		:parameters	(?r - rover ?b1 - base ?b2 - base)
		:precondition 	(and 
					(esta ?r ?b1)
					(or (conectado ?b1 ?b2) (conectado ?b2 ?b1))
				)
		:effect 	(and
					(not (esta ?r ?b1))
					(esta ?r ?b2)
				)
	)

	(:action cargarPersonal
		:parameters	(?r - rover ?a - asentamiento)
		:precondition	(and 
					(esta ?r ?a)
					(disponible ?a)
				)
		:effect		(and
					(decrease (disponiblePersonal ?a) (disponiblePersonal ?a))
					(increase (numPersonal ?r) (disponiblePersonal ?a))
					(not (vacio ?r))
				)
	)

	(:action cargarSuministro
		:parameters (?r - rover ?a - almacen)
		:precondition	(and
					(esta ?r ?a)
					(disponible ?a)
				)
		:effect		(and
					(decrease (disponibleSuministro ?a) (disponibleSuministro ?a))
					(increase (numSuministro ?r) (disponibleSuministro ?a))
					(not (vacio ?r))
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
					(when 	(and (> (numPersonal ?r) 0) (peticion-dePersonal ?p) )
						(decrease (numPersonal ?r) 1)
					)
					(when 	(and (> (numSuministro ?r) 0) (peticion-deSuministro ?p))
						(decrease (numSuministro ?r) 1)
					)
					(not (no-hecho ?p))
				)
	)

	(:action revisaEstadoAlmacen
		:parameters	(?a - almacen)
		:effect		(when 
					(and (= (disponibleSuministro ?a) 0) )
					(and (no-disponible ?a) (not (disponible ?a))) 
				)
	)

	(:action revisaEstadoAsentamiento
		:parameters	(?a - asentamiento)
		:effect		(when 
					(and (= (disponiblePersonal ?a) 0) )
					(and (no-disponible ?a) (not (disponible ?a))) 
				)
	)

	(:action revisaEstadoRover
		:parameters	(?r - rover)
		:effect		(when
					(and (= (numPersonal ?r) 0) (= (numSuministro ?r) 0))
					(vacio ?r)
				)
	)
)