Class {
	#name : #Gt4CopilotLSPExecutable,
	#superclass : #FileReference,
	#instVars : [
		'version'
	],
	#category : #'Gt4Copilot-LSP'
}

{ #category : #accessing }
Gt4CopilotLSPExecutable class >> defaultDirectory [
	^ (FileLocator localDirectory / 'copilot-language-server') asPath
]

{ #category : #creation }
Gt4CopilotLSPExecutable class >> forVersion: aCopilotLSPVersion [
	^ self
		forVersion: aCopilotLSPVersion
		inDirectory: Gt4CopilotLSPExecutable defaultDirectory
]

{ #category : #creation }
Gt4CopilotLSPExecutable class >> forVersion: aCopilotLSPVersion inDirectory: aPathToContainingDirectory [
	^ (self
		fileSystem: FileSystem disk
		path: aPathToContainingDirectory asPath / (self resolveName: aCopilotLSPVersion))
		version: aCopilotLSPVersion
]

{ #category : #defaults }
Gt4CopilotLSPExecutable class >> resolveName: aCopilotLSPVersion [
	^ 'copilot-language-service-{versionString}{extension}'
		format: aCopilotLSPVersion asDictionary
]

{ #category : #defaults }
Gt4CopilotLSPExecutable >> archiveName [
	^ 'copilot-language-server-{os}-{arch}-{versionString}.zip'
		format: self version asDictionary
]

{ #category : #defaults }
Gt4CopilotLSPExecutable >> archiveUrl [
	^ ('https://github.com/github/copilot-language-server-release/releases/download/{versionString}'
		format: self version asDictionary) asZnUrl
]

{ #category : #utilities }
Gt4CopilotLSPExecutable >> cleanUp: aPathToArchive [
	^ self
		job: [ self ensureExecutable.
			aPathToArchive asFileReference ensureDelete ]
		named: 'Cleaning up...'
]

{ #category : #utilities }
Gt4CopilotLSPExecutable >> downloadArchive [
	"I download the executable archive to my current parent directory"

	^ self
		job: [ :job | 
			| archive |
			archive := self parent / self archiveName.
			archive ensureDelete.

			[ ZnClient new
				url: self archiveUrl / self archiveName;
				signalProgress: true;
				withOptions: [ :options | options at: #queryKeyValueSafeSet put: ZnOptions queryKeyValueSafeSet \ '/;'	"Required as per https://github.com/svenvc/zinc/issues/69" ];
				downloadTo: archive ]
				on: HTTPProgress
				do: [ :progress | 
					job current: progress percentage.
					progress resume ].

			archive ]
		named: 'Downloading...'
]

{ #category : #private }
Gt4CopilotLSPExecutable >> ensureExecutable [
	self isExecutable
		ifFalse: [ OSPlatform current isWindows
				ifFalse: [ LibC system: 'chmod +x ' , self pathString ]
				ifTrue: [ self error: 'Unsupported operation' ] ]
]

{ #category : #utilities }
Gt4CopilotLSPExecutable >> extractArchive: aPathToZipArchive [
	"I am an utility method to extract the executable I represent from a given ZIP archive."

	^ self
		job: [ :job | 
			self ensureDelete.
			self ensureCreateFile.
			(ZipArchive new
				readFrom: aPathToZipArchive;
				members) first extractTo: self binaryWriteStream.

			aPathToZipArchive ]
		named: 'Extracting...'
]

{ #category : #operations }
Gt4CopilotLSPExecutable >> fetch [
	"I fetch, extract and setup the executable from the appropriate Github Releases page"

	^ (self downloadArchive then: [ :archive | self extractArchive: archive ])
		then: [ :archive | self cleanUp: archive ]
]

{ #category : #testing }
Gt4CopilotLSPExecutable >> isValid [
	^ self exists and: [ self isExecutable ]
]

{ #category : #private }
Gt4CopilotLSPExecutable >> job: aBlock named: aString [
	| job notification |
	job := GtJob block: aBlock.
	job label: aString.

	notification := GtNotificationJob new
			summaryClass: GtSingleJobNotificationSummary;
			job: job;
			registerNotifications;
			yourself.

	^ [ job run ] asAsyncPromise
]

{ #category : #accessing }
Gt4CopilotLSPExecutable >> version [
	^ version
]

{ #category : #accessing }
Gt4CopilotLSPExecutable >> version: anObject [
	version := anObject
]
