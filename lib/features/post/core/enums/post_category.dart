// 게시글 카테고리를 나타내는 열거형
enum PostCategory {
  luxuryGoods('Luxury Goods'), // 수입명품
  ticketsAndCoupons('Tickets & Coupons'), // 티켓/쿠폰
  freeGiveaway('Free Giveaway'), // 무료나눔
  fashionApparel('Fashion Apparel'), // 패션의류
  fashionAccessories('Fashion Accessories'), // 패션잡화
  beauty('Beauty'), // 뷰티
  babyAndMaternity('Baby & Maternity'), // 출산/유아 용품
  mobileAndTablets('Mobile & Tablets'), // 모바일/태블릿
  homeAppliances('Home Appliances'), // 가전제품
  laptopsAndPcs('Laptops & PCs'), // 노트북/PC
  camerasAndCamcorders('Cameras & Camcorders'), // 카메라/캠코더
  furnitureAndInterior('Furniture & Interior'), // 가구/인테리어
  homeAndLiving('Home & Living'), // 리빙/생활
  videoGames('Video Games'), // 게임
  petsAndHobbies('Pets & Hobbies'), // 반려동물/취미
  booksAndMusic('Books & Music'), // 도서/음반/취미
  sports('Sports'), // 스포츠
  leisureAndTravel('Leisure & Travel'), // 레저/여행
  carsAndMotorcycles('Cars & Motorcycles'), // 자동차/오토바이
  toolsAndIndustrial('Tools & Industrial'); // 공구/산업용품

  final String displayName;
  const PostCategory(this.displayName);
}
