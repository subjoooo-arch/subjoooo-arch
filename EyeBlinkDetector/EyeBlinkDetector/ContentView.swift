import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FaceTrackingViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // AR Camera View
                ARViewContainer(viewModel: viewModel)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        viewModel.screenSize = geometry.size
                    }

                // Gaze cursor
                if viewModel.isGazeTracking {
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [Color.yellow.opacity(0.8), Color.orange.opacity(0.4), Color.clear]),
                                center: .center,
                                startRadius: 5,
                                endRadius: 30
                            )
                        )
                        .frame(width: 60, height: 60)
                        .position(viewModel.gazePosition)
                        .allowsHitTesting(false)

                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 20, height: 20)
                        .position(viewModel.gazePosition)
                        .allowsHitTesting(false)
                }

                // Overlay UI
                VStack {
                // Top status bar
                HStack {
                    Image(systemName: viewModel.isFaceDetected ? "face.smiling.fill" : "face.dashed")
                        .foregroundColor(viewModel.isFaceDetected ? .green : .red)
                        .font(.title)

                    Text(viewModel.isFaceDetected ? "얼굴 인식됨" : "얼굴을 감지하세요")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.leading, 8)

                    Spacer()
                }
                .padding()
                .background(Color.black.opacity(0.5))

                Spacer()

                // Blink counter display
                VStack(spacing: 20) {
                    Text("눈 깜빡임 횟수")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("\(viewModel.blinkCount)")
                        .font(.system(size: 72, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Circle()
                                .fill(Color.blue.opacity(0.7))
                                .frame(width: 150, height: 150)
                        )

                    // Eye status indicators
                    HStack(spacing: 40) {
                        VStack {
                            Image(systemName: viewModel.isLeftEyeClosed ? "eye.slash.fill" : "eye.fill")
                                .font(.title)
                                .foregroundColor(viewModel.isLeftEyeClosed ? .red : .green)
                            Text("왼쪽 눈")
                                .font(.caption)
                                .foregroundColor(.white)
                        }

                        VStack {
                            Image(systemName: viewModel.isRightEyeClosed ? "eye.slash.fill" : "eye.fill")
                                .font(.title)
                                .foregroundColor(viewModel.isRightEyeClosed ? .red : .green)
                            Text("오른쪽 눈")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()

                    // Reset button
                    Button(action: {
                        viewModel.resetCount()
                    }) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                            Text("리셋")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red.opacity(0.7))
                        .cornerRadius(10)
                    }
                }
                .padding(.bottom, 50)
                }
            }
            .alert("카메라 권한 필요", isPresented: $viewModel.showPermissionAlert) {
                Button("확인", role: .cancel) { }
            } message: {
                Text("얼굴 추적을 위해 카메라 권한이 필요합니다. 설정에서 권한을 허용해주세요.")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
