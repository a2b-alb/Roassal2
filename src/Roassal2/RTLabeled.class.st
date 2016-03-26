"
A RTLabelled  adds a label above an element. The label may be particularized using #text: in the default string representation is not sufficient. Consider:

E.g., 
v := RTView new.
e := (RTEllipse new size: 30) elementOn: 42.
v add: e.
e @ (RTLabelled new text: [ :value | 'My value is ', value asString ]).
v

Instance Variables
	canvas:		<Object>
	color:		<Object>
	highlightable:		<Object>
	lowColor:		<Object>
	offsetOnEdge:		<Object>
	position:		<Object>
	text:		<Object>

canvas
	- xxxxx

color
	- xxxxx

highlightable
	- xxxxx

lowColor
	- xxxxx

offsetOnEdge
	- xxxxx

position
	- xxxxx

text
	- xxxxx

"
Class {
	#name : #RTLabeled,
	#superclass : #RTInteraction,
	#instVars : [
		'canvas',
		'color',
		'highlightable',
		'lbl',
		'lowColor',
		'offsetOnEdge',
		'position',
		'text',
		'fontSize'
	],
	#category : #'Roassal2-Interactions'
}

{ #category : #public }
RTLabeled class >> above [
	"Default behavior"
	^ self new
]

{ #category : #public }
RTLabeled class >> below [
	^ self new below
]

{ #category : #public }
RTLabeled class >> center [
	^ self new center
]

{ #category : #visitor }
RTLabeled >> accept: aVisitor with: args [
	aVisitor visitLabelledInteraction: self with: args
]

{ #category : #'public - layout' }
RTLabeled >> below [
	position := #below
]

{ #category : #'public - layout' }
RTLabeled >> bottomLeft [
	position := #bottomLeft
]

{ #category : #'public - layout' }
RTLabeled >> center [
	position := #center		
]

{ #category : #accessing }
RTLabeled >> color [
	^ color
]

{ #category : #accessing }
RTLabeled >> color: aBlockOrColor [
	color := aBlockOrColor
]

{ #category : #accessing }
RTLabeled >> fontSize [
	^ fontSize
]

{ #category : #accessing }
RTLabeled >> fontSize: anObject [
	fontSize := anObject
]

{ #category : #initialization }
RTLabeled >> initialize [
	super initialize.
	text := #model.
	self top.
	color := Color gray.
	lowColor := Color veryVeryLightGray.
	
	highlightable := false. 
	offsetOnEdge := 0.5.

	fontSize := TRLabelShape defaultFontSize.

	canvas := [ :el | 
		el view ifNil: [ self error: 'You are trying to use RTLabelled on an element before adding the element to the view. Two solutions: (i) specify the view to the RTLabelled (using #view:) or (ii) use RTLabelled after having added the element' ].
		el view canvas ]
]

{ #category : #hooks }
RTLabeled >> initializeElement: element [
	| s t callback |
	t := text rtValue: element.
	t isNil ifTrue: [ ^ self ].
	
	s := element trachelShape.
	lbl := TRLabelShape new text: t asString.
	lbl color: (color rtValue: element).
	lbl fontSize: (fontSize rtValue: element model).
	
	"We first get a reference to the canvas, and then we add the shape in it"
	"We are using the variable canvas to let the user specificy the canvas (or the view) before 
	adding the element into it"
	canvas := (canvas rtValue: element).
	canvas addShape: lbl.
	
	self make: lbl highlightableIfNecessaryBy: element.
	
	"Make sure that if we remove the element, the trachel shape is also removed"
	callback := TRRemoveCallback new block: [ :shape | lbl remove ].
	element trachelShape addCallback: callback.
	element 
		attributeAt: #RTLabelledCallback put: callback;
		attributeAt: #RTLabelledLabel put: lbl.
	
	"Not really nice. Maybe a different solution could be to have a double dispatch"
	(element isKindOf: RTEdge) 
		ifTrue: [ TRConstraint 
							stick: lbl 
							between: element from trachelShape 
							and: element to trachelShape
							offset: offsetOnEdge. 
				  ^ lbl ].

	
	self isTop ifTrue: [ TRConstraint stick: lbl above: s ]. 
	self isBelow ifTrue: [ TRConstraint stick: lbl below: s ].
	self isLeft ifTrue: [ TRConstraint stick: lbl onTheLeftOf: s ].
	self isRight ifTrue: [ TRConstraint stick: lbl onTheRightOf: s ].
	self isCenter ifTrue: [ TRConstraint stick: lbl onTheCenterOf: s ].
	self isBottomLeft ifTrue: [ TRConstraint stick: lbl onTheBottomLeftOf: s ].
	^ lbl.
]

{ #category : #testing }
RTLabeled >> isBelow [
	^ position = #below
]

{ #category : #testing }
RTLabeled >> isBottomLeft [
	^ position = #bottomLeft
]

{ #category : #testing }
RTLabeled >> isCenter [
	^ position = #center		
]

{ #category : #testing }
RTLabeled >> isLeft [
	^ position = #left
]

{ #category : #testing }
RTLabeled >> isRight [
	^ position = #right
]

{ #category : #testing }
RTLabeled >> isTop [
	^ position = #top
]

{ #category : #accessing }
RTLabeled >> lbl [
	^ lbl
]

{ #category : #accessing }
RTLabeled >> left [
	position := #left
]

{ #category : #accessing }
RTLabeled >> lowColor [
	^ lowColor
]

{ #category : #accessing }
RTLabeled >> lowColor: aBlockOrColor [
	lowColor := aBlockOrColor
]

{ #category : #utility }
RTLabeled >> make: label highlightableIfNecessaryBy: element [
	"Do nothing if there is no need to"
	highlightable ifFalse: [ ^ self ].
	
	label color: lowColor.
	element when: TRMouseEnter do: [ :evt | label color: color. label pushFront. evt signalUpdate ].
	element when: TRMouseLeave do: [ :evt | label color: lowColor. evt signalUpdate ].
]

{ #category : #accessing }
RTLabeled >> offsetOnEdge [
	^ offsetOnEdge
]

{ #category : #accessing }
RTLabeled >> offsetOnEdge: aFloat [
	"aFloat is between 0.0 and 1.0. With a value of 1.0, the label is close to the starting extremity, if RTLabelled is used on an edge"
	offsetOnEdge := aFloat
]

{ #category : #public }
RTLabeled >> removeLabelFrom: aRTElement [ 
	| callback label |
	callback := aRTElement attributeAt: #RTLabelledCallback ifAbsent: [ ^ self ].
	aRTElement trachelShape removeCallback: callback ifAbsent: [ ].
	label := aRTElement attributeAt: #RTLabelledLabel ifAbsent: [ ^ self ].
	label remove.
	aRTElement
		removeAttributeAt: #RTLabelledCallback;
		removeAttributeAt: #RTLabelledLabel.
]

{ #category : #'public - layout' }
RTLabeled >> right [
	position := #right
]

{ #category : #'public configuration' }
RTLabeled >> setAsHighlightable [
	"Make the label highlightable by moving the mouse over the element"
	highlightable := true
]

{ #category : #accessing }
RTLabeled >> text: aValueOrAOneArgBlock [
	"aValueOrAOneArgBlock is applied on the object model"
	self textElement: [ :anElement | aValueOrAOneArgBlock rtValue: anElement model ]
]

{ #category : #accessing }
RTLabeled >> textElement [
	"Return the string value, symbol, or block that is evaluated, using rtValue: against an element"
	^ text
]

{ #category : #accessing }
RTLabeled >> textElement: aTextOrBlock [
	text := aTextOrBlock
]

{ #category : #'public - layout' }
RTLabeled >> top [
	position := #top
]

{ #category : #accessing }
RTLabeled >> view: aBlockOrValue [
	"aBlock is evaluated against the element to get the canvas"
	canvas := [ :el | (aBlockOrValue rtValue: el) canvas ]
]