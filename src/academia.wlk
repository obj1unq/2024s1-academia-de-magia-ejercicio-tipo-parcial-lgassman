/** Reemplazar por la solución del enunciado */

//class Marca {
//	method utilidad(cosa) 
//}

//Marcas
object acme {
	method utilidad(cosa) {
		return cosa.volumen() / 2
	}
}

object cuchuflito {
	method utilidad(cosa) {
		return 0
	}	
}

object fenix {
	method utilidad(cosa) {
		return if(cosa.reliquia()) 3 else 0
	}	
}

class CosaGuardable {
	
	var property volumen //numerito
	var property marca // una instanacia de Marca?
	var property magico //booleano
	var property reliquia //booleano
	
	method utilidad() {
		return self.volumen() + self.utilidadSiMagica() + self.utilidadSiReliquia() + self.utilidadPorMarca() 
	}
	
	method utilidadSiMagica() {
		return if (magico) 3 else 0
	}
	
	method utilidadSiReliquia() {
		return if (reliquia) 5 else 0
	}
	
	method utilidadPorMarca() {
		return marca.utilidad(self)
	}

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
	 
	 method utilidad() {
	 	 return self.utilidadDeLasCosas() / self.precio()	
	 }
	 
	 method utilidadDeLasCosas() {
	 	return cosas.sum({cosa => cosa.utilidad()})
	 }
	 
	 method precio() 
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
	
	override method precio() {
		return volumenMaximo + 2
	}
	
	override method utilidad() {
		return super() + self.extraSiReliquias()	
	}
	
	method extraSiReliquias() {
		return if (self.todasReliquias()) 2 else 0
	}
	
	method todasReliquias() {
		return cosas.all({cosa => cosa.reliquia()})
	}
}

class GabineteMagico inherits Mueble {
	
	const precio
	
	override method puedeGuardar(cosa) {
		return super(cosa) and cosa.magico() 
	}
	
	override method precio() {
		return precio
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

	override method precio() {
		return 5 * cantidadMaxima
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

