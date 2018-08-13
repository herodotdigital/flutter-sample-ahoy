import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:ahoy_sample/Services/TripProvider.dart';
import 'package:ahoy_sample/Models/Stubs/TripStubs.dart';
import 'package:ahoy_sample/UI/TripList/MyTripsInteractor.dart';
import 'package:mockito/mockito.dart';
import 'package:ahoy_sample/UI/TripList/TripHeader.dart';
import 'package:ahoy_sample/UI/TripList/TripCell.dart';

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
  
  test("Header and Two cells for one full trip", (){
    final trip = TripStubs.stubTodayTrip(id: 1); //trip with flight and hotel
    when(provider.allTrips()).thenReturn([trip]);

    expect(sut.count(), 3);
    expect(sut.buildRow(null, 0, null), isInstanceOf<TripHeader>()); //header
    expect(sut.buildRow(null, 1, null), isInstanceOf<TripCell>()); //flight cell
    expect(sut.buildRow(null, 2, null), isInstanceOf<TripCell>()); //hotel cell
    expect(sut.buildRow(null, 3, null), isNull);
  });

  test("Date-based headers", (){
    final todayTrip = TripStubs.stubTodayTrip(id: 1);
    final laterTrip = TripStubs.stubLaterTrip(id: 2);
    when(provider.allTrips()).thenReturn([todayTrip, laterTrip]);

    expect(sut.buildRow(null, 0, null), isInstanceOf<TripHeader>());
    expect((sut.buildRow(null, 0, null) as TripHeader).data.title, "Now");
    expect((sut.buildRow(null, 0, null) as TripHeader).data.details, isNotNull);
    expect(sut.buildRow(null, 3, null), isInstanceOf<TripHeader>());
    expect((sut.buildRow(null, 3, null) as TripHeader).data.title, "Later");
  });

}