# YourPilling
Flutter_project title pill

01.22 플러터 프로젝트 구조 구현

font는 추가할때마다 yaml 파일에서 수동으로 추가해줄것
- googlefont 에서 원하는 거 받아서 사용가능

const 폴더는 우리가 고정적으로 사용할 css 적고 import해서 사용

component 한 screen에 들어갈 세부 기능들의 모음

screen 한 화면 화면단을 나누어 둔 폴더

<<<<<<< HEAD
route 여기서 route설정, bool에 세션 or 토큰 담아서 로그인 확인

### 캘린더 참고사항
캘린더 library로 디자인 및 값 할당되는거 확인함
다른 라이브러리 찾아 쓰지 말고 내가 만들어둔 캘린더 기능 추가 및 변경해서 사용할것


## 01.22 프론트가 해야할 것. http 통신으로 백엔드와 데이터 연결할것.
### 못할시 로그인 or 검색 or router 수정할것

### 파이어베이스 설정
1. firebase login
2. dart pub global activate flutterfire_cli
3. flutterfire configure ( 경로 설정이 되어있으면 바로 가능 )
4. firebase 해당 프로젝트에 android가 등록됐는지 확인
5. flutter pub add firebase_core
6. flutter pub add firebase messaging  yaml파일에 의존성 추가