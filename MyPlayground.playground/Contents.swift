//: Playground - noun: a place where people can play

import UIKit

extension CollectionType {
	/// Return a lazy SequenceType containing pairs *(i, x)*,
	/// where *i*s are the sequential indices and *x*s are the elements of `base`.
	func enumerateWithIndex() -> AnySequence<(Index, Generator.Element)> {
		var index = startIndex
		return AnySequence {
			return anyGenerator {
				guard index != self.endIndex else { return nil }
				return (index, self[index++])
			}
		}
	}
}

let str = "Hello from Nate"

// omg
let name = str.characters[str.characters.startIndex.advancedBy(11) ..< str.characters.startIndex.advancedBy(15)]

for (index, char) in name.enumerate() {
	// type doesn't match:
	// error: cannot subscript a value of type 'String.CharacterView' with an index of type 'Int'
	// print(char, name[index])
}

for (index, char) in name.enumerateWithIndex() {
	print(char, name[index])
}

func response(divider:Int, _ expectedResult:Int) -> ((Int) -> Bool) {
	return {
		value in
		return value % divider == expectedResult
	}
}

let numbers = [1,2,3,4,5,6,7,8,9,0]
let eaven = numbers.filter(response(2,0))
let notEavend = numbers.filter(response(2,1))
