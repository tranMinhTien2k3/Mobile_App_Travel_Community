import 'package:flutter/material.dart';
import 'package:travel_app/Components/tip_card.dart';

class expPage extends StatefulWidget {
  const expPage({super.key});

  @override
  State<expPage> createState() => _expPageState();
}

class _expPageState extends State<expPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Tips"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Hành động khi nhấn vào nút bộ lọc
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          TipCard(
            title: 'Mountain Travel Tip ',
            content: 'Let`s go to point A and then point B',
            note: 'bring camera',
            author: 'Tác giả',
            time: '1 giờ trước',
            imageUrl: 'https://via.placeholder.com/150',
            likes: 10,
            comments: 5,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
