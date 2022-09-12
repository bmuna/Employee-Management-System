class Config {
  static const String appName = "EMS";
  static const String hostURL = 'localhost:3000';
  static const String restaurantOrderURL = 'user.foodhost.us:3000';
  static const String basePathURL = "/ems/api/v1";
  static const String adminLoginPath = "/auth/login_admin";
  static const String checkUserExistPath = "/auth/check_exist_employee";
  static const String sendOTPPath = "/auth/send_otp";
  static const String verifyOTPPath = "/auth/verify_otp";
  static const String getUserPath = "/admin/get_users";
  static const String getUserWithRolePath = "/admin/get_users_with_roles";
  static const String getTaskListPath = "/employee/get_tasks/";
  static const String getlistOfRolesPath = "/admin/get_list_role";
  static const String addEmployeePath = "/admin/add_users";
  static const String addTaskPath = "/admin/add_task";
  static const String addRolePath = "/admin/add_role";
  static const String restaurantOrderListPath = "/api/restaurant_order/";
}
