import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheather/utils/api_http.dart';
import '../model/homemodel.dart';
import '../provider/homeprovier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeProvider? providertrue;
  HomeProvider? providerfalse;

  int i=1;
  @override
  Widget build(BuildContext context) {
    providertrue = Provider.of<HomeProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(

        body: Stack(
          children: [
            SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  "assets/image/$i.png",
                  fit: BoxFit.fill,
                )),
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black12,
            ),
            FutureBuilder(
              future: Api_http().weatherData(providertrue!.city == null
                  ? "Surat"
                  : "${providertrue!.city}"),
              builder: (context, snapshot) {
                if (snapshot.hasError) {

                  return Center(child: Text("${snapshot.error}"));
                }
                if (snapshot.hasData) {
                  HomeModel? h1 = snapshot.data;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: providertrue!.txtCity,
                            cursorColor: Colors.white70,
                            style: const TextStyle(color: Colors.white70),
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {
                                  i=i+1;
                                  setState(() {

                                  });
                                  providertrue!.search();
                                },
                                child: const Icon(
                                  Icons.search,
                                  color: Colors.white70,
                                ),
                              ),
                              label: const Text(
                                "Search City",
                                style: TextStyle(color: Colors.white70),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white70),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white70),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(
                          height: 150,
                        ),
                        Stack(
                          children: [
                            Center(
                              child: Text(
                                "${h1!.name}",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  (h1.main!.temp! - 273).toStringAsFixed(0),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 90,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 72),
                                  child: Text(
                                    ".",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 75),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 11),
                                  child: Text(
                                    "c",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 45),
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 150),
                                child: Text(
                                  "${h1.weather![0].description}",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 28,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 185),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${DateTime.now().weekday == 1 ? "Monday" : ""}${DateTime.now().weekday == 2 ? "Tuesday" : ""}${DateTime.now().weekday == 3 ? "Wednesday" : ""}${DateTime.now().weekday == 4 ? "Thursday" : ""}${DateTime.now().weekday == 5 ? "Friday" : ""}${DateTime.now().weekday == 6 ? "Saturday" : ""}${DateTime.now().weekday == 7 ? "Sunday" : ""} ,${DateTime.now().day} ${DateTime.now().month == 1 ? "Jan" : ""}${DateTime.now().month == 2 ? "Feb" : ""}${DateTime.now().month == 3 ? "Mar" : ""}${DateTime.now().month == 4 ? "Apr" : ""}${DateTime.now().month == 4 ? "May" : ""}${DateTime.now().month == 6 ? "Jun" : ""}${DateTime.now().month == 7 ? "July" : ""}${DateTime.now().month == 8 ? "Aug" : ""}${DateTime.now().month == 9 ? "Sep" : ""}${DateTime.now().month == 10 ? "Oct" : ""}${DateTime.now().month == 11 ? "Nov" : ""}${DateTime.now().month == 12 ? "Dec" : ""} ",
                                    style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 80),
                        Container(
                            height: 0.7,
                            width: double.infinity,
                            color: Colors.white70),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Icon(Icons.air,
                                        color: Colors.white70),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${(h1.wind!.speed)!.toStringAsFixed(1)} km/h",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    const Text(
                                      "Wind",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Icon(Icons.water_drop_rounded,
                                        color: Colors.white70),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${(h1.main!.humidity)!.toStringAsFixed(0)}%",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    const Text(
                                      "Humidity",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Icon(Icons.cloud_queue_rounded,
                                        color: Colors.white70),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${(100 - h1.clouds!.all!).toStringAsFixed(0)}%",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    const Text(
                                      "Chance of rain",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Visibility - ${h1.visibility}m",
                          style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                              fontSize: 25),
                        ),
                        const SizedBox(height: 15),
                        Container(
                            height: 0.7,
                            width: double.infinity,
                            color: Colors.white70),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black54,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Mon",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Colors.white70,
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    const Text(
                                      "22 c",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 22),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                height: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black54,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Tue",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Colors.white70,
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    const Text(
                                      "30 c",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 22),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                height: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black54,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Wed",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Colors.white70,
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    const Text(
                                      "22 c",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 22),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                height: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black54,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Thu",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Colors.white70,
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    const Text(
                                      "25 c",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 22),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 50,
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black54,
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Fri",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.white70,
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  const Text(
                                    "31 c",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 22),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black54,
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Sat",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.white70,
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  const Text(
                                    "21 c",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 22),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black54,
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Sun",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.white70,
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  const Text(
                                    "29 c",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 22),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
