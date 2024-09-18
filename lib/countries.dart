import 'package:covid_tracker/View/detail.dart';
import 'package:covid_tracker/service/stat_service.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Countrieslist extends StatefulWidget {
  const Countrieslist({Key? key}) : super(key: key);

  @override
  State<Countrieslist> createState() => _CountrieslistState();
}

class _CountrieslistState extends State<Countrieslist> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    statesService stateservice = statesService();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: searchcontroller,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 50),
                  hintText: 'search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: stateservice.countrieslist(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(
                                        height: 10,
                                        width: 9,
                                        color: Colors.white,
                                      ),
                                      subtitle: Container(
                                        height: 10,
                                        width: 9,
                                        color: Colors.white,
                                      ),
                                      leading: Container(
                                        height: 10,
                                        width: 9,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data![index]['country'];

                              if (searchcontroller.text.isEmpty) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    detailcountrie(
                                                      image: snapshot
                                                                  .data![index]
                                                              ['countryInfo']
                                                          ['flag'],
                                                      name:
                                                          snapshot.data![index]
                                                              ['country'],
                                                      totalcases:
                                                          snapshot.data![index]
                                                              ['cases'],
                                                      todayrescovered:
                                                          snapshot.data![index]
                                                              ['recovered'],
                                                      totaldeaths:
                                                          snapshot.data![index]
                                                              ['deaths'],
                                                      critical:
                                                          snapshot.data![index]
                                                              ['critical'],
                                                      test:
                                                          snapshot.data![index]
                                                              ['tests'],
                                                      active:
                                                          snapshot.data![index]
                                                              ['active'],
                                                    )));
                                      },
                                      child: ListTile(
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text(
                                            snapshot.data![index]['country']),
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                            )),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (name.toLowerCase().contains(
                                  searchcontroller.text.toLowerCase())) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    detailcountrie(
                                                      image: snapshot
                                                                  .data![index]
                                                              ['countryInfo']
                                                          ['flag'],
                                                      name:
                                                          snapshot.data![index]
                                                              ['country'],
                                                      totalcases:
                                                          snapshot.data![index]
                                                              ['cases'],
                                                      todayrescovered:
                                                          snapshot.data![index]
                                                              ['recovered'],
                                                      totaldeaths:
                                                          snapshot.data![index]
                                                              ['deaths'],
                                                      critical:
                                                          snapshot.data![index]
                                                              ['critical'],
                                                      test:
                                                          snapshot.data![index]
                                                              ['tests'],
                                                      active:
                                                          snapshot.data![index]
                                                              ['active'],
                                                    )));
                                      },
                                      child: ListTile(
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text(
                                            snapshot.data![index]['country']),
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                            )),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            });
                      }
                    })),
          ],
        ),
      ),
    );
  }
}
