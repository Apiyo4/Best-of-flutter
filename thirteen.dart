import 'dart:io';
import 'package:flutter/services.dart';
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
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF258EA3),
      ),

      body: currentPage,
//
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
  final formKey = GlobalKey<FormState>();



  static final CREATE_TRIP_URL = 'https://prodevmatatu.herokuapp.com/api/trip';
  TextEditingController routeController = new TextEditingController();
  TextEditingController passengersController = new TextEditingController();
  TextEditingController fareController = new TextEditingController();
  TextEditingController stationController = new TextEditingController();
  TextEditingController driverController = new TextEditingController();
  TextEditingController conductorController = new TextEditingController();
  TextEditingController numberPlateController = new TextEditingController();
  TextEditingController staffNameController = new TextEditingController();
  String url = 'https://prodevmatatu.herokuapp.com/api/trip';
  Future<String> makeRequest() async {
    var response = await http
        .post(Uri.encodeFull(url), body: json.encode({

      "driver": driverController.text,
      "conductor": conductorController.text,
      "route": routeController.text,
      "passengers": passengersController.text,
      "staff_name": staffNameController.text,
      "station": stationController.text,
      "fare": fareController.text,
    }), headers: { "content-type" : "application/json",
      "accept" : "application/json",});

    print(response.body);

  }


  @override
  Widget build(BuildContext context) {
    final txtRoute = TextFormField(
      autocorrect: false,
      controller: routeController,
      decoration: InputDecoration(
          labelText: "Route",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
      validator: (str)=> str.length <=5 ? "Not a valid route!" : null,
    );
    final txtStaffNameController = TextFormField(
      autocorrect: false,
      controller: staffNameController,
      decoration: InputDecoration(
          labelText: "Sacco Employee Name",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
      validator: (str)=> str.length <=5 ? "Not a valid route!" : null,
    );
    final txtPassengers = TextFormField(
      autocorrect: false,
      controller: passengersController,
      decoration: InputDecoration(
          labelText: "Number of Passengers",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
      validator: (str)=> str.length < 1 ? "Not a valid number of passengers!" : null,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
    );
    final txtAmount = TextFormField(
      autocorrect: false,
      controller: fareController,
      decoration: InputDecoration(
          labelText: "Fare",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
      validator: (str)=> str.length < 1? "Not a valid fare!" : null,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
    );
    final txtStation = TextFormField(
      autocorrect: false,
      controller: stationController,
      decoration: InputDecoration(
          labelText: "Station",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
      validator: (str)=> str.length <=5 ? "Not a valid station!" : null,
    );
    final txtDriver = TextFormField(
      autocorrect: false,
      controller: driverController,
      decoration: InputDecoration(
          labelText: "Name of driver",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
      validator: (str)=> str.length <=5 ? "Not a valid name for driver!" : null,
    );
    final txtConductor = TextFormField(
      controller: conductorController,
      autocorrect: false,
      decoration: InputDecoration(
          labelText: "Name of conductor",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
      validator: (str)=> str.length <=5 ? "Not a valid name for conductor!" : null,
    );
    final txtAsset = FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 3.0),
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
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

      onPressed: () async {

        var form = formKey.currentState;
        if(form.validate()){
          makeRequest();
          return  _showToast(context);

        }

      },
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
          children:    <Widget>[
            new Text(strStringData,
              style: new TextStyle(

                  color: Color.fromARGB(0xFF, 0x42, 0xA5, 0xF5) ,
                  fontSize: 40.00
              ),
            ),

            new Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
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
                  txtStaffNameController,
                  SizedBox(height: 20.0,),
                  txtAsset,
                  SizedBox(height: 20.0,),
                  btnSubmit
                ],
              ),

            )

          ]

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


  final String url = 'https://prodevmatatu.herokuapp.com/api/trip';
  List data;
  bool _isLoading = true;

  Future<String> getTrips() async {
    var res = await http.get(
        Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["data"];
      _isLoading = false;
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Records'),
        ),
        body: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar:
        AppBar(

          title: Text("Records",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),),

        ),
        body:
        ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                          child: Container(

                              padding: EdgeInsets.all(15.0),
                              child: Center(
                                child: Column(
                                  children: <Widget>[

                                    Row(
                                      children: <Widget>[
                                        Text("Time : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(data[index]["time"],
                                          style: TextStyle(fontSize: 18),)
                                      ],

                                    ),
                                    SizedBox(height: 8.0,),
                                    Row(
                                      children: <Widget>[
                                        Text("Sacco staff : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),),
                                        Text(data[index]["staff_name"],
                                          style: TextStyle(fontSize: 18),)
                                      ],

                                    ),
                                    SizedBox(height: 8.0,),
                                    Row(
                                      children: <Widget>[
                                        Text("Route : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),),
                                        Text(data[index]["route"],
                                          style: TextStyle(fontSize: 18),)
                                      ],

                                    ),
                                    SizedBox(height: 8.0,),
                                    Row(
                                      children: <Widget>[
                                        Text("Driver : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),),
                                        Text(data[index]["driver"],
                                          style: TextStyle(fontSize: 18),)
                                      ],

                                    ),
                                    SizedBox(height: 8.0,),
                                    Row(
                                      children: <Widget>[
                                        Text("Conductor : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),),
                                        Text(data[index]["conductor"],
                                          style: TextStyle(fontSize: 18),)
                                      ],

                                    ),

                                    SizedBox(height: 8.0,),
                                    Row(
                                      children: <Widget>[
                                        Text("Station: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),),
                                        Text(data[index]["station"],
                                          style: TextStyle(fontSize: 18),)

                                      ],


                                    ),
                                    SizedBox(height: 8.0,),
                                    Row(
                                      children: <Widget>[
                                        Text("Fare : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),),
                                        Text((data[index]["fare"]).toString(),
                                          style: TextStyle(fontSize: 18),)
                                      ],

                                    ),
                                    SizedBox(height: 8.0,),
                                    Row(
                                      children: <Widget>[
                                        Text("Passengers : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),),
                                        Text((data[index]["passengers"])
                                            .toString(),
                                          style: TextStyle(fontSize: 18),)
                                      ],

                                    )

                                  ],

                                ),
                              )

                          )
                      )
                    ],
                  ),

                ),
              );
            }),

      );
    }
  }

  @override
  void initState() {
    super.initState();
    this.getTrips();
  }


//
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
