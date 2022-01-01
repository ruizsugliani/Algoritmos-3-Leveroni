!classDefinition: #DialogosConPNJsTest category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!
TestCase subclass: #DialogosConPNJsTest
	instanceVariableNames: 'trebor opinionDeRiverwood carolina'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!

!DialogosConPNJsTest methodsFor: 'tests - conversador' stamp: 'JMB 11/6/2021 01:00:39'!
test01CuandoElConversadorInteractuaPorPrimeraVezConUnPersonajeLeRespondeConSuPrimerFrase
	| mensaje |
	mensaje := self pnjConversadorTrebor interactuarCon: self pjHamilton.
	
	self assert: 'Hola forastero' equals: mensaje.
! !

!DialogosConPNJsTest methodsFor: 'tests - conversador' stamp: 'JMB 11/6/2021 01:00:54'!
test02CuandoElConversadorInteractuaPorSegundaVezConUnPersonajeLeRespondeConSuSegundaFrase
	| mensaje |
	self pnjConversadorTrebor interactuarCon: self pjHamilton.
	
	mensaje := self pnjConversadorTrebor interactuarCon: self pjHamilton.
	
	self assert: '¿Todo bien?' equals: mensaje.! !

!DialogosConPNJsTest methodsFor: 'tests - conversador' stamp: 'JMB 11/6/2021 01:01:06'!
test03CuandoElConversadorOlvidaInteraccionesPreviasConUnPersonajeAlVolverAInteractuarLeRespondeConSuPrimerFrase
	| mensaje |
	self pnjConversadorTrebor interactuarCon: self pjHamilton.
	self pnjConversadorTrebor olvidar.
	
	mensaje := self pnjConversadorTrebor interactuarCon: self pjHamilton.
	
	self assert: 'Hola forastero' equals: mensaje.! !

!DialogosConPNJsTest methodsFor: 'tests - conversador' stamp: 'srs 11/6/2021 10:30:06'!
test04CuandoElConversadorInterctuaYTerminoSuRepertorioDeFrasesConUnPersonajeLeRespondeConSuUltimaFrase
	| mensaje |
	self unConversadorTerminaSuRepertorioDeFrasesCon: self pjHamilton. 
	
	mensaje := self pnjConversadorTrebor interactuarCon: self pjHamilton.
	
	self assert: '¿Algún problema?' equals: mensaje.! !

!DialogosConPNJsTest methodsFor: 'tests - conversador' stamp: 'JMB 11/6/2021 01:01:53'!
test05ElConversadorMantieneInteraccionesEnParaleloConDiferentesPersonajes

	self assert: 'Hola forastero' equals: (self pnjConversadorTrebor interactuarCon: self pjHamilton).
	self assert: 'Hola forastero' equals: (self pnjConversadorTrebor interactuarCon: self pjTirion).! !

!DialogosConPNJsTest methodsFor: 'tests - conversador' stamp: 'JMB 11/6/2021 01:03:19'!
test06ElConversadorMantieneInteraccionesCompletasEnParaleloConDiferentesPersonajes
	
	self assert: 'Hola forastero' equals: (self pnjConversadorTrebor interactuarCon: self pjHamilton).
	
	self assert: 'Hola forastero' equals: (self pnjConversadorTrebor interactuarCon: self pjTirion).
	self assert: '¿Todo bien?' equals: (self pnjConversadorTrebor interactuarCon: self pjTirion).
	self assert: '¿Algún problema?' equals: (self pnjConversadorTrebor interactuarCon: self pjTirion).
	
	self assert: '¿Todo bien?' equals: (self pnjConversadorTrebor interactuarCon: self pjHamilton).
	self assert: '¿Algún problema?' equals: (self pnjConversadorTrebor interactuarCon: self pjHamilton).! !

!DialogosConPNJsTest methodsFor: 'tests - conversador' stamp: 'JMB 11/6/2021 01:03:32'!
test07CuandoElConversadorInteractuaPorPrimeraVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuPrimerFrase
	| mensaje |
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	
	mensaje := self pnjConversadorTrebor interactuarCon: self pjHamilton.
	
	self assert: 'Bienvenido aventurero!!' equals: mensaje.
! !

