//
//  HGLog.swift
//  OpenSim
//
//  Created by  on 2019/1/23.
//  Copyright © 2019 Luo Sheng. All rights reserved.
//  Copy From http://www.hangge.com/blog/cache/detail_1482.html

import Foundation

//封装的日志输出功能（T表示不指定日志信息参数类型）
func HGLog<T>(_ message:T, file:String = #file, function:String = #function,
              line:Int = #line) {
    #if DEBUG
    //获取文件名
    let fileName = (file as NSString).lastPathComponent
    //日志内容
    let consoleStr = "\(fileName):\(line) \(function) | \(message)"
    //打印日志内容
    print(consoleStr)
    
    // 创建一个日期格式器
    let dformatter = DateFormatter()
    // 为日期格式器设置格式字符串
    dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    // 使用日期格式器格式化当前日期、时间
    let datestr = dformatter.string(from: Date())
    
    //将内容同步写到文件中去（Caches文件夹下）
    let cachePath = FileManager.default.urls(for: .cachesDirectory,
                                             in: .userDomainMask)[0]
    let logURL = cachePath.appendingPathComponent("log.txt")
    appendText(fileURL: logURL, string: "\(datestr) \(consoleStr)")
    #endif
}

//在文件末尾追加新内容
func appendText(fileURL: URL, string: String) {
    do {
        //如果文件不存在则新建一个
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            FileManager.default.createFile(atPath: fileURL.path, contents: nil)
        }
        
        let fileHandle = try FileHandle(forWritingTo: fileURL)
        let stringToWrite = "\n" + string
        
        //找到末尾位置并添加
        fileHandle.seekToEndOfFile()
        fileHandle.write(stringToWrite.data(using: String.Encoding.utf8)!)
        
    } catch let error as NSError {
        print("failed to append: \(error)")
    }
}
