"
Je represente une annonce
	lien vers l url du bon coin
	lien vers annonces precendetes si mise a jour detectees
	
	info de lannonce (title...
"
Class {
	#name : #LBCAnnonce,
	#superclass : #LBCObject,
	#instVars : [
		'lbcId',
		'titre',
		'prix',
		'date',
		'contenu',
		'photos',
		'tel',
		'lieu',
		'visible',
		'versionPrecedente',
		'lbcUrl'
	],
	#category : #LeBonTrouveur
}

{ #category : #'initialize scrap' }
LBCAnnonce class >> completeAnnonce: ann with: annHtmlTree [
	"recuperation encart de droite - pseudo tel message"

	| format2 fullAnnNode pseudoVendeur messageUrl annNode titre timestamp contenu codePostal photoUrls |
	fullAnnNode := (annHtmlTree xpath: '//*[@id="container"]/main/div/div/div/section/section/section[2]') first.
	pseudoVendeur := 1.
	messageUrl := 1.
	"recuperation du reste ecart de gauche"
	annNode := (annHtmlTree xpath: '//*[@id="container"]/main/div/div/div/section/section/section[1]') first.
	titre := (annNode xpath: './div[1]/div[2]/div[1]/div[1]/h1/text()') first value.
	ann titre: titre.
	timestamp := (annNode xpath: './div[1]/div[2]/div[1]/div[3]/text()') first value string.
	format2 := ZTimestampFormat fromString: '03/02/2001 √† 16h05'.
	ann date: (format2 parse: timestamp).
	contenu := Character cr join: (annNode xpath: './div[3]/div[2]/div/div[1]/span/text()').
	ann contenu: contenu.
	codePostal := ($  split: (annNode xpath: './div[4]/div[2]/div/div/div[2]/span/text()') first string) second
		asNumber.
	ann lieu codePostal: codePostal.
	"on recupere une seule photo - compliqu√© pour les suivantes car non precharg√©es - pas forcement utile facon"
	self halt.
	photoUrls := (annNode xpath: './div[1]/div[1]/div/div[2]/div/div[4]/div/div/span')
		collect: [ :ea | 
			self halt.
			ea xpath: '' ].
	ann photos: photoUrls
]

{ #category : #'initialization scrap' }
LBCAnnonce class >> fromLBCXMLNode: aLBCAnnXML [
	"a partir de chaque noeud, on accede aux composantes"

	"premiere definition incomplete a partir de l element de liste seulement"

	
	^ self new initializeWith: aLBCAnnXML.

]

{ #category : #'initialize - scrap' }
LBCAnnonce >> completeWith: annHtmlTree [
	"methode qui finit de remplir l'annonce. Trop longue... dispatcher et tester"

	"recuperation encart de droite - pseudo tel message"

	"href=/ar?id=1404587149  =>  url utile"

	| format2 fullAnnNode pseudoVendeur messageUrl annNode codePostal photoUrls timestamp |
	fullAnnNode := (annHtmlTree xpath: '//*[@id="container"]/main/div/div/div/section/section/section[2]') first.
	pseudoVendeur := (fullAnnNode xpath: './div[1]/div/div/div/div[1]/div[2]/div/text()') first string.
	messageUrl := 'https://www.leboncoin.fr/ar/form/0?id=' , self lbcId asString.
	"recuperation du reste ecart de gauche"

	"pour recuperer le tel mais je desactive pour l'instant => ca marche plus sur mon ordi meme depuis le navigateur"
	(fullAnnNode xpath: './/@name="phoneXXXXXXX"')
		ifTrue: [tel := self scrappeTelephoneAPI.].

	"curl 'https://api.leboncoin.fr/api/utils/phonenumber.json' \
-XPOST \
-H 'Referer: https://www.leboncoin.fr/consoles_jeux_video/1405623513.htm?ca=12_s' \
-H 'Content-Type: application/x-www-form-urlencoded' \
-H 'Origin: https://www.leboncoin.fr' \
-H 'Host: api.leboncoin.fr' \
-H 'Accept: application/json' \
-H 'Connection: keep-alive' \
-H 'Accept-Language: fr-fr' \
-H 'Accept-Encoding: br, gzip, deflate' \
-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/604.5.6 (KHTML, like Gecko) Version/11.0.3 Safari/604.5.6' \
-H 'Content-Length: 89' \
--data 'app_id=leboncoin_web_utils&key=54bb0281238b45a03f0ee695f73e704f&list_id=1405623513&text=1'"
	annNode := (annHtmlTree xpath: '//*[@id="container"]/main/div/div/div/section/section/section[1]') first.
	titre := (annNode xpath: './div[1]/div[2]/div[1]/div[1]/h1/text()') first value.
	self titre: titre.
	timestamp := (annNode xpath: './div[1]/div[2]/div[1]/div[3]/text()') first value string.
	format2 := ZTimestampFormat fromString: '03/02/2001 √† 16h05'.
	self date: (format2 parse: timestamp).
	contenu := Character cr join: (annNode xpath: './div[3]/div[2]/div/div[1]/span/text()').
	self contenu: contenu.
	codePostal := ($  split: (annNode xpath: './div[4]/div[2]/div/div/div[2]/span/text()') first string) second asNumber.
	self lieu codePostal: codePostal.
	"on recupere une seule photo - compliqu√© pour les suivantes car non precharg√©es - pas forcement utile facon"
	photoUrls := (annNode xpath: './div[1]/div[1]/div/div[2]/div/div[4]/div/div/span')
		collect: [ :ea | 
			| urlHackString |
			urlHackString := (ea xpath: './div/@style') first value.
			urlHackString := (');' split: ('background-image:url(' split: urlHackString) second) first.
			urlHackString asUrl ].	"Faire test unitaire => depend fortement de changement"
	self photos: photoUrls
	"accessible ensuite simplement par:
	ZnEasy getJpeg: aPhotoUrl "
]

{ #category : #accessing }
LBCAnnonce >> contenu [
	^ contenu
]

{ #category : #accessing }
LBCAnnonce >> contenu: anObject [
	contenu := anObject
]

{ #category : #accessing }
LBCAnnonce >> date [
	^ date
]

{ #category : #accessing }
LBCAnnonce >> date: anObject [
	date := anObject
]

{ #category : #'initialize - scrap' }
LBCAnnonce >> initializeWith: aLBCAnnXML [
	"premiere definition incomplete a partir de l element de liste seulement"

	| urlString |
	urlString := ('https:' , (aLBCAnnXML xpath: './a/@href') first value).
	self
		visible: true;
		lbcUrl: urlString asUrl;
		prix: (aLBCAnnXML xpath: './a/section/h3/@content') first value asNumber;
		lieu:
			(LBCLieu new
				ville: (aLBCAnnXML xpath: './a/section/p[2]/meta[1]/@content') first value;
				departement: (aLBCAnnXML xpath: './a/section/p[2]/meta[2]/@content') first value;
				yourself);
		lbcId: ($. split: urlString asUrl segments last) first asNumber.
	
	self completeWith: (XMLHTMLParser parseURL: urlString).
	


]

{ #category : #accessing }
LBCAnnonce >> lbcId [
	^ lbcId
]

{ #category : #accessing }
LBCAnnonce >> lbcId: anObject [
	lbcId := anObject
]

{ #category : #accessing }
LBCAnnonce >> lbcUrl [
	^ lbcUrl
]

{ #category : #accessing }
LBCAnnonce >> lbcUrl: anObject [
	lbcUrl := anObject
]

{ #category : #accessing }
LBCAnnonce >> lieu [
	^ lieu
]

{ #category : #accessing }
LBCAnnonce >> lieu: anObject [
	lieu := anObject
]

{ #category : #accessing }
LBCAnnonce >> photos [
	^ photos
]

{ #category : #accessing }
LBCAnnonce >> photos: anObject [
	photos := anObject
]

{ #category : #accessing }
LBCAnnonce >> prix [
	^ prix
]

{ #category : #accessing }
LBCAnnonce >> prix: anObject [
	prix := anObject
]

{ #category : #'initialize-scrap' }
LBCAnnonce >> scrappeTelephoneAPI [
	
	| key dico |
	key := '54bb0281238b45a03f0ee695f73e704f'.
	dico := ZnClient new
				"referer: 'https://www.leboncoin.fr/consoles_jeux_video/' , self lbcId asString , '.htm?ca=12_s';"
				post: 'https://api.leboncoin.fr/api/utils/phonenumber.json'
					contents: 'app_id=leboncoin_web_utils&key=', key ,'&list_id=' , self lbcId asString , '&text=1';
				contentReader: [ :entity | NeoJSONReader fromString: entity contents ].		
	^ (dico at: 'utils') 
			at: 'phonenumber' 
			ifAbsent: [ nil ] 
]

{ #category : #accessing }
LBCAnnonce >> tel [
	^ tel
]

{ #category : #accessing }
LBCAnnonce >> tel: anObject [
	tel := anObject
]

{ #category : #accessing }
LBCAnnonce >> titre [
	^ titre
]

{ #category : #accessing }
LBCAnnonce >> titre: anObject [
	titre := anObject
]

{ #category : #accessing }
LBCAnnonce >> versionPrecedente [
	^ versionPrecedente
]

{ #category : #accessing }
LBCAnnonce >> versionPrecedente: anObject [
	versionPrecedente := anObject
]

{ #category : #accessing }
LBCAnnonce >> visible [
	^ visible
]

{ #category : #accessing }
LBCAnnonce >> visible: anObject [
	visible := anObject
]
