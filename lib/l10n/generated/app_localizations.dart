import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @slogan.
  ///
  /// In en, this message translates to:
  /// **'We are with you, every step of the way'**
  String get slogan;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your first steps start here. Welcome back — sign in to your account.'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'name@example.com'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordMsg.
  ///
  /// In en, this message translates to:
  /// **'A password reset link has been sent to your email.'**
  String get forgotPasswordMsg;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @createOne.
  ///
  /// In en, this message translates to:
  /// **'Create one'**
  String get createOne;

  /// No description provided for @demoHint.
  ///
  /// In en, this message translates to:
  /// **'Demo account: demo@helpi.app / Helpi1234'**
  String get demoHint;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a new account'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join HelpI to plan accessible routes and places.'**
  String get registerSubtitle;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullNameLabel;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNameHint;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordLabel;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccount;

  /// No description provided for @errorEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required.'**
  String get errorEmailRequired;

  /// No description provided for @errorEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get errorEmailInvalid;

  /// No description provided for @errorPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required.'**
  String get errorPasswordRequired;

  /// No description provided for @errorPasswordShort.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters.'**
  String get errorPasswordShort;

  /// No description provided for @errorPasswordWeak.
  ///
  /// In en, this message translates to:
  /// **'Include at least one letter and one number.'**
  String get errorPasswordWeak;

  /// No description provided for @errorNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name.'**
  String get errorNameRequired;

  /// No description provided for @errorPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get errorPasswordMismatch;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect. Try the demo account or create a new one.'**
  String get invalidCredentials;

  /// No description provided for @emailTaken.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists.'**
  String get emailTaken;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get unexpectedError;

  /// No description provided for @messageTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s message'**
  String get messageTitle;

  /// No description provided for @messageBody.
  ///
  /// In en, this message translates to:
  /// **'Hello 💙\nYou have the right to an environment that meets your mobility needs and supports your independence. Every option is open to you — you choose the route and the way that suits you.'**
  String get messageBody;

  /// No description provided for @navTransport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get navTransport;

  /// No description provided for @navPlaces.
  ///
  /// In en, this message translates to:
  /// **'Places'**
  String get navPlaces;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navServices.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get navServices;

  /// No description provided for @mapTitle.
  ///
  /// In en, this message translates to:
  /// **'Accessibility map'**
  String get mapTitle;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search for a place:'**
  String get searchTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by place or area name'**
  String get searchHint;

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @nearbyTitle.
  ///
  /// In en, this message translates to:
  /// **'Show nearby places:'**
  String get nearbyTitle;

  /// No description provided for @suggestedTitle.
  ///
  /// In en, this message translates to:
  /// **'Suggested places for you:'**
  String get suggestedTitle;

  /// No description provided for @addPlace.
  ///
  /// In en, this message translates to:
  /// **'Add a place'**
  String get addPlace;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryHospitals.
  ///
  /// In en, this message translates to:
  /// **'Hospitals'**
  String get categoryHospitals;

  /// No description provided for @categorySchools.
  ///
  /// In en, this message translates to:
  /// **'Schools & universities'**
  String get categorySchools;

  /// No description provided for @categoryGovernment.
  ///
  /// In en, this message translates to:
  /// **'Government offices'**
  String get categoryGovernment;

  /// No description provided for @categoryCafes.
  ///
  /// In en, this message translates to:
  /// **'Cafes & restaurants'**
  String get categoryCafes;

  /// No description provided for @categoryAttractions.
  ///
  /// In en, this message translates to:
  /// **'Attractions'**
  String get categoryAttractions;

  /// No description provided for @categoryParks.
  ///
  /// In en, this message translates to:
  /// **'Parks'**
  String get categoryParks;

  /// No description provided for @categoryPalaces.
  ///
  /// In en, this message translates to:
  /// **'Palaces'**
  String get categoryPalaces;

  /// No description provided for @categoryThemeParks.
  ///
  /// In en, this message translates to:
  /// **'Theme parks'**
  String get categoryThemeParks;

  /// No description provided for @categoryLandmarks.
  ///
  /// In en, this message translates to:
  /// **'Landmarks'**
  String get categoryLandmarks;

  /// No description provided for @categoryDistricts.
  ///
  /// In en, this message translates to:
  /// **'Areas'**
  String get categoryDistricts;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No places match your search.'**
  String get noResults;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load places. Check your connection and try again.'**
  String get loadFailed;

  /// No description provided for @detailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Place details'**
  String get detailsTitle;

  /// No description provided for @placeImage.
  ///
  /// In en, this message translates to:
  /// **'Place image'**
  String get placeImage;

  /// No description provided for @placeName.
  ///
  /// In en, this message translates to:
  /// **'Place name'**
  String get placeName;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @kmUnit.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get kmUnit;

  /// No description provided for @featuresTitle.
  ///
  /// In en, this message translates to:
  /// **'Reported accessibility features:'**
  String get featuresTitle;

  /// No description provided for @featuresUnverified.
  ///
  /// In en, this message translates to:
  /// **'Reported, not verified'**
  String get featuresUnverified;

  /// No description provided for @accessibilityNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Accessibility information has not been independently verified. Please confirm details directly with the venue before travelling.'**
  String get accessibilityNotVerified;

  /// No description provided for @featureRamp.
  ///
  /// In en, this message translates to:
  /// **'Ramp'**
  String get featureRamp;

  /// No description provided for @featureRestroom.
  ///
  /// In en, this message translates to:
  /// **'Accessible restroom'**
  String get featureRestroom;

  /// No description provided for @featureElevator.
  ///
  /// In en, this message translates to:
  /// **'Wide elevator'**
  String get featureElevator;

  /// No description provided for @featureDoors.
  ///
  /// In en, this message translates to:
  /// **'Wide doors'**
  String get featureDoors;

  /// No description provided for @goToLocation.
  ///
  /// In en, this message translates to:
  /// **'Go to location'**
  String get goToLocation;

  /// No description provided for @directionsFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the maps application.'**
  String get directionsFailed;

  /// No description provided for @addPlaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a new place'**
  String get addPlaceTitle;

  /// No description provided for @placeNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Place name'**
  String get placeNameLabel;

  /// No description provided for @placeNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter place name'**
  String get placeNameHint;

  /// No description provided for @placeTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Place type'**
  String get placeTypeLabel;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address or location'**
  String get addressLabel;

  /// No description provided for @addressHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the address or area'**
  String get addressHint;

  /// No description provided for @pinLocation.
  ///
  /// In en, this message translates to:
  /// **'Pin the location'**
  String get pinLocation;

  /// No description provided for @locationPinned.
  ///
  /// In en, this message translates to:
  /// **'Location pinned on the map.'**
  String get locationPinned;

  /// No description provided for @savePlace.
  ///
  /// In en, this message translates to:
  /// **'Save place'**
  String get savePlace;

  /// No description provided for @placeSaved.
  ///
  /// In en, this message translates to:
  /// **'Place saved. It now appears on the map.'**
  String get placeSaved;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save the place. Please try again.'**
  String get saveFailed;

  /// No description provided for @errorPlaceName.
  ///
  /// In en, this message translates to:
  /// **'Place name is required.'**
  String get errorPlaceName;

  /// No description provided for @errorCategory.
  ///
  /// In en, this message translates to:
  /// **'Select a place type.'**
  String get errorCategory;

  /// No description provided for @errorAddress.
  ///
  /// In en, this message translates to:
  /// **'Address is required.'**
  String get errorAddress;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @preferencesSection.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferencesSection;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'HelpI MVP · v0.1.0'**
  String get appVersion;

  /// No description provided for @servicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Services & support'**
  String get servicesTitle;

  /// No description provided for @transportTitle.
  ///
  /// In en, this message translates to:
  /// **'Accessible transport'**
  String get transportTitle;

  /// No description provided for @transportDesc.
  ///
  /// In en, this message translates to:
  /// **'Request a wheelchair-accessible ride that gets you to your destination safely.'**
  String get transportDesc;

  /// No description provided for @transportAction.
  ///
  /// In en, this message translates to:
  /// **'Request a ride'**
  String get transportAction;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home adaptations'**
  String get homeTitle;

  /// No description provided for @homeDesc.
  ///
  /// In en, this message translates to:
  /// **'Assessment and installation of ramps, handrails and accessible fittings in your home.'**
  String get homeDesc;

  /// No description provided for @homeAction.
  ///
  /// In en, this message translates to:
  /// **'Book an assessment'**
  String get homeAction;

  /// No description provided for @communityTitle.
  ///
  /// In en, this message translates to:
  /// **'Community help'**
  String get communityTitle;

  /// No description provided for @communityDesc.
  ///
  /// In en, this message translates to:
  /// **'Connect with trained volunteers nearby who can help you day to day.'**
  String get communityDesc;

  /// No description provided for @communityAction.
  ///
  /// In en, this message translates to:
  /// **'Find volunteers'**
  String get communityAction;

  /// No description provided for @hotlineTitle.
  ///
  /// In en, this message translates to:
  /// **'HelpI support line'**
  String get hotlineTitle;

  /// No description provided for @hotlineDesc.
  ///
  /// In en, this message translates to:
  /// **'Our team is available daily from 8:00 to 22:00.'**
  String get hotlineDesc;

  /// No description provided for @callAction.
  ///
  /// In en, this message translates to:
  /// **'Call now'**
  String get callAction;

  /// No description provided for @callFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not start the phone call.'**
  String get callFailed;

  /// No description provided for @requestSent.
  ///
  /// In en, this message translates to:
  /// **'This is a demo; no request was sent to a service provider.'**
  String get requestSent;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
