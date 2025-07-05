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

{ #category : #'as yet unclassified' }
Gt4CopilotLSPClient >> arguments [
	^ arguments ifNil: [ #('--stdio') ]
]

{ #category : #initialization }
Gt4CopilotLSPClient >> initialize [
	super initialize.
	version := Gt4CopilotLSPVersion new
]

{ #category : #'as yet unclassified' }
Gt4CopilotLSPClient >> start [
	externalProcess := [ (GtExternalProcessBuilder new: self executablePath)
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
