import 'package:flutter/material.dart';
// import 'package:weather_icons/weather_icons.dart';
import 'dart:async';
import 'dart:convert';

import 'package:weather_icons/weather_icons.dart';
import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';


class WeatherDemo extends StatefulWidget {
  @override
  _WeatherDemoState createState() => _WeatherDemoState();
}

class _WeatherDemoState extends State<WeatherDemo> {
  int _currentIndex = 0;
  String _cityGet;
  double _cityLat;
  double _cityLon;

  @override
  void initState() {
    super.initState();
    // initializeDateFormatting();
  }

  final List<Widget> _children = [
    MyScrollView('hourly'),
    MyScrollView('daily')
  ];


  Future _changeCity(BuildContext context) async {
    Map results = await Navigator.of(context)
        .push(new MaterialPageRoute<Map>(builder: (BuildContext context) {
      return new CityPage();
    }));
    if (results != null && results.containsKey('enter')) {
      _cityGet = '${results['enter']}, ${results['code']}';
      _cityLat = results['lat'];
      _cityLon = results['lon'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //todo: change colors
        //todo: set theme styles for text

        //todo: maybe delete appbar?
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_city),
          backgroundColor: Theme.of(context).accentColor,
          onPressed: () => MyScrollView('hourly')._changeCity(context),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              backgroundColor: Colors.grey.shade900,
              selectedItemColor: Colors.yellow.shade600,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.watch_later),
                    title: Text('Hodinová predpoveď')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today),
                    title: Text('Denná predpoveď')),
              ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _children[_currentIndex]);
    //backgroundColor: Colors.grey.shade700);
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class CityPage extends StatelessWidget {
  var _cityController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.grey.shade900,
          title: new Text('Zmeniť mesto',
              style: new TextStyle(color: Theme.of(context).accentColor)),
          centerTitle: true,
        ),
        body: new Container(
          color: Theme.of(context).primaryColor,
          child: new ListView(
            children: <Widget>[
              new ListTile(
                title: new TextField(
                  decoration: new InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Mesto'),
                  controller: _cityController,
                  keyboardType: TextInputType.text,
                ),
              ),
              new ListTile(
                title: new FlatButton(
                  splashColor: Colors.blueAccent,
                  textColor: Colors.white70,
                  child: new Text('Zmeniť'),
                  onPressed: () async {
                    List geoData = await convertCity(_cityController.text);
                    var lat = geoData[0]['lat'];
                    var lon = geoData[0]['lon'];
                    var countryCode =
                        geoData[0]['address']['country_code'].toUpperCase();
                    Navigator.pop(context, {
                      'enter': _cityController.text,
                      'lat': lat,
                      'lon': lon,
                      'code': countryCode
                    });
                  },
                ),
              )
            ],
          ),
        ));
  }
}



class MyScrollView extends StatelessWidget {
  final String interval;
  String _cityName;
  var _cityLat;
  var _cityLon;

  MyScrollView(this.interval);

