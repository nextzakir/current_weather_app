import 'package:current_weather_app/model/current_weather_model.dart';
import 'package:current_weather_app/network/network.dart';
import 'package:current_weather_app/util/convert_img.dart';
import 'package:current_weather_app/util/current_weather_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentWeather extends StatefulWidget {
  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  Future<CurrentWeatherModel> currentWeatherObj;
  String _cityName = "Sylhet";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentWeatherObj = getWeather(cityName: _cityName);

    // currentWeatherObj.then((obj) => {print(obj.name)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          "Current Weather Condition",
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
            child: Card(
              elevation: 1.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: "Enter City Name",
                  hintText: "Type Here...",
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                onSubmitted: (value) {
                  setState(() {
                    _cityName = value;
                    currentWeatherObj = getWeather(cityName: _cityName);
                  });
                },
              ),
            ),
          ),
          FutureBuilder<CurrentWeatherModel>(
            future: currentWeatherObj,
            builder: (BuildContext context,
                AsyncSnapshot<CurrentWeatherModel> snapshot) {
              if (snapshot.hasData) {
                return _currentWeatherView(context, snapshot);
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 270,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<CurrentWeatherModel> getWeather({String cityName}) =>
      Network().getCurrentWeather(cityName: _cityName);

  Widget _currentWeatherView(
      BuildContext context, AsyncSnapshot<CurrentWeatherModel> snapshot) {
    var dateTime =
        new DateTime.fromMillisecondsSinceEpoch(snapshot.data.dt * 1000);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
          child: Center(
            child: Text(
              "${snapshot.data.weather[0].description}".toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Card(
                elevation: 1.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * .60,
                  height: 260,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        "images/cloud.png",
                        width: 200,
                      ),
                      Text(
                        "${snapshot.data.name}, ${snapshot.data.sys.country}",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "${Util.getFormattedDate(dateTime)}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Card(
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .335,
                      height: 126,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "images/thermometer.png",
                              height: 35,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${snapshot.data.main.temp}°C",
                              style: TextStyle(
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .335,
                      height: 126,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: getDynamicImg(snapshot.data.weather[0].main),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Card(
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 22.0),
              height: 60,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset(
                          "images/humidity.png",
                          height: 20,
                        ),
                        Text(
                          "${snapshot.data.main.humidity}%",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Image.asset(
                          "images/wind.png",
                          height: 20,
                        ),
                        Text(
                          "${snapshot.data.wind.speed} km/h",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Image.asset(
                          "images/thermometer.png",
                          height: 20,
                        ),
                        Text(
                          "${snapshot.data.main.tempMax}°C",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
