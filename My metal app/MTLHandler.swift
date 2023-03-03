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

    func makeBoxMesh(device: MTLDevice) throws -> MTKMesh {
        let allocator = MTKMeshBufferAllocator(device: device)
        let size: Float = 0.8
        let mdlMesh = MDLMesh(
            boxWithExtent: [size, size, size],
            segments: [1, 1, 1],
            inwardNormals: false,
            geometryType: .triangles,
            allocator: allocator
        )

        do {
            return try MTKMesh(mesh: mdlMesh, device: device)
        } catch {
            throw error
        }
    }

    func makePipelineState(device: MTLDevice, metalView: MTKView, mesh: MTKMesh) throws -> MTLRenderPipelineState {

        guard let library = device.makeDefaultLibrary() else {
            throw MetalError.invalidDefaultLibrary
        }

        let vertexFunction = library.makeFunction(name: "vertex_main")
        let fragmentFunction = library.makeFunction(name: "fragment_main")

        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = metalView.colorPixelFormat
        pipelineDescriptor.vertexDescriptor = MTKMetalVertexDescriptorFromModelIO(mesh.vertexDescriptor)

        do {
          return try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            throw error
        }
    }
}
