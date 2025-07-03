Class {
	#name : #Gt4CopilotLSP,
	#superclass : #Object,
	#instVars : [
		'version'
	],
	#category : #Gt4Copilot
}

{ #category : #creation }
Gt4CopilotLSP class >> withVersion: aCopilotLSPVersion [
	^ self new withVersion: aCopilotLSPVersion
]

{ #category : #default }
Gt4CopilotLSP >> baseUrl [
	^ 'https://github.com/github/copilot-language-server-release/releases/download/{version}/copilot-language-server-{os}-{arch}-{version}.zip'
]

{ #category : #'as yet unclassified' }
Gt4CopilotLSP >> download: aCopilotLSPVersion [
	self releaseUrl: aCopilotLSPVersion
]

{ #category : #initialization }
Gt4CopilotLSP >> initialize [
	super initialize.
	version := Gt4CopilotLSPVersion new
]

{ #category : #'as yet unclassified' }
Gt4CopilotLSP >> releaseUrl [
	^ self baseUrl
		format: {#version -> self version version.
				#os -> self version os.
				#arch -> self version arch} asDictionary
]

{ #category : #'as yet unclassified' }
Gt4CopilotLSP >> releaseUrl: aCopilotLSPVersion [
	^ self baseUrl
		format: {#version -> aCopilotLSPVersion version.
				#os -> aCopilotLSPVersion os.
				#arch -> aCopilotLSPVersion arch} asDictionary
]

{ #category : #accessing }
Gt4CopilotLSP >> version [
	^ version
]

{ #category : #accessing }
Gt4CopilotLSP >> version: anObject [
	version := anObject
]
