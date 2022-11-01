import producto.*

class Carrito {
	const productos = []
	
	method agregarProducto(unProducto){
		productos.add(unProducto)
	}
	
	method precioTotalCarrito(){
		return productos.sum({unProducto => unProducto.precioFinal()})
	}
	
	method precioTotalCarritoConCupon(unDescuento){
		return self.precioTotalCarrito() * (1 - unDescuento)
	}
	
}
