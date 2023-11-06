/* 
Apellido y nombre: Luciano Foglia
Nro de Legajo: 2036241
*/

class Plato{
	// Punto 1
	method calorias() = self.azucar() * 3 + 100
	method azucar()
}


class Entrada inherits Plato{
	method esBonito() = true
	override method azucar() = 0	
}

class Principal inherits Plato{
	var azucar
	var esBonito
	override method azucar() = azucar
	method esBonito() = esBonito
}

class Postre inherits Plato{
	var cantColores
	override method azucar() = 120
	method esBonito() = cantColores > 3
}

// Cree esta clase para no tener que hacer dos listas para el torneo, una para participantes y
// otra para platos presentados (la otra opcion que se me habia ocurrido)
class PlatoPresentado{
	var plato
	var creador
	method creador() = creador
	method plato() = plato
}



class Cocinero{
	var especialidad
	// Punto 2
	method catarYDarCalificacion(plato) = especialidad.puntaje(plato)
	
	// Punto 3
	method cambiarEspecialidad(cual){
		especialidad = cual
	}
	
	// Punto 5
	method cocinar() = especialidad.cocinar()
	
	// Punto 6)A)
	method participar(torneo){
		const platoParticipante = new PlatoPresentado(plato = self.cocinar(),creador = self)
		torneo.agregarPlato(platoParticipante)
	}
}


class Pastelero{
	var dulzorDeseado
	
	method puntaje(plato) =
		((5*plato.azucar()) / dulzorDeseado).min(10)
	
	method cocinar() = new Postre(cantColores = dulzorDeseado/50)
}

class Chef{
	var cantCaloriasDeseada
	
	method puntaje(plato) =
		if (self.cumpleCriterio(plato))
			10
		else
			0
	
	method cocinar() = new Principal(esBonito = true,azucar = cantCaloriasDeseada)
	
	method cumpleCriterio(plato) = plato.esBonito() and plato.calorias() <= cantCaloriasDeseada
}


// Punto 4
class Souschef inherits Chef{

	override method cocinar() = new Entrada()
	override method puntaje(plato) =
		if(self.cumpleCriterio(plato))
 			super(plato)
		else
			(plato.calorias() / 100).min(6)			
}


class Torneo{
	const catadores = #{}
	var platosPresentados = #{}
	
	method agregarPlato(plato){
		platosPresentados.add(plato)
	}
	
	// Punto 6)B)
	method cocineroGanador() = 
		if (platosPresentados.isEmpty())
			throw new DomainException(message = "No se presentaron participantes")
		else
			self.platoPresentadoGanador().creador()
	
	method platoPresentadoGanador() = platosPresentados.max({platoPresentado => self.puntajeTotal(platoPresentado.plato())})
	
	method puntajeTotal(plato) = catadores.sum({catador => catador.catarYDarCalificacion(plato)})
}



