import 'package:flutter/material.dart';
import './views/chart_component.dart';

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
  List<String> currencies = ["EURO"];
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 45,
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(
                  'assets/images/eu.png',
                  fit: BoxFit.fill,
                ),
              ),
              Container(margin: EdgeInsets.only(left: 5), child: Text("EURO")),
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.compare_arrows,
                  color: Colors.blue,
                  size: 36.0,
                ),
              ),
              Container(
                width: 50,
                height: 45,
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(
                  'assets/images/global.png',
                  fit: BoxFit.fill,
                ),
              ),
              _buildDropDownButton("EURO"),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: 95,
              height: 35,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(border: Border.all()),
              child: Center(
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: TextStyle(color: Colors.black45)),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Container(
              width: 95,
              height: 35,
              margin: EdgeInsets.only(right: 10),
              decoration:
                  BoxDecoration(border: Border.all(), color: Colors.black12),
              child: Center(
                child: Text(
                  "0",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 30,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                width: 100,
                height: 35,
                decoration: BoxDecoration(border: Border.all()),
                child: Center(
                  child: Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(
              width: 100,
              height: 35,
              decoration:
                  BoxDecoration(border: Border.all(), color: Colors.black12),
              child: Center(
                child: Text(
                  DateTime.now().toLocal().toString().split(' ')[0],
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]),
          SizedBox(height: 10),
          ChartComponent()
        ]),
      ),
    );
  }

  Widget _buildDropDownButton(String currencyCategory) {
    return DropdownButton(
      value: currencyCategory,
      items: currencies
          .map((String value) => DropdownMenuItem(
                value: value,
                child: Row(
                  children: <Widget>[
                    Text(value),
                  ],
                ),
              ))
          .toList(),
      onChanged: (String value) {},
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}