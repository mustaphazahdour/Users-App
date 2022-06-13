class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Request Ride',
    image: 'images/img11.svg',
    discription: "Request a ride get picked up by a nearby community driver "
  ),
  UnbordingContent(
    title: 'Confirm Your Driver',
    image: 'images/img2.svg',
    discription: "Huge Drivers network helps. find comfortable, safe and cheap ride "
  ),
  UnbordingContent(
    title: 'Track Your Ride',
    image: 'images/img3.svg',
    discription: "Know your driver in advance and be able to view current location in real time "
  ),
];
