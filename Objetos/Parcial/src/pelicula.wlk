import IMPdeP.*
import artista.*

class Pelicula {
	const nombre
	const elenco = []
	
	method initialize(){
		iMPdeP.nuevaPelicula(self)
	}
	
	
	method presupuesto(){
		return elenco.sum({unArtista => unArtista.salarioArtista()}) * 1.7
	}
	
	method ganancias(){
		return self.cuantoRecaudo()-self.presupuesto()
	}
	
	method cuantoRecaudo(){
		return 1000000 + self.plusRecaudacion()
	}
	
	method plusRecaudacion(){
		return 0
	}
	
	method rodar(){
		elenco.forEach({unArtista => unArtista.actuar()})
	}
	
	method unArtistaActuo(unArtista){
		return elenco.contains(unArtista)
	}
	
	method esEconomica(){
		return self.presupuesto() < 500000
	}
}

class PeliculaDeAccion inherits Pelicula{
	const vidriosRotos
	
	override method initialize(){
		super() //Wollok no lee el initialize de la superclase
	}
	
	override method presupuesto(){
		return super() + 1000 * vidriosRotos
	}
	
	override method plusRecaudacion(){
		return 50000 * elenco.size()
	}
	
}

class PeliculaDeDrama inherits Pelicula{
	
	override method initialize(){
		super() //Wollok no lee el initialize de la superclase
	}
	
	override method plusRecaudacion(){
		return 100000 * nombre.size()
	}
}

class PeliculaDeTerror inherits Pelicula{
	const cucho
	
	override method initialize(){
		super() //Wollok no lee el initialize de la superclase
	}
	
	
	override method plusRecaudacion(){
		return 20000 * cucho
	}
}


class PeliculaDeComedia inherits Pelicula{
	
	override method initialize(){
		super() //Wollok no lee el initialize de la superclase
	}
	
}