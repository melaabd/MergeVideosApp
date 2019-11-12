//
//  ViewController.swift
//  MergeVideosApp
//
//  Created by El-Abd IOS on 12/11/2019.
//  Copyright © 2019 El-Abd. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class VideoHelper {
  
  static func startMediaBrowser(delegate: UIViewController & UINavigationControllerDelegate & UIImagePickerControllerDelegate, sourceType: UIImagePickerControllerSourceType) {
    guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
    
    let mediaUI = UIImagePickerController()
    mediaUI.sourceType = sourceType
    mediaUI.mediaTypes = [kUTTypeMovie as String]
    mediaUI.allowsEditing = true
    mediaUI.delegate = delegate
    delegate.present(mediaUI, animated: true, completion: nil)
  }
  
  static func orientationFromTransform(_ transform: CGAffineTransform) -> (orientation: UIImageOrientation, isPortrait: Bool) {
    var assetOrientation = UIImageOrientation.up
    var isPortrait = false
    if transform.a == 0 && transform.b == 1.0 && transform.c == -1.0 && transform.d == 0 {
      assetOrientation = .right
      isPortrait = true
    } else if transform.a == 0 && transform.b == -1.0 && transform.c == 1.0 && transform.d == 0 {
      assetOrientation = .left
      isPortrait = true
    } else if transform.a == 1.0 && transform.b == 0 && transform.c == 0 && transform.d == 1.0 {
      assetOrientation = .up
    } else if transform.a == -1.0 && transform.b == 0 && transform.c == 0 && transform.d == -1.0 {
      assetOrientation = .down
    }
    return (assetOrientation, isPortrait)
  }
  
  static func firstVideoCompositionInstruction(_ track: AVCompositionTrack, asset: AVAsset) -> AVMutableVideoCompositionLayerInstruction {
//    let instruction = AVMutableVideoCompositionLayerInstruction(assetTrack: track)
    let assetTrack = asset.tracks(withMediaType: AVMediaType.video)[0]
    
    let instruction = AVMutableVideoCompositionLayerInstruction(assetTrack: track)
    let scale = CGAffineTransform(scaleX: 0.45, y: 1.0)
    let move = CGAffineTransform(translationX: 0, y: 0)
    let transform = scale.concatenating(move)
    instruction.setTransform(transform, at: kCMTimeZero)
    
    return instruction
  }
  
  static func secondVideoCompositionInstruction(_ track: AVCompositionTrack, asset: AVAsset) -> AVMutableVideoCompositionLayerInstruction {
    
    let instruction = AVMutableVideoCompositionLayerInstruction(assetTrack: track)
       let secondScale = CGAffineTransform(scaleX: 0.55, y: 1.0)
    let secondMove = CGAffineTransform(translationX: UIScreen.main.bounds.width / 2, y: 0)
       let secondTransform = secondScale.concatenating(secondMove)
       instruction.setTransform(secondTransform, at: kCMTimeZero)
    
    
    
    return instruction
  }
  
}
