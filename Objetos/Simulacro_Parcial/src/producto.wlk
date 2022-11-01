import pdePLibre.*

class Producto {
	const nombre
	const precioBase
	
	method initialize(){
		pdePLibre.nuevoProducto(self)
		
	}
	
	method precioFinal()
	
	
	
	method nombreDeOferta(){
		return 'SUPER OFERTA ' + nombre
	}	
	method precioConIVA(){
		return precioBase * 1.21
	}
	
	
}

class Mueble inherits Producto{

	
	override method precioFinal(){
		return self.precioConIVA() + 1000
	}
	
}


class Indumentaria inherits Producto{
	

	
	override method precioFinal(){
		return self.precioConIVA()
	}
}

class Ganga inherits Producto{
	
	override method nombreDeOferta(){
		return nombre + 'COMPRAME POR FAVOR'
	}
	
	override method precioFinal(){
		return 0
	}
}
