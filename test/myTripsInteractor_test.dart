import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:ahoy_sample/Services/TripProvider.dart';
import 'package:ahoy_sample/Models/Stubs/TripStubs.dart';
import 'package:ahoy_sample/UI/TripList/MyTripsInteractor.dart';
import 'package:mockito/mockito.dart';

class MockTripProvider extends Mock implements TripProvider {}

MockTripProvider provider;
MyTripsInteractor sut;

main() {
  
  setUp(() async {
    GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
    provider = MockTripProvider();
    sut = MyTripsInteractor(listKey: listKey, tripProvider: provider);
  });

  tearDown(() async {
  });

  test("Nothing when provider is empty", (){
    when(provider.allTrips()).thenReturn([]);

    expect(sut.count(), 0);
    expect(sut.buildRow(null, 0, null), isNull);
  });
  
  test("Two cells on one full trip", (){
    final trip = TripStubs.stubTodayTrip(id: 1);

    when(provider.allTrips()).thenReturn([trip]);

    expect(sut.count(), 2);
    expect(sut.buildRow(null, 0, null), isInstanceOf<Widget>());
    expect(sut.buildRow(null, 1, null), isInstanceOf<Widget>());
    expect(sut.buildRow(null, 2, null), isNull);
  });

}