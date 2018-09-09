"
Metacello new
    baseline: #LeBonTrouveur;
    repository: 'github://Ducasse/LeBonTrouveur';
    load
"
Class {
	#name : #BaselineOfLeBonTrouveur,
	#superclass : #BaselineOf,
	#category : #BaselineOfLeBonTrouveur
}

{ #category : #baselines }
BaselineOfLeBonTrouveur >> baseline: spec [
	<baseline>

	
	spec for: #pharo do: [		
				
		spec
			project: 'XPath'
			with: [ spec
						className: #ConfigurationOfXPath;
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/PharoExtras/XPath/main/' ].

		spec 
			package: 'LeBonTrouveur'	with:
					[ spec requires: #('XPath') ]
		]
]
