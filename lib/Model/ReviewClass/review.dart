class Review {
  final String name;
  final int rating;

  final String profilePic;
  final String time;
  final String subtitle;

  Review({
    required this.name,
    required this.subtitle,
    required this.rating,
    required this.profilePic,
    required this.time,
  });
}

final List<Review> reviews = [
  Review(
    name: 'Michail trot',
    subtitle: "abasdfjasd",
    rating: 4,
    profilePic: 'assets/images/profilepic.jpg',
    time: '2 min ago',
  ),
  Review(
    name: 'Rojar marei',
    subtitle: "abasdfjasd",
    rating: 2,
    profilePic: 'assets/images/profilepic.jpg',
    time: '2 min ago',
  ),
  Review(
    name: 'Jack raben',
    subtitle: "abasdfjasd",
    rating: 1,
    profilePic: 'assets/images/profilepic.jpg',
    time: '2 min ago',
  ),
  Review(
    name: 'Rojar marei',
    subtitle: "abasdfjasd",
    rating: 2,
    profilePic: 'assets/images/profilepic.jpg',
    time: '2 min ago',
  ),
  Review(
    name: 'Rojar marei',
    subtitle: "abasdfjasd",
    rating: 1,
    profilePic: 'assets/images/profilepic.jpg',
    time: '2 min ago',
  ),
  Review(
    name: 'Rojar marei',
    subtitle: "abasdfjasd",
    rating: 2,
    profilePic: 'assets/images/profilepic.jpg',
    time: '2 min ago',
  ),
];
