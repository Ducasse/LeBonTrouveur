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
			package: 'LeBonTrouveur'.
		]
]
