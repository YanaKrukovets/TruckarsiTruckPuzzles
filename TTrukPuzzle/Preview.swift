//
//  Preview.swift
//  TTrukPuzzle
//
//  Created by Yana  on 2020-10-29.
//  Copyright © 2020 Yana . All rights reserved.
//

import SpriteKit
import AVFoundation

class Preview: SKScene {
    
      override func didMove(to view: SKView) {
        audio.playMusic(fileName: "Sound/aknasi", type: "mp3", volume: 0.3, loop: -1)
        audio.playSound(fileName: "Sound/horn", type: "mp3", volume: 1, loop: 0)
    }
}

