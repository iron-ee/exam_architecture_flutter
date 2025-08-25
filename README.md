
# ✈️ 인천공항 출국 정보 조회 앱 (Flight Departures Info)

Flutter를 사용하여 개발된 인천공항의 실시간 출국 항공편 정보를 조회하는 애플리케이션입니다. 이 프로젝트는 단순한 기능 구현을 넘어, **확장성과 유지보수성, 그리고 테스트 용이성**을 극대화하기 위해 클린 아키텍처(Clean Architecture)와 BLoC 패턴을 기반으로 설계되었습니다.

---

## 🏛️ 핵심 아키텍처

이 프로젝트의 가장 큰 특징은 계층별 역할을 명확히 분리한 **클린 아키텍처**입니다. 이를 통해 각 코드는 자신의 책임에만 집중하며, 비즈니스 로직이 UI나 외부 데이터 소스로부터 독립적으로 유지됩니다.

```
┌─────────────────────────────────────────────┐
│             PRESENTATION LAYER              │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────┐│
│  │   BLoC      │ │   Screen    │ │  Widget ││
│  │  (상태관리)   │ │    (화면)    │ │ (UI요소) ││
│  └─────────────┘ └─────────────┘ └─────────┘│
└─────────────────────┬───────────────────────┘
                      │
┌─────────────────────▼───────────────────────┐
│                DOMAIN LAYER                 │
│        ┌─────────────┐ ┌─────────────┐      │
│        │   UseCase   │ │   Entity    │      │
│        │ (비즈니스로직) │ │   (핵심모델)   │      │
│        └─────────────┘ └─────────────┘      │
└─────────────────────┬───────────────────────┘
                      │
┌─────────────────────▼───────────────────────┐
│                 DATA LAYER                  │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────┐│
│  │  Repository │ │ API Service │ │  Model  ││
│  │  (데이터관리)  │ │  (네트워크)   │ │  (DTO)  ││
│  └─────────────┘ └─────────────┘ └─────────┘│
└─────────────────────────────────────────────┘
```

#### ➌ Presentation Layer

* **역할**: UI 렌더링과 사용자 입력 처리를 담당합니다.
* **주요 기술**: `Flutter`, `BLoC`
* **특징**: UI의 상태 관리를 위해 **BLoC 패턴**을 적용하여 비즈니스 로직과 UI를 완벽히 분리했습니다. UI는 BLoC이 전달하는 상태(State)에 따라 반응적으로 렌더링되며, 모든 사용자 액션은 이벤트(Event)를 통해 BLoC으로 전달됩니다.

#### ➋ Domain Layer

* **역할**: 앱의 핵심 비즈니스 로직을 포함하며, 가장 순수하고 독립적인 계층입니다.
* **주요 기술**: 순수 `Dart`
* **특징**: `UseCase`를 통해 비즈니스 로직을 캡슐화하고, `Entity`를 통해 핵심 데이터 모델을 정의합니다. 외부 계층의 변화에 전혀 영향을 받지 않아 안정적입니다.

#### ➊ Data Layer

* **역할**: 외부 데이터 소스(네트워크 API, 로컬 DB 등)와의 통신 및 데이터 처리를 담당합니다.
* **주요 기술**: `Dio`, `Dartz`
* **특징**: `Repository` 구현체를 통해 Domain 계층에 데이터를 제공합니다. `Dio` 인터셉터를 활용하여 API 통신 시 발생하는 예외 처리, 로깅, API 키 재시도 로직 등을 중앙에서 관리하여 코드 중복을 최소화했습니다.


---

## 📂 상세 폴더 구조

```
lib/
├── main.dart                    # 앱 진입점
├── router.dart                  # 전역 라우팅 설정
├── injection_container.dart     # 전역 의존성 주입
│
├── core/                        # 프로젝트 전반에서 사용되는 공통 모듈
│   ├── constants/
│   │   ├── api_constants.dart   # API URL, 서비스키
│   │   ├── date_formatter.dart  # 시간 포맷 유틸
│   │   └── airport_data.dart    # 항공사/공항 한글명 매핑
│   ├── error/
│   │   ├── failures.dart        # 에러 타입 정의
│   │   ├── api_error_handler.dart # API 에러 매핑
│   │   └── failure_to_message_mapper.dart # 사용자용 에러메시지
│   ├── interceptor/
│   │   └── api_interceptor.dart # Dio 인터셉터 (에러처리+재시도)
│   └── usecase/
│       └── usecase.dart         # UseCase 추상 클래스
│
└── feature/                     # 기능별 모듈
    └── flight/                  # 항공편 기능 모듈
        ├── data/
        │   ├── api/
        │   │   └── flight_api_service.dart      # API 통신
        │   ├── model/
        │   │   └── flight_response_model.dart   # JSON 응답 모델
        │   ├── mapper/
        │   │   └── flight_mapper.dart           # Model→Entity 변환
        │   └── repository/
        │       ├── flight_repository.dart       # Repository 인터페이스
        │       └── flight_repository_impl.dart  # Repository 구현체
        ├── domain/
        │   ├── entity/
        │   │   └── flight_entity.dart           # 항공편 핵심 모델
        │   ├── enum/
        │   │   └── flight_enums.dart            # 터미널ID, 항공편타입
        │   └── usecase/
        │       └── get_flight_departures_usecase.dart # 항공편조회 로직
        └── presentation/
            ├── bloc/
            │   ├── flight_bloc.dart             # 상태 관리
            │   ├── flight_event.dart            # BLoC 이벤트
            │   └── flight_state.dart            # BLoC 상태
            ├── screen/
            │   ├── flight_list_screen.dart      # 메인 목록 화면
            │   └── flight_detail_screen.dart    # 상세 정보 화면
            └── widget/
                └── flight_list_item.dart        # 항공편 카드 위젯
```

---

## ✨ 기술 하이라이트

* **의존성 주입 (DI)**: `get_it` 패키지를 사용하여 클래스 간의 의존성을 외부에서 주입합니다. 이를 통해 컴포넌트 간의 결합도를 낮추고 단위 테스트를 용이하게 만듭니다.
* **중앙화된 라우팅**: `go_router`를 사용하여 앱 내의 모든 화면 전환 로직을 한 곳에서 관리합니다. 이를 통해 라우팅 규칙이 명확해지고 유지보수가 간편해집니다.
* **표준화된 에러 처리**: `Dartz` 라이브러리의 `Either` 타입을 활용하여 성공 결과와 실패(Failure)를 명시적으로 처리합니다. 모든 예외는 `Failure`라는 공통 클래스로 추상화되어 일관성 있는 에러 핸들링이 가능합니다.
* **불변 모델**: `equatable`을 사용하여 모델 클래스를 불변(Immutable) 객체로 관리하며, BLoC의 상태 변화를 효과적으로 감지합니다.

---

## 🚀 실행 방법

```bash
# 저장소 복제
$ git clone https://github.com/iron-ee/exam_architecture_flutter.git

# 프로젝트 폴더로 이동
$ cd exam_architecture_flutter

# 의존성 설치
$ flutter pub get

# 앱 실행
$ flutter run
```