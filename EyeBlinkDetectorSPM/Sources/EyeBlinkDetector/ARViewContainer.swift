import SwiftUI
import ARKit
import SceneKit

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var viewModel: FaceTrackingViewModel

    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView(frame: .zero)
        arView.delegate = context.coordinator
        arView.session.delegate = context.coordinator

        // Configure AR session for face tracking
        guard ARFaceTrackingConfiguration.isSupported else {
            print("Face tracking is not supported on this device")
            return arView
        }

        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true

        // Run the AR session
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])

        return arView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {
        // Nothing to update
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }

    class Coordinator: NSObject, ARSCNViewDelegate, ARSessionDelegate {
        var viewModel: FaceTrackingViewModel

        init(viewModel: FaceTrackingViewModel) {
            self.viewModel = viewModel
        }

        // MARK: - ARSCNViewDelegate

        func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
            guard let faceAnchor = anchor as? ARFaceAnchor else { return }
            viewModel.updateFaceAnchor(faceAnchor)
        }

        func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
            guard anchor is ARFaceAnchor else { return }
            viewModel.updateFaceAnchor(nil)
        }

        // MARK: - ARSessionDelegate

        func session(_ session: ARSession, didFailWithError error: Error) {
            print("AR Session failed: \(error.localizedDescription)")
            viewModel.handleSessionError()
        }

        func sessionWasInterrupted(_ session: ARSession) {
            print("AR Session was interrupted")
        }

        func sessionInterruptionEnded(_ session: ARSession) {
            print("AR Session interruption ended")
            // Restart session
            guard let configuration = session.configuration as? ARFaceTrackingConfiguration else { return }
            session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        }
    }
}
