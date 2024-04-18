class Data {
  final String image;
  final String title;

  Data({required this.image, required this.title});
}

List<Data> datas = [
  Data(
      image: 'assets/json/shoppingcart.json',
      title: "Near by store and Product"),
  Data(image: 'assets/json/payment3.json', title: "Secure Payment Method"),
  Data(image: 'assets/json/care.json', title: "Chat with Supplier"),
];

class StoreList {
  final String name;
  final String subtitle;
  final String address;
  final String image;
  final String rating;
  final String distance;

  StoreList(
      {required this.name,
      required this.address,
      required this.subtitle,
      required this.image,
      required this.rating,
      required this.distance});
}

List<StoreList> storelist = [
  StoreList(
      name: 'Walmart',
      subtitle: 'asdhasg',
      address: '1234 Washington Street, Us, 4568',
      image: 'https://etimg.etb2bimg.com/photo/106564692.cms',
      rating: '4.0',
      distance: '1 mile'),
  StoreList(
      name: 'Stop & Shop',
      subtitle: 'asdhasg',
      address: '13423 Washington Street, Us23, 4568',
      image:
          'https://assets1.progressivegrocer.com/files/styles/hero/s3/2018-12/Stop%20%26%20Shop%20MASS.jpg?VersionId=4cyzIT2jX3BBIyfYVz1RNYcju1S2JRJz&itok=hge4JxAD',
      rating: '4.5',
      distance: '3 mile'),
  StoreList(
      name: 'Safe Shop',
      subtitle: 'asdhasg',
      address: '1234 Washington Street, Us, 4568',
      image:
          'https://img.freepik.com/premium-vector/safe-shop-logo-design-template_145155-556.jpg',
      rating: '4.0',
      distance: '2 mile'),
  StoreList(
      name: 'Gaint Food Store',
      subtitle: 'asdhasg',
      address: '1234 Washington Street, Us, 4568',
      image: 'https://etimg.etb2bimg.com/photo/106564692.cms',
      rating: '3.0',
      distance: '2 mile'),
  StoreList(
      name: 'Meijer',
      subtitle: 'asdhasg',
      address: '1234 Washington Street, Us, 4568',
      image:
          'https://assets1.progressivegrocer.com/files/styles/hero/s3/2018-12/Stop%20%26%20Shop%20MASS.jpg?VersionId=4cyzIT2jX3BBIyfYVz1RNYcju1S2JRJz&itok=hge4JxAD',
      rating: '5.0',
      distance: '6 mile'),
  StoreList(
      name: 'Walmart',
      subtitle: 'asdhasg',
      address: '1234 Washington Street, Us, 4568',
      image: 'https://etimg.etb2bimg.com/photo/106564692.cms',
      rating: '4.0',
      distance: '4 mile'),
  StoreList(
      name: 'Walmart',
      subtitle: 'asdhasg',
      address: '1234 Washington Street, Us, 4568',
      image:
          'https://www.indiafilings.com/learn/wp-content/uploads/2023/03/How-can-I-register-my-shop-and-establishment-online.jpg',
      rating: '5',
      distance: '3 mile'),
  StoreList(
      name: 'Walmart',
      subtitle: 'asdhasg',
      address: '1234 Washington Street, Us, 4568',
      image:
          'https://img.freepik.com/premium-vector/safe-shop-logo-design-template_145155-556.jpg',
      rating: '4.5',
      distance: '2 mile'),
];
