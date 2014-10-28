"
RTUMLExample new installTitle: 'colored' 
		code:
		'| b |
b := RTUMLClassBuilder new.
b methodShape label
	if: [ :method | method selector beginsWith: ''init'' ] color: Color green;
	if: [ :method | method selector beginsWith: ''with'' ] color: Color red.
			
b attributeShape label
	if: [ :attribute | attribute beginsWith: ''a'' ] color: Color blue.
b addObjects: RTShape withAllSubclasses.
b treeLayout.

b view setDefaultMenu.
b open.
b view canvas'
"
Class {
	#name : #RTUMLExample,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-UML'
}

{ #category : #sources }
RTUMLExample >> examplecolored [
| b |
b := RTUMLClassBuilder new.
b methodShape label
	if: [ :method | method selector beginsWith: 'init' ] color: Color green;
	if: [ :method | method selector beginsWith: 'with' ] color: Color red.
			
b attributeShape label
	if: [ :attribute | attribute beginsWith: 'a' ] color: Color blue.
b addObjects: RTShape withAllSubclasses.
b treeLayout.

b view setDefaultMenu.
b open.
b view canvas
]

{ #category : #icons }
RTUMLExample >> examplecoloredIcon [
	^ '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'
]

{ #category : #sources }
RTUMLExample >> exampleexampleWithNonClasses [

| objects b |
	objects :=  {
		{ 'MyClass' . { #iv1 . #iv2 } . { #method1 . #method2 . #method3 }}  .
		{ 'MyClass2' . { #iv2 . #iv2 } . { #method1 . #method2 . #method4 }}  }.

	b := RTUMLClassBuilder new.
	b attributeShape label if: [ :a | a = #iv1 ] color: Color red.
	b
		addObjects: objects;
		classname: #first;
		instanceVariables: #second;
		methodsNames: #third;
		methodselector: #yourself;
		attributeselector: #yourself;
		superclass: nil;
		open.
b view canvas
]

{ #category : #icons }
RTUMLExample >> exampleexampleWithNonClassesIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAEFElEQVR4XuXZR0skaxTG8fl6
LvwObty4UBDduFFRMSxEUcSMATMGRBAMqBgwx4VgzmGhjoqKC/vceg5478xgO109XO6d+T9Q
tF3dbwv1qzpvvae+mPHzf8oX/iHgg/DDB+GD8MMH4YPwwwfhg/DDB+GD8MMH4YcPwgfhhw/C
B+GHD8IH4YcPwgfhhw/CDx+ED8IPH4QPwg8fhA/CDx+ED8IPH4QfPggfhB8+CB+EHz4IH4Qf
Pggf5L/O3t5eJOx2dHQU0diHh4dIPOO13dzcRPggH+Tw8DD0mImJie9e40kkCB8kJMjd3V3c
ILe3t3yQeEGamppsdnbWtra27OzszKqrq/2z/v5+W1lZsenpabu6urKDg4MPQfLy8iwhIcGm
pqZsbm7OgnJkHR0dtru7a4uLi/4b+j+jo6M2PDzMB/kZSFdXl3V3d9vl5aUVFhZaaWmp7e/v
W29vr9XU1PiBbW5utszMzA9BSkpKLCsry0ZGRnSgbXNz08rLy62zs9P3NTY22sXFhWVkZNj4
+DgfJNaS9fLyYjMzM3HPIQMDA/w5hD+p/4kgwRwR1Cizr18tqDOhQdrb232e0Lyxvr7OB/ll
kOBAWn29WVub2dJSaJCCggKbnJz0GwP+FcIvWXwQPsi/DLK8vOx/Pz8/W19fX2iQtbU1f9Ut
bazAfJBPQDQZ9/T0BNNIva8fwoIkJSX5/LGxsWGPj498kF8F0Qo9aBTa9fW1ZWdnhwbZ3t52
DI2NtYzxQT4B0ao81k09qm9B9D7M+Pff4IN8AqLe08nJibc91Mva2dnxV23K8fGxt1GiXSH6
3vn5uZ2envp8kp6e7vvVnFTLRB0A/hUSAkT9K9X+nJwcbyxqcad9lZWVlpaW5t/Jzc2NCiKI
uro673e9j83Pz/dSqKbk09MTH4R/2/sHgby9vX33Xme4ylYsIBqrdv23Udnig4QsWbW1tb6l
pKTY2NiYpaamWllZmd8Ga32xuroaFUSlTS37xMTEoPvSZsnJyd7fGhwc9FtpIf2Iwgf5BERn
9OvrqzcIh4aGHED79EBJk/XCwoLPCdFA7u/vfWxFRYW37zVW4/SwSnOS1jhLP/TI+CD8OeT3
ukL0GFfzhM50lSw9QVQHV+sGXTGtra1RQVpaWvy7DQ0Nf5csPe5VS0Yla35+ng8Sz21vUVGR
lxc9etU+vde8ogNfVVX109ve4uJifw6vsfod9cVUsrSG0UqeD8IvWb8fSHDmRoJSFWoLJm4/
mMHCL/TY9y1YxfNB+OGD8EH44YPwQfjhg/BB+OGD8EH44YPwwwfhg/DDB+GD8MMH4YPwwwfh
g/DDB+GHD8IH4YcPwgfhhw/CB+GHD8IH4YcPwg8fhA/CDx+ED8IPH4QPwg8fhA/CDx+En3/y
F6uitrt8gybeAAAAAElFTkSuQmCC'
]

{ #category : #accessing }
RTUMLExample >> label [
	^ 'UML'
]