enum OnBoardingPageEnum {
  page1,
  page2,
  page3;

  String getImage() {
    final String value = switch (this) {
      page1 => "assets/on_boarding_page/img1.svg",
      page2 => "assets/on_boarding_page/img2.svg",
      page3 => "assets/on_boarding_page/img3.svg",
    };
    return value;
  }

  String getTitle() {
    final String value = switch (this) {
      page1 => "Find Food You Love",
      page2 => "Fast Delivery",
      page3 => "Live Tracking",
    };
    return value;
  }

  String getDescription() {
    final String value = switch (this) {
      page1 =>
        "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep",
      page2 => "Fast food delivery to your home, office wherever you are",
      page3 =>
        "Real time tracking of your food on the app once you placed the order",
    };
    return value;
  }
}
