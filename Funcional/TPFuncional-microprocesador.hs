{--
A = acumulador
B = acumulador B
addr = address (unaPosicion en memoria comineza en 1)
val = unValor
PC = program counter (+1 cada instruccion)
error = etiqueta de ultome msg error

NOP == no operation
ADD == A = A + B && B = 0 (B se resetea)
DIV == A = A 'div' B && B = 0 (B se resetea)
SWAP == A pasa a ser B y B pasa a ser A
LOD addr == addr (unaPosicion) = A
STR addr == addr (unaPosicion) = val (unValor)
LODV val == A = val
--}

--3.1
import Text.Show.Functions

data Procesador = UnProcesador { 
    acumuladorA :: Acumulador, 
    acumuladorB :: Acumulador, 
    pc :: ProgramCounter, 
    errorProcesador :: Error, 
    memoria :: Memoria,
    programa :: Programa} deriving Show

type Acumulador = Int
type ProgramCounter = Int
type Error = String
type Memoria = [Int]

type MicroInstruccion = Procesador -> Procesador

type Programa = [MicroInstruccion]

mapAcumuladorA :: (Int -> Int) -> MicroInstruccion
mapAcumuladorA  unaFuncion unProcesador = unProcesador { acumuladorA = (unaFuncion) . acumuladorA $ unProcesador}
mapAcumuladorB :: (Int -> Int) ->  MicroInstruccion
mapAcumuladorB unaFuncion unProcesador = unProcesador { acumuladorB = (unaFuncion) . acumuladorB $ unProcesador}

mapProgramCounter :: (Int -> Int) -> MicroInstruccion
mapProgramCounter unaFuncion unProcesador  = unProcesador { pc = (unaFuncion) . pc $ unProcesador}

mapErrorProcesador :: (String -> String)  -> MicroInstruccion
mapErrorProcesador unaFuncion unProcesador = unProcesador { errorProcesador = (unaFuncion) . errorProcesador $ unProcesador}

mapMemoria:: ([Int] -> [Int]) -> MicroInstruccion
mapMemoria unaFuncion unProcesador  = unProcesador { memoria = (unaFuncion) . memoria $ unProcesador}

mapPrograma :: (Programa -> Programa) -> MicroInstruccion
mapPrograma unaFuncion unProcesador = unProcesador { programa = (unaFuncion).programa $ unProcesador}

setAcumuladorA :: Int -> MicroInstruccion
setAcumuladorA unValor unProcesador = mapAcumuladorA (const unValor) unProcesador

setAcumuladorB :: Int -> MicroInstruccion
setAcumuladorB unValor unProcesador = mapAcumuladorB (const unValor) unProcesador

xt8088 :: Procesador 
xt8088 = UnProcesador { acumuladorA = 0, acumuladorB = 0, pc = 0, errorProcesador = "", memoria = replicate 1024 0, programa = []}

--3.2


aumentarProgramCounter :: MicroInstruccion
aumentarProgramCounter unProcesador = mapProgramCounter (+1) unProcesador

nop :: MicroInstruccion
nop unProcesador = aplicarMicroInstruccion id unProcesador
--Interviene el concepto de tuplas y de tipos

--3.3

lodv:: Int -> MicroInstruccion
lodv unNumero unProcesador  = aplicarMicroInstruccion (setAcumuladorA unNumero) unProcesador

swap:: MicroInstruccion
swap unProcesador =  aplicarMicroInstruccion (setAcumuladorA (acumuladorB unProcesador) . setAcumuladorB (acumuladorA unProcesador) )unProcesador

add:: MicroInstruccion
add unProcesador = aplicarMicroInstruccion (operacionEntreAcumuladores (+)) unProcesador


--3.4

divide :: MicroInstruccion
divide (UnProcesador acumuladorA 0 pc _ memoria programa) = (UnProcesador acumuladorA 0 (pc + 1) "DIVISION BY ZERO" memoria programa)
divide unProcesador = aplicarMicroInstruccion (operacionEntreAcumuladores (flip div)) unProcesador

operacionEntreAcumuladores :: (Int -> Int -> Int) -> MicroInstruccion
operacionEntreAcumuladores unaOperacion unProcesador = mapAcumuladorA (unaOperacion (acumuladorB unProcesador)) . setAcumuladorB 0  $ unProcesador


str:: Int-> Int-> MicroInstruccion
str posicion valorNuevo unProcesador = mapMemoria (insertoValorEnListaMayorPosicion posicion valorNuevo) . aumentarProgramCounter $ unProcesador 

