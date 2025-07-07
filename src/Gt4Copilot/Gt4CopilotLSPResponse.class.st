Class {
	#name : #Gt4CopilotLSPResponse,
	#superclass : #Gt4CopilotLSPMessage,
	#category : #'Gt4Copilot-LSP'
}

{ #category : #testing }
Gt4CopilotLSPResponse class >> accepts: aRawMessage [
	^ (aRawMessage at: #method) equalsTo: self method
]

{ #category : #creation }
Gt4CopilotLSPResponse class >> from: aRawMessage [
	^ self new
		id: (aRawMessage at: #id);
		populateFrom: (aRawMessage at: #params);
		yourself
]

{ #category : #deserialization }
Gt4CopilotLSPResponse >> populateFrom: aDictionary [
	^ self subclassResponsibility
]
