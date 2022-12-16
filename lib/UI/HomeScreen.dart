import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nested_listview/UI/ListScreen.dart';

import '../Model/CategoryModel.dart';
import '../Model/MovieDataModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> arrCategory = [];
  List<MovieDataModel> arrMovie = [];
  List<List<MovieDataModel>> arrMovieTemp = [];

  fetchCategoryData() async {
    final url = Uri.parse(
        'http://myvbox.uk:2052/player_api.php?username=test&password=test1&action=get_vod_categories');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        List data = json.decode(response.body);
        data.forEach((element) {
          arrCategory.add(CategoryModel.fromJson(element));
        });
      });
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  fetchData() async {
    final url = Uri.parse(
        'http://myvbox.uk:2052/player_api.php?username=test&password=test1&action=get_vod_streams');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        List data = json.decode(response.body);
        data.forEach((element) {
          arrMovie.add(MovieDataModel.fromJson(element));
        });
      });

      for (int i = 0; i < arrCategory.length; i++) {
        List<MovieDataModel> arr = [];
        for (int j = 0; j < arrMovie.length; j++) {
          if (arrCategory[i].categoryId == arrMovie[j].categoryId) {
            setState(() {
              arr.add(arrMovie[j]);
            });
          }
        }
        setState(() {
          arrMovieTemp.add(arr);
        });
      }
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryData();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: (arrCategory.isNotEmpty)
            ? ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: arrCategory.length,
                itemBuilder: (context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              arrCategory[index].categoryName!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ListScreen(
                                      arrCategory: arrMovieTemp[index]),
                                ));
                              },
                              child: const Text(
                                "View All",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: (arrMovieTemp.isNotEmpty)
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: arrMovieTemp[index].length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, subIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SizedBox(
                                      height: 150,
                                      width: 80,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: (arrMovieTemp[index]
                                                            [subIndex]
                                                        .streamIcon!
                                                        .isNotEmpty)
                                                    ? Image.network(
                                                        arrMovieTemp[index]
                                                                [subIndex]
                                                            .streamIcon!,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return const Text(
                                                              "No Image");
                                                        },
                                                        // loadingBuilder: (context, child, loadingProgress) {
                                                        //   return const Center(child: CircularProgressIndicator(),);
                                                        // },
                                                      )
                                                    : Container()),
                                          ),
                                          Text(
                                            arrMovieTemp[index][subIndex].name!,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const Center(child: Text('Loading...')),
                      )
                    ],
                  );
                })
            : const Center(child: Text('No Data Found')),
      ),
    );
  }
}
