# ProductListSwiftUIApp

## 개요

상품 리스트와 상세 화면을 표시하는 iOS 애플리케이션입니다.

**SwiftUI + Combine + MVVM** 구조로 구성되었으며 JSON 파일로 상품 리스트, 상세 URL로 `WKWebView`를 구현한 점은 **`ProductListApp`** 과 동일합니다.
**`ProductListApp`**(UIKit + MVVM) 앱과 같은 기능이지만, SwiftUI + Combine를 활용하여 보다 가볍고 직관적으로 작성했습니다. 과제 요구사항에 맞춘 적절한 볼륨으로 간결하면서도 핵심 기능에 집중했습니다.

---

## UIKit vs SwiftUI 버전 비교
UIKit의 견고함과 SwiftUI + Combine의 간결함, 두 가지 접근 방식으로 같은 과제를 해결해보았습니다. 


**UIKit 버전**          : https://github.com/may-ios/Swift-ProductListApp

**(현재)SwiftUI 버전**   : https://github.com/may-ios/SwiftUI-ProductListApp


| 항목 | UIKit 버전 | SwiftUI 버전 |
|---|---|---|
| **코드 라인 수** | ~2000 라인 | ~800 라인 |
| **아키텍처 복잡도** | 높음 (Base 클래스, 공통 컴포넌트) | 낮음 (핵심 기능 중심) |
| **UI 구현** | UICollectionView + AutoLayout | List + 선언적 구문 |
| **데이터 바인딩** | 수동 업데이트 | @Published + Combine |
| **레이아웃 전환** | 2가지 레이아웃 토글 | 단일 레이아웃 (과제 요구사항 최적화) |
| **이미지 처리** | 커스텀 ImageManager + NSCache | AsyncImage (시스템 기본) |
| **개발 시간** | 7시간 | 3.5시간 |


---

## 핵심 기능

### 필수 구현사항
- **상품 리스트 화면**
  - SwiftUI `List`로 구현된 상품 목록 
  - 상품명, 브랜드, 가격, 할인정보, 썸네일 이미지 표시
- **상품 상세 화면**
  - 셀 탭 시 WKWebView로 상품 고유 URL을 로드하여 상품 상세 정보 표시
- **UI/UX 완성도**
  - CJ ENM 로고 표시
  - 할인율 및 할인가격 시각적 구분
  - User Interface Style(라이트,다크 모드 지원)등 HIG 준수

### 추가 구현사항
- **SwiftUI + Combine 활용**
  - `@StateObject`, `@Published`를 통한 반응형 데이터 바인딩
  - Combine의 `AnyPublisher`와 `sink`를 활용한 비동기 데이터 처리
- **MVVM 아키텍처**
  - View와 비즈니스 로직의 명확한 분리
  - `ObservableObject`를 통한 상태 관리
- **의존성 주입**
  - `ProductServiceProtocol`을 통한 느슨한 결합
  - 테스트 가능한 구조 설계
- **WebView 최적화**
  - `WebViewCoordinator`를 통한 WKWebView 상태 관리
  - `WebProcessPool` 싱글톤으로 메모리 효율성 향상
  - 로딩 진행률 실시간 업데이트
- **테스트**
  - 유닛 테스트: 모델, 서비스, 뷰모델, WebView 컴포넌트
  - UI 테스트: 앱 실행, 화면 전환, 웹뷰 로딩, 성능 측정

---

## 빌드 및 실행 방법

1. **요구사항**:
   - Xcode 16.2 이상
   - iOS 16.6 이상 
   - Swift 5.0 이상

2. **설치 및 실행**:
   ```bash
   # 1. 리포지토리 클론
   git clone https://github.com/may-ios/SwiftUI-ProductListApp.git
   
   # 2. 프로젝트 디렉토리로 이동
   cd ProductListSwiftUIApp
   
   # 3. Xcode에서 프로젝트 열기
   open ProductListSwiftUIApp.xcodeproj
   ```
   - Xcode에서 `ProductListSwiftUIApp` 타겟을 선택하고, iOS 시뮬레이터 또는 디바이스를 선택하여 빌드 및 실행합니다.
   - 외부 라이브러리 의존성이 없어 추가 설치 과정이 필요하지 않습니다.

---

## 앱 동작 방법

1. Xcode에서 프로젝트를 열고 빌드합니다.
2. 상품 리스트 화면:
   - 상품을 탭하여 상세 페이지로 이동합니다.
3. 상세 화면에서 웹뷰 로딩 상태를 상단 프로그레스 바로 확인합니다.

---

## 사용된 기술 및 라이브러리

### 언어 및 아키텍처
- **Swift 5**
- **아키텍처**: MVVM + SwiftUI + Combine
- **설계 원칙**: 단일 책임 원칙, 의존성 역전

### 프레임워크
- **SwiftUI**: 선언적 UI 구현
- **Combine**: 반응형 프로그래밍 , 데이터 바인딩
- **WebKit**: WKWebView를 통한 웹 콘텐츠 표시
- **XCTest**: 유닛 테스트 및 UI 테스트

