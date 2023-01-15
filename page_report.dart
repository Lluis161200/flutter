import 'package:flutter/material.dart';

List<String> list_period = <String>['Today','Yesterday','Last week', 'This week','Other'];
List<String> list_content = <String>['Brief','Detail','Statistic'];
List<String> list_format = <String>['Web page','PDF','Text'];


class PageReport extends StatefulWidget {
  const PageReport({Key? key}) : super(key: key);

  @override
  State<PageReport> createState() => _PageReportState();
}
class _PageReportState extends State<PageReport> {
  //get onChanged => null;

  String firstElementPeriod = list_period.first;
  String firstElementContent = list_content.first;
  String firstElementFormat = list_format.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      body:Container(
        //padding: const EdgeInsets.all(16.0),
        child:Padding(
          padding: const EdgeInsets.all(50.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Container(
                  child:Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text('Period  '),
        )

                ),
                DropdownButton(
                  value: firstElementPeriod,
                  items: list_period.map((String i) {
                    return DropdownMenuItem(
                      value: i,
                      child: Text(i),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dateFrom = DateTime.now();
                      if(newValue==list_period.elementAt(0)){
                        //today
                        dateFrom=DateTime.now();
                        dateTo=DateTime.now();
                      }
                      if(newValue==list_period.elementAt(1)){

                        dateFrom=DateTime.now();
                        dateTo=DateTime.now();
                        //yesterday
                        dateFrom= dateFrom.subtract(Duration(days: 1));
                        dateTo=dateTo.subtract(Duration(days:1));
                      }
                      if(newValue==list_period.elementAt(2)){
                        //last week
                        dateFrom= DateTime(dateFrom.year,dateFrom.month,dateFrom.day-dateFrom.weekday+1).subtract(
                            new Duration(days:7));
                      }
                      if(newValue==list_period.elementAt(3)){
                        //this week
                        dateFrom=DateTime.now();
                        dateTo=DateTime.now();
                        dateFrom= DateTime(dateFrom.year,dateFrom.month,dateFrom.day-dateFrom.weekday+1);
                        dateTo= DateTime(dateFrom.year,dateFrom.month,dateFrom.day-dateFrom.weekday+7);
                      }
                      firstElementPeriod = newValue!;
                    });
                  },)
              ],
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child:Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text('From  '),
            )

                ),
                Text(
                  '${dateFrom.year}/${dateFrom.month}/${dateFrom.day}',
                ),
                IconButton(
                    onPressed: () async{
                      DateTime ? newDate= await showDatePicker(
                        context: context,
                        initialDate: dateFrom,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2030),
                      );
                      if (newDate==null){
                        return;
                      }
                      setState(() {
                        dateFrom=newDate;
                      });
                    },
                    icon: Icon(Icons.calendar_month))
              ],
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child:Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text('To  '),
    )

                ),
                Text(
                  '${dateTo.year}/${dateTo.month}/${dateTo.day}',
                ),
                IconButton(
                    onPressed: () async{
                      DateTime ? newDate= await showDatePicker(
                        context: context,
                        initialDate: dateTo,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2030),
                      );
                      if (newDate==null){
                        return;
                      }
                      setState(() {
                        dateTo=newDate;
                      });
                    },
                    icon: Icon(Icons.calendar_month))
              ],
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child:Padding(
                  padding: const EdgeInsets.all(30.0),
                    child: Text('Content  '),
                )
                ),
                DropdownButton(
                  value: firstElementContent,
                  items: list_content.map((String i) {
                    return DropdownMenuItem(
                      value: i,
                      child: Text(i),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      firstElementContent = newValue!;
                    });
                  },)
              ],
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text('Format  '),

    )

                ),
                DropdownButton(
                  value: firstElementFormat,
                  items: list_format.map((String i) {
                    return DropdownMenuItem(
                      value: i,
                      child: Text(i),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      firstElementFormat = newValue!;
                    });
                  },)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      if(dateTo.isBefore(dateFrom)){
                        _showMyDialog();
                      }else{
                        print("reporte creado");
                      }
                    },
                    child: const Text('Generate'),),

                ),

              ],

            ),





















          ],
        ),
        )



      ),
    );
  }
  DateTime dateFrom  = DateTime.now();

  DateTime dateTo  = DateTime.now();


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Range Dates'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('The From date is after the To Date'),
                Text('Please select a New Date'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ACCEPT'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