insertoValorEnListaMayorPosicion :: Num a => Int -> a -> [a] -> [a] 
insertoValorEnListaMayorPosicion  unaPosicion unValor unaLista = (take (unaPosicion - 1 ) unaLista) ++ (unValor : (drop unaPosicion unaLista))

lod:: Int -> MicroInstruccion
lod posicion unProcesador = mapAcumuladorA  (const ((memoria unProcesador) !! (posicion - 1) ) ) . aumentarProgramCounter $ unProcesador

--Entrega 2--
--3.1--
cargarUnPrograma :: Programa -> Procesador -> Procesador 
cargarUnPrograma unPrograma unProcesador = mapPrograma (const unPrograma) unProcesador 

aplicarMicroInstruccion :: MicroInstruccion -> Procesador -> Procesador
aplicarMicroInstruccion unaMicroInstruccion unProcesador
    |tieneError unProcesador = unProcesador 
    |otherwise =  unaMicroInstruccion unProcesador 

tieneError :: Procesador -> Bool
tieneError unProcesador = not . null . errorProcesador $ unProcesador



--3.2--
ejecutarPrograma :: Procesador -> Procesador
ejecutarPrograma (UnProcesador acumuladorA acumuladorB pc "" memoria programa) = ejecutarProgramaEnProcesador (UnProcesador acumuladorA acumuladorB pc "" memoria programa) programa
ejecutarPrograma unProcesador = unProcesador

-- "En estas dos funciones repiten la lógica de ejecutar un conjunto de instrucciones! deleguen en una función que las tome por parámetro."
-- nuevaFuncion :: Microinstruccion
-- nuevaFuncion  unProcesador = foldl (flip aplicarMicroInstruccion) unProcesador unPrograma

--3.3--
ifnz :: Programa -> MicroInstruccion
ifnz unPrograma unProcesador
    | (acumuladorA unProcesador) == 0 = unProcesador
    | otherwise = ejecutarProgramaEnProcesador unProcesador unPrograma

ejecutarProgramaEnProcesador :: Procesador -> Programa -> Procesador 
ejecutarProgramaEnProcesador unProcesador unPrograma = foldl (flip aplicarMicroInstruccion) unProcesador unPrograma

--3.4--
depurarPrograma :: Programa -> Programa
depurarPrograma unPrograma = filter noDejaEnCero unPrograma

noDejaEnCero :: MicroInstruccion -> Bool
noDejaEnCero unaMicroInstruccion = not . sonIgualesLosProcesadores procesadorGenerico. aplicarMicroInstruccion unaMicroInstruccion $ procesadorGenerico

sonIgualesLosProcesadores :: Procesador -> Procesador -> Bool
sonIgualesLosProcesadores unProcesador otroProcesador = (acumuladorA unProcesador) == (acumuladorA otroProcesador) && (acumuladorB unProcesador) == (acumuladorB otroProcesador) && (memoria unProcesador) == (memoria otroProcesador)

procesadorGenerico :: Procesador 
procesadorGenerico = UnProcesador { acumuladorA = 0, acumuladorB = 0, pc = 0, errorProcesador = "", memoria = replicate 1024 0, programa = []}

--3.5--
memoriaOrdenada :: Procesador -> Bool
memoriaOrdenada unProcesador = menorIgual (memoria unProcesador)

menorIgual :: Memoria -> Bool
menorIgual [] = True
menorIgual [_] = True
menorIgual (x1:x2:xs) = (x1 <= x2) && menorIgual (x2 : xs)

--3.6--

--procesadorPrueba :: Procesador
--procesadorPrueba = UnProcesador { acumuladorA = 0, acumuladorB = 0, pc = 0, errorProcesador = "", memoria = [0,0..]}
{--
¿Qué sucede al querer cargar y ejecutar el programa que suma 10 y 22 en el procesador con memoria infinita?
Lo hace bien, devuelve un procesador con los cambios hechos y la lista infinita.
¿Y si queremos saber si la memoria está ordenada (punto anterior)?
No tira error, compila bien, pero no devuelve nada porque se queda haciendo la comparación ya que al usar recursividad y ser infinito no hay manera que el código de un resultado.
--}
--4-- Casos de Prueba (TODOS LOS CASOS DIERON BIEN)


--fp20 :: Procesador 
--fp20 = UnProcesador { acumuladorA = 7, acumuladorB = 24, pc = 0, errorProcesador = "", memoria = replicate 4 0, programa = []}

--microDesorden :: Procesador 
--microDesorden = UnProcesador { acumuladorA = 0, acumuladorB = 0, pc = 0, errorProcesador = "", memoria = [2,5,1,0,6,9]}