### 핵심 기술
- **SwiftUI 컴포넌트**: List, AsyncImage, NavigationView, ProgressView
- **Combine Publisher**: AnyPublisher, Just, sink
- **프로토콜 지향**: ProductServiceProtocol을 통한 추상화
- **UIViewRepresentable**: SwiftUI에서 UIKit의 WKWebView 사용
- **메모리 최적화**: 싱글톤 패턴을 활용한 WebProcessPool 공유
- **라이브러리**: 외부 의존성 없음 (Apple 내장 프레임워크만 사용)

### 데이터 처리
- **JSON 파싱**: Foundation의 Codable 활용
- **Bundle 리소스**: 로컬 JSON 파일에서 상품 데이터 로딩
- **UUID**: 중복 ID 방지를 위한 고유 식별자 자동 생성

### MVVM 패턴
- **Model**: `Product` (Codable, Identifiable)
- **View**: `ProductListView`, `ProductDetailView`, `ProductCompactRow`
- **ViewModel**: `ProductListViewModel` (@MainActor, ObservableObject)
- **Service**: `ProductService` (ProductServiceProtocol 준수)

### 의존성 주입 및 상태 관리
```swift
// ViewModel에서 서비스 의존성 주입
init(productService: ProductServiceProtocol = ProductService()) {
    self.productService = productService
    fetchProducts()
}

// SwiftUI 환경 객체를 통한 상태 공유
WebView(url: product.link)
    .environmentObject(coordinator)
```

---

## 📁 폴더 구조

```
ProductListSwiftUIApp/
├─ ProductListSwiftUIApp/
│  ├─ Resources/
│  │  └─ products.json            # 로컬 JSON 상품 데이터
│  └─ Sources/
│     ├─ Models/
│     │  └─ Product.swift         # 상품 데이터 모델
│     ├─ Services/
│     │  └─ ProductService.swift  # JSON 데이터 로딩 서비스
│     ├─ ViewModels/
│     │  └─ ProductListViewModel.swift # 상품 목록 뷰모델
│     ├─ Views/
│     │  ├─ ProductListView.swift      # 메인 상품 목록 화면
│     │  ├─ ProductCompactRow.swift    # 상품 셀 (현재 사용)
│     │  ├─ ProductFullRow.swift       # 풀 레이아웃 셀 (미사용)
│     │  └─ ProductDetailView.swift    # 상품 상세 화면
│     └─ WebComponents/
│        ├─ WebView.swift              # SwiftUI WebView Wrapper
│        ├─ WebViewCoordinator.swift   # WKWebView 델리게이트 관리
│        ├─ WebConfiguration.swift     # WebView 설정
│        └─ WebProcessPool.swift       # 메모리 최적화
├─ ProductListSwiftUIAppTests/         # Unit Tests
└─ ProductListSwiftUIAppUITests/       # UI Tests
```

> SwiftUI App의 진입점은 `ProductListSwiftUIAppApp.swift`에서 `ProductListView()`로 시작합니다.

---

## 테스트

- **단위 테스트**:
  - `Product` 속성 초기화, `hasDiscount` 계산 속성 테스트
  - `ProductService`의 JSON 데이터 로딩, 프로토콜 준수 여부 테스트
  - `ProductListViewModel`의 초기화, Mock 서비스를 통한 데이터 로딩 테스트
  - `WebProcessPool`의 WebProcessPool 싱글톤 테스트.

- **UI 테스트**:
  - 앱 실행 테스트
  - List, 네비게이션 바, CJ ENM 로고 표시 확인
  - 상품 셀 탭으로 상세 화면 전환 확인
  - 프로그레스 바 표시 및 완료 확인
  - 리스트 스크롤 정상 동작 확인
  - 앱 실행 성능 테스트

---

## 과제 요구사항

| 요구사항 | 구현 내용 |
|---|---|
| **상품 리스트 화면** | 로컬 JSON 데이터 로드 → SwiftUI `List`로 표시 |
| **상품 상세 화면** | 셀 선택 시 네비게이션 전환, `WKWebView`로 각 상품 URL 로딩 |
| **UI/UX 완성도** | CJ ENM 브랜딩, 할인정보, 다크모드 지원, HIG 준수 |
| **SwiftUI 가산점** | 선언적 뷰 , Combine 데이터 바인딩, @StateObject 상태 관리 |
| **구조 설계** | MVVM 패턴, 의존성 주입, 프로토콜 추상화 |
| **테스트 코드** | Unit Test, UI Test |

---

## 개선 가능 사항

- **에러 처리**: 네트워크 오류, JSON 파싱 실패 시 사용자 알림
- **성능 최적화**: LazyVStack 적용, 이미지 캐싱 전략 개선
- **UI 확장**: 풀 레이아웃(`ProductFullRow`) 활성화, 레이아웃 토글 기능 추가

---

## 빌드 노트

- 외부 서드파티 의존성 없이 동작합니다.
- 리소스 JSON은 `Resources/`에 포함되어 있습니다.
---

## 과제 소요 시간

- **총 소요 시간**: 약 3.5시간
  - 기본 구조 및 UI 구현: 2시간
  - 테스트 작성: 1시간
  - 코드 리팩토링 및 문서화: 30분

---

**개발자**: 강명은  
**e-mail**: akme762@naver.com  

**감사합니다.**
