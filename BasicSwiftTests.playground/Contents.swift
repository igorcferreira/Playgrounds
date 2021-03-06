//:  This is a basic file to present you how to manipulate and iterate over the ```Array``` on Swift

import Foundation

//: AnySequence able to generate fibonnaci elements
let fibs = AnySequence { () -> AnyGenerator<Int> in
    var i = 0
    var j = 1
    return anyGenerator {
        (i , j) = (j, j + i)
        return i
    }
}

//: A call to the 7 first elements in the sequence
let sequence = fibs.prefix(7)
sequence.forEach {
    print($0)
}

struct BasicStruct {
    private(set) lazy var array:[Int] = {
        let array = [2,2,3,4,5,6,2,4,6,3,4,1]
        print("Here comes a new int array")
        return array
    }()
    
    let otherArray:[String] = {
        let array = ["Um", "Dos", "Tres", "Quatorze"]
        print("Here comes a new string array")
        return array
    }()
}

extension BasicStruct : Comparable {}

func ==(var lhs:BasicStruct, var rhs:BasicStruct) -> Bool {
    return lhs.otherArray == rhs.otherArray && lhs.array == rhs.array
}

func <(lhs:BasicStruct, rhs:BasicStruct) -> Bool {
    return lhs.otherArray.count < rhs.otherArray.count
}

let stringArary = ["Opa", "Eu"]

let dateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

let dateObject = dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: 162000))

let dateString = "2015-08-14T16:00:00.000-0700"
let date = dateFormatter.dateFromString(dateString)


extension String {
    func matchRegex(regex:String, locale:NSLocale = NSLocale.currentLocale()) -> Bool
    {
        guard let _ = self.rangeOfString(regex, options: .RegularExpressionSearch, range: self.characters.indices, locale: locale) else {
            return false
        }
        return true
    }
}

infix operator ~= { associativity left precedence 160 }
func ~= (input:String, pattern:String) -> Bool {
    return input.matchRegex(pattern)
}

let stringExample = "Gather Customer Information and Documents"
let regex = "^([Gg]ather)\\s.*\\s?([Ii]nformation)"
let locale = NSLocale.currentLocale()
if let match = stringExample.rangeOfString(regex, options: .RegularExpressionSearch, range: stringExample.characters.indices, locale: locale) {
    print("Matched")
}
if stringExample.matchRegex(regex, locale: locale) {
    print("Matched")
}

if stringExample ~= regex {
    print("Matched")
}

var element = BasicStruct()

element.array
element.array.append(5)
element.array.append(6)
element.array.append(7)

element.otherArray
element.otherArray.count

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
let flatten = Array(arrayCollection.map({
    return $0
}).flatten())


//: More specific, the flatMap is the result of map + flatten
