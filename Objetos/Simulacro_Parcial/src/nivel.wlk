import producto.*
import carrito.*

class Nivel {
	
	method cantidadMaximaProductos()
	
	method evaluarNivel(unosPuntos){
		if (unosPuntos <= 5000){
			return bronce
		}
		if (5000 < unosPuntos <= 15000){
			return plata
		}
		else {
			return oro
		}
	}
	
	
	method verificarEspacioDisponible(unCarrito){
		if (self.cantidadMaximaProductos() <= unCarrito.size()){
			throw new Exception (message= 'Tu nivel no permite agregar más productos al carrito.')
		}
	}
	
	method agregarProducto(unCarrito, unProducto){
		self.verificarEspacioDisponible(unCarrito)
		unCarrito.agregarProducto(unProducto)
		
	}
	
	method nivelPermitido(unosPuntos){
	}
	
}

object bronce inherits Nivel{
	
	override method cantidadMaximaProductos(){
		return 1
	}

}

object plata inherits Nivel{
	override method cantidadMaximaProductos(){
		return 5
	}
}

object oro inherits Nivel{
	
	override method cantidadMaximaProductos(){}
	
	
	override method agregarProducto(unCarrito, unProducto){
		unCarrito.agregarProducto(unProducto)
	}
	
}

