"
je represente une recher utilisateur sur un produit particulier.

jai la responsabilite de parser le ou les contenu (urls lbc) pour repondre a un besoin.
je garde la liste des annonces (conversion des annonces parsees et detectee / maj... exclusion... versions)

motCles

type : local (deplacement) rayon 30 50 100 200 ou france entiere. #(10 20 30 50 100 200 500)
convertir en human friendly => suivi precis + large + + + icone elargissement

annonces continet les resultats de la recherche (trait√©s / converties en objets )

CLASS SIDE
la base de donn√©es du prototype se trouve defini comme une variable de classe qui sera persistante de facto (in image).
prevoir plus tard des mecanismes de serialisation/deserailisation FUEL/STON.
"
Class {
	#name : #LBCRecherche,
	#superclass : #LBCObject,
	#instVars : [
		'motCles',
		'categorie',
		'type',
		'lbcUrls',
		'filtres',
		'annonces'
	],
	#classInstVars : [
		'RechercheDB'
	],
	#category : #LeBonTrouveur
}

{ #category : #accessing }
LBCRecherche class >> all [
	"acces a la base de donn√©es in image"

	^ RechercheDB ifNil: [ self initializeDBStructure ]
]

{ #category : #accessing }
LBCRecherche class >> initializeDBStructure [
	"ATTENTION CELA EFFACE LA BASE DE DONNEES
	definit la structure de la base de donn√©es"

	"pour l'instant une simple collection"

	^ RechercheDB := OrderedCollection new

	"plus tard surement un dictionnaire pour permettre de mieux indexer"
]

{ #category : #'unit-test' }
LBCRecherche class >> test [
	" self test
	retourne une recherche par defaut ..."

	"permet de developer incrementalement les differents objets => Recherche et Annonce"

	"decomposition progressive de l url selon le besoin..."

	| recherche |
	"disque de recherche d'annonce lat/long/radius ... meritera surement une classe a part entiere. deja on prend celle de l'image GCircle"
	recherche := LBCRecherche new
		motCles: (#('PS4 GT SPORT' 'PS4 Gran Turismo') collect: #urlEncoded);
		categorie: 'consoles_jeux_video';
		"initialArea: (GCircle center: 43.100 @ 0.6370 radius: 100000);"
			"'PS4%20GT%20Sport'  exemple d'encodage url"
			"le precision et l enchainement des requetes se fait en fonction dune strategeie...  du plus proche... puis on etend progressivement...  pour l'instant on fixe"
			"#(10000 20000 30000 50000 100000 200000 #france)"
			lbcUrls: 'https://www.leboncoin.fr/consoles_jeux_video/offres/ile_de_france/?th=1&q=PS4%20GT%20Sport&w=4&latitude=43.100&longitude=0.6370&radius=200000'.
	"prevoir multiple url entrees / decomposition => recomposition selon strategie"
	^ recherche
]

{ #category : #accessing }
LBCRecherche >> annonces [
	^ annonces
]

{ #category : #accessing }
LBCRecherche >> annonces: anObject [
	annonces := anObject
]

{ #category : #accessing }
LBCRecherche >> categorie [
	^ categorie
]

{ #category : #accessing }
LBCRecherche >> categorie: anObject [
	categorie := anObject
]

{ #category : #sauvegarde }
LBCRecherche >> efface [
	LBCRecherche all remove: self 
]

{ #category : #accessing }
LBCRecherche >> filtres [
	^ filtres
]

{ #category : #accessing }
LBCRecherche >> filtres: anObject [
	filtres := anObject
]

{ #category : #configuring }
LBCRecherche >> initialArea: aCircleArea [
	self shouldBeImplemented.
]

{ #category : #accessing }
LBCRecherche >> initialize [
	
	super initialize.
	annonces := OrderedCollection new. 
]

{ #category : #accessing }
LBCRecherche >> lbcUrls [
	^ lbcUrls
]

{ #category : #accessing }
LBCRecherche >> lbcUrls: anObject [
	lbcUrls := anObject
]

{ #category : #accessing }
LBCRecherche >> motCles [
	^ motCles
]

{ #category : #accessing }
LBCRecherche >> motCles: anObject [
	motCles := anObject
]

{ #category : #sauvegarde }
LBCRecherche >> sauvegarde [
	self class all add: self
]

{ #category : #traitement }
LBCRecherche >> traiteUrl [
	"delegue le scrapping a proprepment parler aux annonces."

	"objectif ici : recuperer la liste des annonces quelques soit le nombre de pages... "

	| htmlTree allAnnonceNodes |
	htmlTree := XMLHTMLParser parseURL: self lbcUrls. "faire en sortes que ca prenne plusieurs urls ... paging ou multi criteres"
	"recupere toutes les annonces de la page => noeux du DOM"
	allAnnonceNodes := htmlTree xpath: '//*[@id="listingAds"]/section/section/ul/li'.	" faire unit test... Structure liste 1"
	allAnnonceNodes
		do: [ :nod | "on cree l'objet annonce qui continedra toutes les infos extraites" annonces add: (LBCAnnonce fromLBCXMLNode: nod) ].
	"premiere recherche termin√©e   yeahhhh :)   a peaufiner..."

	"assure que dans la db...  a changer.. car ca ajout simplement la..."
	self sauvegarde
	"du coup faire la fonction update... qui va filtrer et ne pas aller chercher toutes les 	pages..."
]

{ #category : #accessing }
LBCRecherche >> type [
	^ type
]

{ #category : #accessing }
LBCRecherche >> type: anObject [
	type := anObject
]

{ #category : #execution }
LBCRecherche >> update [
	"methode qui permet dinitialiser une recherche mais aussi de la mettre a jour    on separera si n√©cessaire"
	self halt.

	
]

{ #category : #traitement }
LBCRecherche >> xpathAnnoncesPage [
	^ '//*[@id="listingAds"]/section/section/ul/li'
]
