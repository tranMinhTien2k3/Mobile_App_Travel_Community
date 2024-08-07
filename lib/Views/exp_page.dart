import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/Components/bottom_nav.dart';
import 'package:travel_app/Components/drawer_home.dart';
import 'package:travel_app/Components/tip_card.dart';
import 'package:travel_app/Widgets/big_text.dart';
import 'package:travel_app/Widgets/creat_tip.dart';
import 'package:travel_app/Widgets/text_color.dart';
import 'package:travel_app/databases/dataName.dart';
import 'package:travel_app/databases/dataTheme.dart';
import 'package:travel_app/repositories/theme_notifier.dart';

class expPage extends ConsumerStatefulWidget {
  const expPage({super.key});

  @override
  ConsumerState<expPage> createState() => _expPageState();
}

class _expPageState extends ConsumerState<expPage> {
  final DatabaseReference usersRef =
      FirebaseDatabase.instance.ref().child("Users");
  final DatabaseReference tipsRef =
      FirebaseDatabase.instance.ref().child("Tips");
  String selectedFilter = 'All';
  String searchKeyword = '';

  void showFilterDialog() async {
    List<String> themes = await getAllThemes();
    themes.insert(0, "All");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Filter by Topic"),
          content: SingleChildScrollView(
            child: ListBody(
              children: themes.map((theme) {
                return ListTile(
                  title: Text(theme),
                  onTap: () {
                    setState(() {
                      selectedFilter = theme;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void onSearchTextChanged(String text) {
    setState(() {
      searchKeyword = text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeNotifierProvider) == ThemeModeState.dark;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              const Text("Travel Tips"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0), // Điều chỉnh khoảng cách ở đây
                  child: TextField(
                    onChanged: onSearchTextChanged,
                    decoration: InputDecoration(
                      hintText: 'Search in ${selectedFilter}',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: showFilterDialog,
            ),
          ],
        ),
        body: StreamBuilder<DatabaseEvent>(
          stream: tipsRef.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
              return Center(child: Text('No data available'));
            }

            final Map<dynamic, dynamic>? tipsMap =
                snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

            if (tipsMap == null) {
              return Center(child: Text('Data format error'));
            }

            final List<Map<dynamic, dynamic>> tips = [];
            if (selectedFilter == "All") {
              tipsMap.forEach((key, value) {
                if (value is Map<dynamic, dynamic>) {
                  Map<String, dynamic> tip = value.cast<String, dynamic>();
                  tip['id'] = key; // Thêm ID vào dữ liệu của tip
                  tips.add(tip);
                }
              });
            } else {
              tipsMap.forEach((key, value) {
                if (value is Map<dynamic, dynamic>) {
                  Map<String, dynamic> tip = value.cast<String, dynamic>();
                  tip['id'] = key;
                  if (selectedFilter.isEmpty ||
                      tip['theme'] == selectedFilter) {
                    tips.add(tip);
                  }
                }
              });
            }

            List<Map<dynamic, dynamic>> filteredTips = tips.where((tip) {
              // Kiểm tra từ khóa tìm kiếm trong title
              return tip['title'].toLowerCase().contains(searchKeyword);
            }).toList();

            return ListView.builder(
              itemCount: filteredTips.length,
              itemBuilder: (context, index) {
                List<String> img = [];
                if (filteredTips[index]['image'] != null &&
                    filteredTips[index]['image'] is List<dynamic>) {
                  img = filteredTips[index]['image'].cast<String>();
                }

                List like = [];
                if (filteredTips[index]['like'] != null &&
                    filteredTips[index]['like'] is List<dynamic>) {
                  like = filteredTips[index]['like'].cast<String>();
                }
                List comment = [];
                if (filteredTips[index]['comments'] != null) {
                  comment = filteredTips[index]['comments'];
                }
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/exp_detail', arguments: {
                          'title': filteredTips[index]['title'],
                          'content': filteredTips[index]['content'],
                          'note': filteredTips[index]['notes'],
                          'author': filteredTips[index]['id_name'],
                          'time': filteredTips[index]['datePublished'],
                          'imageUrl': img,
                          'likes': like,
                          'comments': comment,
                          'id': filteredTips[index]['id'],
                        });
                      },
                      title: Text(filteredTips[index]['title']),
                      trailing: const Icon(Icons.call_made_rounded),
                      subtitle: FutureBuilder<String>(
                        future: getName(filteredTips[index]['id_name']),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(
                              'Loading...',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                              'Error: ${snapshot.error}',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.red,
                              ),
                            );
                          } else {
                            String authorName = snapshot.data ?? 'Unknown';
                            return Text(
                              'By $authorName',
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                );
                // TipCard(
                //
                // );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CreateTip();
                });
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}
