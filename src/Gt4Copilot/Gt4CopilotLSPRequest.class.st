Class {
	#name : #Gt4CopilotLSPRequest,
	#superclass : #Gt4CopilotLSPMessage,
	#category : #'Gt4Copilot-LSP'
}

{ #category : #serialization }
Gt4CopilotLSPRequest >> serialize [
	^ {#jsonrpc -> '2.0'.
		#id -> self id.
		#method -> self class method.
		#params -> self serializeParams} asDictionary
]

{ #category : #serialization }
Gt4CopilotLSPRequest >> serializeParams [
	^ self subclassResponsibility
]
