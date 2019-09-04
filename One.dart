import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sacco/tripDeta.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main(){
  runApp(new TripDetails());
}
class TripDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title:"Matatu Sacco",
        home: new Homepage(),
        theme: new ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.tealAccent
        )

    );
  }
}
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
//  String strStringData = "Trip Details";
//  String dropdownValue;
  int currentTab = 0;
  PageOne one;
  PageTwo two;
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState(){
    one = PageOne();
    two = PageTwo();
    pages = [one, two];
   currentPage = one;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
//    final txtRoute = TextField(
//      decoration: InputDecoration(
//          hintText: "Route",
//          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
//      ),
//    );
//    final txtTime = TextField(
//      decoration: InputDecoration(
//          hintText: "Time",
//          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
//      ),
//    );
//
//    final txtAmount = TextField(
//      decoration: InputDecoration(
//          hintText: "Fare",
//          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
//      ),
//    );
//    final txtPassengers = TextField(
//      decoration: InputDecoration(
//          hintText: "Number of Passengers",
//          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
//      ),
//    );
//    final txtStation = TextField(
//      decoration: InputDecoration(
//          hintText: "Station",
//          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
//      ),
//    );
//    final txt = TextFormField(
//      decoration: InputDecoration(
//          hintText: "Number Plate",
//          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//         border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
//      ),
//    );
//
//      final txtNumberPlate = FormField<String>(
//        builder: (FormFieldState<String> state) {
//          return InputDecorator(
//            decoration: InputDecoration(
//                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 3.0),
//                errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
//                hintText: 'Please select expense',
//                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
//                isEmpty: dropdownValue == '',
//            child: DropdownButtonHideUnderline(
//              child: DropdownButton<String>(
//                hint: new Text('Number plate'),
//               value: dropdownValue,
//                isDense: true,
//                onChanged: (String newValue) {
//                  setState(() {
//                    dropdownValue = newValue;
//                    state.didChange(newValue);
//                  });
//                },
//                items: <String>['One', 'Two', 'Three', 'Four']
//                    .map<DropdownMenuItem<String>>((String value) {
//                  return DropdownMenuItem<String>(
//                    value: value,
//                    child: Text(value),
//                  );
//                })
//                    .toList(),
//              ),
//            ),
//          );
//        },
//      );
//    final btnSubmit = RaisedButton(
//      color: Colors.white,
//      onPressed:(){
//        Navigator.push(context, MaterialPageRoute(builder: (context)=> TripDeta()));
//      },
//      child: Text("Submit", style: new TextStyle(
//        color: Colors.yellow,
//        fontSize: 18.00,
//      ),
//      ),
//      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
//
//    );
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF258EA3),
      ),
//      appBar: new AppBar(
//          title: new Text("Sacco App")
//      ),

      body: currentPage,
//      new Center(

//        child:

