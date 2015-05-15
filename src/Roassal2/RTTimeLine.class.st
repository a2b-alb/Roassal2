"
Define a time line, a bit like a Gantt diagram.

Here is an example:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	| b data |
	data := #(#(WP1 0 5) #(WP2 5 8) #(WP3 7 10)).

	b := RTTimeline new.
	
	s := RTTimelineSet new.
	s objects: data.
	s lineIdentifier: #first.
	s start: #second.
	s end: #third.
	b add: s.
	
	b axisX 
		numberOfLabels: 5;
		labelRotation: -45;
		labelConversion: [ :v | Date year: 2015 day: v ]. 

	d := RTVerticalTickLineDecorator new.
	d shape line color: Color white.
	b addDecorator: d.
	b  open
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RTTimeline,
	#superclass : #RTAbstractGrapher,
	#instVars : [
		'sets',
		'timelineLabel'
	],
	#category : #'Roassal2-Builder-Timeline'
}

{ #category : #adding }
RTTimeline >> add: aTimeLineSet [
	sets add: aTimeLineSet
]

{ #category : #'accessing - computed' }
RTTimeline >> indexOfLineIdentifier: anIdentifier [
	^ self lineIdentifiers indexOf: anIdentifier
]

{ #category : #initialization }
RTTimeline >> initialize [
	super initialize.
	sets := OrderedCollection new.
	timelineLabel := #yourself.
	self axisY noTick; noLabel.
]

{ #category : #'private - utility' }
RTTimeline >> label: aString on: position [
	"Add a label in the view"
	| e |
	e := RTLabel elementOn: aString.
	e translateTo: position.
	self view add: e.
	^ e
]

{ #category : #'accessing - computed' }
RTTimeline >> lineIdentifiers [
	^ (sets flatCollect: #lineIdentifiers) removeDuplicates; yourself
]

{ #category : #'accessing - computed' }
RTTimeline >> numberOfEvents [
	^ sets inject: 0 into: [ :sum :aSet | sum + aSet numberOfObjects ]
]

{ #category : #'accessing - computed' }
RTTimeline >> numberOfLines [
	^ self lineIdentifiers size
]

{ #category : #'accessing - computed' }
RTTimeline >> numberOfSets [
	^ sets size
]

{ #category : #hooks }
RTTimeline >> renderIn: aView [
	self setsComputeMinAndMax.
	self defineAxesIfNecessary.
	
	self renderAllDecoratorsBehind.
	sets do: [ :aSet | aSet renderIn: aView using: self ].
	self renderAxis.	
	self renderAllDecoratorsInFront.
	self renderTimeLineLabels
]

{ #category : #'private - utility' }
RTTimeline >> renderTimeLineLabels [
	| labels position labelElements offset halfVerticalStep |
	labels := self lineIdentifiers collect: [ :i | (timelineLabel rtValue: i) asString ].
	labelElements := RTGroup new.
	labels doWithIndex: [ :aLabel :index |
		position := self getPixelPositionOf: 0 @ index.
		labelElements add: (self label: aLabel on: position) ].

	offset := 10.
	halfVerticalStep := (self getPixelPositionOf: 0 @ 1) y / -2.

	TRConstraint alignFromRight: labelElements.
	labelElements translateBy: (labelElements extent x / 2 + offset) negated @ halfVerticalStep. 
]

{ #category : #'private - utility' }
RTTimeline >> setsComputeMinAndMax [
	"We are here compute the minimum and maximum of the timeline (X-axis, Y-axis)"
	| globalMin globalMax |
	self numberOfSets = 0 ifTrue: [ ^ self ].
	
	globalMin := (sets collect: #localMin) min.
	globalMax := (sets collect: #localMax) max.
	
	sets do: [ :s | s globalMin: globalMin ].
	sets do: [ :s | s globalMax: globalMax ].
	
	self maxX: globalMax.
	self maxY: self numberOfLines.

]

{ #category : #accessing }
RTTimeline >> timelineLabel [
	^ timelineLabel
]

{ #category : #accessing }
RTTimeline >> timelineLabel: symbolOrBlock [
	timelineLabel := symbolOrBlock
]