!DialogosConPNJsTest methodsFor: 'tests - conversador' stamp: 'JMB 11/6/2021 01:03:42'!
test08CuandoElConversadorInteractuaPorSegundaVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuSegundaFrase
	| mensaje |
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	self pnjConversadorTrebor interactuarCon: self pjHamilton.
	
	mensaje := self pnjConversadorTrebor interactuarCon: self pjHamilton.
	
	self assert: 'Espero que tengas una buena estadia en Riverwood' equals: mensaje.! !


!DialogosConPNJsTest methodsFor: 'tests - influyente' stamp: 'srs 11/6/2021 10:16:14'!
test09CuandoUnInfluyenteTerminaSuRepertorioDeFrasesConUnPersonajeNoCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedorSiNoLoConocenSuficientesPNJs
	
	self unInfluyenteTerminaSuRepertorioDeFrasesCon: self pjHamilton. 
	
	self deny: (self esVistoPorElPuebloComoPrometedor: self pjHamilton).! !

!DialogosConPNJsTest methodsFor: 'tests - influyente' stamp: 'srs 11/6/2021 10:17:27'!
test10CuandoUnInfluyenteTerminaSuRepertorioDeFrasesConUnPersonajeCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedorSiLoConocenSuficientesPNJs
	
	self unConversadorTerminaSuRepertorioDeFrasesCon: self pjHamilton. 

	self unInfluyenteTerminaSuRepertorioDeFrasesCon: self pjHamilton. 
	
	self assert: (self esVistoPorElPuebloComoPrometedor: self pjHamilton).! !

!DialogosConPNJsTest methodsFor: 'tests - influyente' stamp: 'srs 11/6/2021 10:18:03'!
test11CuandoUnInfluyenteCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedorReiniciaSuHiloDeDialogoConElPersonaje
	
	self unConversadorTerminaSuRepertorioDeFrasesCon: self pjHamilton. 

	self unInfluyenteTerminaSuRepertorioDeFrasesCon: self pjHamilton. 
	
	self assert: 'Salud aventurero!!' equals: (self pnjInfluyenteCarolina interactuarCon: self pjHamilton)! !

!DialogosConPNJsTest methodsFor: 'tests - influyente' stamp: 'srs 11/6/2021 10:18:17'!
test12CuandoUnInfluyenteCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedorReiniciaLosHilosDeDialogosDelRestoDeLosPNJs
	
	self unConversadorTerminaSuRepertorioDeFrasesCon: self pjHamilton. 

	self unInfluyenteTerminaSuRepertorioDeFrasesCon: self pjHamilton. 

	self assert: 'Bienvenido aventurero!!' equals: (self pnjConversadorTrebor interactuarCon: self pjHamilton)! !

!DialogosConPNJsTest methodsFor: 'tests - influyente' stamp: 'srs 11/6/2021 10:27:33'!
unConversadorNoTerminaSuRepertorioDeFrasesCon: unPersonaje

	self pnjConversadorTrebor interactuarCon: unPersonaje.
	self pnjConversadorTrebor interactuarCon: unPersonaje.! !

!DialogosConPNJsTest methodsFor: 'tests - influyente' stamp: 'srs 11/6/2021 10:17:10'!
unConversadorTerminaSuRepertorioDeFrasesCon: unPersonaje

	self pnjConversadorTrebor interactuarCon: unPersonaje.
	self pnjConversadorTrebor interactuarCon: unPersonaje.
	self pnjConversadorTrebor interactuarCon: unPersonaje.	! !

!DialogosConPNJsTest methodsFor: 'tests - influyente' stamp: 'srs 11/6/2021 10:15:46'!
unInfluyenteTerminaSuRepertorioDeFrasesCon: unPersonaje

	self pnjInfluyenteCarolina interactuarCon: unPersonaje.
	self pnjInfluyenteCarolina interactuarCon: unPersonaje.	
	self pnjInfluyenteCarolina interactuarCon: unPersonaje.	! !


!DialogosConPNJsTest methodsFor: 'tests - opinion del pueblo' stamp: 'JMB 11/6/2021 01:04:38'!
test13SiNoHuboInteraccionesLaOpinionDeUnPuebloDiceQueQueNadieConoceANingunPJ
	
	self assert: 0 equals: (opinionDeRiverwood cantidadDePNJsQueConocenA: self pjHamilton).
	self assert: 0 equals: (opinionDeRiverwood cantidadDePNJsQueConocenA: self pjTirion).! !

