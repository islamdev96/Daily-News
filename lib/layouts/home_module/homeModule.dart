// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/SearchScreen/search.dart';
import '../../shared/component/constants.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class HomeModule extends StatelessWidget {
  const HomeModule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        List menu = ['Country', 'Category'];
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titleScreen[cubit.initialIndex]),
            actions: [
              InkWell(
                child: const Icon(Icons.search),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
              ),
              PopupMenuButton(
                itemBuilder: (context) {
                  return menu.map((item) {
                    return PopupMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList();
                },
                onSelected: (selectedItem) {
                  if (selectedItem == 'Country') {
                    showMenu(
                      context: context,
                      position:
                          const RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0),
                      items: const [
                        PopupMenuItem<String>(value: '1', child: Text('Egypt')),
                        PopupMenuItem<String>(
                            value: '2', child: Text('United States')),
                        PopupMenuItem<String>(
                            value: '3', child: Text('Germany')),
                        PopupMenuItem<String>(
                            value: '4', child: Text('France')),
                      ],
                      elevation: 0,
                    ).then((value) {
                      if (value == '1') {
                        cubit.selectCountry('eg');
                        arabicDirection = TextDirection.rtl;
                        cubit.getNews(country: 'eg', category: cubit.category);
                      } else if (value == '2') {
                        cubit.selectCountry('us');
                        arabicDirection = TextDirection.ltr;
                        cubit.getNews(country: 'us', category: cubit.category);
                      } else if (value == '3') {
                        cubit.selectCountry('de');
                        arabicDirection = TextDirection.ltr;
                        cubit.getNews(country: 'de', category: cubit.category);
                      } else if (value == '4') {
                        cubit.selectCountry('fr');
                        arabicDirection = TextDirection.ltr;
                        cubit.getNews(country: 'fr', category: cubit.category);
                      }
                    });
                  } else if (selectedItem == 'Category') {
                    showMenu(
                      context: context,
                      position:
                          const RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0),
                      items: const [
                        PopupMenuItem<String>(
                            value: '1', child: Text('General')),
                        PopupMenuItem<String>(
                            value: '2', child: Text('Sports')),
                        PopupMenuItem<String>(
                            value: '3', child: Text('Science')),
                        PopupMenuItem<String>(
                            value: '4', child: Text('Health')),
                      ],
                      elevation: 0,
                    ).then((value) {
                      if (value == '1') {
                        cubit.selectCategory('general');
                        cubit.getNews(
                            country: cubit.country, category: 'general');
                      } else if (value == '2') {
                        cubit.selectCategory('sports');
                        cubit.getNews(
                            country: cubit.country, category: 'sports');
                      } else if (value == '3') {
                        cubit.selectCategory('science');
                        cubit.getNews(
                            country: cubit.country, category: 'science');
                      } else if (value == '4') {
                        cubit.selectCategory('health');
                        cubit.getNews(
                            country: cubit.country, category: 'health');
                      }
                    });
                  }
                },
              ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.black),
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.all(12),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.orange.shade900,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: "Archive"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ],
              onTap: (index) {
                cubit.ChangeBottomNavIndex(index);
              },
              currentIndex: cubit.initialIndex,
            ),
          ),
          body: cubit.screens[cubit.initialIndex],
        );
      },
    );
  }
}
