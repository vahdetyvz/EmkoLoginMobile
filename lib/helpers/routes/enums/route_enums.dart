enum RouteEnums {
  auth('/auth'),
  login('/login'),
  register('/register'),
  profile('/profile'),
  profileEdit('/profile_edit'),
  history('/history'),
  //search('/search'),
  qr('/qr'),
  //faq('/faq'),
  schoolDetail('/school_detail'),
  addTeacher('/add_teacher'),
  teachers('/teachers'),
  agreementPage('/agreementPage'),
  aboutPage('/aboutPage'),
  notifications('/notifications'),
  notificationDetail('/notification_detail'),
  //home('/home'),
  ;

  final String routeName;
  const RouteEnums(this.routeName);
}