!DialogosConPNJsTest methodsFor: 'tests - opinion del pueblo' stamp: 'srs 11/6/2021 10:19:18'!
test14CuandoUnPNJTerminaSuRepertorioConUnPJDesconocidoLaOpinionDelPuebloDiceQueEsConocidoPorUno
	
	self unConversadorTerminaSuRepertorioDeFrasesCon: self pjHamilton. 
	
	self assert: 1 equals: (opinionDeRiverwood cantidadDePNJsQueConocenA: self pjHamilton).! !

!DialogosConPNJsTest methodsFor: 'tests - opinion del pueblo' stamp: 'srs 11/6/2021 10:27:58'!
test15CuandoUnPNJNoTerminaSuRepertorioConUnPJDesconocidoLaOpinionDelPuebloDiceQueEsConocidoPor0
	
	self unConversadorNoTerminaSuRepertorioDeFrasesCon: self pjHamilton. 
	
	self assert: 0 equals: (opinionDeRiverwood cantidadDePNJsQueConocenA: self pjHamilton).! !

!DialogosConPNJsTest methodsFor: 'tests - opinion del pueblo' stamp: 'srs 11/6/2021 10:22:11'!
test16CuandoUnPNJTerminaSuRepertorioConUnPJDesconocidoNoAfectaLaCantidadDePNJsQueConocenAUnNuevoPJ
	
	self unConversadorTerminaSuRepertorioDeFrasesCon: self pjHamilton.
	
	self assert: 0 equals: (opinionDeRiverwood cantidadDePNJsQueConocenA: self pjTirion).! !

!DialogosConPNJsTest methodsFor: 'tests - opinion del pueblo' stamp: 'srs 11/6/2021 10:28:21'!
test17CuandoUnPNJTerminaSuRepertorioConUnPJDesconocidoSiSigueInteractuandoNoSubeLaCantidadDePNJsQueLoConocen
	
	self unConversadorTerminaSuRepertorioDeFrasesCon: self pjHamilton.
	
	self unConversadorNoTerminaSuRepertorioDeFrasesCon: self pjHamilton. 
	
	self assert: 1 equals: (opinionDeRiverwood cantidadDePNJsQueConocenA: self pjHamilton).! !

!DialogosConPNJsTest methodsFor: 'tests - opinion del pueblo' stamp: 'srs 11/6/2021 10:22:58'!
test18UnConversadorTieneCeroEgoCuandoNoInteractuóConNingunPrometedor
	
	self unConversadorTerminaSuRepertorioDeFrasesCon: self pjHamilton.

	self unConversadorTerminaSuRepertorioDeFrasesCon: self pjTirion .
	
	self assert: 0 equals: self pnjConversadorTrebor cantidadDeEgo.
! !

!DialogosConPNJsTest methodsFor: 'tests - opinion del pueblo' stamp: 'srs 11/6/2021 10:23:17'!
test19UnConversadorTieneUnoDeEgoCuandoInteractuóConUnPrometedor

	self hacerQueRiverwoodVeaPrometedorAHamilton.	
	
	self unConversadorTerminaSuRepertorioDeFrasesCon: self pjHamilton.

	self unConversadorTerminaSuRepertorioDeFrasesCon: self pjTirion .
	
	self assert: 1 equals: self pnjConversadorTrebor cantidadDeEgo.
! !

!DialogosConPNJsTest methodsFor: 'tests - opinion del pueblo' stamp: 'JMB 11/5/2021 00:43:55'!
test20LaOpinionDeUnPuebloTieneCeroConfianzaConAlguienPrometedorSiNoInteractuoLoSuficienteConSusInfluyentes

	self hacerQueRiverwoodVeaPrometedorAHamilton.	
	
	self pnjInfluyenteCarolina interactuarCon: self pjHamilton.
	
	self assert: 0 equals: (opinionDeRiverwood cantidadDeConfianzaHacia: self pjHamilton).
! !

