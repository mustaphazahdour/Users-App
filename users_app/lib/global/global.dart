import 'package:firebase_auth/firebase_auth.dart';
import 'package:users_app/models/direction_details_info.dart';
import 'package:users_app/models/user_model.dart';



final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List dList = []; //online-active drivers Information List
DirectionDetailsInfo? tripDirectionDetailsInfo;
String? chosenDriverId="";
String cloudMessagingServerToken = "key=AAAAa5EX9jk:APA91bGeriR_WO_Dc3pXMmuXcDnFf94XpG1jHrXRXtzQt25xo6NfQmMupv5v9NPtn8yiNWwhz-xGmVbyD7rA4JojbNZUMA_owrTwsCsqQWY3JePvnp92ZFsHppYGvB3VRDqPqyWTt7ML";
String userDropOffAddress = "";
String driverCarDetails="";
String driverName="";
String driverPhone="";
double countRatingStars=0.0;
String titleStarsRating="";