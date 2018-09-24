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
			baseline: 'ZTimestamp'
			with: [ spec repository: 'github://Ducasse/ztimestamp:AddingBaseline/repository/' ].		
				
				
		spec 
			package: 'LeBonTrouveur'	with:
					[ spec requires: #('XPath' 'ZTimestamp') ]
		]
]