!DialogosConPNJsTest methodsFor: 'tests - opinion del pueblo' stamp: 'srs 11/6/2021 10:24:35'!
test21UnInfluyenteAumentaLaConfianzaSobreUnPJCuandoHablaConEl

	self hacerQueRiverwoodVeaPrometedorAHamilton.	
	
	self unInfluyenteTerminaSuRepertorioDeFrasesCon: self pjHamilton.
	
	self assert: 1 equals: (opinionDeRiverwood cantidadDeConfianzaHacia: self pjHamilton).
	! !


!DialogosConPNJsTest methodsFor: 'personajes' stamp: 'SF 11/4/2021 15:50:15'!
pjHamilton
	^#Hamilton.! !

!DialogosConPNJsTest methodsFor: 'personajes' stamp: 'SF 11/4/2021 15:50:05'!
pjTirion
	^#Tirion.! !

!DialogosConPNJsTest methodsFor: 'personajes' stamp: 'SF 11/4/2021 15:51:07'!
pnjConversadorTrebor
	^trebor.! !

!DialogosConPNJsTest methodsFor: 'personajes' stamp: 'SF 11/4/2021 15:51:20'!
pnjInfluyenteCarolina
	^carolina.! !


!DialogosConPNJsTest methodsFor: 'soporte' stamp: 'SF 10/7/2021 21:14:38'!
esVistoPorElPuebloComoPrometedor: unPersonaje
	^opinionDeRiverwood esVistoComoPrometedor: unPersonaje! !

!DialogosConPNJsTest methodsFor: 'soporte' stamp: 'SF 11/4/2021 15:50:16'!
hacerQueRiverwoodVeaPrometedorAHamilton
	opinionDeRiverwood verComoPrometedorA: self pjHamilton.! !

!DialogosConPNJsTest methodsFor: 'soporte' stamp: 'srs 11/6/2021 13:36:28'!
setUp
	opinionDeRiverwood := OpinionDeUnPueblo new.
	
	trebor := PersonajeNoJugadorConversador 
		queSigue: opinionDeRiverwood
		frasesParaPersonajesDesconocidos: #('Hola forastero' '¿Todo bien?' '¿Algún problema?' )
		frasesParaPersonajesPrometedores: #('Bienvenido aventurero!!' 'Espero que tengas una buena estadia en Riverwood' ).
	
	carolina := PersonajeNoJugadorInfluyente 
		queSigue: opinionDeRiverwood
		frasesParaPersonajesDesconocidos: #('¿Estás enfermo forastero?' 'Ah, solo quieres conversar' 'Cuando tengas una aflicción, ven a verme' )
		frasesParaPersonajesPrometedores: #('Salud aventurero!!' 'Toma esta pócima que te hará crecer el pelo. Y cuando tengas una aflicción, ven a verme').
	carolina cantidadDePNJsQueDebenConocerAPJ: 2.

	opinionDeRiverwood agregarSeguidor: trebor.
	opinionDeRiverwood agregarSeguidor: carolina.
! !


!classDefinition: #OpinionDeUnPueblo category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!
Object subclass: #OpinionDeUnPueblo
	instanceVariableNames: 'opiniones seguidores pjsDesconocidosConocidosPorPNJs prometedoresConocidosPorPNJsInfluyentes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!

!OpinionDeUnPueblo methodsFor: 'private' stamp: 'SF 10/7/2021 20:11:50'!
notificarCambioDeOpinionSobre: unPersonajeJugadorACalificar
	seguidores do: [:unSeguidor |
		unSeguidor elPuebloHaCambiadoSuOpinionDe: unPersonajeJugadorACalificar.
	]. ! !

!OpinionDeUnPueblo methodsFor: 'private' stamp: 'srs 11/6/2021 12:36:16'!
opinionDesconocido
	^PersonajeJugadorDesconocido new.! !

!OpinionDeUnPueblo methodsFor: 'private' stamp: 'srs 11/6/2021 12:36:32'!
opinionPrometedor
	^PersonajeJugadorPrometedor new.! !


!OpinionDeUnPueblo methodsFor: 'public' stamp: 'JMB 11/4/2021 23:45:31'!
agregarSeguidor: unPersonajeNoJugador 
	seguidores add: unPersonajeNoJugador.! !

