import "package:test/test.dart";
import 'package:flutter/material.dart';
import 'package:ahoy_sample/Services/TripProvider.dart';
import 'package:ahoy_sample/Models/Stubs/TripStubs.dart';
import 'package:ahoy_sample/UI/TripList/MyTripsInteractor.dart';
import 'package:mockito/mockito.dart';

class MockTripProvider extends Mock implements TripProvider {}

main() {
  
  test("Nothing when provider is empty", (){
    GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
    MockTripProvider provider = MockTripProvider();
    when(provider.allTrips()).thenReturn([]);
    final sut = MyTripsInteractor(listKey: _listKey, tripProvider: provider);

    expect(sut.count(), 0);
    expect(sut.buildRow(null, 0, null), isNull);
  });
  
}