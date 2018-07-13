
import 'package:ahoy_sample/AhoyCell.dart';

class AhoyCellMockData {
  static List<AhoyCellData> now() {
    return [
      const AhoyCellData(
        title: "wro - waw",
        subtitle: "Wrocław City Airport",
        iconName: "assets/images/planeGray.png", 
        topRightText: "in 30 mins",
        bottomRightCaption: "Gate closes:",
        bottomRightValue: "8:05 PM", 
        bottomLeftCaption: "Departure:", 
        bottomLeftValue: "8:35 PM",
      ),
      const AhoyCellData(
        title: "2 night stay",
        subtitle: "Warsaw, Doubletree by Hilton",
        iconName: "assets/images/hotelGray.png", 
        topRightText: "Today",
        bottomRightCaption: "Check in after:",
        bottomRightValue: "1:00 PM", 
        bottomLeftCaption: "", 
        bottomLeftValue: "",
      ),
    ];
  }
  static List<AhoyCellData> later() {
    return [
      const AhoyCellData(
        title: "waw - bcn",
        subtitle: "Warsaw Chopin Airport",
        iconName: "assets/images/planeGray.png", 
        topRightText: "Thu, 24 May",
        bottomRightCaption: "Gate closes:",
        bottomRightValue: "8:05 PM", 
        bottomLeftCaption: "Departure:", 
        bottomLeftValue: "8:35 PM",
      ),
      const AhoyCellData(
        title: "1 night stay",
        subtitle: "Barcelona, Some Apartments",
        iconName: "assets/images/hotelGray.png", 
        topRightText: "Thu, 24 May",
        bottomRightCaption: "Check in after:",
        bottomRightValue: "12:00 AM", 
        bottomLeftCaption: "", 
        bottomLeftValue: "",
      ),
    ];
  }
}