!OpinionDeUnPueblo methodsFor: 'public' stamp: 'JMB 11/4/2021 23:45:58'!
aumentarConfianzaCon: unPersonajeJugador porHablarCon: unPersonajeNoJugador 
	| pnjsQueInteractuaron |
	pnjsQueInteractuaron := prometedoresConocidosPorPNJsInfluyentes at: unPersonajeJugador ifAbsentPut: [Set new].
	pnjsQueInteractuaron add: unPersonajeNoJugador.! !

!OpinionDeUnPueblo methodsFor: 'public' stamp: 'JMB 11/4/2021 23:46:24'!
cantidadDeConfianzaHacia: unPersonajeJugador
	| pnjsQueInteractuaron cantidad |
	pnjsQueInteractuaron _ prometedoresConocidosPorPNJsInfluyentes at: unPersonajeJugador ifAbsentPut: [Set new].
	cantidad := 0.
	pnjsQueInteractuaron do: [ : unPNJ | cantidad := cantidad + 1 ].
	^ cantidad! !

!OpinionDeUnPueblo methodsFor: 'public' stamp: 'JMB 11/4/2021 23:49:41'!
cantidadDePNJsQueConocenA: unPersonajeJugador
	| cantidad pnjsQueConocenAlPJ |
	pnjsQueConocenAlPJ := pjsDesconocidosConocidosPorPNJs at: unPersonajeJugador ifAbsent: [Set new].
	cantidad := 0.
	pnjsQueConocenAlPJ do: [ : unPNJ | cantidad := cantidad + 1 ].
	^ cantidad! !

!OpinionDeUnPueblo methodsFor: 'public' stamp: 'JMB 11/4/2021 23:48:16'!
esVistoComoPrometedor: unPotencialPersonajeJugadorPrometedor 
	^ (self opinionDe: unPotencialPersonajeJugadorPrometedor) = self opinionPrometedor.! !

!OpinionDeUnPueblo methodsFor: 'public' stamp: 'JMB 11/4/2021 23:48:02'!
opinionDe: unPersonajeJugador
	^opiniones at: unPersonajeJugador ifAbsent: [self opinionDesconocido]
! !

!OpinionDeUnPueblo methodsFor: 'public' stamp: 'JMB 11/4/2021 23:50:12'!
pnj: unPersonajeNoJugador conocioA: unPersonajeJugador
	| pnjsQueConocenAlPJ |
	pnjsQueConocenAlPJ := pjsDesconocidosConocidosPorPNJs at: unPersonajeJugador ifAbsentPut: [Set new].
	pnjsQueConocenAlPJ add: unPersonajeNoJugador.! !

!OpinionDeUnPueblo methodsFor: 'public' stamp: 'JMB 11/4/2021 23:48:16'!
verComoPrometedorA: unPersonajeJugadorACalificar 
	opiniones at: unPersonajeJugadorACalificar put: self opinionPrometedor.
	self notificarCambioDeOpinionSobre: unPersonajeJugadorACalificar.! !


!OpinionDeUnPueblo methodsFor: 'initialization' stamp: 'JMB 11/4/2021 23:35:18'!
initialize
	opiniones := Dictionary new.
	seguidores := OrderedCollection new.
	pjsDesconocidosConocidosPorPNJs := Dictionary new.
	prometedoresConocidosPorPNJsInfluyentes := Dictionary new.! !


!classDefinition: #PersonajeJugador category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!
Object subclass: #PersonajeJugador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!

!PersonajeJugador methodsFor: 'consecuencias del opinion del pueblo' stamp: 'srs 11/6/2021 13:44:40'!
aumentaLaConfianzaEn: OpinionDeSuPueblo trasQue: unPersonajeNoJugable habloCon: unPersonajeJugable
	self subclassResponsibility ! !

!PersonajeJugador methodsFor: 'consecuencias del opinion del pueblo' stamp: 'srs 11/6/2021 13:46:42'!
pedirFrasesSegunOpinionDe: unPersonajeNoJugable
	self subclassResponsibility. ! !

!PersonajeJugador methodsFor: 'consecuencias del opinion del pueblo' stamp: 'srs 11/6/2021 13:45:41'!
produceQue: unPersonajeNoJugador modificaLa:  opinionDeSuPueblo oInflaSuEgotrasHablarCon: unPersonajeJugador
	self subclassResponsibility ! !


