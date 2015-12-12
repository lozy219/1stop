//
//  DestinationMapViewController.swift
//  1stop
//
//  Created by Lei Mingyu on 12/12/15.
//  Copyright © 2015 golearn. All rights reserved.
//

import UIKit
import MapKit

class DestinationMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet private weak var mapView: MKMapView!
    private var selectedRoutePoint: RoutePoint?
    private let pc: UIPopoverPresentationController = UIPopoverPresentationController()
    private let locationManager: CLLocationManager = CLLocationManager()
    private var routePolyline: MKPolyline?
    private var routePoints: [RoutePoint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.zoomIntoSingapore()
        mapView.showsUserLocation = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func refresh(sender: AnyObject) {
        // Remove polylines
        mapView.removeOverlays(mapView.overlays)
        
        // Remove annotation
        for annotation in mapView.annotations {
            if annotation is MKUserLocation {
                mapView.removeAnnotation(annotation)
            }
        }
    }
    
    func zoomIntoSingapore() {
        // Start and zoom into Singapore
        var newRegion = MKCoordinateRegion()
        newRegion.center.latitude = 1.360117
        newRegion.center.longitude = 103.803635
        newRegion.span.latitudeDelta = 0.2
        newRegion.span.longitudeDelta = 0.2
        mapView.setRegion(newRegion, animated: true)
        mapView.delegate = self
    }
    
    func setRoutePolylines(polyline: MKPolyline) {
        // Remove previous routePolylines
        mapView.removeOverlays(mapView.overlays)
        
        // Update routePolylines with new data
        routePolyline = polyline
        mapView.addOverlay(routePolyline!)
    }
    
    func setRoutePoints(rpoints: [RoutePoint]) {
        routePoints = rpoints
        
        // Remove previous annotation pins
        for annotation in mapView.annotations {
            if annotation is MKUserLocation {
                mapView.removeAnnotation(annotation)
            }
        }
        
        // Show new annotation pins
        var zoomRect = MKMapRectNull
        for pin in routePoints {
            mapView.addAnnotation(pin)
            
            let annotationPoint = MKMapPointForCoordinate(pin.coordinate)
            let pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1)
            zoomRect = MKMapRectUnion(zoomRect, pointRect)
        }
        
        // Zoom into to fit visible pins
        mapView.setVisibleMapRect(zoomRect, animated: true)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = UIColor.redColor()
        polylineRenderer.lineWidth = 8.0
        return polylineRenderer
    }
    
    func zoomToPolyline(map: MKMapView, polyline: MKPolyline, animated: Bool) {
        let polygon = MKPolygon(points: polyline.points(), count: polyline.pointCount)
        map.setRegion(MKCoordinateRegionForMapRect(polygon.boundingMapRect), animated: true)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var pinView: MKAnnotationView?
        let coord1 = annotation.coordinate
        let coord2 = mapView.userLocation.coordinate
        if coord1.latitude != coord1.latitude || coord1.longitude != coord2.longitude {
            let defaultPindID = "sg.1stop.pin"
            pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(defaultPindID)
            if pinView == nil {
                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: defaultPindID)
            }
            
            pinView?.image = UIImage(named: "red-pin-dot.png")
            
            pinView?.canShowCallout = true
            pinView?.opaque = true
        } else {
            mapView.userLocation.title = "I am here."
        }
        return pinView
    }
    
    func removeSelectedRoutePoint() {
        if (selectedRoutePoint != nil) {
            mapView.removeAnnotation(selectedRoutePoint!)
        }
        
        for currentAnnotation in mapView.annotations {
            mapView.deselectAnnotation(currentAnnotation, animated: true)
        }
    }
    
    func setSelectedRoutePoint(r: RoutePoint) {
        // Remove previous callout if exists
        if selectedRoutePoint != nil {
            mapView.removeAnnotation(selectedRoutePoint!)
        }
        
        // Update new routepoint and add it to map
        selectedRoutePoint = r
        mapView.addAnnotation(selectedRoutePoint!)
        
        mapView.selectAnnotation(r, animated: true)
    }
}

