
import IMPdeP.*
import pelicula.*
import experiencia.*

class Artista {	
	var ahorros
	var categoria 
	
	
	method initialize(){
		iMPdeP.nuevoArtista(self)
	}
	
	method recategorizar(){
		categoria = categoria.reevaluarCategoria()
	}
	
	
	method nivelFama(){
		return self.cantidadPeliculasActuadas().div(2)
	}
	
	
	method salarioArtista(){
		return categoria.salario(self)
	}
	
	method tieneMejorSalarioQue(unSalario){
		return self.salarioArtista() > unSalario
	}
	
	method actuar(){
		ahorros += self.salarioArtista()
	}
	
	method cantidadPeliculasActuadas(){
		return self.peliculasEnLasQueActuo().size()
	}
	
	method peliculasEnLasQueActuo(){
		return iMPdeP.peliculasEnLasQueActuo(self)
	}
	
	method actuo(unaPelicula){
		//Supongo que cuando actua la pelicula se inicializa, recibiria como parametro un new Pelicula. Ej: artista.actuo(new Pelicula(elenco=[a,b,..., self,...,n))
		return unaPelicula.unArtistaActuo(self)
	}
}
