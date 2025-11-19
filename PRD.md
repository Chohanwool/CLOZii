# CLOZii Product Requirements Document (PRD)

## 📋 Document Information

- **Product Name**: CLOZii
- **Version**: 1.0
- **Last Updated**: 2025-01-19
- **Status**: Planning & Early Development
- **Owner**: CLOZii Team

---

## 🎯 Executive Summary

CLOZii는 필리핀 지역 커뮤니티를 위한 동네 기반 중고거래 및 생활 서비스 플랫폼입니다. 당근마켓의 성공 모델을 벤치마크하여, 필리핀 시장의 특성에 맞춘 차별화된 서비스를 제공합니다.

**핵심 가치 제안**:
- 🏘️ **동네 중심**: GPS 기반 위치 인증으로 안전한 로컬 거래
- 💱 **환전 서비스**: 필리핀 특화 - 페소/달러 환전 매칭
- 🤝 **신뢰 기반**: 거래 후기 및 이웃 인증 시스템
- 📱 **간편함**: 전화번호 하나로 시작하는 쉬운 가입

---

## 🌟 Product Vision

### Vision Statement
"필리핀의 모든 동네를 연결하여, 이웃 간 신뢰를 바탕으로 한 안전하고 편리한 거래 문화를 만든다"

### Mission
1. 중고 거래 활성화로 지속 가능한 소비 문화 조성
2. 동네 커뮤니티 강화를 통한 사회적 가치 창출
3. 필리핀 시장 특성에 맞는 실용적인 서비스 제공

### Long-term Goals (3년)
- 필리핀 주요 도시 MAU 100만 달성
- 월 거래액 100억 페소 달성
- 동네 인증 사용자 50만 명 확보
- 환전 서비스 거래 건수 월 10만 건

---

## 👥 Target Users

### Primary Personas

#### 1. Maria (28세, 마닐라 거주 직장인)
- **Pain Points**:
  - 사용하지 않는 물건이 많지만 처분 방법을 모름
  - 새 제품 구매 부담 (중고로 저렴하게 구하고 싶음)
  - 온라인 거래 사기 경험으로 신뢰 부족
- **Needs**:
  - 안전한 동네 거래
  - 빠른 현금화
  - 신뢰할 수 있는 거래 상대

#### 2. Juan (35세, 세부 거주 자영업자)
- **Pain Points**:
  - 해외 송금/환전 시 높은 수수료
  - 은행 방문 시간 부족
  - 환율 정보 불투명
- **Needs**:
  - 간편한 개인 간 환전
  - 투명한 환율
  - 빠른 거래 매칭

#### 3. Ana (22세, 대학생)
- **Pain Points**:
  - 제한된 예산
  - 기숙사 이사로 인한 물건 처분 필요
  - 무료 나눔 받고 싶지만 정보 부족
- **Needs**:
  - 학생 간 중고 거래
  - 무료 나눔 정보
  - 간편한 채팅 거래

---

## ⚡ Core Features & Requirements

### Phase 1: MVP (현재 → 3개월)
**목표**: 기본 중고거래 기능으로 초기 사용자 확보

#### 1.1 Authentication & Onboarding ✅ (In Progress)
- [x] 전화번호 기반 회원가입/로그인
- [x] SMS OTP 인증
- [x] Firebase Auth 연동
- [ ] 동네 인증 (GPS 기반 위치 등록)
- [ ] 프로필 설정 (닉네임, 프로필 사진)

#### 1.2 Item Listing (상품 등록)
- [ ] 사진 업로드 (최대 10장)
- [ ] 카테고리 선택 (전자기기, 가구, 의류, 도서, 기타)
- [ ] 가격 설정 (판매/나눔 구분)
- [ ] 상품 설명 작성
- [ ] 거래 희망 장소 설정 (동네 기반)
- [ ] 상태 표시 (새 제품, 거의 새것, 보통, 하자 있음)

#### 1.3 Browse & Search (검색 및 탐색)
- [ ] 동네별 상품 피드 (최신순, 가격순)
- [ ] 카테고리별 필터링
- [ ] 키워드 검색
- [ ] 거리 기반 정렬 (내 동네 우선)
- [ ] 가격 범위 필터

#### 1.4 Chat & Transaction (채팅 및 거래)
- [ ] 1:1 실시간 채팅 (Firebase Realtime Database)
- [ ] 이미지 전송
- [ ] 가격 제안 (네고)
- [ ] 약속 잡기 (시간, 장소)
- [ ] 거래 완료 처리

#### 1.5 My Page (마이페이지)
- [ ] 판매 중인 상품 관리
- [ ] 구매 관심 목록
- [ ] 거래 내역
- [ ] 받은 후기 보기