!classDefinition: #PersonajeJugadorDesconocido category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!
PersonajeJugador subclass: #PersonajeJugadorDesconocido
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!

!PersonajeJugadorDesconocido methodsFor: 'consecuencias del opinion del pueblo' stamp: 'srs 11/6/2021 13:44:40'!
aumentaLaConfianzaEn: OpinionDeSuPueblo trasQue: unPersonajeNoJugable habloCon: unPersonajeJugable
	
	 (unPersonajeNoJugable cantidadDeInteraccionesCon: unPersonajeJugable) >= unPersonajeNoJugable frasesParaDesconocidos size
					ifTrue: [
						OpinionDeSuPueblo pnj: unPersonajeNoJugable conocioA: unPersonajeJugable.
						unPersonajeNoJugable siCumpleLosRequisitosHacerPrometedorA: unPersonajeJugable.
						].! !

!PersonajeJugadorDesconocido methodsFor: 'consecuencias del opinion del pueblo' stamp: 'srs 11/6/2021 13:46:42'!
pedirFrasesSegunOpinionDe: unPersonajeNoJugable
	
	^unPersonajeNoJugable frasesParaDesconocidos.! !

!PersonajeJugadorDesconocido methodsFor: 'consecuencias del opinion del pueblo' stamp: 'srs 11/6/2021 13:51:00'!
produceQue: unPersonajeNoJugable modificaLa:  opinionDeSuPueblo oInflaSuEgotrasHablarCon: unPersonajeJugable

	(unPersonajeNoJugable cantidadDeInteraccionesCon: unPersonajeJugable) >= unPersonajeNoJugable frasesParaDesconocidos size
					ifTrue: [opinionDeSuPueblo pnj: unPersonajeNoJugable conocioA: unPersonajeJugable]! !


!classDefinition: #PersonajeJugadorPrometedor category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!
PersonajeJugador subclass: #PersonajeJugadorPrometedor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!

!PersonajeJugadorPrometedor methodsFor: 'consecuencias del opinion del pueblo' stamp: 'srs 11/6/2021 13:44:40'!
aumentaLaConfianzaEn: OpinionDeSuPueblo trasQue: unPersonajeNoJugable habloCon: unPersonajeJugable
	
	(unPersonajeNoJugable cantidadDeInteraccionesCon: unPersonajeJugable) >= unPersonajeNoJugable frasesParaPrometedores size
					ifTrue: [
						OpinionDeSuPueblo aumentarConfianzaCon: unPersonajeJugable porHablarCon: unPersonajeJugable .
					]! !

!PersonajeJugadorPrometedor methodsFor: 'consecuencias del opinion del pueblo' stamp: 'srs 11/6/2021 13:46:42'!
pedirFrasesSegunOpinionDe: unPersonajeNoJugable
	
	^unPersonajeNoJugable frasesParaPrometedores.! !

!PersonajeJugadorPrometedor methodsFor: 'consecuencias del opinion del pueblo' stamp: 'srs 11/6/2021 13:50:14'!
produceQue: unPersonajeNoJugable modificaLa:  opinionDeSuPueblo oInflaSuEgotrasHablarCon: unPersonajeJugable
	(unPersonajeNoJugable cantidadDeInteraccionesCon: unPersonajeJugable) >= unPersonajeNoJugable frasesParaPrometedores size
					ifTrue: [
						unPersonajeNoJugable aumentarEgoPorInteractuarConPrometedor: unPersonajeJugable.]! !


!classDefinition: #PersonajeNoJugador category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!
Object subclass: #PersonajeNoJugador
	instanceVariableNames: 'cantidadDeInteraccionesPorPersonaje frasesParaPersonajesPrometedores frasesParaPersonajesDesconocidos opinionDeMiPueblo cantidadDePNJsQueDebenConocerAPJ rol prometedoresConocidos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!

!PersonajeNoJugador methodsFor: 'public' stamp: 'srs 11/6/2021 13:28:35'!
actuaSegunSuInfluenciaEnBaseA: unaOpinion
	self subclassResponsibility. ! !