  Future _changeCity(BuildContext context) async {
    Map results = await Navigator.of(context)
        .push(new MaterialPageRoute<Map>(builder: (BuildContext context) {
      return new CityPage();
    }));
    if (results != null && results.containsKey('enter')) {
      print(results);
      _cityName = '${results['enter']}, ${results['code']}';
      _cityLat = results['lat'];
      _cityLon = results['lon'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return new CustomScrollView(
      slivers: <Widget>[
        new SliverAppBar(
          brightness: Brightness.dark,
          centerTitle: true,
          title: Text(
            _cityName == null ? 'Liptovský Mikuláš, SK' : _cityName,
            style: new TextStyle(fontSize: 17.5, fontWeight: FontWeight.w200),
          ),
          expandedHeight: 300,
          floating: true,
          pinned: true,
          snap: true,
          flexibleSpace: FlexibleSpaceBar(
              background: new Container(
            child: updateCurrentWeather(),
          )),
        ),
        FutureBuilder(
          future: _cityLat == null || _cityLon == null
              ? getWeather(49.083351, 19.609819)
              : getWeather(_cityLat, _cityLon),
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
            var forecast = snapshot.data;
            var childrenCount = 0;
            if (snapshot.connectionState != ConnectionState.done ||
                snapshot.hasData == null)
              childrenCount = 1;
            else if (interval == 'hourly') {
              childrenCount = 24;
            } else {
              childrenCount = 8;
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (snapshot.connectionState != ConnectionState.done) {
                  //todo handle state
                  return Container(); //todo set progress bar
                }
                if (snapshot.hasData == null) {
                  return Container();
                }

                var tempMax =
                    forecast['$interval']['data'][index]['temperatureMax'];
                var tempMin =
                    forecast['$interval']['data'][index]['temperatureMin'];

                var temperature =
                    forecast['$interval']['data'][index]['temperature'];

                String icon = forecast['$interval']['data'][index]['icon'];
                var template = "Hm";// new DateFormat('Hm');
                int hour = forecast['$interval']['data'][index]['time'];
                var hourObject =
                    new DateTime.fromMillisecondsSinceEpoch(hour * 1000);
                String time = "time"; //template.format(hourObject);

                // initializeDateFormatting('sk');
                var templateDay = "EEE";// new DateFormat('EEEE','sk');
                int dayData = forecast['$interval']['data'][index]['time'];
                var dayObject =
                    new DateTime.fromMillisecondsSinceEpoch(dayData * 1000);

                String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

                String dayUncap = "dayUncap";// templateDay.format(dayObject);

                String day = capitalize(dayUncap);

                String summary =
                    forecast['$interval']['data'][index]['summary'];
                var probability =
                    forecast['$interval']['data'][index]['precipProbability'];
                var precipitation =
                    forecast['$interval']['data'][index]['precipIntensity'];
                var humidity = forecast['$interval']['data'][index]['humidity'];
                var uv = forecast['$interval']['data'][index]['uvIndex'];
                var pressure = forecast['$interval']['data'][index]['pressure'];

                return Card(
                  margin: index == 0
                      ? EdgeInsets.fromLTRB(20, 6, 20, 3)
                      : EdgeInsets.fromLTRB(20, 3, 20, 3),
                  color: Colors.black12,
                  child: new ExpansionTile(
                    leading: Image.asset('images/$icon.png'),
                    trailing: new Text(
                      interval == 'hourly'
                          ? '${temperature.toStringAsFixed(0)}°'
                          : '${tempMin.toStringAsFixed(0)}° ${tempMax.toStringAsFixed(0)}°',
                      style: new TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.0),
                    ),
                    title: new RichText(
                        text: TextSpan(
                            text: interval == 'hourly' ? '$time  ' :
                            index==0? 'Dnes  ':
                            index==1? 'Zajtra  ':
                            '$day  ',
                            style: new TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16.0),
                            children: <TextSpan>[
                          TextSpan(
                              text: '$summary',
                              style: new TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 15.5))
                        ])),
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        //height: 80,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Container(
                                // TEMP STATS - HOUR
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: new Column(
                                  children: <Widget>[
                                    new Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 6),
                                        child: new Icon(
                                          WeatherIcons.thermometer,
                                          size: 20,
                                        )),
                                    new Text(
                                      interval == 'hourly'
                                          ? '${temperature.toStringAsFixed(0)}°'
                                          : '',
                                      style: new TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    new Text('Teplota',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0))
                                  ],
                                )),
                            new Container(
                                // RAIN STATS - HOUR
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: new Column(
                                  children: <Widget>[
                                    new Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 6),
                                        child: new Icon(
                                          WeatherIcons.umbrella,
                                          size: 20,
                                        )),
                                    new Text(
                                      '${(probability * 100).toStringAsFixed(0)}%',
                                      style: new TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    new Text(
                                        '${precipitation.toStringAsFixed(2)} mm',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0))
                                  ],
                                )),
                            new Container(
                                // HUMIDITY STATS - HOUR
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: new Column(
                                  children: <Widget>[
                                    new Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 6),
                                        child: new Icon(
                                          WeatherIcons.humidity,
                                          size: 20,
                                        )),
                                    new Text(
                                      '${(humidity * 100).toStringAsFixed(0)}%',
                                      style: new TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    new Text('Vlhkosť',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0))
                                  ],
                                )),
                            new Container(
                                // UV STATS - HOUR
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: new Column(
                                  children: <Widget>[
                                    new Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 6),
                                        child: new Icon(
                                          WeatherIcons.day_sunny,
                                          size: 20,
                                        )),
                                    new Text(
                                      'UV $uv',
                                      style: new TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    new Text('Žiarenie',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0))
                                  ],
                                )),
                            new Container(
                                // PRESSURE STATS - HOUR
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: new Column(
                                  children: <Widget>[
                                    new Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 6),
                                        child: new Icon(
                                          WeatherIcons.barometer,
                                          size: 20,
                                        )),
                                    new Text(
                                      '${pressure.toStringAsFixed(0)} hpa',
                                      style: new TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    new Text('Tlak',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0))
                                  ],
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }, childCount: childrenCount),
            );
          },
        )
      ],
    );
  }

  Widget updateCurrentWeather() {
    return new FutureBuilder(
        future: getWeather(49.083351, 19.609819),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            var temperature = content['currently']['temperature'];
            var probability = content['currently']['precipProbability'];
            var precipitation = content['currently']['precipIntensity'];
            var windSpeed = content['currently']['windSpeed'];
            int windBearing = content['currently']['windBearing'];
            var moonPhase = content['daily']['data'][0]['moonPhase'];
            var humidity = content['currently']['humidity'];
            String icon = content['currently']['icon'];
            //var template = new DateFormat('Hm','sk');
//            var timeFormat = new DateFormat.Hm('sk');
//            int sunrise = content['daily']['data'][0]['sunriseTime'];
//            var sunriseObject = new DateTime.fromMillisecondsSinceEpoch(sunrise*1000);
//            String sunriseTime = timeFormat.format(sunriseObject);
//            int sunset = content['daily']['data'][0]['sunsetTime'];
//            var sunsetObject = new DateTime.fromMillisecondsSinceEpoch(sunset);
//            String sunsetTime = timeFormat.format(sunsetObject);
            String direction;
            String phase;
            var windIcon;
            var moonIcon;
            if (windSpeed != 0) {
              if ((0 <= windBearing && windBearing <= 22.5) ||
                  (360 > windBearing && 337.5 < windBearing)) {
                direction = 'S';
                windIcon = WeatherIcons.wind_deg_180;
              } else if (22.5 < windBearing && windBearing <= 67.5) {
                direction = 'SV';
                windIcon = WeatherIcons.wind_deg_225;
              } else if (67.5 < windBearing && windBearing <= 112.5) {
                direction = 'V';
                windIcon = WeatherIcons.wind_deg_270;
              } else if (112.5 < windBearing && windBearing <= 157.5) {
                direction = 'JV';
                windIcon = WeatherIcons.wind_deg_315;
              } else if (157.5 < windBearing && windBearing <= 202.5) {
                direction = 'J';
                windIcon = WeatherIcons.wind_deg_0;
              } else if (202.5 < windBearing && windBearing <= 247.5) {
                direction = 'JZ';
                windIcon = WeatherIcons.wind_deg_45;
              } else if (247.5 < windBearing && windBearing <= 292.5) {
                direction = 'Z';
                windIcon = WeatherIcons.wind_deg_90;
              } else if (292.5 < windBearing && windBearing <= 337.5) {
                direction = 'SZ';
                windIcon = WeatherIcons.wind_deg_135;
              }
            } else {
              direction = '';
              windIcon = WeatherIcons.na;
            }

            if (moonPhase == 0) {
              moonIcon = WeatherIcons.moon_new;
              phase = 'Nov';
            } else if (0 < moonPhase && moonPhase < 0.25) {
              moonIcon = WeatherIcons.moon_alt_waxing_crescent_3;
              phase = 'Dorastá';
            } else if (moonPhase == 0.25) {
              moonIcon = WeatherIcons.moon_first_quarter;
              phase = '1. štvrť';
            } else if (0.25 < moonPhase && moonPhase < 0.5) {
              moonIcon = WeatherIcons.moon_alt_waxing_gibbous_3;
              phase = 'Dorastá';
            } else if (moonPhase == 0.5) {
              moonIcon = WeatherIcons.moon_full;
              phase = 'Spln';
            } else if (0.5 < moonPhase && moonPhase < 0.75) {
              moonIcon = WeatherIcons.moon_alt_waning_gibbous_3;
              phase = 'Cúva';
            } else if (moonPhase == 0.75) {
              moonIcon = WeatherIcons.moon_third_quarter;
              phase = '3. štvrť';
            } else {
              moonIcon = WeatherIcons.moon_waning_crescent_3;
              phase = 'Cúva';
            }

            return new Container(
              alignment: Alignment.topCenter,
              child: new Column(
                children: <Widget>[
                  new Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      new Container(
                          padding: const EdgeInsets.fromLTRB(25, 30, 140, 0),
                          child: new Image.asset(
                            'images/s_$icon.png',
                            width: 160,
                          )),
                      new Container(
                          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: new Image.asset('images/scene_blue.png')),
                    ],
                  ),
                  new Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0)),
                  new Row(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Container(
                          // TEMP STATS - CURRENT
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: new Column(
                            children: <Widget>[
                              new Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 6),
                                  child: new Icon(
                                    WeatherIcons.thermometer,
                                    size: 20,
                                  )),
                              new Text(
                                '${temperature.toStringAsFixed(0)}°',
                                style: new TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              new Text('Teplota',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14.0))
                            ],
                          )),
                      new Container(
                          // RAIN STATS - CURRENT
                          //padding: const EdgeInsets.fromLTRB(0, 220, 0, 0),
                          child: new Column(
                        children: <Widget>[
                          new Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                              child: new Icon(
                                WeatherIcons.umbrella,
                                size: 20,
                              )),
                          new Text(
                            '${(probability * 100).toStringAsFixed(0)}%',
                            style: new TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600),
                          ),
                          new Text('${precipitation.toStringAsFixed(2)} mm',
                              style: new TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 14.0))
                        ],
                      )),
                      new Container(
                          // HUMIDITY STATS - CURRENT
                          //padding: const EdgeInsets.fromLTRB(0, 220, 0, 0),
                          child: new Column(
                        children: <Widget>[
                          new Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                              child: new Icon(
                                WeatherIcons.humidity,
                                size: 20,
                              )),
                          new Text(
                            '${(humidity * 100).toStringAsFixed(0)}%',
                            style: new TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600),
                          ),
                          new Text('Vlhkosť',
                              style: new TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 14.0))
                        ],
                      )),
                      new Container(
                          // WIND STATS - CURRENT
                          //padding: const EdgeInsets.fromLTRB(0, 220, 0, 0),
                          child: new Column(
                        children: <Widget>[
                          new Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                              child: new Icon(
                                windIcon,
                                size: 20,
                              )),
                          new Text(
                            '${windSpeed.toStringAsFixed(1)} m/s',
                            style: new TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600),
                          ),
                          //todo: condition update - if wind speed == 0: wind bearing= none
                          new Text('$direction',
                              style: new TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 14.0))
                        ],
                      )),
                      new Container(
                          // MOON STATS - CURRENT
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: new Column(
                            children: <Widget>[
                              new Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 6),
                                  child: new Icon(
                                    moonIcon,
                                    size: 20,
                                  )),
                              new Text(
                                '$phase',
                                style: new TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              //todo: condition update - if wind speed == 0: wind bearing= none
                              new Text('Fáza',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14.0))
                            ],
                          )),
                      new Container()
                    ],
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }

  Future<Map> getWeather(double lat, double lon) async {
    String key = 'SECRET-KEY';
    //todo: switch to deploy key
    String apiUrl = 'https://api.darksky.net/forecast/0123456789abcdef9876543210fedcba/42.3601,-71.0589';
        // 'https://api.darksky.net/forecast/$key/$lat,$lon?lang=sk&units=si';
    http.Response response = await http.get(apiUrl);

    print(response.body);
    return json.decode(getWeatherResponse());
  }
}

