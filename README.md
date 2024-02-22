# 💊프로젝트 이름💊
### Pillin(필린)

###### 영양제 <mark>재고 관리 및 알림</mark> 앱 서비스

![pillin](../ImageFile/noback_login_pillin_logo.png)

![pages](../ImageFile/pages.png)

# 💊개발 환경💊

<img src="https://img.shields.io/badge/Gitlab-FC6D26?style=flat-square&logo=GitLab&logoColor=white"/>
<img src="https://img.shields.io/badge/SpringBoot-6DB23F?style=flat-square&logo=SpringBoot&logoColor=white"/>
<img src="https://img.shields.io/badge/MariaDB-003545?style=flat-square&logo=MariaDB&logoColor=white"/>
<img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=Flutter&logoColor=white"/>
<img src="https://img.shields.io/badge/Kotlin-7F52FF?style=flat-square&logo=Kotlin&logoColor=white"/>
<img src="https://img.shields.io/badge/WearOS-4285F4?style=flat-square&logo=WearOS&logoColor=white"/>
<img src="https://img.shields.io/badge/AndroidStudio-3DDC84?style=flat-square&logo=AndroidStudio&logoColor=white"/>

# 💊서비스 화면💊

| 메인 페이지 |영양제 등록 페이지|복용 이력 페이지|영양제 알람 등록 페이지|분석 리포트 페이지|검색 페이지
|:----:|:----:|:----:|:----:|:----:|:----:|
|![main](../ImageFile/main.gif)|![regist](../ImageFile/regist.gif)|![calendar](../ImageFile/calendar.gif)|![push](../ImageFile/push.gif)|![report_rank](../ImageFile/report_rank.gif)|![search](../ImageFile/search.gif)|

# 💊주요 기능💊

### 로그인

- 소셜 계정으로도 회원 가입 및 로그인이 가능해요!
    - 카카오

### 내 프로필 생성

- 기본 정보(아이디, 이름, 생년월일, 성별 등)

### <mark>재고 등록</mark>

- 사용자가 보유중인 영양제 등록
- 재고 관리를 통해 재구매 알람

### <mark>알림 설정</mark>

- 주기적인 복용을 도와주기 위해 현재 보유 중인 영양제 알람 등록/수정 가능

### 건강 관리

- 영양제 복용 기록 ( 월간/주간/일일 형식 )
- 필요한 영양소의 영양제 추천(랭킹 서비스)
- 영양제 분석 리포트

### 검색

- 영양제 이름 검색
    - 텍스트 검색 - 영양제 성분별/ 제품명/브랜드명/건강고민별 검색
- 영양제 상세정보 및 구매링크 제공

### <mark>웨어러블</mark>

- 영양제 복용 기록
- 영양제 복용 알림

# 💊기술 소개💊

- Android/iOS 에서 동작 가능한 <mark>하이브리드</mark> 어플리케이션
    - Flutter를 활용하여 하이브리드 어플리케이션 제작
- 사용자 알림
    - Firebase Cloud Message 를 이용하여 사용자에게 <mark>Push 알림</mark> 제공
- 카카오 로그인
    - 일반 회원가입 및 OAuth를 이용한 인증을 통해 간편한 회원가입 제공
- 웨어러블
    - Wear OS를 활용하여 간편한 복용 기록 관리 기능 제공

# 💊설계 문서💊

### 기획서

[기획서 바로가기](https://www.notion.so/e8be82238cd24274bd5aecdc23b75efd?pvs=21)

### 기능 명세서

[기능 명세서 바로가기](https://www.notion.so/fc19297e4dc44ad584ce8067969edea1?pvs=21)

### ERD
![ERD](../ImageFile/ERD.png)

### 아키텍처
![architecture](../ImageFile/architecture.png)

### UCC
[UCC 바로가기](https://bonkri.notion.site/Pillin-e594f1a0efff47e6ad42acfcb31e98ec?pvs=4)

# 💊포팅 메뉴얼💊
### Backend 빌드
- gradle -> Bootjar

### Wearable 
- Android Studio 실행

# 💊팀원 소개💊
![team](../ImageFile/team.png)
