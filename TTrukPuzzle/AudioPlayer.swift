//
//  AudioPlayer.swift
//  ShapesFlashCards
//
//  Created by Yana  on 2020-10-11.
//  Copyright © 2020 Yana . All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

//Manages a shared instance of AudioPlayer.
private let AudioInstance = AudioPlayer()

//Provides an easy way to play sounds and music. Use sharedInstance method to access a single object for the entire game to manage the sound and music.
public class AudioPlayer {

    var musicPlayer: AVAudioPlayer!
    var soundPlayer: AVAudioPlayer!

    //Creates an instance of the AudioPlayer class so the user doesn't have to make their own instance and allows use of the functions.
    public class func sharedInstance() -> AudioPlayer {
        return AudioInstance
    }

//Plays music
    public func playMusic(fileName: String, type: String, volume: Float, loop: Int) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: type) {
            musicPlayer = try? AVAudioPlayer(contentsOf: url)
            musicPlayer.numberOfLoops = loop
            musicPlayer.volume = volume
            musicPlayer.play()
        }
    }
    
    //Plays sound
    public func playSound(fileName: String, type: String, volume: Float, loop: Int) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: type) {
            soundPlayer = try? AVAudioPlayer(contentsOf: url)
            soundPlayer.numberOfLoops = loop
            soundPlayer.volume = volume
            soundPlayer.play()
        }
    }

    //Stops the music
    public func stopMusic() {
        if (musicPlayer != nil && musicPlayer!.isPlaying) {
            musicPlayer.currentTime = 0
            musicPlayer.stop()
        }
         if (soundPlayer != nil && soundPlayer!.isPlaying) {
            soundPlayer.currentTime = 0
            soundPlayer.stop()
        }
    }

    //Pauses the music.
    public func pauseMusic() {
        if (musicPlayer != nil && musicPlayer!.isPlaying) {
            musicPlayer.pause()
        }
    }

    //Resumes the music
    public func resumeMusic() {
        if (musicPlayer != nil && !musicPlayer!.isPlaying) {
            musicPlayer.play()
        }
    }
   
}
