# Eye Blink Detector (SwiftPM 버전)

ARKit을 활용한 iOS/iPadOS용 실시간 눈 깜빡임 측정 및 시선 추적 라이브러리입니다.

## 개요

이 프로젝트는 Swift Package Manager(SwiftPM)를 사용하여 관리되는 버전입니다. Xcode 프로젝트 파일 없이 순수 SwiftPM으로 구성되어 있어, 다른 프로젝트에 쉽게 통합할 수 있습니다.

## 주요 기능

### 1. 실시간 눈 깜빡임 감지
- ARKit의 Face Tracking을 사용하여 정확한 눈 깜빡임 감지
- 왼쪽 눈과 오른쪽 눈 각각의 깜빡임 감지
- 실시간 깜빡임 횟수 카운터

### 2. 시선 추적 (Gaze Tracking)
- 사용자가 화면의 어느 부분을 보고 있는지 실시간 추적
- 시각적 커서로 시선 위치 표시
- 눈의 상하좌우 움직임을 정확하게 화면 좌표로 변환

### 3. 직관적인 UI
- 얼굴 인식 상태 실시간 표시
- 각 눈의 열림/닫힘 상태 시각화
- 깜빡임 횟수 리셋 기능
- 카메라 피드 위에 오버레이된 인터페이스

## 시스템 요구사항

- **iOS/iPadOS 15.0 이상**
- **macOS 12.0 이상** (Mac Catalyst 지원)
- **TrueDepth 카메라가 있는 기기** (Face ID 지원 기기)
  - iPhone X 이상
  - iPad Pro (2018년 모델 이상)
- **Swift 5.9 이상**

## Swift Package Manager로 설치

### 1. Xcode에서 설치

1. Xcode에서 프로젝트를 엽니다
2. File > Add Package Dependencies... 선택
3. 패키지 URL 입력:
   ```
   https://github.com/subjoooo-arch/subjoooo-arch
   ```
4. EyeBlinkDetectorSPM 디렉토리 선택
5. Add Package 클릭

### 2. Package.swift에 추가

```swift
dependencies: [
    .package(url: "https://github.com/subjoooo-arch/subjoooo-arch", branch: "claude/eye-blink-detector-016AmNprFqKawXc2mkDnjKyB")
]
```

그리고 타겟에 추가:

```swift
.target(
    name: "YourApp",
    dependencies: [
        .product(name: "EyeBlinkDetector", package: "subjoooo-arch")
    ]
)
```

## 사용 방법

### 기본 사용

```swift
import SwiftUI
import EyeBlinkDetector

struct MyView: View {
    var body: some View {
        ContentView()
    }
}
```

### ViewModel 직접 사용

```swift
import SwiftUI
import EyeBlinkDetector

struct CustomView: View {
    @StateObject private var viewModel = FaceTrackingViewModel()

    var body: some View {
        VStack {
            Text("깜빡임 횟수: \(viewModel.blinkCount)")
            Text("얼굴 인식: \(viewModel.isFaceDetected ? "감지됨" : "없음")")

            ARViewContainer(viewModel: viewModel)
                .frame(height: 300)
        }
    }
}
```

## 프로젝트 구조

```
EyeBlinkDetectorSPM/
├── Package.swift                         # SwiftPM 매니페스트
├── Sources/
│   └── EyeBlinkDetector/
│       ├── EyeBlinkDetectorApp.swift     # 앱 엔트리 포인트
│       ├── ContentView.swift              # 메인 UI
│       ├── FaceTrackingViewModel.swift    # 얼굴 추적 로직
│       ├── ARViewContainer.swift          # ARKit 뷰 통합
│       └── Resources/
│           ├── Assets.xcassets/          # 에셋 카탈로그
│           └── Info.plist                # 앱 설정
└── Tests/
    └── EyeBlinkDetectorTests/
        └── EyeBlinkDetectorTests.swift   # 유닛 테스트
```

## 빌드 및 테스트

### 패키지 빌드

```bash
cd EyeBlinkDetectorSPM
swift build
```

### 테스트 실행

```bash
swift test
```

### Xcode에서 열기

```bash
cd EyeBlinkDetectorSPM
open Package.swift
```

## 기술 스택

- **SwiftUI**: 사용자 인터페이스
- **ARKit**: 얼굴 추적 및 BlendShapes 분석
- **Combine**: 반응형 프로그래밍
- **SceneKit**: AR 렌더링
- **Swift Package Manager**: 의존성 관리

## 작동 원리

### 눈 깜빡임 감지
ARKit의 `ARFaceAnchor`에서 제공하는 BlendShapes를 사용:
- `eyeBlinkLeft`: 왼쪽 눈 깜빡임 정도 (0.0 ~ 1.0)
- `eyeBlinkRight`: 오른쪽 눈 깜빡임 정도 (0.0 ~ 1.0)
- 임계값 0.6 이상일 때 눈을 감은 것으로 판단
- 열림 → 닫힘 전환 시 카운터 증가

### 시선 추적
ARKit의 Eye Look BlendShapes 사용:
- `eyeLookInLeft` / `eyeLookOutLeft`: 좌우 시선
- `eyeLookUpLeft` / `eyeLookDownLeft`: 상하 시선
- BlendShape 값을 화면 좌표로 매핑하여 커서 위치 계산

## API 문서

### FaceTrackingViewModel

얼굴 추적 및 눈 깜빡임 감지를 관리하는 ViewModel입니다.

#### Published Properties

- `blinkCount: Int` - 깜빡임 횟수
- `isFaceDetected: Bool` - 얼굴 감지 여부
- `isLeftEyeClosed: Bool` - 왼쪽 눈 닫힘 상태
- `isRightEyeClosed: Bool` - 오른쪽 눈 닫힘 상태
- `gazePosition: CGPoint` - 시선 위치 (화면 좌표)
- `isGazeTracking: Bool` - 시선 추적 활성화 여부
- `showPermissionAlert: Bool` - 권한 알림 표시 여부

#### Properties

- `screenSize: CGSize` - 화면 크기 (시선 좌표 매핑용)

#### Methods

- `resetCount()` - 깜빡임 카운터 초기화
- `updateFaceAnchor(_ faceAnchor: ARFaceAnchor?)` - 얼굴 추적 데이터 업데이트
- `handleSessionError()` - AR 세션 에러 처리

### ARViewContainer

ARKit 얼굴 추적을 위한 UIViewRepresentable 컨테이너입니다.

#### Initializer

```swift
ARViewContainer(viewModel: FaceTrackingViewModel)
```

## 개인정보 보호

이 라이브러리는:
- 카메라 데이터를 기기 외부로 전송하지 않습니다
- 얼굴 데이터를 저장하지 않습니다
- 모든 처리는 기기 내에서 실시간으로 이루어집니다

## 라이선스

MIT License

## 관련 프로젝트

- [Xcode 프로젝트 버전](../EyeBlinkDetector/) - 전통적인 Xcode 프로젝트 형식

## 개발자

@subjoooo-arch

## 기여하기

이슈나 풀 리퀘스트는 언제든지 환영합니다!

## 지원

문제가 발생하거나 질문이 있으시면 이슈를 등록해주세요.