!PersonajeNoJugador methodsFor: 'public' stamp: 'SF 11/3/2021 11:36:35'!
cantidadDeEgo
	^prometedoresConocidos size.! !

!PersonajeNoJugador methodsFor: 'public' stamp: 'SF 11/3/2021 10:48:14'!
cantidadDePNJsQueDebenConocerAPJ: aSmallInteger 
	cantidadDePNJsQueDebenConocerAPJ _ aSmallInteger! !

!PersonajeNoJugador methodsFor: 'public' stamp: 'SF 10/7/2021 20:37:22'!
elPuebloHaCambiadoSuOpinionDe: unPersonajeJugador 
	self olvidarInteraccionesCon: unPersonajeJugador.! !

!PersonajeNoJugador methodsFor: 'public' stamp: 'srs 11/6/2021 12:32:00'!
frasesParaDesconocidos
	^frasesParaPersonajesDesconocidos ! !

!PersonajeNoJugador methodsFor: 'public' stamp: 'srs 11/6/2021 12:32:11'!
frasesParaPrometedores
	^frasesParaPersonajesPrometedores ! !

!PersonajeNoJugador methodsFor: 'public' stamp: 'srs 11/6/2021 13:47:28'!
interactuarCon: unPersonajeJugador 
	| frase opinion opinionDeSuPueblo |
	
	self recordarInteraccionCon: unPersonajeJugador.
	frase := self responderSegunCantidadDeInteraccionesCon: unPersonajeJugador.
	opinionDeSuPueblo := self opinionDeSuPueblo. 
	opinion := opinionDeMiPueblo opinionDe: unPersonajeJugador.
	self actuaSegunSuInfluenciaEnBaseA: opinion queAlteraraLa: opinionDeSuPueblo luegoDeHablarCon: unPersonajeJugador. 
	^ frase.
! !

!PersonajeNoJugador methodsFor: 'public' stamp: 'SF 10/7/2021 19:54:10'!
olvidar
	cantidadDeInteraccionesPorPersonaje := Dictionary new.
	! !

!PersonajeNoJugador methodsFor: 'public' stamp: 'srs 11/6/2021 13:05:49'!
opinionDeSuPueblo
	^ opinionDeMiPueblo. 
	! !


!PersonajeNoJugador methodsFor: 'private' stamp: 'SF 11/3/2021 11:35:23'!
aumentarEgoPorInteractuarConPrometedor: unPJPrometedor
	prometedoresConocidos add: unPJPrometedor.! !

!PersonajeNoJugador methodsFor: 'private' stamp: 'SF 10/7/2021 19:58:11'!
cantidadDeInteraccionesCon: unPersonajeJugadorAInteractuar
	^ cantidadDeInteraccionesPorPersonaje at: unPersonajeJugadorAInteractuar ifAbsent: [ 0 ]! !

!PersonajeNoJugador methodsFor: 'private' stamp: 'srs 11/6/2021 13:46:42'!
frasesPara: unPersonajeJugadorAInteractuar
	
	| opinion |
	opinion := opinionDeMiPueblo opinionDe: unPersonajeJugadorAInteractuar.
	^opinion pedirFrasesSegunOpinionDe: self.
! !

!PersonajeNoJugador methodsFor: 'private' stamp: 'SF 10/7/2021 20:27:29'!
indiceDeLaSiguienteFrasePara: unPersonajeJugadorAInteractuar en: frasesAResponder
	| cantidadDeInteracciones |
	cantidadDeInteracciones := self cantidadDeInteraccionesCon: unPersonajeJugadorAInteractuar.
	^ cantidadDeInteracciones min: frasesAResponder size ! !

!PersonajeNoJugador methodsFor: 'private' stamp: 'SF 10/7/2021 20:37:54'!
olvidarInteraccionesCon: unPersonajeJugador 
	cantidadDeInteraccionesPorPersonaje at: unPersonajeJugador put: 0.! !

!PersonajeNoJugador methodsFor: 'private' stamp: 'SF 10/7/2021 19:57:44'!
recordarInteraccionCon: unPersonajeJugadorAInteractuar
	| cantidadDeInteracciones |
	cantidadDeInteracciones := self cantidadDeInteraccionesCon: unPersonajeJugadorAInteractuar. 
	cantidadDeInteraccionesPorPersonaje at: unPersonajeJugadorAInteractuar put: cantidadDeInteracciones + 1
