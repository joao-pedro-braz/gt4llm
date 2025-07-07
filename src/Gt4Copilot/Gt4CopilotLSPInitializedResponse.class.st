Class {
	#name : #Gt4CopilotLSPInitializedResponse,
	#superclass : #Gt4CopilotLSPResponse,
	#category : #'Gt4Copilot-LSP'
}

{ #category : #defaults }
Gt4CopilotLSPInitializedResponse class >> method [
	^ 'initialized'
]

{ #category : #deserialization }
Gt4CopilotLSPInitializedResponse >> populateFrom: aDictionary [
	^ self
]
