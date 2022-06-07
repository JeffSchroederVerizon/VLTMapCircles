import CoreLocation
import UIKit
import VLTMaps

class ViewController: UIViewController, VLTMapViewDelegate {
    // MARK: - Private Variables
    /// The mapView object that displays map data
    private var mapView: VLTMapView!
    private let cameraCenter = CLLocationCoordinate2D(latitude: 39.8111444, longitude: -98.5569364)
    
    // MARK: - Outlets
    @IBOutlet weak var centerButton: UIButton!
    

    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let mapConfiguration = MapConfiguration(mode: .day, cameraCenter: cameraCenter)
        mapView = VLTMapView(frame: view.bounds)
        mapView.delegate = self
        view.addSubview(mapView)
        
        mapView.loadMap(apiKey: VLT_API_KEY, configuration: mapConfiguration)
        view.bringSubviewToFront(centerButton)
    }
    
    @IBAction func centerButtonPressed(_ sender: Any) {
        do
        {
            /// Update the camera to center on the user's current location
            try mapView.camera.updateCamera(tilt: nil,
                                            bearing: nil,
                                            zoom: nil,
                                            target: cameraCenter,
                                            withAnimation: true)
        } catch {
            print("!!!!! - No Center")
        }
    }
    
    // MARK: VLTMapViewDelegate Conformance
    func didFinishLoadingMap(mapView: VLTMapView) {
        guard (mapView.map?.style) != nil else {
            print("!!!!! - No Style")
            return
        }
        
        // 1 - Zoom in
        do
        {
            try mapView.camera.set(zoom: 14)
        }
        catch
        {
            print("!!!!! - No Zoom")
        }
        
        let accuracy = 30 as CLLocationDistance
        let accuracyCircle = VLTMapCircle(coordinate: cameraCenter, radius: accuracy, fillColor: UIColor.blue.withAlphaComponent(0.4), strokeColor: UIColor.blue)
  
        // 2 - Add single circle
        do
        {
            try mapView.add(objects: [accuracyCircle])
        }
        catch
        {
            print("!!!!! -  No Single Circle")
        }
        
        let coordinate1 = CLLocationCoordinate2D(latitude: 39.8111444, longitude: -98.5560)
        let coordinate2 = CLLocationCoordinate2D(latitude: 39.8111444, longitude: -98.5578)
        let coordinate3 = CLLocationCoordinate2D(latitude: 39.8111444, longitude: -98.5586)
        
        let accuracyCircle1 = VLTMapCircle(coordinate: coordinate1, radius: accuracy, fillColor: UIColor.red.withAlphaComponent(0.4), strokeColor: UIColor.red)
        let accuracyCircle2 = VLTMapCircle(coordinate: coordinate2, radius: accuracy, fillColor: UIColor.green.withAlphaComponent(0.4), strokeColor: UIColor.green)
        let accuracyCircle3 = VLTMapCircle(coordinate: coordinate3, radius: accuracy, fillColor: UIColor.purple.withAlphaComponent(0.4), strokeColor: UIColor.purple)
        
        // 2 - Add array of circles
        do
        {
            try mapView.add(objects: [accuracyCircle1, accuracyCircle2, accuracyCircle3])
        }
        catch
        {
            print("!!!!! -  No Mutliple Circles")
        }
    }
    func tappedOnCircle(mapView: VLTMapView, circle: VLTMapCircle, coordinate: CLLocationCoordinate2D) {
        do
        {
            try mapView.remove(object: circle)
        }
        catch
        {
            print("!!!!! -  No Remove Circle")
        }
    }
    
    func tappedOnMap(mapView: VLTMapView, point: CGPoint, coordinate: CLLocationCoordinate2D) {
        print("Coordinate: \(mapView.convertPointToCoordinate(point: point))")
    }
    
    func didFailLoadingMap(mapView: VLTMapView, error: Error) {
        let alert = UIAlertController(title: "Map Error", message: "Can't Load Map", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "End", style: .default) { _ in exit(0)})
        present(alert, animated: true)
    }
}
