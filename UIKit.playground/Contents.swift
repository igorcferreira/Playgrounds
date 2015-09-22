import UIKit
import MapKit

class TestViewController:UIViewController {}

extension TestViewController : MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseIdentifier = "pin"
        
        let view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier) as? MKPinAnnotationView
        
        if let annotationView = view {
            annotationView.annotation = annotation
            return annotationView
        }
        
        let newView = createAnnotationView(annotation, reuseIdentifier: reuseIdentifier)
        return newView
    }
    
    func createAnnotationView(annotation: MKAnnotation, reuseIdentifier: String) -> MKPinAnnotationView {
        let newView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        newView.canShowCallout = true
        newView.animatesDrop = true
        newView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        
        return newView
    }
}