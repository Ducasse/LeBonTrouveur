Class {
	#name : #LBCRechercheTest,
	#superclass : #LBCObjectTest,
	#instVars : [
		'recherche'
	],
	#category : #LeBonTrouveur
}

{ #category : #initialization }
LBCRechercheTest >> setUp [

	recherche := LBCRecherche test.
]

{ #category : #initialization }
LBCRechercheTest >> testDB [
	| db |
	db := LBCRecherche all.
	self assert: db isCollection.
	self assert: recherche annonces isEmpty.
	self deny: (db includes: recherche).
	" db add: recherche    permet de sauvegarder une recherche."
	db add: recherche.	
	self assert: (db includes: recherche).
	db remove: recherche.
	self deny: (db includes: recherche).
	"une autre facon de sauvegarder /effecer une recherche"
	recherche sauvegarde. 
	self assert: (db includes: recherche).
	recherche efface.
	self deny: (db includes: recherche)
]

{ #category : #initialization }
LBCRechercheTest >> testRecherche [
	self assert: recherche annonces isEmpty.
	recherche traiteUrl.
]