//        new ListView(
//          shrinkWrap: true,
//          padding: EdgeInsets.only(left: 25.0, right: 25.0),
//          children: <Widget>[
//            new Text(strStringData,
//              style: new TextStyle(
//                  color: Color.fromARGB(0xFF, 0x42, 0xA5, 0xF5) ,
//                  fontSize: 40.00
//              ),
//            ),
//
//            SizedBox(height: 20.0,
//            ),
//            txtRoute,
//            SizedBox(height: 8.0,),
//            txtTime,
//            SizedBox(height: 8.0,),
//            txtAmount,
//            SizedBox(height: 8.0,),
//            txtPassengers,
//            SizedBox(height: 8.0,),
//            txtNumberPlate,
//            SizedBox(height: 8.0,),
//            txtStation,
//            SizedBox(height: 8.0,),
//            txt,
//            SizedBox(height: 20.0,),
//            btnSubmit
//
//          ],
//        ),
//      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab,
          onTap: (int index){
            setState(() {
              currentTab = index;
             currentPage = pages[index];
            });

          },
          items: [
            BottomNavigationBarItem(
                title: Text("Add trip details"),
                icon: Icon(Icons.add)
            ),
            BottomNavigationBarItem(
              title: Text("View Details"),
              icon: Icon(Icons.remove_red_eye)
            ),
          ],
      ),
    );
  }



}
class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  String strStringData = "Trip Details";
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    final txtRoute = TextField(
      decoration: InputDecoration(
          hintText: "Route",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
    );
    final txtPassengers = TextField(
      decoration: InputDecoration(
          hintText: "Number of Passengers",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
    );
    final txtAmount = TextField(
      decoration: InputDecoration(
          hintText: "Fare",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
    );
    final txtStation = TextField(
      decoration: InputDecoration(
          hintText: "Station",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
    );
    final txtDriver = TextField(
      decoration: InputDecoration(
          hintText: "Name of driver",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
    );
    final txtConductor = TextField(
      decoration: InputDecoration(
          hintText: "Name of conductor",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
    );
    final txtAsset = FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 3.0),
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
              hintText: 'Please select expense',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
          isEmpty: dropdownValue == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: new Text('Number plate'),
              value: dropdownValue,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                  state.didChange(newValue);
                });
              },
              items: <String>['One', 'Two', 'Three', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),
          ),
        );
      },
    );
    final btnSubmit = RaisedButton(
      color: Colors.white,
//      onPressed:(){
//        Navigator.push(context, MaterialPageRoute(builder: (context)=> TripDeta()));
        onPressed: () => _showToast(context),
//      },
      child: Text("Submit", style: new TextStyle(
        color: Colors.yellow,
        fontSize: 18.00,
      ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,

    );
    return new Center(


          child : new ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 25.0, right: 25.0),


            children: <Widget>[
              new Text(strStringData,
                style: new TextStyle(

                    color: Color.fromARGB(0xFF, 0x42, 0xA5, 0xF5) ,
                    fontSize: 40.00
                ),
              ),

              SizedBox(height: 20.0,
              ),
              txtRoute,
              SizedBox(height: 8.0,),
              txtPassengers,
              SizedBox(height: 8.0,),
              txtAmount,
              SizedBox(height: 8.0,),
              txtStation,
              SizedBox(height: 8.0,),
              txtDriver,
              SizedBox(height: 8.0,),
              txtConductor,
              SizedBox(height: 8.0,),
              txtAsset,
              SizedBox(height: 20.0,),
              btnSubmit

            ],
          ),
        );

  }
  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Trip details saved'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}

class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  Trip tripFromJson(String str){
    final jsonData = json.decode(str);
    return Trip.fromJson(jsonData);
  }
  String tripToJson(Trip data){
    final dyn = data.toJson();
    return json.encode(dyn);
  }


  String url = 'https://prodevmatatu.herokuapp.com/api/trip';


  Future<Trip> _getTrips() async{
    final response = await http.get(url);
    print(response.body);
    return tripFromJson(response.body);

  }
  Future<http.Response> createPost(Trip trip) async{
    final response = await http.post('$url',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader : ''
        },
        body: tripToJson(trip)
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(

        child: FutureBuilder(
            future: _getTrips(),
            builder:(BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.connectionState==ConnectionState.done && snapshot.data != null){
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                          title: Text(snapshot.data[index].route)
                      ),
                    );
                  },
                );

              }else {
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              }
            } )
    );
//      MaterialApp(
//        debugShowCheckedModeBanner: false,
//        title: "Matatu Sacco",
//        home: new Text("Hello"),
//        theme: new ThemeData(
//            brightness: Brightness.light,
//            primaryColor: Colors.tealAccent
//        )
//    );
  }


}


class Trip {
  String status;
  List<Datum> data;

  Trip({
    this.status,
    this.data,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => new Trip(
    status: json["status"],
    data: new List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": new List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int fare;
  String station;
  String driver;
  int id;
  DateTime time;
  String route;
  String staffName;
  int passengers;
  String conductor;

  Datum({
    this.fare,
    this.station,
    this.driver,
    this.id,
    this.time,
    this.route,
    this.staffName,
    this.passengers,
    this.conductor,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => new Datum(
    fare: json["fare"],
    station: json["station"],
    driver: json["driver"],
    id: json["id"],
    time: DateTime.parse(json["time"]),
    route: json["route"],
    staffName: json["staff_name"],
    passengers: json["passengers"],
    conductor: json["conductor"],
  );

  Map<String, dynamic> toJson() => {
    "fare": fare,
    "station": station,
    "driver": driver,
    "id": id,
    "time": time.toIso8601String(),
    "route": route,
    "staff_name": staffName,
    "passengers": passengers,
    "conductor": conductor,
  };
}
