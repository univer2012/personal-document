//
//  SGH0804Assistant.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/4.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//
/// 人工智能助手类，预定义了一些有趣的答案，当用户提问时会给予响应
import UIKit
import AVFoundation

class SGH0804Assistant: NSObject, AVSpeechSynthesizerDelegate {
    
    internal let answer : [String] = [
    "OK from now on I'll call you 'my little princess'. I sent your new name to all your contacts as well",
    "Can't find any local business around you for search term 'cheap booze'",
    "Looks like you are leaving the house - don't forget you're living in a post apocalyptic zombie world",
    "Making a wake up reminder for 3:00 AM. Don't wake me up...",
    "Here is the list of the 20 closest 'raging football fans' around you"
    ]
    
    fileprivate var completionBlock: (()->Void)?
    
    fileprivate let synth = AVSpeechSynthesizer()
    
    override init() {
        super.init()
        synth.delegate = self
    }
    
    func randomAnswer() -> String {
        return answer[Int(arc4random_uniform(UInt32(answer.count)))]
    }
    
    func speak(_ phrase: String, completion: @escaping ()->Void) {
        //save the completion block
        completionBlock = completion
        
        let utterance = AVSpeechUtterance(string: phrase)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.volume = 1.0
        synth.speak(utterance)
        
    }
    
    //MARK: - speech synth methods
    internal func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        completionBlock?()
    }
    
    

}