! !

!PersonajeNoJugador methodsFor: 'private' stamp: 'SF 10/7/2021 20:15:03'!
responderSegunCantidadDeInteraccionesCon: unPersonajeJugadorAInteractuar
	| frasesParaElPersonaje |
	frasesParaElPersonaje := self frasesPara: unPersonajeJugadorAInteractuar. 
	^ self siguienteFrasePara: unPersonajeJugadorAInteractuar en: frasesParaElPersonaje.! !

!PersonajeNoJugador methodsFor: 'private' stamp: 'SF 11/2/2021 20:49:46'!
siCumpleLosRequisitosHacerPrometedorA: unPersonajeJugador
	(opinionDeMiPueblo cantidadDePNJsQueConocenA: unPersonajeJugador) >= cantidadDePNJsQueDebenConocerAPJ
		ifTrue: [
		opinionDeMiPueblo verComoPrometedorA: unPersonajeJugador.		
	].! !

!PersonajeNoJugador methodsFor: 'private' stamp: 'SF 10/7/2021 20:27:10'!
siguienteFrasePara: unPersonajeJugadorAInteractuar en: frasesAResponder
	| indice |
	indice := self indiceDeLaSiguienteFrasePara: unPersonajeJugadorAInteractuar en: frasesAResponder.
	^ frasesAResponder at: indice.! !


!PersonajeNoJugador methodsFor: 'initialization' stamp: 'SF 11/3/2021 11:35:50'!
initializeWithOpinion: anOpinionDeUnPueblo frasesParaPersonajesDesconocidos: unasFrasesParaPersonajesDesconocidos frasesParaPersonajesPrometedores: unasFrasesParaPersonajesPrometedores
	self olvidar.
	prometedoresConocidos := Set new.
	opinionDeMiPueblo := anOpinionDeUnPueblo.
	frasesParaPersonajesDesconocidos := unasFrasesParaPersonajesDesconocidos.
	frasesParaPersonajesPrometedores := unasFrasesParaPersonajesPrometedores.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersonajeNoJugador class' category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!
PersonajeNoJugador class
	instanceVariableNames: ''!

!PersonajeNoJugador class methodsFor: 'instance creation' stamp: 'JMB 11/5/2021 00:59:16'!
queSigue: unaOpinionDeUnPueblo frasesParaPersonajesDesconocidos: unasFrasesParaPJDesconocidos frasesParaPersonajesPrometedores: unasFrasesParaPJPrometedores
	^ self new
		initializeWithOpinion: unaOpinionDeUnPueblo
		frasesParaPersonajesDesconocidos: unasFrasesParaPJDesconocidos
		frasesParaPersonajesPrometedores: unasFrasesParaPJPrometedores	
! !


!classDefinition: #PersonajeNoJugadorConversador category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!
PersonajeNoJugador subclass: #PersonajeNoJugadorConversador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!

!PersonajeNoJugadorConversador methodsFor: 'comportamiento segun interaccion' stamp: 'srs 11/6/2021 13:45:41'!
actuaSegunSuInfluenciaEnBaseA: unaOpinion queAlteraraLa: opinionDeSuPueblo luegoDeHablarCon: unPersonajeJugador 
	
	^unaOpinion produceQue: self modificaLa: opinionDeSuPueblo oInflaSuEgotrasHablarCon: unPersonajeJugador. 
! !


!classDefinition: #PersonajeNoJugadorInfluyente category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!
PersonajeNoJugador subclass: #PersonajeNoJugadorInfluyente
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AlgoIII-2020-2C-1Parcial-DialogosConPNJs-P3'!

!PersonajeNoJugadorInfluyente methodsFor: 'comportamiento segun interaccion' stamp: 'srs 11/6/2021 13:44:40'!
actuaSegunSuInfluenciaEnBaseA: unaOpinion queAlteraraLa: opinionDeSuPueblo luegoDeHablarCon: unPersonajeJugador 

	^unaOpinion aumentaLaConfianzaEn: opinionDeSuPueblo trasQue: self habloCon: unPersonajeJugador
! !
