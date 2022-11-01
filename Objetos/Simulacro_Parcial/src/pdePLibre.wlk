import usuario.*
import producto.*

object pdePLibre {

	const usuarios = #{}
	const productos = []
	
	method nuevoProducto(unProducto){
		productos.add(unProducto)
	}
	
	method nuevoUsuario(unUsuario){
		usuarios.add(unUsuario)
	}
	
	method actualizarNiveles(){
		usuarios.forEach({unUsuario => unUsuario.actualizarNivel()})
	}
	
	method nombresDeOferta(){
		return productos.map({unProducto => unProducto.nombreDeOferta()})
	}
	
	method eliminarCuponesUsados(){
		usuarios.forEach({unUsuario => unUsuario.eliminarCuponesUsados()})
	}
	
	method reducirPuntosMorosos(){
		self.usuariosMorosos().forEach({unUsuario => unUsuario.restarPuntos(1000)})
	}
	
	method usuariosMorosos(){
		return usuarios.filter({unUsuario => unUsuario.esMoroso()})
	}
	
}
