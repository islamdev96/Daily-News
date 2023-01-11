// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/shared/component/constants.dart';
import '../../layouts/cubit/cubit.dart';
import '../../layouts/cubit/states.dart';
import '../details_screen/details_screen.dart';

class NewsScreen extends StatelessWidget {
  var pageViewController = PageController();
  NewsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var newsData = cubit.mydata;
        var breakingData = newsData.length -
            6; // to get the last 3 news from each category to display on breaking news
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: newsData.isEmpty
                ? const Text('')
                : ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text("Breaking News",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 21)),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        height: 180,
                        width: double.infinity,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  if (newsData[breakingData - i]
                                          ['urlToImage'] !=
                                      null) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return DetailsScreen(
                                          newsData[breakingData - i]['title'],
                                          newsData[breakingData - i]
                                              ['urlToImage'],
                                          newsData[breakingData - i]
                                              ['description']);
                                    }));
                                  }
                                },
                                child: Container(
                                  width: 300,
                                  height: 160,
                                  clipBehavior: Clip.hardEdge,
                                  margin: const EdgeInsets.only(right: 25),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    image: newsData[breakingData - i]
                                                ['urlToImage'] !=
                                            null
                                        ? DecorationImage(
                                            image: NetworkImage(
                                                newsData[breakingData - i]
                                                    ['urlToImage']),
                                            fit: BoxFit.fill)
                                        : null,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(top: 70),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.black
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    )),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Text(
                                                newsData[breakingData - i]
                                                    ['title'],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textDirection: arabicDirection,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 19,
                                                    color: Colors.white))),
                                        SizedBox(
                                            height: 20,
                                            child: Text(
                                              newsData[breakingData - i]
                                                  ['source']['name'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text("Recent News",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 21)),
                      ),
                      const SizedBox(height: 5),
                      cubit.mydata.isEmpty
                          ? Container()
                          : // if data is empty will show empty container
                          ListView.separated(
                              shrinkWrap: true,
                              itemCount: newsData.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    if (newsData[index]['urlToImage'] != null) {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return DetailsScreen(
                                            newsData[index]['title'],
                                            newsData[index]['urlToImage'],
                                            newsData[index]['description']);
                                      }));
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 110,
                                          width: 110,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: newsData[index]
                                                      ['urlToImage'] ==
                                                  null
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : Image.network(
                                                  newsData[index]['urlToImage'],
                                                  fit: BoxFit.fill,
                                                  width: 120,
                                                  height: 120),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: 110,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        newsData[index]
                                                            ['title'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 3,
                                                        textDirection:
                                                            arabicDirection,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16.5,
                                                            color:
                                                                Colors.white))),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      Jiffy(newsData[index]
                                                              ['publishedAt'])
                                                          .yMMMd,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 13,
                                                          color: Colors.grey),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          cubit
                                                              .InsertTODatabase(
                                                            title:
                                                                newsData[index]
                                                                    ['title'],
                                                            urlToImage: newsData[
                                                                    index]
                                                                ['urlToImage'],
                                                            publishedAt: newsData[
                                                                    index]
                                                                ['publishedAt'],
                                                          );
                                                        },
                                                        child: const Icon(
                                                          Icons.archive,
                                                          size: 20,
                                                          color: Colors.grey,
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Container(height: 10);
                              },
                            )
                    ],
                  ),
          ),
        );
      },
    );
  }
}
