import 'package:flutter/material.dart';
import 'package:flutter_app/recordsPage.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
              items: <String>['KBH897T', 'KBC348P', 'KBY675E', 'KAW234L']
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
//        Navigator.push(context, MaterialPageRoute(builder: (context)=> RecordsPage()));
//      },
      onPressed: () => _showToast(context),
      child: Text("Submit", style: new TextStyle(
        color: Colors.yellow,
        fontSize: 18.00,
      ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,

    );
    return   new Center(
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
  Future<List<Trip>> _getTrips() async{
    var data = await http.get("https://prodevmatatu.herokuapp.com/api/trip");
    var jsonData = json.decode(data.body);
    List<Trip> trips = [];
    for(var t in jsonData){
      Trip trip = Trip(t["station"], t["number_plate"], t["passengers"], t["id"], t["time"], t["route"], t["fare"]);
      trips.add(trip);
    }
    print(trips.length);
    return trips;
  }
  @override
  Widget build(BuildContext context) {
    return  Container(

        child: FutureBuilder(
            future: _getTrips(),
            builder:(BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data==null){
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              }else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(snapshot.data[index].route),
                    );
                  },
                );
              }
            } )
    );
  }
}
class Trip{
  final String station;
  final String number_plate;
  final int passengers;
  final int id;
  final String time;
  final String route;
  final int fare;
  Trip(this.station, this.number_plate, this.passengers, this.id, this.time, this.route, this.fare);
}





