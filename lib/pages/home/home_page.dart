import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/constants/images.dart';
import 'package:weather_app/controller/HomeController.dart';
import 'package:weather_app/widget/myList.dart';
import 'package:weather_app/widget/my_chart.dart';

double coverHeight = 280;
double middlePartHeight = 200;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  Widget buildCoverImage(
    controller,
  ) {
    return Container(
      height: coverHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
          image: AssetImage(
            'assets/images/cloud-in-blue-sky.jpg',
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30, left: 20, right: 20),
            child: TextField(
              onChanged: (value) => controller.city = value,
              style: TextStyle(
                color: Colors.white,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) => controller.updateWeather(),
              decoration: InputDecoration(
                suffix: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Search'.toUpperCase(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMiddlePart(HomeController controller, BuildContext context) {
    double? tempreture = controller.currentWeatherData.main?.temp;
    double ? minTemp=controller.currentWeatherData.main?.tempMin;
    double ?maxTemp = controller.currentWeatherData.main?.tempMax;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: middlePartHeight,
      width: MediaQuery.of(context).size.width-40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //TODO
          Container(
            padding: EdgeInsets.only(top: 15, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    '${controller.currentWeatherData.name}'.toUpperCase(),
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.black45,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'flutterfonts',
                        ),
                  ),
                ),
                Center(
                  child: Text(
                    DateFormat().add_MMMMEEEEd().format(DateTime.now()),
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.black45,
                          fontSize: 16,
                          fontFamily: 'flutterfonts',
                        ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          //TODO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 50),
                child: Column(
                  children: <Widget>[
                    Text(
                      '${controller.currentWeatherData.weather?[0].description}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.black45,
                            fontSize: 22,
                            fontFamily: 'flutterfonts',
                          ),
                    ),
                    tempreture != null
                        ? Text(
                            '${(tempreture - (273.15)).round().toString()}\u2103',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    color: Colors.black45,
                                    fontSize: 47,
                                    fontFamily: 'flutterfonts'),
                          )
                        : Text(''),
                    Row(
                      children: [
                       minTemp!=null? Text(
                          'min: ${(minTemp - 273.15).round().toString()}\u2103\t/\t',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.black45,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'flutterfonts',
                              ),
                        ):Text(''),
                       maxTemp!=null? Text(
                          'max: ${(maxTemp - 273.15).round().toString()}\u2103',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.black45,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'flutterfonts',
                              ),
                        ):Text(''),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 80,
                      child: LottieBuilder.asset(
                        Images.cloudyAnim,
                      ),
                    ),
                    // Text(
                    //   'wind ${controller.currentWeatherData.wind?.speed} m/s',
                    //   style: Theme.of(context).textTheme.caption!.copyWith(
                    //         color: Colors.black45,
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.bold,
                    //         fontFamily: 'flutterfonts',
                    //       ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double topPossion = coverHeight - middlePartHeight / 2;
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return SafeArea(
            child: ListView(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    buildCoverImage(
                      controller,
                    ),
                    Positioned(
                      top: topPossion,
                      child: buildMiddlePart(controller, context),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: EdgeInsets.only(top: 120),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'other city'.toUpperCase(),
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        fontSize: 16,
                                        fontFamily: 'flutterfonts',
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                      ),
                            ),
                          ),
                          MyList(),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'forcast next 5 days'.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black45,
                                      ),
                                ),
                                Icon(
                                  Icons.next_plan_outlined,
                                  color: Colors.black45,
                                ),
                              ],
                            ),
                          ),
                          MyChart(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
