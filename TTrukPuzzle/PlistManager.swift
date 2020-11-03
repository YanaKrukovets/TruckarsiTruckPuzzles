//
//  PlistManager.swift
//  TTrukPuzzle
//
//  Created by Yana  on 2020-11-02.
//  Copyright © 2020 Yana . All rights reserved.
//

import Foundation


class PlistManager {

func readPlist(namePlist: String, key: String) -> AnyObject {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
    let documentsDirectory = paths.object(at: 0) as! NSString
    let path = documentsDirectory.appendingPathComponent(namePlist+".plist")
    
    var output:AnyObject = false as AnyObject
    
    if let dict = NSMutableDictionary(contentsOfFile: path){
        output = dict.object(forKey: key)! as AnyObject
    } else {
        if let privPath = Bundle.main.path(forResource: namePlist, ofType: "plist") {
            if let dict = NSMutableDictionary(contentsOfFile: privPath) {
                output = dict.object(forKey: key)! as AnyObject
            } else {
                output = false as AnyObject
                print("error read")
            }
        } else {
            output = false as AnyObject
            print("error read")
        }
    }
    print("plist read \(output)")
    return output
}

func writePlist(namePlist: String, key: String, data: AnyObject) {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
    let documentsDirectory = paths.object(at: 0) as! NSString
    let path = documentsDirectory.appendingPathComponent(namePlist+".plist")
    
    if let dict = NSMutableDictionary(contentsOfFile: path) {
        dict.setObject(data, forKey: key as NSCopying)
        if dict.write(toFile: path, atomically: true) {
            print("plist write")
        } else {
            print("plist write error")
        }
    } else {
        if let privPath = Bundle.main.path(forResource: namePlist, ofType: "plist") {
            if let dict = NSMutableDictionary(contentsOfFile: privPath){
                dict.setObject(data, forKey: key as NSCopying)
                if dict.write(toFile: path, atomically: true) {
                    print("plist write")
                }
            }
        } 
    }
}

}
