//
//  ViewController.swift
//  My metal app
//
//  Created by Куделин Виктор on 29.01.2023.
//

import UIKit
import MetalKit

final class ViewController: UIViewController {

    // MARK: Private properties

    private var renderer: Renderer?
    private let metalView = MTKView()
}

// MARK: - UIViewController life cycle

extension ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMetalView()
    }
}

// MARK: - Private methods

private extension ViewController {

    func layout() {
        view.addSubview(metalView)
        metalView.translatesAutoresizingMaskIntoConstraints = false

        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            metalView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            metalView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            metalView.topAnchor.constraint(equalTo: guide.topAnchor),
            metalView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }

    func setup() {
        view.backgroundColor = .systemYellow

        metalView.clipsToBounds = true
        metalView.layer.cornerRadius = 12
        metalView.layer.borderWidth = 4
        metalView.layer.borderColor = UIColor.black.cgColor
        metalView.clearColor = MTLClearColor(red: 1, green: 1, blue: 0.8, alpha: 1)
    }

    func setupMetalView() {
        let metalHandler = MTLHandler()

        do {
            let device = try metalHandler.makeDevice()
            let commandQueue = try metalHandler.makeCommandQueue(device: device)
            let mesh = try metalHandler.makeBoxMesh(device: device)
            let pipelineState = try metalHandler.makePipelineState(
                device: device,
                metalView: metalView,
                mesh: mesh
            )

            renderer = Renderer(
                device: device,
                commandQueue: commandQueue,
                mesh: mesh,
                pipelineState: pipelineState
            )
            metalView.device = device
            metalView.delegate = renderer
        } catch {
            showError(descriptoin: error.localizedDescription)
        }
    }

    func showError(descriptoin: String) {
        let alert = UIAlertController(title: "Error", message: descriptoin, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
