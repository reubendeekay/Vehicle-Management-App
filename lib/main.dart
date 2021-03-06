import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_management/bottom_nav.dart';
import 'package:vehicle_management/main_drawer.dart';
import 'package:vehicle_management/providers/auth_provider.dart';
import 'package:vehicle_management/providers/dark_mode_provider.dart';
import 'package:vehicle_management/providers/location_provider.dart';
import 'package:vehicle_management/providers/property_provider.dart';
import 'package:vehicle_management/screens/admin/admin_screen.dart';
import 'package:vehicle_management/screens/auth/auth_screen.dart';
import 'package:vehicle_management/screens/booking/booking_screen.dart';
import 'package:vehicle_management/screens/booking/payment_screen.dart';
import 'package:vehicle_management/screens/change_password/change_password.dart';
import 'package:vehicle_management/screens/chat/chat_room.dart';
import 'package:vehicle_management/screens/dashboard/add_vehicle/add_vehicle.dart';
import 'package:vehicle_management/screens/dashboard/add_yard/add_yard_screen.dart';
import 'package:vehicle_management/screens/history/history_screen.dart';
import 'package:vehicle_management/screens/home/view_all_screen.dart';
import 'package:vehicle_management/screens/management/manage_staff.dart';
import 'package:vehicle_management/screens/map_overview/map_search_screen.dart';
import 'package:vehicle_management/screens/notifications/notification_settings.dart';
import 'package:vehicle_management/screens/notifications/notifications_screen.dart';
import 'package:vehicle_management/screens/policies/privacy_policy.dart';
import 'package:vehicle_management/screens/policies/terms_of_use.dart';
import 'package:vehicle_management/screens/privacy_security/privacy_security.dart';
import 'package:vehicle_management/screens/profile/user_profile.dart';
import 'package:vehicle_management/screens/property_details/vehicle_details_screen.dart';
import 'package:vehicle_management/screens/property_details/widgets/details_fullscreen.dart';
import 'package:vehicle_management/screens/welcome/welcome_screen.dart';
import 'package:vehicle_management/screens/search_screen/search_screen.dart';
import 'package:vehicle_management/screens/wishlist/wishlist_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LocationProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PropertyProvider()),
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
      ],
      child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(themeChangeProvider.darkTheme, context),

          //  ThemeData(
          //     textTheme: GoogleFonts.barlowTextTheme(), primaryColor: kPrimary),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, snapshot) =>
                  snapshot.hasData ? MainDrawer() : WelcomeScreen()),
          // home: ChatScreen(),
          routes: {
            MyNav.routeName: (context) => MyNav(),
            MainDrawer.routeName: (context) => MainDrawer(),
            VehicleDetailsScreen.routeName: (context) => VehicleDetailsScreen(),
            SearchScreen.routeName: (context) => SearchScreen(),
            DetailsFullScreen.routeName: (context) => DetailsFullScreen(),
            BookingScreen.routeName: (context) => BookingScreen(),
            NotificationsScreen.routeName: (context) => NotificationsScreen(),
            ViewAllScreen.routeName: (context) => ViewAllScreen(),
            AuthScreen.routeName: (context) => AuthScreen(),
            MapSearchScreen.routeName: (context) => MapSearchScreen(),
            UserProfile.routeName: (context) => UserProfile(),
            PrivacyPolicy.routeName: (context) => PrivacyPolicy(),
            TermsofUse.routeName: (context) => TermsofUse(),
            AdminScreen.routeName: (context) => AdminScreen(),
            NotificationSettings.routeName: (context) => NotificationSettings(),
            PrivacyAndSecurity.routeName: (context) => PrivacyAndSecurity(),
            ChatRoom.routeName: (context) => ChatRoom(),
            WishlistScreen.routeName: (context) => WishlistScreen(),
            HistoryScreen.routeName: (context) => HistoryScreen(),
            AddVehicle.routeName: (context) => AddVehicle(),
            ManageStaff.routeName: (context) => ManageStaff(),
            AddYardScreen.routeName: (context) => AddYardScreen(),
          },
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case PaymentScreen.routeName:
                return PageTransition(
                  child: PaymentScreen(),
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 200),
                  settings: settings,
                );
                break;
              case ChangePassword.routeName:
                return PageTransition(
                  child: ChangePassword(),
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 200),
                  settings: settings,
                );
                break;
              default:
                return null;
            }
          },
        );
      }),
    );
  }
}
