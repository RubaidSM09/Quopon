class Api {
  /// base url

  static const baseUrl = "http://10.10.13.52:7000";
  //static const socket = "https://socket.thirdshotslot.co.uk/";


  ///auth
  static const signup = "$baseUrl/auth/register/";//done
  static const login = "$baseUrl/auth/login/"; //done
  static const verification = "$baseUrl/auth/verify-otp/"; //done
  static const forgotPassword = "$baseUrl/auth/forgot-password/"; //done
  static const resetPassword = "$baseUrl/auth/set-new-password/"; //done

  /// homepage
  static const categories = "$baseUrl/home/categories/";
  static const searchByCategories = "$baseUrl/home/shops/search/?category_name=";
  static const beyondNeighbourhood = "$baseUrl/home/shops/search/?is_beyond_neighborhood=true";
  static const speedyDeliveries = "$baseUrl/home/shops/search/?ordering=delivery_time_minutes";

  /// search
  static const frequentSearch = "$baseUrl/home/search/frequent/";

  /// Discover list
  static const discoverList = "$baseUrl/discover/list/";

  /// Profile
  static const followedVendors = "$baseUrl/discover/followed-vendors/";
  static const menu = "$baseUrl/discover/menu/";
}