### Phase 2: Growth Features (3~6개월)
**목표**: 사용자 신뢰도 강화 및 거래 활성화

#### 2.1 Trust & Safety (신뢰 시스템)
- [ ] 거래 후기 시스템 (별점 + 텍스트)
- [ ] 매너 온도 (당근마켓 벤치마크)
- [ ] 이웃 인증 배지 (동네 인증, 거래 횟수 기반)
- [ ] 신고 기능 (사기, 부적절한 게시물)
- [ ] 차단 기능

#### 2.2 Community Features (커뮤니티)
- [ ] 동네 소식 게시판
- [ ] 질문/답변 게시판
- [ ] 분실/습득 게시판
- [ ] 모임 만들기 (동네 독서 모임 등)

#### 2.3 Enhanced UX
- [ ] 푸시 알림 (채팅, 가격 제안, 관심 카테고리 신상품)
- [ ] 찜하기 (관심 상품 저장)
- [ ] 공유하기 (SNS 공유)
- [ ] 게시물 끌어올리기 (유료 기능)

#### 2.4 Analytics & Insights
- [ ] 내 상품 조회수
- [ ] 지역별 인기 카테고리
- [ ] 적정 가격 추천

### Phase 3: Differentiation (6~12개월)
**목표**: 필리핀 특화 서비스로 차별화

#### 3.1 Currency Exchange (환전 매칭) 🌟
**필리핀 특화 기능 - 핵심 차별화 포인트**

- [ ] 페소 ↔ 달러 환전 매칭
- [ ] 실시간 환율 정보
- [ ] 환전 희망 금액/환율 등록
- [ ] 안전한 환전 장소 추천 (공공장소, CCTV 있는 곳)
- [ ] 환전 거래 후기
- [ ] 환전 사기 방지 (신원 인증 강화)

**Business Model**:
- 플랫폼 수수료 0.5~1% (선택적)
- 초기에는 무료로 사용자 확보

#### 3.2 Job Board (동네 일자리)
- [ ] 단기 알바 공고 (이벤트 스태프, 배달 등)
- [ ] 재능 거래 (과외, 수리, 청소)
- [ ] 시급 정보 투명화

#### 3.3 Local Business Integration
- [ ] 동네 가게 등록 (식당, 카페, 세탁소)
- [ ] 할인 쿠폰
- [ ] 가게 후기

#### 3.4 Premium Features (수익화)
- [ ] 프로 계정 (사업자용 - 월 구독)
  - 무제한 상품 등록
  - 광고 우선 노출
  - 통계 대시보드
- [ ] 배너 광고
- [ ] 게시물 부스팅 (유료 끌어올리기)

---

## 🏗️ Technical Requirements

### Architecture
- **Frontend**: Flutter (iOS/Android)
- **Backend**: Firebase
  - Authentication: Firebase Auth (Phone)
  - Database: Cloud Firestore
  - Storage: Firebase Storage (이미지)
  - Messaging: Firebase Cloud Messaging (푸시)
  - Analytics: Firebase Analytics
- **Maps**: Google Maps API
- **State Management**: Riverpod + Freezed

### Performance Requirements
- 앱 초기 로딩 시간: < 3초
- 검색 결과 표시: < 1초
- 채팅 메시지 전송: < 500ms
- 이미지 업로드: < 5초 (1장당)

### Security Requirements
- 전화번호 암호화 저장 (필요시 마스킹 표시)
- Firestore Security Rules 엄격 적용
- 사용자 위치 정보 정확한 주소 노출 금지 (동네 레벨까지만)
- 환전 거래 시 추가 본인 인증

### Scalability
- 초기 목표: 동시 접속자 1만 명 지원
- Firestore 쿼리 최적화 (인덱싱, 페이지네이션)
- 이미지 CDN 활용

---

## 📊 Success Metrics

### Phase 1 (MVP) - 3개월
- 가입자 수: 10,000명
- DAU: 1,000명
- 등록 상품 수: 5,000개
- 거래 완료 건수: 500건

### Phase 2 (Growth) - 6개월
- 가입자 수: 50,000명
- DAU: 5,000명
- 거래 완료 건수: 5,000건/월
- 앱 리텐션 (D7): 30%

### Phase 3 (Differentiation) - 12개월
- 가입자 수: 200,000명
- MAU: 80,000명
- 거래 완료 건수: 20,000건/월
- 환전 거래 건수: 2,000건/월

### Key Performance Indicators (KPI)
1. **User Growth**: 주간 신규 가입자 수
2. **Engagement**: DAU/MAU 비율
3. **Transaction**: 거래 완료율 (채팅 시작 대비)
4. **Trust**: 평균 매너 온도, 거래 후기 작성률
5. **Revenue**: ARPU (유료 기능 사용자 평균 매출)

---

## 🗓️ Roadmap

