import artista.*
class Experiencia{
	
	method salario(unArtista)
	method reevaluarCategoria(unArtista)

}


object amateur inherits Experiencia{
	override method salario(unArtista){
		return 10000
	}
	
	override method reevaluarCategoria(unArtista){
		if (unArtista.cantidadPeliculasActuadas() > 10){
			return establecido
		}
		else {
			return self
		}
	}
}

object establecido inherits Experiencia{
	
	override method salario(unArtista){
		const nivelFama = unArtista.nivelFama()
		if (nivelFama >= 15) {
			return 5000 * nivelFama
		}
		return 15000
	}
	
	override method reevaluarCategoria(unArtista){
		if (unArtista.nivelFama() > 10){
			return amateur
		}
		else {
			return self
		}
	}
}

object estrella inherits Experiencia{
	override method salario(unArtista){
		return 30000 * unArtista.cantidadPeliculasActuadas()
	}
	
	override method reevaluarCategoria(unArtista){
		throw new Exception(message='No se puede recategorizar a una estrella.')
	}
	
}
