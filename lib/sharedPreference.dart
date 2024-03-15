import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SharedPreference extends StatefulWidget {
  const SharedPreference({super.key});

  @override
  State<SharedPreference> createState() => _SharedPreferenceState();
}

class _SharedPreferenceState extends State<SharedPreference> {
  String name="";
  int age=0;
   List<String>? valueGetList=[];
  List<String> valueSetList=["aa","bb","cc"];
  // var latitude;
  // var longitude;

@override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async{
  SharedPreferences sp= await SharedPreferences.getInstance();//opens the app after closing we get locally stored data.
  name = sp.getString("keyname")??'';
  age = sp.getInt("keyage") ?? 0;
  valueGetList = sp.getStringList("listt")?? [];
  setState(() {

  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shared_Preference "),),
      body: Column(
        children: [
        Text(name.toString()),
          Text(age.toString()),
        Container(
          color: Colors.yellow,
          height: 100,
          child:  ListView.builder(
              itemCount: valueGetList?.length,
              itemBuilder: (context , index)
              {
               return Text("${valueGetList?[index]}");
              }) ,
        ),
          ElevatedButton(onPressed: (){
            _calculateDistance();
          }, child: Text("tap"))

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          SharedPreferences sp= await SharedPreferences.getInstance();
          sp.setInt("keyage", 25);
          sp.setString("keyname", "Rohan");
          sp.setBool("cc", true);
          sp.setDouble("keySal", 1.1);
          sp.setStringList("listt",valueSetList);
          name= sp.getString("keyname")??"";//creates the variable and stores data in this
          print("listt--${sp.getStringList("listt")}");
    },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<double> _calculateDistance() async {
    final distance = await Geolocator.distanceBetween(19.0715487, 73.0285745 , 19.284759 ,73.022082);
    print("distance--${distance}");
    print("distancemt--${distance*1000}");
    print("distancemtKM--${distance/1000}");
   return distance;
  }
}
