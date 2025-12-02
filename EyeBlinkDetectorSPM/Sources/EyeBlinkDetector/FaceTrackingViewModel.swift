import SwiftUI
import ARKit
import Combine

class FaceTrackingViewModel: NSObject, ObservableObject {
    @Published var blinkCount: Int = 0
    @Published var isFaceDetected: Bool = false
    @Published var isLeftEyeClosed: Bool = false
    @Published var isRightEyeClosed: Bool = false
    @Published var showPermissionAlert: Bool = false
    @Published var gazePosition: CGPoint = .zero
    @Published var isGazeTracking: Bool = false

    private var wasLeftEyeClosed: Bool = false
    private var wasRightEyeClosed: Bool = false

    // Threshold for eye closure detection (0.0 = fully open, 1.0 = fully closed)
    private let eyeClosureThreshold: Float = 0.6

    // Screen size for gaze mapping
    var screenSize: CGSize = .zero

    func resetCount() {
        blinkCount = 0
    }

    func updateFaceAnchor(_ faceAnchor: ARFaceAnchor?) {
        guard let faceAnchor = faceAnchor else {
            DispatchQueue.main.async {
                self.isFaceDetected = false
                self.isLeftEyeClosed = false
                self.isRightEyeClosed = false
                self.isGazeTracking = false
            }
            return
        }

        DispatchQueue.main.async {
            self.isFaceDetected = true
        }

        // Get eye blink blend shapes
        let blendShapes = faceAnchor.blendShapes

        // Left eye blink detection
        if let leftEyeBlink = blendShapes[.eyeBlinkLeft]?.floatValue {
            let isLeftClosed = leftEyeBlink > eyeClosureThreshold

            DispatchQueue.main.async {
                self.isLeftEyeClosed = isLeftClosed
            }

            // Detect blink transition (was open, now closed)
            if !wasLeftEyeClosed && isLeftClosed {
                DispatchQueue.main.async {
                    self.blinkCount += 1
                }
            }
            wasLeftEyeClosed = isLeftClosed
        }

        // Right eye blink detection
        if let rightEyeBlink = blendShapes[.eyeBlinkRight]?.floatValue {
            let isRightClosed = rightEyeBlink > eyeClosureThreshold

            DispatchQueue.main.async {
                self.isRightEyeClosed = isRightClosed
            }

            // Detect blink transition (was open, now closed)
            if !wasRightEyeClosed && isRightClosed {
                DispatchQueue.main.async {
                    self.blinkCount += 1
                }
            }
            wasRightEyeClosed = isRightClosed
        }

        // Gaze tracking using eye look blend shapes
        updateGazePosition(blendShapes: blendShapes)
    }

    private func updateGazePosition(blendShapes: [ARFaceAnchor.BlendShapeLocation: NSNumber]) {
        // Get eye look values
        let lookLeft = blendShapes[.eyeLookOutLeft]?.floatValue ?? 0
        let lookRight = blendShapes[.eyeLookInLeft]?.floatValue ?? 0
        let lookUp = blendShapes[.eyeLookUpLeft]?.floatValue ?? 0
        let lookDown = blendShapes[.eyeLookDownLeft]?.floatValue ?? 0

        // Calculate horizontal position (0 = left, 1 = right)
        let horizontalGaze = 0.5 + (lookRight - lookLeft)

        // Calculate vertical position (0 = top, 1 = bottom)
        let verticalGaze = 0.5 + (lookDown - lookUp)

        // Clamp values between 0 and 1
        let clampedX = max(0, min(1, horizontalGaze))
        let clampedY = max(0, min(1, verticalGaze))

        // Map to screen coordinates
        let screenX = CGFloat(clampedX) * screenSize.width
        let screenY = CGFloat(clampedY) * screenSize.height

        DispatchQueue.main.async {
            self.gazePosition = CGPoint(x: screenX, y: screenY)
            self.isGazeTracking = true
        }
    }

    func handleSessionError() {
        DispatchQueue.main.async {
            self.showPermissionAlert = true
        }
    }
}
