"
Fonctions pour projet ICTT 
"
Class {
	#name : #LBCCapture,
	#superclass : #Object,
	#category : #LeBonTrouveur
}

{ #category : #acccessing }
LBCCapture >> categoryAnnonce: dl [
	| re i tableau |
	tableau := OrderedCollection new.
	re := '[\w\W]*">(.*)</p>' asRegexIgnoringCase.
	i := dl xPath: '//p[@itemprop=''category'']'.
	1 to: i size do: [ :g | 
		tableau
			add:
				((re matchesPrefix: (i at: g) asString contents)
					ifTrue: [ re subexpression: 2 ]
					ifFalse: [ 'error' ]) ].
	^ tableau
]

{ #category : #acccessing }
LBCCapture >> dateAnnonce:  aCollection [
	^(aCollection xPath: '//p[@itemprop=''availabilityStarts'']')
]

{ #category : #acccessing }
LBCCapture >> lienAnnonce:  aCollection [
	^(aCollection xPath: '//a[@class=''list_item clearfix trackable'']/@href') 


]

{ #category : #acccessing }
LBCCapture >> lieuxAnnonce: dl [
	| re i tableau |
	tableau := OrderedCollection new.
	re := '[\w\W]*">(.*)<' asRegexIgnoringCase.
	i := dl xPath: '//p[@itemprop=''availableAtOrFrom'']'.
	1 to: i size do: [ :g | 
		tableau
			add:
				((re matchesPrefix: (i at: g) asString contents)
					ifTrue: [ re subexpression: 2 ]
					ifFalse: [ 'error' ]) ].
	^ tableau
]

{ #category : #acccessing }
LBCCapture >> pageSuivantes:  aCollection [
|re i|
	re := '[\w\W]*href="//(.*)"' asRegexIgnoringCase.
	i := ((aCollection xPath: '//a[@class=''element page'']/@href') at:1).
	^ (re matchesPrefix: (i) asString  contents)
		ifTrue: [ re subexpression: 2 ]
		ifFalse: [ '(', self fileName, ' -- untitled)' ]

]

{ #category : #acccessing }
LBCCapture >> prixAnnonce: dl [
	| re i tableau |
	tableau := OrderedCollection new.
	re := '[\w\W]*">(.*)</h3>' asRegexIgnoringCase.
	i := dl xPath: '//h3[@class=''item_price'']'.
	1 to: i size do: [ :g | 
		tableau
			add:
				((re matchesPrefix: (i at: g) asString contents)
					ifTrue: [ re subexpression: 2 ]
					ifFalse: [ 'error' ]) ].
	^ tableau
]

{ #category : #acccessing }
LBCCapture >> telecharger: aString [
	^(XMLHTMLParser parseURL: aString) 


]

{ #category : #acccessing }
LBCCapture >> titreAnnonce: dl [
	| re i tableau |
	tableau := OrderedCollection new.
	re := '[\w\W]*name">(.*)</h2>' asRegexIgnoringCase.
	i := dl xPath: '//h2[@class=''item_title'']'.
	1 to: i size do: [ :g | 
		tableau
			add:
				((re matchesPrefix: (i at: g) asString contents)
					ifTrue: [ re subexpression: 2 ]
					ifFalse: [ 'error' ]) ].
	^ tableau
]
