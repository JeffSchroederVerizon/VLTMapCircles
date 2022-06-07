# VLTMapCircles
This repo holds a quick prototype of adding circles to a map using the VLTMaps SDK. It will add the map manually, center the map on a set of coordinates, and draw several circles both as a single and array of circles. They can be removed from the map by touching them. You need a Mapbox `download` key for the pod install to work. 
## Setup
1. Add the following to the ~/.netrc file: `machine api.mapbox.com  login mapbox password <your secret key with download privileges goes here>`
2. Run `pod install` on the project directory
3. Open the VLTMapsCircles.xcworkspace and on the VLTMapCirlces target update the 'Signing & Capabilities' with your cert  if you want to run on a device.
4. Add a `license.swift` file and add a constant `let VLT_API_KEY = "YourActualKey"`. The `license.swift` file is ignored by git.  Or you can just hard code it in ViewController.swift
5. Run the demo.
