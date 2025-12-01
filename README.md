# Eye Blink Detector (눈 깜빡임 측정기)

ARKit을 활용한 iOS/iPadOS용 실시간 눈 깜빡임 측정 및 시선 추적 앱입니다.

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
- **TrueDepth 카메라가 있는 기기** (Face ID 지원 기기)
  - iPhone X 이상
  - iPad Pro (2018년 모델 이상)
- **Xcode 15.0 이상** (개발용)

## 기술 스택

- **SwiftUI**: 사용자 인터페이스
- **ARKit**: 얼굴 추적 및 BlendShapes 분석
- **Combine**: 반응형 프로그래밍
- **SceneKit**: AR 렌더링

## 프로젝트 구조

```
EyeBlinkDetector/
├── EyeBlinkDetectorApp.swift     # 앱 엔트리 포인트
├── ContentView.swift              # 메인 UI
├── FaceTrackingViewModel.swift    # 얼굴 추적 로직 및 상태 관리
├── ARViewContainer.swift          # ARKit 뷰 통합
├── Info.plist                     # 앱 설정 및 권한
└── Assets.xcassets/              # 에셋 카탈로그
```

## 빌드 및 실행

### 1. Xcode에서 프로젝트 열기
```bash
cd EyeBlinkDetector
open EyeBlinkDetector.xcodeproj
```

### 2. 개발 팀 설정
- Xcode에서 프로젝트 설정 열기
- Signing & Capabilities 탭에서 개발 팀 선택

### 3. 실제 기기에서 실행
- ARKit Face Tracking은 시뮬레이터에서 작동하지 않습니다
- TrueDepth 카메라가 있는 실제 기기가 필요합니다

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

## 개인정보 보호

이 앱은:
- 카메라 데이터를 기기 외부로 전송하지 않습니다
- 얼굴 데이터를 저장하지 않습니다
- 모든 처리는 기기 내에서 실시간으로 이루어집니다

## 라이선스

MIT License

## 개발자

@subjoooo-arch
