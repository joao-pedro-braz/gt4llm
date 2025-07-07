Class {
	#name : #Gt4CopilotLSPInitializeRequest,
	#superclass : #Gt4CopilotLSPRequest,
	#instVars : [
		'processId',
		'workspaceFolders',
		'editorInfoName',
		'editorInfoVersion',
		'editorPluginInfoName',
		'editorPluginInfoVersion'
	],
	#category : #'Gt4Copilot-LSP'
}

{ #category : #defaults }
Gt4CopilotLSPInitializeRequest class >> method [
	^ 'initialize'
]

{ #category : #accessing }
Gt4CopilotLSPInitializeRequest >> editorInfoName [
	^ editorInfoName
]

{ #category : #accessing }
Gt4CopilotLSPInitializeRequest >> editorInfoName: anObject [
	editorInfoName := anObject
]

{ #category : #accessing }
Gt4CopilotLSPInitializeRequest >> editorInfoVersion [
	^ editorInfoVersion
]

{ #category : #accessing }
Gt4CopilotLSPInitializeRequest >> editorInfoVersion: anObject [
	editorInfoVersion := anObject
]

{ #category : #accessing }
Gt4CopilotLSPInitializeRequest >> editorPluginInfoName [
	^ editorPluginInfoName
]

{ #category : #accessing }
Gt4CopilotLSPInitializeRequest >> editorPluginInfoName: anObject [
	editorPluginInfoName := anObject
]

{ #category : #accessing }
Gt4CopilotLSPInitializeRequest >> editorPluginInfoVersion [
	^ editorPluginInfoVersion
]

{ #category : #accessing }
Gt4CopilotLSPInitializeRequest >> editorPluginInfoVersion: anObject [
	editorPluginInfoVersion := anObject
]

{ #category : #accessing }
Gt4CopilotLSPInitializeRequest >> processId [
	^ processId
]

{ #category : #accessing }
Gt4CopilotLSPInitializeRequest >> processId: anObject [
	processId := anObject
]

{ #category : #serialization }
Gt4CopilotLSPInitializeRequest >> serializeParams [
	^ Dictionary new
		at: #processId put: self processId;
		at: #workspaceFolders put: self workspaceFolders;
		at: #capabilities
			put: (Dictionary new
					at: #workspace
						put: (Dictionary new
								at: #workspaceFolders put: true;
								yourself);
					yourself);
		at: #initializationOptions
			put: (Dictionary new
					at: #editorInfo
						put: (Dictionary new
								at: #name put: self editorInfoName;
								at: #version put: self editorInfoVersion;
								yourself);
					at: #editorPluginInfo
						put: (Dictionary new
								at: #name put: self editorPluginInfoName;
								at: #version put: self editorPluginInfoVersion;
								yourself);
					yourself);
		yourself
]

{ #category : #accessing }
Gt4CopilotLSPInitializeRequest >> workspaceFolders [
	^ workspaceFolders
]

{ #category : #accessing }
Gt4CopilotLSPInitializeRequest >> workspaceFolders: anObject [
	workspaceFolders := anObject
]
