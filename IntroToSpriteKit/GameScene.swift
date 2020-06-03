//
//  GameScene.swift
//  IntroToSpriteKit
//
//  Created by Russell Gordon on 2019-12-07.
//  Copyright © 2019 Russell Gordon. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    

     // Create the variables required for the app, these variables would then be changed by the user
     var velocity: Double = 10
     var acceleration: Double = 5
     var rampAngle: Double = 30.0
     var gravity: Double = 9.8
     var rampHeight: Double = 10
     var distanceToRamp: Double = 30
    
     var verticalVelocity : Double = 0
     var heightGained: Double = 0
     var maxHeight: Double = 0
     var timeFromRampToMaxHeight: Double = 0
     var timeFromMaxHeightToGround: Double = 0
     var timeTaken: Double = 0
     var xVelocity: Double = 0
     var distance: Double = 0
     
     var result:Double = 0
    
    // Create a property for the car
    var truck = SKSpriteNode(imageNamed: "truck")
    //create the background
    var ground = SKSpriteNode(imageNamed: "green")
    var sky = SKSpriteNode(imageNamed: "blue")
    var ramp = SKSpriteNode(imageNamed: "ramp")
    
    /*
    // Background music player
    var backgroundMusic: AVAudioPlayer?
     */
    
    // This function runs once to set up the scene
    override func didMove(to view: SKView) {
        
        // Set the background colour
        self.backgroundColor = .black
        
        /*
        // Get a reference to the mp3 file in the app bundle
        let backgroundMusicFilePath = Bundle.main.path(forResource: "sleigh-bells-excerpt.mp3", ofType: nil)!
        
        // Convert the file path string to a URL (Uniform Resource Locator)
        let backgroundMusicFileURL = URL(fileURLWithPath: backgroundMusicFilePath)
        
        // Attempt to open and play the file at the given URL
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: backgroundMusicFileURL)
            backgroundMusic?.play()
        } catch {
            // Do nothing if the sound file could not be played
        }
 */
        // Do any additional setup after loading the view.
        velocity = sqrt(2*acceleration * distanceToRamp)
        //Find vertical velocity of the car
        verticalVelocity =  velocity * sin(rampAngle)
        //Find how high the car goes, this will also be used for the animation
        heightGained = (0-sqrt(verticalVelocity))/(2*gravity)
        maxHeight = rampHeight + heightGained

        //Find how long the car is in the air for
        //Time taken from ramp to max height
        timeFromRampToMaxHeight = (0-verticalVelocity)/gravity
        //Time taken from max height to the ground
        timeFromMaxHeightToGround = sqrt((2*maxHeight)/gravity)
        //Total time taken
        timeTaken = timeFromRampToMaxHeight + timeFromMaxHeightToGround


        //Get x velocity
        xVelocity = velocity*cos(rampAngle)


        //Get distance traveled
        distance = xVelocity * timeTaken

        //Change the result value to match the distance
        result = distance
        
        //create the background
        ground.position = CGPoint(x: 0, y: -500)
        ground.setScale(2)
        self.addChild(ground)
        sky.position = CGPoint(x: 400, y: 600)
        sky.setScale(2)
        self.addChild(sky)
        // Position and add the truck
        truck.position = CGPoint(x: 100, y: 100)
        self.addChild(truck)
        //make the ramp appear
        ramp.position = CGPoint(x: 720, y: 105)
        self.addChild(ramp)
    }
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Calculate the truck's new position
        let newPosition = CGPoint(x: truck.position.x + 5, y: truck.position.y)
        
        // Move to the truck to the new position
        truck.position = newPosition
        
    }
    
}
