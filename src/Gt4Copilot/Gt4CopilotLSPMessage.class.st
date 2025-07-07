Class {
	#name : #Gt4CopilotLSPMessage,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #'Gt4Copilot-LSP'
}

{ #category : #defaults }
Gt4CopilotLSPMessage class >> method [
	^ self subclassResponsibility
]

{ #category : #accessing }
Gt4CopilotLSPMessage >> id [
	^ id
]

{ #category : #accessing }
Gt4CopilotLSPMessage >> id: anObject [
	id := anObject
]