void getCoords(lat, lon) {
  var lattitude = lat;
  var longtitude = lon;
  print('$lattitude');
}

Future<List> convertCity(String controller) async {
  var cityString = controller;
  List cityList = cityString.split(' ');
  String cityEntered = cityList.join('+');

  String key = 'SECRET-KEY';
  //todo: switch to deploy key
  // String apiUrl =
  //     'http://open.mapquestapi.com/nominatim/v1/search.php?key=$key&format=json&q=$cityEntered&addressdetails=1&limit=1&featureType=city';
  // http.Response response = await http.get(apiUrl);
  return json.decode(getCityResponse());
}


getWeatherResponse(){
  return '{"latitude":42.3601,"longitude":-71.0589,"timezone":"America/New_York","currently":{"time":1509993277,"summary":"Drizzle","icon":"rain","nearestStormDistance":0,"precipIntensity":0.0089,"precipIntensityError":0.0046,"precipProbability":0.9,"precipType":"rain","temperature":66.1,"apparentTemperature":66.31,"dewPoint":60.77,"humidity":0.83,"pressure":1010.34,"windSpeed":5.59,"windGust":12.03,"windBearing":246,"cloudCover":0.7,"uvIndex":1,"visibility":9.84,"ozone":267.44},"minutely":{"summary":"Light rain stopping in 13 min., starting again 30 min. later.","icon":"rain","data":[{"time":1509993240,"precipIntensity":0.007,"precipIntensityError":0.004,"precipProbability":0.84,"precipType":"rain"}]},"hourly":{"summary":"Rain starting later this afternoon, continuing until this evening.","icon":"rain","data":[{"time":1509991200,"summary":"Mostly Cloudy","icon":"partly-cloudy-day","precipIntensity":0.0007,"precipProbability":0.1,"precipType":"rain","temperature":65.76,"apparentTemperature":66.01,"dewPoint":60.99,"humidity":0.85,"pressure":1010.57,"windSpeed":4.23,"windGust":9.52,"windBearing":230,"cloudCover":0.62,"uvIndex":1,"visibility":9.32,"ozone":268.95}]},"daily":{"summary":"Mixed precipitation throughout the week, with temperatures falling to 39°F on Saturday.","icon":"rain","data":[{"time":1509944400,"summary":"Rain starting in the afternoon, continuing until evening.","icon":"rain","sunriseTime":1509967519,"sunsetTime":1510003982,"moonPhase":0.59,"precipIntensity":0.0088,"precipIntensityMax":0.0725,"precipIntensityMaxTime":1510002000,"precipProbability":0.73,"precipType":"rain","temperatureHigh":66.35,"temperatureHighTime":1509994800,"temperatureLow":41.28,"temperatureLowTime":1510056000,"apparentTemperatureHigh":66.53,"apparentTemperatureHighTime":1509994800,"apparentTemperatureLow":35.74,"apparentTemperatureLowTime":1510056000,"dewPoint":57.66,"humidity":0.86,"pressure":1012.93,"windSpeed":3.22,"windGust":26.32,"windGustTime":1510023600,"windBearing":270,"cloudCover":0.8,"uvIndex":2,"uvIndexTime":1509987600,"visibility":10,"ozone":269.45,"temperatureMin":52.08,"temperatureMinTime":1510027200,"temperatureMax":66.35,"temperatureMaxTime":1509994800,"apparentTemperatureMin":52.08,"apparentTemperatureMinTime":1510027200,"apparentTemperatureMax":66.53,"apparentTemperatureMaxTime":1509994800}]},"alerts":[{"title":"Flood Watch for Mason, WA","time":1509993360,"expires":1510036680,"description":"FLOOD WATCH REMAINS IN EFFECT THROUGH LATE MONDAY NIGHT\nTHE FLOOD WATCH CONTINUES FOR\n* A PORTION OF NORTHWEST WASHINGTON INCLUDING THE FOLLOWING\nCOUNTY MASON.\n* THROUGH LATE FRIDAY NIGHT\n* A STRONG WARM FRONT WILL BRING HEAVY RAIN TO THE OLYMPICS\nTONIGHT THROUGH THURSDAY NIGHT. THE HEAVY RAIN WILL PUSH THE\nSKOKOMISH RIVER ABOVE FLOOD STAGE TODAY AND MAJOR FLOODING IS\nPOSSIBLE.\n* A FLOOD WARNING IS IN EFFECT FOR THE SKOKOMISH RIVER. THE FLOOD\nWATCH REMAINS IN EFFECT FOR MASON COUNTY FOR THE POSSIBILITY OF\nAREAL FLOODING ASSOCIATED WITH A MAJOR FLOOD.\n","uri":"http://alerts.weather.gov/cap/wwacapget.php?x=WA1255E4DB8494.FloodWatch.1255E4DCE35CWA.SEWFFASEW.38e78ec64613478bb70fc6ed9c87f6e6"}]}';
}
getCityResponse(){
  return [
    {
        "place_id": "55567375",
        "licence": "Data © OpenStreetMap contributors, ODbL 1.0. http://www.openstreetmap.org/copyright",
        "osm_type": "way",
        "osm_id": "23580556",
        "boundingbox": [
            "51.4828405",
            "51.4847466",
            "-0.6083937",
            "-0.5999972"
        ],
        "lat": "51.48382",
        "lon": "-0.604132479198226",
        "display_name": "Windsor Castle, Moat Path, Clewer Within, Slopes Lodge, Eton, Windsor and Maidenhead, South East, England, SL4 1PB, United Kingdom",
        "class": "historic",
        "type": "castle",
        "importance": 0.60105687743994,
        "icon": "http://open.mapquestapi.com/nominatim/v1/images/mapicons/tourist_castle.p.20.png",
        "address": {
            "castle": "Windsor Castle",
            "path": "Moat Path",
            "neighbourhood": "Clewer Within",
            "suburb": "Slopes Lodge",
            "town": "Eton",
            "county": "Windsor and Maidenhead",
            "state_district": "South East",
            "state": "England",
            "postcode": "SL4 1PB",
            "country": "United Kingdom",
            "country_code": "gb"
        }
    }
];
}
