Class {
	#name : #LBCLieu,
	#superclass : #LBCObject,
	#instVars : [
		'ville',
		'departement',
		'codePostal'
	],
	#category : #LeBonTrouveur
}

{ #category : #accessing }
LBCLieu >> codePostal [
	^ codePostal
]

{ #category : #accessing }
LBCLieu >> codePostal: anObject [
	codePostal := anObject
]

{ #category : #accessing }
LBCLieu >> departement [
	^ departement
]

{ #category : #accessing }
LBCLieu >> departement: anObject [
	departement := anObject
]

{ #category : #accessing }
LBCLieu >> ville [
	^ ville
]

{ #category : #accessing }
LBCLieu >> ville: anObject [
	ville := anObject
]
