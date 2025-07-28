import 'package:get/get.dart';

class Follower {
  final String followersProfilePic;
  final String followerName;
  final int redeemedDeals;
  final int pushOpens;

  Follower({
    required this.followersProfilePic,
    required this.followerName,
    required this.redeemedDeals,
    required this.pushOpens,
  });
}

class MyFollowersController extends GetxController {
  var followerList = <Follower>[].obs;

  @override
  void onInit() {
    super.onInit();

    followerList.value = [
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
      Follower(
        followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
        followerName: 'Dianne Russell',
        redeemedDeals: 3,
        pushOpens: 5,
      ),
    ];
  }
}
