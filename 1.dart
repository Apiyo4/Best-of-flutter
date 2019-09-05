import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

@JsonSerializable()
class BaseResponse extends Object{
  String status;
  @JsonKey(name: 'data')
  List<Trip> trips;
  BaseResponse(
    this.status,
    this.trips
);
  factory BaseResponse.fromJson(Map<String, dynamic> json)  => _$BaseResponseFromJson(json);
  Map<String, dynamic> toJson()  => _$BaseResponseToJson(this);

}
@JsonSerializable()
class Trip{
  int id;
  @JsonKey(name: 'staf_name')
  String staffName;
  int passengers;
  String time;
  String station;
  String driver;
  String conductor;
  String route;
  int fare;
  Trip({
    this.id,
    this.staffName,
    this.passengers,
    this.time,
    this.station,
    this.driver,
    this.conductor,
    this.route,
    this.fare
  }
);

factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
  Map<String, dynamic> toJson()  => _$TripToJson(this);


  Trip.fromResponse(Trip response)
      : passengers = response.passengers,
        staffName = response.staffName,
        station = response.station,
        driver = response.driver,
        route = response.route,
        conductor = response.conductor,
        fare = response.fare;

}
