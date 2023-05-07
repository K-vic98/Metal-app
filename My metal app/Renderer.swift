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
    private let pipelineState: MTLRenderPipelineState
    private let quad: Quad?

    // MARK: - Initialization

    init(device: MTLDevice, commandQueue: MTLCommandQueue, pipelineState: MTLRenderPipelineState) {

        self.commandQueue = commandQueue
        self.pipelineState = pipelineState

        quad = Quad(device: device)

        super.init()
    }
}

// MARK: - MTKViewDelegate implementation

extension Renderer: MTKViewDelegate {

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {

    }

    func draw(in view: MTKView) {

        guard let quad = quad else {
            return
        }

        guard
            let commandBuffer = commandQueue.makeCommandBuffer(),
            let descriptor = view.currentRenderPassDescriptor,
            let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor) else {
            return
        }

        renderEncoder.setRenderPipelineState(pipelineState)

        renderEncoder.setVertexBuffer(
            quad.vertexBuffer,
            offset: 0,
            index: 0
        )

        renderEncoder.setVertexBuffer(
            quad.colorBuffer,
            offset: 0,
            index: 1
        )

        renderEncoder.drawIndexedPrimitives(
            type: .triangle,
            indexCount: quad.indices.count,
            indexType: .uint16,
            indexBuffer: quad.indexBuffer,
            indexBufferOffset: 0
        )

        renderEncoder.endEncoding()

        guard let drawable = view.currentDrawable else {
            return
        }

        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
