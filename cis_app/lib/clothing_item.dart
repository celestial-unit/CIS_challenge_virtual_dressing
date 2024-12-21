class ClothingItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image; // This will now be a static image path
  final List<String> size;
  final String category;

  ClothingItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image, // This will be a local asset path
    required this.size,
    required this.category,
  });

  // Factory constructor to create ClothingItem from JSON
  factory ClothingItem.fromJson(Map<String, dynamic> json) {
    // Get dynamic image URL (could be from API)
    String imageUrl = json['image'];

    // If you want to make the image static, map it to a local asset
    // For example, you could map certain categories to specific local assets
    String localImage;

    switch (json['category']) {
      case 'Men':
        localImage = 'assets/second.png';
        break;
      case 'Unisex':
        localImage = 'assets/item2.jpg';
        break;
      // Add more cases for other categories
      default:
        localImage = 'assets/item3.jpg'; // Default image
    }

    return ClothingItem(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(), // Convert price to double
      image: localImage, // Use static image path
      size: List<String>.from(json['size']),
      category: json['category'],
    );
  }
}
