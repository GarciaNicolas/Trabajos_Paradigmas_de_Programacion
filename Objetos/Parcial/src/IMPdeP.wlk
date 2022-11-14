import artista.*
import pelicula.*

object iMPdeP {
	const peliculas = []
	const artistas = []
	
	method peliculas(){
		return peliculas
	}
	method nuevaPelicula(unaPelicula){
		peliculas.add(unaPelicula)
	}
	method nuevoArtista(unArtista){
		artistas.add(unArtista)
	}
	
	method artistaMejorPago(){
		return artistas.find({unArtista => self.tieneElMejorSalario(unArtista)})
	}
	
	method tieneElMejorSalario(unArtista){
		return artistas.all({otroArtista => unArtista.tieneMejorSalarioQue(otroArtista.salarioArtista())})
	}
	
	method gananciasTotalesDePeliculasEconomicas(){
		return self.todasLasPeliculasEconomicas().sum({unaPelicula => unaPelicula.ganancias()})
	}
	
	method todasLasPeliculasEconomicas(){
		return peliculas.filter({unaPelicula => unaPelicula.esEconomica()})
	}
	
	method recategorizarTodosLosArtistas(){
		artistas.forEach({unArtista=> unArtista.recategorizar()})
	}
	
	method peliculasEnLasQueActuo(unArtista){
		return peliculas.filter({unaPelicula => unArtista.actuo(unaPelicula)})
	}
}
