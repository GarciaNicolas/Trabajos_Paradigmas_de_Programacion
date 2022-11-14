import mision.*
import empleado.*

class Equipo {
	const integrantes = []
	
	method cumplirMision(unaMision){
		integrantes.forEach({unIntegrante => unIntegrante.cumplirMision(unaMision)})
	}
	
	method cumpleLosRequisitosParaMision(unaMision){
		return unaMision.requisitos().all({unRequisito => self.algunIntegranteTieneLaHabilidad(unRequisito)})
	}
	
	method algunIntegranteTieneLaHabilidad(unaHabilidad){
		return integrantes.any({unIntegrante=> unIntegrante.poseeHabilidad(unaHabilidad)})
		
		}
}
