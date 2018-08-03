import "package:test/test.dart";
import "package:ahoy_sample/UI/Shared/AhoyStyles.dart";

void main() {
  test("Themes should be not null", (){
    expect(AhoyStyles.list.valueStyle, isNotNull);
    expect(AhoyStyles.details.headerStyle, isNotNull);
  });
}