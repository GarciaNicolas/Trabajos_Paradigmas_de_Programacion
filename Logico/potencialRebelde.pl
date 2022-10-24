/* Punto 1 */

/* bakunin */
persona(bakunin).
profesion(bakunin,aviacionMilitar).
esBueno(bakunin,conduciendoAutos).
historialCriminal(bakunin, roboDeAeronaves).
historialCriminal(bakunin, fraude).
historialCriminal(bakunin, tenenciaDeCafeina).

/* ravachol */
persona(ravachol).
esBueno(ravachol, tiroAlBlanco).
leGusta(ravachol, juegosDeAzar).
leGusta(ravachol, ajedrez).
leGusta(ravachol, tiroAlBlanco).
historialCriminal(ravachol, falsificacionDeVacunas).
historialCriminal(ravachol, fraude).

/* rosaDubovsky */
persona(rosaDubovsky).
quiereSer(rosaDubovsky, recolectorDeBasura).
quiereSer(rosaDubovsky, asesinaASueldo).
esBueno(rosaDubovsky,construyendoPuentes).
esBueno(rosaDubovsky,mirandoPeppaPig).
leGusta(rosaDubovsky,mirarPeppaPig).
leGusta(rosaDubovsky,construirPuentes).
leGusta(rosaDubovsky,fisicaCuantica).

/* emmaGoldman */
persona(emmaGoldman).
profesion(emmaGoldman, profesoraDeJudo).
profesion(emmaGoldman, cineasta).
esBueno(emmaGoldman, UnaCosa):-
    esBueno(judithButler, UnaCosa).
esBueno(emmaGoldman, UnaCosa):-
    esBueno(elisaBachofen, UnaCosa).
leGusta(emmaGoldman, Gusto) :-
  leGusta(judithButler, Gusto).

/* judithButler */
persona(judithButler).
profesion(judithButler, profesoraDeJudo).
profesion(judithButler, inteligenciaMilitar).
esBueno(judithButler, judo).
leGusta(judithButler, judo).
leGusta(judithButler, carrerasDeAutomovilismo).
historialCriminal(judithButler, falsificacionDeCheque).
historialCriminal(judithButler, fraude).

/* elisaBachofen */
persona(elisaBachofen).
profesion(elisaBachofen, ingenieraMecanica).
leGusta(elisaBachofen, fuego).
leGusta(elisaBachofen, destruccion).
esBueno(elisaBachofen, armarBombas).

/*juanSuriano*/
persona(juanSuriano).
leGusta(juanSuriano, judo).
leGusta(juanSuriano, armarBombas).
leGusta(juanSuriano, ringRaje).
historialCriminal(juanSuriano, fraude).
historialCriminal(juanSuriano, falsificacionDeDinero).

/* sebastienFaure */ 
persona(sebastienFaure).


/* Punto 2 */

/* casa(Casa,Residentes,Cuartos)
  cuartoSecreto(ancho, largo)
  tunelSecreto(largo, estado)    */
casa(laSeverino,[bakunin,elisaBachofen,rosaDubovsky],[cuartoSecreto(4,8),pasadizo,tunelSecreto(8,terminado),tunelSecreto(5,terminado),tunelSecreto(1,enConstruccion)]).
casa(comisaria48,[ravachol],[]).
casa(casaDePapel,[emmaGoldman,juanSuriano,judithButler],[pasadizo,pasadizo,cuartoSecreto(5,3),cuartoSecreto(4,7),tunelSecreto(9,terminado),tunelSecreto(2,terminado)]).
casa(casaDelSolNaciente,[],[pasadizo,tunelSecreto(3,enConstruccion)]).

viveEn(Persona, Vivienda):-
  casa(Vivienda,Miembros,_),
  member(Persona,Miembros).
  

viviendaConPotencialRebelde(Vivienda):-
  viveUnPosibleDisidente(Vivienda),
  superficieClandestinaPeligrosa(Vivienda, _).

viveUnPosibleDisidente(Vivienda):-  
  viveEn(Persona, Vivienda),
  posibleRebelde(Persona).


superficieClandestinaPeligrosa(Casa,SuperficieTotal):-
    casa(Casa,_,Cuartos),
    findall(Superficie,superficieParcial(Cuartos,Superficie),Superficie),
    sumlist(Superficie, SuperficieTotal),
    SuperficieTotal > 50.
    
superficieParcial(Cuartos,Superficie):-
    member(Cuarto,Cuartos),
    superficie(Cuarto,Superficie).

superficie(cuartoSecreto(Ancho,Altura),Superficie):-
    Superficie is Ancho * Altura.

superficie(pasadizo,Superficie):-
    Superficie is 1.

superficie(tunelSecreto(Largo,terminado),Superficie):-
    Superficie is Largo * 2.


/*punto 4*/

noViveNadie(Vivienda):-  
  casa(Vivienda,_,_),
  not(viveEn(_, Vivienda)).
  
 /* Detectar si en una vivienda todos los que viven tienen al menos un gusto en común.*/ 

gustoEnComunVivienda(Vivienda):-
  viveEn(Alguien,Vivienda),
  leGusta(Alguien,Algo),
  forall(viveEn(Otro,Vivienda),leGusta(Otro,Algo)).


/* Punto 5 */  

posibleRebelde(Persona):-  
  tienePosibleHabilidadTerrorista(Persona),
  gustosTerroristas(Persona),
  viveOTieneRegistroCriminal(Persona, Vivienda).

viveOTieneRegistroCriminal(Persona, Vivienda):-
  viveEn(Persona, Vivienda),
  historialCriminal(Persona,OtroCrimen),
  historialCriminal(Persona,UnCrimen),
  UnCrimen \= OtroCrimen.

viveOTieneRegistroCriminal(Persona, Vivienda):-
  viveEn(OtraPersona, Vivienda),
  historialCriminal(OtraPersona,_),
  Persona \= OtraPersona.


gustosTerroristas(Persona):-
  not(leGusta(Persona,_)).

gustosTerroristas(Persona):-
  forall(esBueno(Persona, Gusto), leGusta(Persona, Gusto)). 

tienePosibleHabilidadTerrorista(Persona):-
  esBueno(Persona, HabilidadTerrorista),
  habilidadTerrorista(HabilidadTerrorista).
  
habilidadTerrorista(armarBombas).
habilidadTerrorista(tirarAlBlanco).
habilidadTerrorista(mirarPeppaPig).

/*Punto 6: Bunkers
 Para agregar los Bunkers, simplemente habría que agregar una nueva cláusula para el predicado superficie(), de la siguiente manera. 


bunker(Perimetro, SuperficieInterna).

superficie(bunker(Perimetro, SuperficieInterna), Superficie):-
  Superficie is Perimetro + SuperficieInterna.*/



/* Punto 7 */

batallonDeRebeldes(Personas):-
  
  findall(Persona, viveOTieneRegistroCriminal(Persona, Vivienda), Personas),
  tieneMasDe3Habilidades(Personas).

tieneMasDe3Habilidades(Personas):-
  findall(Habilidad, habilidad(Personas, Habilidad), Habilidades),
  length(Habilidades, Cantidad),
  Cantidad > 3.

habilidad(UnaHabilidad,Personas):-
  member(Persona,Personas),
  esBueno(Persona,UnaHabilidad).

/* Prolog se basa en consultas existenciales buscando encontrar la forma de que un predicado sea siempre verdadero*/