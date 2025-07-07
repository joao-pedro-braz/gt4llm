Class {
	#name : #Gt4CopilotLSPVersion,
	#superclass : #Object,
	#instVars : [
		'versionString'
	],
	#category : #'Gt4Copilot-LSP'
}

{ #category : #creation }
Gt4CopilotLSPVersion class >> default [
	^ self with: self defaultVersionString
]

{ #category : #default }
Gt4CopilotLSPVersion class >> defaultVersionString [
	^ '1.339.0'
]

{ #category : #'instance creation' }
Gt4CopilotLSPVersion class >> with: aVersionString [
	^ self new versionString: aVersionString
]

{ #category : #accessing }
Gt4CopilotLSPVersion >> arch [
	| platform |
	platform := OSPlatform current.
	platform isUnix64 ifTrue: [ ^ 'x64' ].
	platform isMacOS
		ifTrue: [ platform isMacOSX ifFalse: [ ^ 'x64' ].
			platform isTranslated ifTrue: [ ^ 'arm64' ] ].
	platform isWin64 ifTrue: [ ^ 'win32' ].

	self error: 'Unsupported OS'
]

{ #category : #converting }
Gt4CopilotLSPVersion >> asDictionary [
	^ {#arch -> self arch.
		#versionString -> self versionString.
		#os -> self os.
		#extension -> self extension} asDictionary
]

{ #category : #accessing }
Gt4CopilotLSPVersion >> extension [
	^ OSPlatform current isWindows ifTrue: [ '.exe' ] ifFalse: [ '' ]
]

{ #category : #instantiation }
Gt4CopilotLSPVersion >> initialize [
	super initialize.
	versionString
		ifNil: [ versionString := Gt4CopilotLSPVersion defaultVersionString ]
]

{ #category : #accessing }
Gt4CopilotLSPVersion >> os [
	| platform |
	platform := OSPlatform current.
	platform isUnix64 ifTrue: [ ^ 'linux' ].
	platform isMacOS ifTrue: [ ^ 'darwin' ].
	platform isWin64 ifTrue: [ ^ 'win32' ].

	self error: 'Unsupported OS'
]

{ #category : #accessing }
Gt4CopilotLSPVersion >> versionString [
	^ versionString
]

{ #category : #accessing }
Gt4CopilotLSPVersion >> versionString: aString [
	versionString := aString
]
