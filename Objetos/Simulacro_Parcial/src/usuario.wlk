import cupon.*
import carrito.*
import pdePLibre.*
import nivel.*

class Usuario {	
	const nombre
	var dineroDisponible
	var puntos
	var nivel
	const carrito = new Carrito()
	const cupones = #{}
	
	method initialize(){
		pdePLibre.nuevoUsuario(self)
		
	}
	
	method actualizarNivel(){
		nivel = nivel.evaluarNivel(puntos)
	}
	
	method agregarProductoAlCarrito(unProducto){
		nivel.agregarProducto(carrito, unProducto)
	}
	
	method cuponesNoUsados(){
		return cupones.filter({unCupon => !unCupon.usado()})
	}
	
	method eliminarCuponesUsados(){
		cupones.removeAllSuchThat({unCupon => unCupon.usado()})
	}
	
	
	method comprarProductosDelCarrito(){
		const cupon = self.cuponesNoUsados().anyOne()
		const valorCompra = carrito.precioTotalCarritoConCupon(cupon.porcentajeDescuento())
		self.puedePagar(valorCompra)
		cupon.usar()
		dineroDisponible -= valorCompra
		puntos += valorCompra * 0.1
		self.actualizarNivel()
		
	}
	
	method puedePagar(unaCantidad){
		if (dineroDisponible < unaCantidad){
			throw new Exception(message= 'No tengo suficiente dinero para esta compra.')
		}
		
	}
	
	
	method cupones(){
		return cupones
	}
	
	method esMoroso(){
		return dineroDisponible < 0
	}
	
	method restarPuntos(unaCantidad){
		puntos -= unaCantidad
		self.actualizarNivel()
	}
	
}
