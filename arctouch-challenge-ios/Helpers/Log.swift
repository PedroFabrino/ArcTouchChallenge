//
//  Log.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 12/09/17.
//  Copyright © 2017 AIS Digital. All rights reserved.
//

import Foundation
import SwiftyBeaver

class Log {
    static let shared = Log()
    
    private let logger = SwiftyBeaver.self
    
    private init() {
        self.setup()
    }
    
    private func setup() {
        let console = ConsoleDestination()
        
        console.minLevel = .verbose
        
        self.logger.addDestination(console)
        let file = FileDestination()
        file.format = "$Dyyyy-MM-dd HH:mm:ss.SSS$d $C$L$c: $M" // full datetime, colored log level and message
        //Optionally define a file to save the logs.
        self.logger.addDestination(file)
        
    }
    
    /// log something generally unimportant (lowest priority)
    class func verbose(_ message: @autoclosure () -> Any, _ file: String = #file, function: String = #function, line: Int = #line) {
        Log.shared.logger.verbose(message, file, function, line: line)
    }
    
    /// log something which help during debugging (low priority)
    class func debug(_ message: @autoclosure () -> Any,
                     _ file: String = #file,
                     _ function: String = #function,
                     line: Int = #line) {
        Log.shared.logger.debug(message, file, function, line: line)
    }
    
    /// log something which you are really interested but which is not an issue or error (normal priority)
    class func info(_ message: @autoclosure () -> Any, _ file: String = #file, function: String = #function, line: Int = #line) {
        Log.shared.logger.info(message, file, function, line: line)
    }
    
    /// log something which may cause big trouble soon (high priority)
    class func warning(_ message: @autoclosure () -> Any, _ file: String = #file, function: String = #function, line: Int = #line) {
        Log.shared.logger.warning(message, file, function, line: line)
    }
    
    /// log something which will keep you awake at night (highest priority)
    class func error(_ message: @autoclosure () -> Any, _ file: String = #file, function: String = #function, line: Int = #line) {
        Log.shared.logger.error(message, file, function, line: line)
    }
    
    /// log things which will keep you awake at night (highest priority)
    class func errors(_ errors: [Error?]?, _ message: @autoclosure () -> Any, _ file: String = #file, function: String = #function, line: Int = #line) {
        guard let errors = errors else {
            Log.shared.logger.error("\(message) : NO ERRORS TO SHOW", file, function, line: line)
            return
        }
        for error in errors {
            if let error = error {
                Log.shared.logger.error("\(message) : \(error.localizedDescription)", file, function, line: line)
            } else {
                Log.shared.logger.error("\(message) : - ", file, function, line: line)
            }
            
        }
        
    }
}
