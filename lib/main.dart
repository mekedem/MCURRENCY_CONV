import 'package:flutter/material.dart';
import './views/chart_component.dart';
import './utils/controller.dart';
import 'package:dropdown_search/dropdown_search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCURRENCY_CONV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Currency converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> currenciewithrate = {"EUR": 1};
  Map<String, dynamic> symbolcurrency = {};
  DateTime selectedDate = DateTime.now();
  ControllerComponent controllerComponent;
  String selectedCurrency = "EUR";
  double fromAmount = 0;
  String toAmount = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadInitialData();
  }

  Future loadInitialData() async {
    controllerComponent = ControllerComponent();
    currenciewithrate = await controllerComponent.loadInitialData();
    symbolcurrency = await controllerComponent.loadsymbols();
    // controllerComponent.flactuationData('2016-12-24', '2013-12-24');
    setState(() {});
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(children: [
            Row(
              children: [
                _euroImageContainer(),
                _euroLabel(),
                _exchangeContainer(),
                // _targetImageContainer(),
                // _buildDropDownButton(selectedCurrency),
              ],
            ),
            DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItem: true,
                items: currenciewithrate.keys.toList(),
                label: "target currency",
                hint: "country in menu mode",
                popupItemDisabled: (String s) => s.startsWith('I'),
                onChanged: (val) {
                  setState(() {
                    selectedCurrency = val;
                  });
                },
                showSearchBox: true,
                selectedItem: selectedCurrency),
            // Row(
            //   children: [
            //     // _targetImageContainer(),
            //     // _buildDropDownButton(selectedCurrency),
            //   ],
            // ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                width: 95,
                height: 42,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(border: Border.all()),
                child: Center(
                  child: TextField(
                    key: Key("SearchInput"),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: '',
                        hintStyle: TextStyle(color: Colors.black45)),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      fromAmount = double.parse(value);
                      calculateConversion();
                    },
                  ),
                ),
              ),
              _targetResultDesplay()
            ]),
            SizedBox(
              height: 30,
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildDropDownButton(String initialCurrency) {
    return DropdownButton(
      value: initialCurrency,
      items: currenciewithrate.keys
          .toList()
          .map((String value) => DropdownMenuItem(
                value: value,
                child: Row(
                  children: <Widget>[
                    Text(value),
                  ],
                ),
              ))
          .toList(),
      onChanged: (String value) {
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  void calculateConversion() {
    double result =
        double.parse(currenciewithrate[selectedCurrency].toString()) *
            fromAmount;
    setState(() {
      toAmount = result.toString();
    });
  }

  _euroImageContainer() {
    return Container(
      width: 50,
      height: 45,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Image.asset(
        'assets/images/eu.png',
        fit: BoxFit.fill,
      ),
    );
  }

  _euroLabel() {
    return Container(margin: EdgeInsets.only(left: 5), child: Text("EUR"));
  }

  _targetImageContainer() {
    return Container(
      width: 50,
      height: 45,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Image.asset(
        'assets/images/global.png',
        fit: BoxFit.fill,
      ),
    );
  }

  _exchangeContainer() {
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Icon(
        Icons.compare_arrows,
        color: Colors.blue,
        size: 36.0,
      ),
    );
  }

  _targetResultDesplay() {
    return Container(
      width: 100,
      height: 42,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(border: Border.all(), color: Colors.black12),
      child: Center(
        child: Text(
          toAmount,
          key: Key("outputkey"),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
