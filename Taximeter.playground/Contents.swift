import Foundation

/*:
Let's look for a simple case. Taxi!

In **São Paulo** city, the [cost](http://www3.prefeitura.sp.gov.br/cadlem/secretarias/negocios_juridicos/cadlem/integra.asp?alt=30122014P%20001052014SMT) of a regular taxi ride is based on 4 values:
* A base value of R$4.50
* R$2.75 for each kilometer during the day
* R$3.58 for each kilometer during the night and sundays
* R$0.55 per minute that the car remain stopped

To calculate this rule, we can create an ```enum``` that will encapsulate the costs and a ```struct``` to hold the ride information:
*/

enum CalcNode {
	case Empty
	case Simple(value:Float)
	case Distance(value:Float)
	case Time(value:Float)
}

struct Taximeter {
	let currency:String
	let rule:[CalcNode]
	var time:Int
	var distance:Int
	
	init(currency:String, rule:[CalcNode], time:Int, distance:Int) {
		self.currency = currency
		self.rule = rule
		self.time = time
		self.distance = distance
	}
}

/*:
With this enum and struct, we can, now, create a job with any configuration rule
*/

let baseValue = CalcNode.Simple(value: 4.5)
let meterValue = CalcNode.Distance(value: 2.75)
let stoppedTimeValue = CalcNode.Time(value: 0.55)

var ride = Taximeter(currency:"R$", rule: [baseValue, meterValue, stoppedTimeValue], time: 0, distance: 0)

/*:
To calculate the cost, we reduce the nodes array and check the values
*/

extension Taximeter {
	var cost:String {
		let currentValue = rule.reduce(Float(0), combine: {
			switch $1 {
			case .Empty:
				return Float(0)
			case .Simple(let value):
				return $0 + Float(value)
			case .Distance(let value):
				return $0 + (value * Float(distance))
			case .Time(let value):
				return $0 + (value * Float(time))
			}
		})
		return "\(currency) \(currentValue)"
	}
}

/*:
To improve the display of the job, we can extend the ```CustomStringConvertible``` on the Job and display the cost
*/

extension Taximeter:CustomStringConvertible {
	var description:String {
		return cost
	}
}

/*:
Now, if we want to create a taximeter, all we need to do is change the values for distance and time
*/

ride.distance = 20
ride.time = 45

/*:
Based on this formula, we can extrapolate the functions of our taximeter
*/

extension Taximeter {
	var specificCosts:[CalcNode] {
		return rule.map {
			switch $0 {
			case .Empty:
				return .Empty
			case .Simple(let value):
				return .Simple(value: value)
			case .Distance(let value):
				return .Distance(value: (value * Float(distance)))
			case .Time(let value):
				return .Time(value: (value * Float(time)))
			}
		}
	}
}

let parcialCosts = ride.specificCosts

