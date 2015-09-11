//:  This is a basic file to present you how to manipulate and iterate over the ```Array``` on Swift

import Foundation

var array = [2,2,3,4,5,6,2,4,6,3,4,1]
array
//: Given that array, what ways we have to iterate over those values?

for index in array.indices {
	index
	let int = array[index]
}

array.indices.forEach {
	let index = $0
	let value = array[$0]
}
array.forEach {
	let value = $0
}

for (index, value) in array.enumerate() {
	index
	value
}

let range = array.indices
zip(range, array[range]).forEach {
	index, value in
	index
	value
}

let count = array.reduce(0, combine: {
	let result = $0
	let element = $1
	return result + element
})
count

//: Other way to iterate over the collection is use the map and flatMap closures

let results:[String] = array.map {
	let int = $0
	return String(int)
}
results

let stringResults:[String] = array.flatMap {
	let int = $0
	return String(int)
}

stringResults


//: So, what is the difference between map and flatMap? Let's look to another collection type

let arrayCollection = [[6,6,7],[2,3,4], [4,2]]

let map = arrayCollection.map {
	return $0
}
let flatMap = arrayCollection.flatMap {
	return $0
}

//: See! Now, they are not the same thing. To achieve the same thing, we need another approach
let flatten = arrayCollection.flatten()
let mapAfterFlatten = flatten.map {
	return $0
}

//: More specific, the flatMap is the result of the flatten operation + the map call
