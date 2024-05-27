/** Reemplazar por la solución del enunciado */

class Marca {
	
}

class CosaGuardable {
	
	var property volumen //numerito
	var property marca // una instanacia de Marca?
	var property magico //booleano
	var property reliquia //booleano

}

class Mueble {
	 const cosas = #{}
	 
	 method tiene(cosa) {
	 	return cosas.contains(cosa)
	 }
	
	 method puedeGuardar(cosa) {
	 	return not self.tiene(cosa)
	 }
	 
	 method validarGuardar(cosa) {
	 	if (not self.puedeGuardar(cosa)) {
	 		self.error("No se puede guardar " + cosa)
	 	}
	 }
	 
	 method guardar(cosa) {
	 	self.validarGuardar(cosa)
	 	cosas.add(cosa)
	 }
}

class Baul inherits Mueble {
	const volumenMaximo
	
	override method puedeGuardar(cosa) {
		return super(cosa) and self.hayEspacio(cosa) 
	}
	
	method hayEspacio(cosa) {
		return volumenMaximo >= self.volumenActual() + cosa.volumen()
	}
	
	method volumenActual() {
		return cosas.sum({cosa => cosa.volumen()})
	} 
}

class GabineteMagico inherits Mueble {
	override method puedeGuardar(cosa) {
		return super(cosa) and cosa.magico() 
	}
	
}

class Armario inherits Mueble{
	var property cantidadMaxima 

	override method puedeGuardar(cosa) {
		return super(cosa) and self.hayLugar() 
	}
	
	method hayLugar() {
		return cantidadMaxima > cosas.size() 
	}

}

class Academia {
	const muebles = #{}
	
	method tiene(cosa) {
		return muebles.any({mueble => mueble.tiene(cosa)})
	}
	
	method dondeGuarda(cosa) {
		return muebles.find({mueble => mueble.tiene(cosa)})
	}
	
	method dondeGuardar(cosa){
		return muebles.filter({mueble => mueble.puedeGuardar(cosa)})	
	}
	
	method puedeGuardar(cosa) {
		return not self.tiene(cosa) and self.existeMuebleParaGuardar(cosa)
	}
	
	method existeMuebleParaGuardar(cosa) {
		return muebles.any({mueble => mueble.puedeGuardar(cosa)})
	}
	
	method validarGuardar(cosa) {
		if (not self.puedeGuardar(cosa)) {
			self.error("No se puede guardar " + cosa )
		}
	}

// Mejor alternativa si no existía el dondeGuardar!
//	
//	method elegirMueble(cosa) {
//		return muebles.find({mueble => mueble.puedeGuardar(cosa)})
//	}

	method elegirMueble(cosa) {
		return self.dondeGuardar(cosa).anyOne()
	}
	
	method guardar(cosa) {
		self.validarGuardar(cosa)
		self.elegirMueble(cosa).guardar(cosa)
	}
}	

