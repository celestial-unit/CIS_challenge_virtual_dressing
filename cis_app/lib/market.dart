import 'package:cis_app/details.dart';
import 'package:flutter/material.dart';
import 'clothing_item.dart';
import 'clothing_service.dart';

class MarketPage extends StatelessWidget {
  final ClothingService clothingService = ClothingService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/app.png', height: 24),
          onPressed: () {},
        ),
        title: Text(
          'ZEN',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/face.jpg'),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: FutureBuilder<List<ClothingItem>>(
        future: clothingService.fetchClothingItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items found'));
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    children: snapshot.data!.map((clothingItem) {
                      return ItemCard(
                        image: clothingItem.image,
                        title: clothingItem.name,
                        price: '${clothingItem.price} DNT',
                        clothingItem:
                            clothingItem, // Pass the entire clothing item
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(30), right: Radius.circular(30)),
                child: Image.asset('assets/home.png', height: 24),
              ),
            ),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Image.asset('assets/star.png', height: 24),
            ),
            label: 'POPULAR',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Image.asset('assets/store.png', height: 24),
            ),
            label: 'STORE',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Image.asset('assets/account.png', height: 24),
            ),
            label: 'ACCOUNT',
          ),
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final ClothingItem clothingItem;

  ItemCard({
    required this.image,
    required this.title,
    required this.price,
    required this.clothingItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(clothingItem: clothingItem),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(image), // Use AssetImage for local images
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            price,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
