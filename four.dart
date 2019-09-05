import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sacco/json/response.dart';
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
  @override
  Widget build(BuildContext context) {
    final txtRoute = TextFormField(
      autocorrect: false,
      decoration: InputDecoration(
          labelText: "Route",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
      validator: (str)=> str.length <=5 ? "Not a valid route!" : null,
    );
    final txtPassengers = TextFormField(
      autocorrect: false,
      decoration: InputDecoration(
          labelText: "Number of Passengers",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
      validator: (str)=> str.length < 1 ? "Not a valid number of passengers!" : null,
    );
    final txtAmount = TextFormField(
      autocorrect: false,
      decoration: InputDecoration(
          labelText: "Fare",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
      validator: (str)=> str.length < 1? "Not a valid fare!" : null,
    );
    final txtStation = TextFormField(
      autocorrect: false,
      decoration: InputDecoration(
          labelText: "Station",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
      validator: (str)=> str.length <=5 ? "Not a valid station!" : null,
    );
    final txtDriver = TextFormField(
      autocorrect: false,
      decoration: InputDecoration(
          labelText: "Name of driver",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius:BorderRadius.circular(30.0))
      ),
      validator: (str)=> str.length <=5 ? "Not a valid name for driver!" : null,
    );
    final txtConductor = TextFormField(
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

        onPressed: () {
         var form = formKey.currentState;
         if(form.validate()){
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
//        action: SnackBarAction(
//            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
    );
  }
}

class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
  PageTwo({Key key, this.title}) : super(key: key);
  final String title;

}

class _PageTwoState extends State<PageTwo> {


//  Trip trips = Trip(id, staffName, passengers, time, station, driver, conductor, route, fare);
  Trip trips = Trip();

  bool _isLoading = true;
  List<Trip> _trips = [];

  @override
  void initState() {
    super.initState();
    fetchTrips();
  }

  Future fetchTrips() async {
    _trips = await TripRepository.fetchAll();
    setState(() {
      _isLoading = false;
    });
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
        appBar: AppBar(
          title: Text('Records'),
        ),
        body: ListView.builder(
          itemCount: _trips.length,
          itemBuilder: (context, index) {
            Trip trip = _trips[index];
            return ListTile(
              title: Text(trip.route),
              subtitle: Text(trip.staffName),

            );
          },
        ),
      );
    }
  }
}
class TripRepository {

  static Future<List<Trip>> fetchAll() async {
    String query = '';
    String url = Uri.encodeFull("https://prodevmatatu.herokuapp.com/api/trip" + query);
    final response = await http.get(url);
    if (response.statusCode == 200) {
    List<Trip> trip = BaseResponse
        .fromJson(json.decode(response.body))
        .trips
        .map((trip) {
          return Trip.fromResponse(trip);
        })
        .toList();
    print(trip);

      return trip;
    } else {
      return [];
    }


  }
}
