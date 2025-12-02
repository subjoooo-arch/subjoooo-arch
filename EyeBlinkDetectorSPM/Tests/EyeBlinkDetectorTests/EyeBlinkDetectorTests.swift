import XCTest
@testable import EyeBlinkDetector

final class EyeBlinkDetectorTests: XCTestCase {
    func testViewModelInitialization() throws {
        let viewModel = FaceTrackingViewModel()

        XCTAssertEqual(viewModel.blinkCount, 0)
        XCTAssertFalse(viewModel.isFaceDetected)
        XCTAssertFalse(viewModel.isLeftEyeClosed)
        XCTAssertFalse(viewModel.isRightEyeClosed)
        XCTAssertFalse(viewModel.isGazeTracking)
    }

    func testResetCount() throws {
        let viewModel = FaceTrackingViewModel()

        // Simulate some blinks by directly setting the count
        viewModel.blinkCount = 10

        viewModel.resetCount()

        XCTAssertEqual(viewModel.blinkCount, 0)
    }

    func testScreenSizeConfiguration() throws {
        let viewModel = FaceTrackingViewModel()
        let testSize = CGSize(width: 375, height: 812)

        viewModel.screenSize = testSize

        XCTAssertEqual(viewModel.screenSize.width, 375)
        XCTAssertEqual(viewModel.screenSize.height, 812)
    }
}
