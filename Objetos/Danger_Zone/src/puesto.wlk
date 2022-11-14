import habilidad.*

object espia {
	method saludCritica(){
		return 15
	}
	
	method recompensarMision(){
		return new Habilidad()
	}
	
}

class Oficinista{
	var cantidadDeMedallas = 0
	method saludCritica(){
		return 40 - 5 * cantidadDeMedallas
	}
	
	method recompensarMision(){
		cantidadDeMedallas += 1
	}
}
