import puesto.*
import mision.*

class Empleado{
	const habilidades = #{}
	var salud
	const puesto
	
	method cumpleLosRequisitosParaMision(unaMision){
		return unaMision.requisitos().all({unRequisito => self.poseeHabilidad(unRequisito)})
	}
	
	method estaIncapacitado(){
		return salud < puesto.saludCritica()
	}
	
	method puedeUsarHabilidad(unaHabilidad){
		return self.poseeHabilidad(unaHabilidad) and !self.estaIncapacitado()
	}
	
	method poseeHabilidad(unaHabilidad){
		return habilidades.contains(unaHabilidad)
	}
	
	method cumplirMision(unaMision){
		self.recibirDanio(unaMision.danioIndividual())
		if (salud > 0) {
			puesto.recompensarMision()
		}
	}
	
	
	method recibirDanio(unDanio){
		salud -= unDanio
	}
}

class Jefe inherits Empleado{
	const subordinados = []
	
	override method poseeHabilidad(unaHabilidad){
		return super(unaHabilidad) and self.subordinadosPoseenHabilidad(unaHabilidad)
	}
	
	method subordinadosPoseenHabilidad(unaHabilidad){
		return subordinados.any({unSubordinado => unSubordinado.poseeHabilidad(unaHabilidad)})
	}	
}