"
Test de LBCCapture
"
Class {
	#name : #CaptureTest,
	#superclass : #TestCase,
	#category : #LeBonTrouveur
}

{ #category : #tests }
CaptureTest >> testCapture [
	| k |
	k := LBCCapture new.
	k telecharger:
			'https://www.leboncoin.fr/annonces/offres/midi_pyrenees'

	"trouver comment faire un test si le telchargement a r√©usit :
		ne renvoie pas une erreur ou renvoie un tableau "
]

{ #category : #tests }
CaptureTest >> testpageSuivante [
	|k|
	k := LBCCapture new.
	^('www.(.*)' asRegexIgnoringCase) matchesPrefix: ((k 	pageSuivantes: (k telecharger: 'https://www.leboncoin.fr/annonces/offres/midi_pyrenees') ) asString).


]
