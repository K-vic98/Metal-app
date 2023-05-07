//
//  MTLHandler.swift
//  My metal app
//
//  Created by Куделин Виктор on 02.02.2023.
//

import MetalKit

struct MTLHandler {

    func makeDevice() throws -> MTLDevice {
        guard let device = MTLCreateSystemDefaultDevice() else {
            throw MetalError.invalidGPU
        }

        return device
    }

    func makeCommandQueue(device: MTLDevice) throws -> MTLCommandQueue {
        guard let commandQueue = device.makeCommandQueue() else {
            throw MetalError.invalidCommandQueue
        }

        return commandQueue
    }

    func makePipelineState(device: MTLDevice, metalView: MTKView) throws -> MTLRenderPipelineState {

        guard let library = device.makeDefaultLibrary() else {
            throw MetalError.invalidDefaultLibrary
        }

        let vertexFunction = library.makeFunction(name: "vertex_main")
        let fragmentFunction = library.makeFunction(name: "fragment_main")

        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = metalView.colorPixelFormat
        pipelineDescriptor.vertexDescriptor = MTLVertexDescriptor.defaultLayout

        do {
          return try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            throw error
        }
    }
}
