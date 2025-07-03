Class {
	#name : #Gt4CopilotLSPVersion,
	#superclass : #Object,
	#instVars : [
		'version'
	],
	#category : #Gt4Copilot
}

{ #category : #'instance creation' }
Gt4CopilotLSPVersion class >> default [
	^ self with: self defaultVersion
]

{ #category : #'instance creation' }
Gt4CopilotLSPVersion class >> with: aVersionString [
	^ self new withVersion: aVersionString
]

{ #category : #'as yet unclassified' }
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

{ #category : #default }
Gt4CopilotLSPVersion >> defaultVersion [
	^ '1.339.0'
]

{ #category : #instantiation }
Gt4CopilotLSPVersion >> initialize [
	super initialize.
	version ifNil: [ version := self defaultVersion ]
]

{ #category : #'as yet unclassified' }
Gt4CopilotLSPVersion >> os [
	| platform |
	platform := OSPlatform current.
	platform isUnix64 ifTrue: [ ^ 'linux' ].
	platform isMacOS ifTrue: [ ^ 'darwin' ].
	platform isWin64 ifTrue: [ ^ 'win32' ].

	self error: 'Unsupported OS'
]

{ #category : #accessing }
Gt4CopilotLSPVersion >> version [
	^ version
]

{ #category : #accessing }
Gt4CopilotLSPVersion >> withVersion: anObject [
	version := anObject
]