### Q1 2025 (현재 - 3월)
- [x] 프로젝트 설계 및 기술 스택 확정
- [x] Firebase 연동 및 인증 구현
- [ ] MVP 핵심 기능 개발
  - [ ] 상품 등록/조회
  - [ ] 채팅
  - [ ] 동네 인증
- [ ] 베타 테스터 모집 (마닐라 일부 지역)

### Q2 2025 (4월 - 6월)
- [ ] 신뢰 시스템 구축 (거래 후기, 매너 온도)
- [ ] 커뮤니티 기능 추가
- [ ] 푸시 알림 구현
- [ ] 정식 출시 (마닐라, 세부)
- [ ] 초기 마케팅 캠페인

### Q3 2025 (7월 - 9월)
- [ ] 환전 서비스 베타 출시
- [ ] 일자리 게시판 추가
- [ ] 프로 계정 도입 (수익화 시작)
- [ ] 주요 도시 확장 (다바오, 케손 시티)

### Q4 2025 (10월 - 12월)
- [ ] AI 기반 가격 추천 시스템
- [ ] 로컬 비즈니스 연동
- [ ] 다국어 지원 (영어, 타갈로그어)
- [ ] 연말 프로모션 및 사용자 이벤트

---

## 🚀 Go-to-Market Strategy

### Target Launch Cities
1. **Metro Manila** (우선순위 1)
   - 인구 밀집도 높음
   - 중고거래 수요 많음
2. **Cebu City** (우선순위 2)
   - 관광도시, 외국인 많음 (환전 수요)
3. **Davao City** (우선순위 3)
   - 민다나오 최대 도시

### Marketing Channels
1. **소셜 미디어**: Facebook, Instagram 타겟 광고
2. **입소문**: 초대 이벤트 (친구 초대 시 보너스 포인트)
3. **파트너십**: 대학교, 주거 단지와 협업
4. **PR**: 로컬 미디어 보도자료

### Pricing Strategy
- **Phase 1~2**: 완전 무료 (사용자 확보 우선)
- **Phase 3**: 프리미엄 기능 유료화
  - 프로 계정: ₱299/월
  - 게시물 부스팅: ₱49/회

---

## ⚠️ Risks & Mitigation

### Risk 1: 낮은 초기 사용자 확보
- **Mitigation**: 특정 지역(대학가, 아파트 단지) 집중 공략, 오프라인 프로모션

### Risk 2: 거래 사기 및 신뢰 문제
- **Mitigation**: 강력한 신고/차단 시스템, 동네 인증 강제화, 안전 거래 가이드 제공

### Risk 3: 환전 서비스 법적 이슈
- **Mitigation**: 필리핀 금융 당국 규정 확인, 플랫폼은 매칭만 제공 (직접 환전 금지), 법률 자문

### Risk 4: 대형 경쟁사 진입
- **Mitigation**: 빠른 MVP 출시, 틈새 시장(환전) 선점, 로컬 커뮤니티 강화

### Risk 5: Firebase 비용 증가
- **Mitigation**: 쿼리 최적화, 캐싱 전략, 초기 VC 투자 확보

---

## 💡 Competitive Analysis

### Competitors

| 서비스 | 강점 | 약점 | CLOZii 차별화 |
|--------|------|------|--------------|
| **Facebook Marketplace** | 사용자 기반 거대 | 신뢰도 낮음, 사기 많음 | 동네 인증, 매너 온도 |
| **OLX Philippines** | 브랜드 인지도 | UI/UX 복잡, 커뮤니티 약함 | 간편한 UX, 동네 커뮤니티 |
| **Carousell** | 깔끔한 UI | 동네 기능 약함 | 위치 기반 강화 |
| **당근마켓** (한국) | 벤치마크 모델 | 필리핀 미진출 | 환전 등 로컬 특화 기능 |

---

## 📚 References & Inspiration

- 당근마켓 (Karrot Market) - 동네 중심 모델
- Nextdoor - 이웃 커뮤니티
- OfferUp - 신뢰 시스템
- Wise (TransferWise) - 환전 투명성

---

## 📝 Appendix

### A. User Research
- [ ] 필리핀 사용자 30명 인터뷰 (마닐라, 세부)
- [ ] 중고거래 습관 및 Pain Points 조사
- [ ] 환전 경험 및 니즈 파악

### B. Legal Compliance
- [ ] 필리핀 개인정보보호법 준수
- [ ] 전자상거래법 검토
- [ ] 환전 관련 금융 규제 확인

### C. Design Resources
- [ ] Figma 디자인 시스템 구축
- [ ] 브랜드 가이드라인
- [ ] 일러스트레이션 에셋

---

**Document Status**: Living Document - 매월 업데이트
**Next Review**: 2025-02-19
