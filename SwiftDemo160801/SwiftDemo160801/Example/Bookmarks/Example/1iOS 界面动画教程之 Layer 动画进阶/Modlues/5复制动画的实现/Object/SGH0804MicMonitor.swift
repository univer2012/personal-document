//
//  SGH0804MicMonitor.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/4.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//
/// 用于监控手机的麦克风输入电频，并且会重复的调用一个定义好的闭包表达式，我们需要在闭包中更新、显示内容，
import UIKit
import AVFoundation


class SGH0804MicMonitor: NSObject {
    
    fileprivate var recorder: AVAudioRecorder!
    fileprivate var timer: Timer?
    fileprivate var levelsHandler: ((Float) ->Void)?
    
    override init() {
        let url = URL(fileURLWithPath: "/dev/null", isDirectory: true)
        let settings: [String: AnyObject] = [
            AVSampleRateKey: 44100.0 as AnyObject,
            AVNumberOfChannelsKey: 1 as AnyObject,
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue as AnyObject
        ]
        
        let audioSession = AVAudioSession.sharedInstance()
        
        if audioSession.recordPermission() != .granted {
            audioSession.requestRecordPermission({ (success) in
                print("microphone permission: \(success)")
            })
        }
        
        do {
            try recorder = AVAudioRecorder(url: url, settings: settings)
            try audioSession.setCategory((AVAudioSessionCategoryPlayAndRecord))
        }
        catch {
            print("Couldn't initialize the mic input")
        }
        
        if let recorder = recorder {
            // start observing mic levels
            recorder.prepareToRecord()
            recorder.isMeteringEnabled = true
        }
        
    }
    
    func startMointoringWithHandler(_ handler: @escaping (Float) ->Void) {
        levelsHandler = handler
        
        //start meters
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(p_handleMicLevel(_:)), userInfo: nil, repeats: true)
        recorder.record()
    }
    
    func stopMonitoring() {
        levelsHandler = nil
        timer?.invalidate()
        recorder.stop()
    }
    
    func p_handleMicLevel(_ timer: Timer) {
        recorder.updateMeters()
        levelsHandler?(recorder.averagePower(forChannel: 0))
    }
    
    deinit {
        stopMonitoring()
    }

}
