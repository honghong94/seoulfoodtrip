# 서울 푸드 트립

## 목차

- [프로젝트 소개](#프로젝트-소개)
- [개발 환경](#개발-환경)
- [개발팀](#개발팀)
- [구현 기능](#구현-기능)

## 프로젝트 소개

서울 푸드 트립은 서울에 소재한 맛집들을 소개합니다. 그리고 서울 내에서 크루를 결성할 수 있어 동일한 취미를 가진 사람들끼리 만남을 가질 수 있는 서비스를 제공합니다.
- 서울 각 지역 관광지 리스트 및 상세정보, 검색 기능 제공
- 여행 리뷰 공유 게시판 (조회수 순으로 인기글 선정, 댓글)
- 다양한 크루 모집 및 크루 게시판을 통한 커뮤니티 기능
- KAKAO Map API, OpenWeather 날씨 API 사용
                                                                                                      
## 개발팀
- 류가희([@justlikeryu](https://github.com/justlikeryu)) 
- 전홍재([@honghong94](https://github.com/honghong94))

## 기술 스택
- 개발 언어 : Java (1.8)
- 개발 환경 : IntelliJ IDEA
- Front-End : HTML5, CSS3, JavaScript, JQuery, Ajax
- Back-End : Spring boot, Gradle, Spring-Data-JPA, Spring-Security
- DB : Oracle 18c
- 배포 : AWS EC2 (Amazon Linux)

## 구현 기능
- Bcrypt 사용하여 사용자 PW 암호화, Spring Security를 활용한 인증, 인가 구현
- 회원 가입, 회원 탈퇴 구현 및 마이 페이지 담당
- AWS (Amazon Web Services)를 이용한 프로젝트 배포
- REST API 적용 리팩토링 및 업데이트 중

### Member

- 회원
    - 회원 가입
    - 회원 정보 조회
    - 아이디 및 비밀번호 찾기
    - 비밀번호 및 전화번호 변경
    - 회원 탈퇴
- 프로필 사진
    - 프로필 사진 업로드
    - 프로필 사진 조회
    - 프로필 사진 변경

### Crew
- 크루
  - 크루 생성
  - 크루 조회
### REVIEW

### AREA


