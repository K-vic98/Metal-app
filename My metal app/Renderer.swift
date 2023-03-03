//
//  Renderer.swift
//  My metal app
//
//  Created by Куделин Виктор on 02.02.2023.
//

import MetalKit

final class Renderer: NSObject {

    // MARK: - Properties

    private let commandQueue: MTLCommandQueue
    private let mesh: MTKMesh
    private let vertexBuffer: MTLBuffer
    private let pipelineState: MTLRenderPipelineState

    // MARK: - Initialization

    init(commandQueue: MTLCommandQueue, mesh: MTKMesh, pipelineState: MTLRenderPipelineState) {

        self.commandQueue = commandQueue
        self.mesh = mesh
        self.vertexBuffer = mesh.vertexBuffers[0].buffer
        self.pipelineState = pipelineState

        super.init()
    }
}

// MARK: - MTKViewDelegate implementation

extension Renderer: MTKViewDelegate {

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {

    }

    func draw(in view: MTKView) {

        guard
            let commandBuffer = commandQueue.makeCommandBuffer(),
            let descriptor = view.currentRenderPassDescriptor,
            let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor) else {
            return
        }

        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        for submesh in mesh.submeshes {
          renderEncoder.drawIndexedPrimitives(
            type: .triangle,
            indexCount: submesh.indexCount,
            indexType: submesh.indexType,
            indexBuffer: submesh.indexBuffer.buffer,
            indexBufferOffset: submesh.indexBuffer.offset)
        }

        renderEncoder.endEncoding()

        guard let drawable = view.currentDrawable else {
            return
        }

        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
