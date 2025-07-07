Class {
	#name : #Gt4CopilotLSPClient,
	#superclass : #Object,
	#instVars : [
		'executable',
		'stdin',
		'stdout',
		'stderr',
		'messageHandler',
		'arguments',
		'externalProcess',
		'errorHandler'
	],
	#category : #'Gt4Copilot-LSP'
}

{ #category : #creation }
Gt4CopilotLSPClient class >> default [
	^ self new executable: Gt4CopilotLSPExecutable default
]

{ #category : #'as yet unclassified' }
Gt4CopilotLSPClient >> arguments [
	^ arguments ifNil: [ #('--stdio') ]
]

{ #category : #accessing }
Gt4CopilotLSPClient >> executable [
	^ executable
]

{ #category : #accessing }
Gt4CopilotLSPClient >> executable: anObject [
	executable := anObject
]

{ #category : #'as yet unclassified' }
Gt4CopilotLSPClient >> send: aRequest andOn: aResponseClass do: aBlock [
	^ self notYetImplemented
]

{ #category : #'as yet unclassified' }
Gt4CopilotLSPClient >> start [
	externalProcess := [ (GtExternalProcessBuilder new: self executable pathString)
			args: self arguments;
			pipeStdin;
			pipeStdout;
			pipeStderr;
			spawn ]
			on: GtExternalProcessFailedToStart
			do: [ :exception "We want to be resilient against failures" | exception child ].
	stdout := externalProcess asynchronousStdout.
	stderr := externalProcess asynchronousStderr.
	stdin := externalProcess stdin.
	messageHandler := stdout
			pollStringEvery: 20 milliseconds
			do: [ :str | str inspect ]
]

{ #category : #'as yet unclassified' }
Gt4CopilotLSPClient >> terminate [
	externalProcess
		ifNotNil: [ externalProcess terminate.
			externalProcess := nil ].
	messageHandler
		ifNotNil: [ (messageHandler isTerminated or: [ messageHandler isTerminating ])
				ifFalse: [ messageHandler terminate ].
			messageHandler := nil ].
	stderr
		ifNotNil: [ stderr release.
			stderr := nil ].
	stdout
		ifNotNil: [ stdout release.
			stdout := nil ].
	stdin
		ifNotNil: [ stdin release.
			stdin := nil ]
]
