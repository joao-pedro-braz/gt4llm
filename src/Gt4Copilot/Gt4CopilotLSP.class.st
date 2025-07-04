Class {
	#name : #Gt4CopilotLSP,
	#superclass : #Object,
	#instVars : [
		'version'
	],
	#category : #Gt4Copilot
}

{ #category : #creation }
Gt4CopilotLSP class >> withVersion: aCopilotLSPVersion [
	^ self new version: aCopilotLSPVersion
]

{ #category : #'as yet unclassified' }
Gt4CopilotLSP >> archiveName [
	^ 'copilot-language-server-{os}-{arch}-{version}.zip'
		format: self version asDictionary
]

{ #category : #default }
Gt4CopilotLSP >> baseUrl [
	^ 'https://github.com/github/copilot-language-server-release/releases/download'
		asZnUrl
]

{ #category : #'as yet unclassified' }
Gt4CopilotLSP >> download [
	self
		executeAsync: [ :job | 
			| targetFolder |
			targetFolder := self targetFolder.
			targetFolder ensureDeleteAll.
			targetFolder ensureCreateDirectory.

			[ ZnClient new
				url: self releaseUrl / self archiveName;
				signalProgress: true;
				withOptions: [ :options | options at: #queryKeyValueSafeSet put: ZnOptions queryKeyValueSafeSet \ '/;'	"Required as per https://github.com/svenvc/zinc/issues/69" ];
				downloadTo: targetFolder ]
				on: HTTPProgress
				do: [ :progress | 
					progress isEmpty ifFalse: [ job progress: progress percentage ].
					progress resume ].

			(ZipArchive new readFrom: targetFolder / self archiveName)
				extractAllTo: targetFolder.

			(self targetFolder / self archiveName) ensureDelete ]
		named: 'Downloading Github Copilot...'
]

{ #category : #private }
Gt4CopilotLSP >> executeAsync: aBlock named: aLabel [
	| job notification |
	job := GtJob block: aBlock.
	job label: aLabel.

	notification := GtNotificationJob new
			summaryClass: GtSingleJobNotificationSummary;
			job: job;
			registerNotifications;
			yourself.

	^ [ job run ] asAsyncPromise
]

{ #category : #initialization }
Gt4CopilotLSP >> initialize [
	super initialize.
	version := Gt4CopilotLSPVersion new
]

{ #category : #'as yet unclassified' }
Gt4CopilotLSP >> releaseUrl [
	^ self baseUrl / self version version
]

{ #category : #accessing }
Gt4CopilotLSP >> targetFolder [
	^ FileLocator localDirectory / 'copilot-language-server'
]

{ #category : #accessing }
Gt4CopilotLSP >> version [
	^ version
]

{ #category : #accessing }
Gt4CopilotLSP >> version: anObject [
	version := anObject
]
