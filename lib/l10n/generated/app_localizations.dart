import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pt.dart';

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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('nl'),
    Locale('pt'),
  ];

  /// App title
  ///
  /// In en, this message translates to:
  /// **'Tempo'**
  String get appTitle;

  /// Subtitle on home screen
  ///
  /// In en, this message translates to:
  /// **'The ultimate party game!'**
  String get homeSubtitle;

  /// Button to start a new game
  ///
  /// In en, this message translates to:
  /// **'New Game'**
  String get newGame;

  /// Rules button/title
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get rules;

  /// Settings title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Game setup screen title
  ///
  /// In en, this message translates to:
  /// **'Game Setup'**
  String get gameSetup;

  /// Categories screen title
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// Custom words screen title
  ///
  /// In en, this message translates to:
  /// **'Custom Words'**
  String get customWords;

  /// Game screen title
  ///
  /// In en, this message translates to:
  /// **'Game'**
  String get game;

  /// Round score screen title
  ///
  /// In en, this message translates to:
  /// **'Round Score'**
  String get roundScore;

  /// Final results screen title
  ///
  /// In en, this message translates to:
  /// **'Final Results'**
  String get finalResults;

  /// Onboarding title
  ///
  /// In en, this message translates to:
  /// **'Welcome to Tempo!'**
  String get onboardingTitle;

  /// Onboarding description
  ///
  /// In en, this message translates to:
  /// **'Make your friends guess words through 3 rounds: describe, one word, and mime!'**
  String get onboardingDescription;

  /// Get started button
  ///
  /// In en, this message translates to:
  /// **'Let\'s Go!'**
  String get getStarted;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Sound setting label
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// Vibration setting label
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get vibration;

  /// Teams label
  ///
  /// In en, this message translates to:
  /// **'Teams'**
  String get teams;

  /// Words label
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get words;

  /// Timer label
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get timer;

  /// Start button
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// Next button
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Pass button during game
  ///
  /// In en, this message translates to:
  /// **'Pass'**
  String get pass;

  /// Correct answer button
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correct;

  /// Round 1 title
  ///
  /// In en, this message translates to:
  /// **'Round 1 — Describe'**
  String get round1Title;

  /// Round 1 rules
  ///
  /// In en, this message translates to:
  /// **'Describe the word using as many words as you want, but without saying the word itself or any word from the same family!'**
  String get round1Description;

  /// Round 2 title
  ///
  /// In en, this message translates to:
  /// **'Round 2 — One Word'**
  String get round2Title;

  /// Round 2 rules
  ///
  /// In en, this message translates to:
  /// **'You can only say ONE word to make your team guess. Choose wisely!'**
  String get round2Description;

  /// Round 3 title
  ///
  /// In en, this message translates to:
  /// **'Round 3 — Mime'**
  String get round3Title;

  /// Round 3 rules
  ///
  /// In en, this message translates to:
  /// **'No words allowed! Use only gestures and mime to make your team guess.'**
  String get round3Description;

  /// Default team name
  ///
  /// In en, this message translates to:
  /// **'Team {number}'**
  String teamName(int number);

  /// Seconds display
  ///
  /// In en, this message translates to:
  /// **'{count}s'**
  String seconds(int count);

  /// Word count display
  ///
  /// In en, this message translates to:
  /// **'{count} words'**
  String wordCount(int count);

  /// Play again button
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// Back to home button
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'nl',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'nl':
      return AppLocalizationsNl();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
