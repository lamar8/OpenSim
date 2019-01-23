//
//  Helper.swift
//  OpenSim
//
//  Created by Bradley Van Dyk on 3/4/16.
//  Copyright © 2016 Luo Sheng. All rights reserved.
//

import Foundation
// TODO: Xcode->Preferences->Locations->Command Line Tools 未设置导致无法显示的错误
func shell(_ launchPath: String, arguments: [String]) -> String {
    let progress = Process()
    progress.launchPath = launchPath
    progress.arguments = arguments
    
    let pipe = Pipe()
    progress.standardOutput = pipe
    progress.standardError = Pipe()
    progress.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: String.Encoding.utf8)
    
    return output ?? ""
}
