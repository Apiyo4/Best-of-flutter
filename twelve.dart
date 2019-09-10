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
