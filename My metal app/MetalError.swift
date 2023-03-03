//
//  MetalError.swift
//  My metal app
//
//  Created by Куделин Виктор on 02.02.2023.
//

import Foundation

enum MetalError: Error {
    case invalidGPU
    case invalidCommandQueue
    case invalidDefaultLibrary
}

extension MetalError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidGPU:
            return NSLocalizedString(
                "Failed to connect GPU",
                comment: "invalid GPU"
            )
        case .invalidCommandQueue:
            return NSLocalizedString(
                "Failed to make command queue",
                comment: "invalid command queue"
            )
        case .invalidDefaultLibrary:
            return NSLocalizedString(
                "Failed to make default shaders library",
                comment: "invalid default library"
            )
        }
    }
}
