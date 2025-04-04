# 🧙🏻‍♀️ HarryPotter Series App  
총 7권의 해리 포터 시리즈의 각 작품에 대한 개요, 출판 연도, 목차 등의 정보를 제공하는 iOS 앱입니다. <br> 

## 📘 프로젝트 개요
- **주제:** `View`와 `ViewController`를 활용한 `UI 컴포넌트`의 이해
- **학습 개념:** `UiKit`, `AutoLayout`과 `Constraints`


## 👩🏻‍🏫 구현 가이드

### ✅ 기본 기능

- [x] **책 시리즈 데이터 불러오기**: `data.json`파일을 읽어와서 데이터를 사용합니다.
- [x] **책 정보 보여주기**: 불러온 책 시리즈 데이터를 화면에 보여줍니다.
- [x] **책 시리즈 버튼**: 총 7개의 버튼이 나열되어있고, 버튼을 선택하면 선택된 책에 대한 정보로 데이터가 변경되어 화면에 보여지게 됩니다.
- [x] **더보기 버튼**: 글자수가 450자 이상인 경우 `…` 말줄임표 표시 및 더보기 버튼을 표시합니다. 앱을 종료 후 재실행시도 이전 상태를 유지하도록 합니다. 

### ✅ 도전 과제

- [x] **모든 디바이스 지원**: `iOS 16.0`과 호환 가능한 `iPhone 모델`(`SE 2세대`, `16 Pro Max` 등)의 다양한 디바이스를 지원합니다.
- [x] **`Portrait` / `Landscape` 모드 대응**: 콘텐츠가 `노치`나 `Dynamic Island` 영역에 가려지지 않도록 구현합니다. 
- [x] **Autolayout 관련 경고 메시지**: 디바이스 방향을 바꾸더라도 콘솔창에 `AutoLayout` 관련 경고 메시지가 뜨지 않도록 구현합니다.


## 사용 기술
- `Swift`
- `UIKit`
- `SnapKit`
- `Combine`
- `delegate`패턴

## 📂 폴더 구조 (MVVM 기반)
```
HarryPotterSeriesHakyung
├── HarryPotterSeriesHakyung
│   ├── Handler
│   │   ├── DefaultsHandler.swift                   // UserDefaults 관련 처리  
│   ├── Model
│   │   ├── Book.swift                              // 책 정보 모델  
│   │   ├── Chapter.swift                           // 챕터 정보 모델  
│   │   ├── data.json                              // JSON 데이터 
│   ├── Service
│   │   ├── DataService.swift                       // 데이터 제공 서비스  
│   │   ├── ServiceError.swift                      // 에러 처리  
│   ├── Util
│   │   ├── Color.swift                              // 색상 관리  
│   │   ├── Constants.swift                          // 상수 관리  
│   │   ├── DateFormatter.swift                      // 날짜 형식 변환  
│   │   ├── Image.swift                              // 이미지 관련 유틸  
│   │   ├── Label.swift                              // 뷰 별 Title Label 관리  
│   ├── View
│   │   ├── BookDescriptionView                      // 책 설명 관련 뷰  
│   │   │   ├── ChapterView.swift  
│   │   │   ├── InfoView.swift  
│   │   │   ├── LabelContentView.swift  
│   │   ├── BookSeriesButton                         // 책 시리즈 버튼 컴포넌트  
│   │   │   ├── BookSeriesButton.swift  
│   │   │   ├── BookSeriesButtonDelegate.swift  
│   │   ├── HomeView                                 // 메인 화면  
│   │   │   ├── HomeView.swift  
│   │   │   ├── HomeViewController.swift  
│   │   ├── MoreLessButton                           // 더보기 버튼  
│   │   │   ├── MoreLessButton.swift  
│   │   │   ├── MoreLessButtonDelegate.swift  
│   ├── ViewModel
│   │   ├── HomeViewModel.swift                      // HomeView의 ViewModel  
│   ├── AppDelegate.swift                            // 앱 라이프사이클 관리  
│   ├── Assets.xcassets                              // 앱의 이미지 및 리소스  
│   ├── Info.plist 
│   ├── SceneDelegate.swift                          // Scene 관리  
```

📌 **폴더 및 파일 설명**
- `MVVM` 패턴 적용: `Model`, `ViewModel`, `View`로 역할을 분리
- 서비스 계층 분리: `Service` 폴더에서 데이터 관련 처리
- 재사용 가능한 컴포넌트: `Util`, `BookSeriesButton`, `MoreLessButton` 등

