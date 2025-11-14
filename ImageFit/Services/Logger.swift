//
//  Logger.swift
//  ImageFit
//
//  Created by Дмитрий Чмир on 27.10.2025.
//

import Foundation

final class Logger {
    static let shared = Logger()
    
    private init() {}
    
    func insertLog(_ message: ErrorMessages) {
        print("ImageFit LOG: \(message.description)")
    }
    
    func insertLog(_ message: String) {
        print("ImageFit LOG: \(message)")
        
    }
    
    func insertLog(_ error: Error) {
        assertionFailure("ImageFit LOG - Error: \(error.localizedDescription)")
    }
}
