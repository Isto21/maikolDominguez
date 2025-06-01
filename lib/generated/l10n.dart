// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Passwords do not match`
  String get Passwords_Do_Not_Match {
    return Intl.message(
      'Passwords do not match',
      name: 'Passwords_Do_Not_Match',
      desc: '',
      args: [],
    );
  }

  /// `Or Sign In With`
  String get or {
    return Intl.message('Or Sign In With', name: 'or', desc: '', args: []);
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Leave a review`
  String get leave_a_review {
    return Intl.message(
      'Leave a review',
      name: 'leave_a_review',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `View All`
  String get view_all {
    return Intl.message('View All', name: 'view_all', desc: '', args: []);
  }

  /// `Collectors`
  String get Collectors {
    return Intl.message('Collectors', name: 'Collectors', desc: '', args: []);
  }

  /// `Offer`
  String get offer {
    return Intl.message('Offer', name: 'offer', desc: '', args: []);
  }

  /// `Add to cart`
  String get add_to_cart {
    return Intl.message('Add to cart', name: 'add_to_cart', desc: '', args: []);
  }

  /// `Buy now`
  String get buy_now {
    return Intl.message('Buy now', name: 'buy_now', desc: '', args: []);
  }

  /// `Favorites`
  String get Favorites {
    return Intl.message('Favorites', name: 'Favorites', desc: '', args: []);
  }

  /// `View`
  String get view {
    return Intl.message('View', name: 'view', desc: '', args: []);
  }

  /// `Follow`
  String get follow {
    return Intl.message('Follow', name: 'follow', desc: '', args: []);
  }

  /// `Message`
  String get message {
    return Intl.message('Message', name: 'message', desc: '', args: []);
  }

  /// `Products`
  String get products {
    return Intl.message('Products', name: 'products', desc: '', args: []);
  }

  /// `Sold`
  String get sold {
    return Intl.message('Sold', name: 'sold', desc: '', args: []);
  }

  /// `Followers`
  String get followers {
    return Intl.message('Followers', name: 'followers', desc: '', args: []);
  }

  /// `Following`
  String get following {
    return Intl.message('Following', name: 'following', desc: '', args: []);
  }

  /// `Recommended for you`
  String get Recommended_for_you {
    return Intl.message(
      'Recommended for you',
      name: 'Recommended_for_you',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message('Remember me', name: 'rememberMe', desc: '', args: []);
  }

  /// `Privacy Notice and Terms of Use`
  String get termsAndConditions {
    return Intl.message(
      'Privacy Notice and Terms of Use',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `CREATE ACCOUNT`
  String get create_account {
    return Intl.message(
      'CREATE ACCOUNT',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Or Sign Up With`
  String get orSignUp {
    return Intl.message(
      'Or Sign Up With',
      name: 'orSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get sign_in {
    return Intl.message('Sign in', name: 'sign_in', desc: '', args: []);
  }

  /// `Send again`
  String get send_again {
    return Intl.message('Send again', name: 'send_again', desc: '', args: []);
  }

  /// `Fill your information below or register with your social account`
  String get Sign_Up_Text {
    return Intl.message(
      'Fill your information below or register with your social account',
      name: 'Sign_Up_Text',
      desc: '',
      args: [],
    );
  }

  /// ` Password Reset!`
  String get reset_password {
    return Intl.message(
      ' Password Reset!',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been successfully reset. Please click below to continue your login.`
  String get reset_password_text {
    return Intl.message(
      'Your password has been successfully reset. Please click below to continue your login.',
      name: 'reset_password_text',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Don\'t have an account' key

  /// `Credenciales incorrectas`
  String get wrongCredentials {
    return Intl.message(
      'Credenciales incorrectas',
      name: 'wrongCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Recover Password`
  String get recover_password {
    return Intl.message(
      'Recover Password',
      name: 'recover_password',
      desc: '',
      args: [],
    );
  }

  /// `Get your code`
  String get Get_Your_Code {
    return Intl.message(
      'Get your code',
      name: 'Get_Your_Code',
      desc: '',
      args: [],
    );
  }

  /// `The code expire in `
  String get expired_code {
    return Intl.message(
      'The code expire in ',
      name: 'expired_code',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the 6 digit code that sent to your email address.`
  String get enter_verification_code_text {
    return Intl.message(
      'Please enter the 6 digit code that sent to your email address.',
      name: 'enter_verification_code_text',
      desc: '',
      args: [],
    );
  }

  /// `Enter the email address associated with your account.`
  String get enter_email_text {
    return Intl.message(
      'Enter the email address associated with your account.',
      name: 'enter_email_text',
      desc: '',
      args: [],
    );
  }

  /// `Enter your verification code`
  String get Enter_Verification_Code {
    return Intl.message(
      'Enter your verification code',
      name: 'Enter_Verification_Code',
      desc: '',
      args: [],
    );
  }

  /// `You must activate your account`
  String get must_active_the_account {
    return Intl.message(
      'You must activate your account',
      name: 'must_active_the_account',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Form`
  String get invalidForm {
    return Intl.message(
      'Invalid Form',
      name: 'invalidForm',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get login {
    return Intl.message('LOGIN', name: 'login', desc: '', args: []);
  }

  /// `Hi! Welcome back to The Collector's Court`
  String get loginText {
    return Intl.message(
      'Hi! Welcome back to The Collector\'s Court',
      name: 'loginText',
      desc: '',
      args: [],
    );
  }

  /// `Email Or Username`
  String get Email_Or_Username {
    return Intl.message(
      'Email Or Username',
      name: 'Email_Or_Username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message('Password', name: 'Password', desc: '', args: []);
  }

  /// `¿Forgot Password?`
  String get Forgot_Password {
    return Intl.message(
      '¿Forgot Password?',
      name: 'Forgot_Password',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get Already_account {
    return Intl.message(
      'Already have an account? ',
      name: 'Already_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get Sign_Up {
    return Intl.message('Sign Up', name: 'Sign_Up', desc: '', args: []);
  }

  /// `Nombre`
  String get Name {
    return Intl.message('Nombre', name: 'Name', desc: '', args: []);
  }

  /// `Apellidos `
  String get Last_name {
    return Intl.message('Apellidos ', name: 'Last_name', desc: '', args: []);
  }

  /// `Current Password`
  String get Actual_password {
    return Intl.message(
      'Current Password',
      name: 'Actual_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar contraseña`
  String get Confirm_Paswword {
    return Intl.message(
      'Confirmar contraseña',
      name: 'Confirm_Paswword',
      desc: '',
      args: [],
    );
  }

  /// `Do not have an account? `
  String get Dont_account {
    return Intl.message(
      'Do not have an account? ',
      name: 'Dont_account',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get Phone {
    return Intl.message('Phone', name: 'Phone', desc: '', args: []);
  }

  /// `Verification Code`
  String get Verification_Code {
    return Intl.message(
      'Verification Code',
      name: 'Verification_Code',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a confirmation code to your email`
  String get Confirm_Email {
    return Intl.message(
      'We have sent a confirmation code to your email',
      name: 'Confirm_Email',
      desc: '',
      args: [],
    );
  }

  /// `RESEND`
  String get Resend {
    return Intl.message('RESEND', name: 'Resend', desc: '', args: []);
  }

  /// `You have not received the code?`
  String get Resend_Text {
    return Intl.message(
      'You have not received the code?',
      name: 'Resend_Text',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get Continue {
    return Intl.message('Continue', name: 'Continue', desc: '', args: []);
  }

  /// `Enter your email`
  String get Enter_Email {
    return Intl.message(
      'Enter your email',
      name: 'Enter_Email',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message('Email', name: 'Email', desc: '', args: []);
  }

  /// `Without connection`
  String get withoutConection {
    return Intl.message(
      'Without connection',
      name: 'withoutConection',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message('Settings', name: 'setting', desc: '', args: []);
  }

  /// `Enter your email`
  String get hintEmail {
    return Intl.message(
      'Enter your email',
      name: 'hintEmail',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get Reset_Password {
    return Intl.message(
      'Change Password',
      name: 'Reset_Password',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get New_password {
    return Intl.message(
      'New Password',
      name: 'New_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password`
  String get Enter_New_password {
    return Intl.message(
      'Enter your new password',
      name: 'Enter_New_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get Confirm_New_password {
    return Intl.message(
      'Confirm new password',
      name: 'Confirm_New_password',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search {
    return Intl.message('Search', name: 'Search', desc: '', args: []);
  }

  /// `Home`
  String get Home {
    return Intl.message('Home', name: 'Home', desc: '', args: []);
  }

  /// `Report`
  String get Report {
    return Intl.message('Report', name: 'Report', desc: '', args: []);
  }

  /// `Night Mode`
  String get NightMode {
    return Intl.message('Night Mode', name: 'NightMode', desc: '', args: []);
  }

  /// `Account`
  String get Account {
    return Intl.message('Account', name: 'Account', desc: '', args: []);
  }

  /// `NOTIFICATIONS`
  String get Notifications {
    return Intl.message(
      'NOTIFICATIONS',
      name: 'Notifications',
      desc: '',
      args: [],
    );
  }

  /// `WARNING`
  String get WARNING {
    return Intl.message('WARNING', name: 'WARNING', desc: '', args: []);
  }

  /// `Surely you want to delete this notification?`
  String get Delete_Confirm {
    return Intl.message(
      'Surely you want to delete this notification?',
      name: 'Delete_Confirm',
      desc: '',
      args: [],
    );
  }

  /// `Surely you want to delete this location?`
  String get Delete_Location {
    return Intl.message(
      'Surely you want to delete this location?',
      name: 'Delete_Location',
      desc: '',
      args: [],
    );
  }

  /// `ACCEPT`
  String get ACCEPT {
    return Intl.message('ACCEPT', name: 'ACCEPT', desc: '', args: []);
  }

  /// `CANCEL`
  String get CANCEL {
    return Intl.message('CANCEL', name: 'CANCEL', desc: '', args: []);
  }

  /// `About`
  String get ABOUT {
    return Intl.message('About', name: 'ABOUT', desc: '', args: []);
  }

  /// `Send Report`
  String get SEND_COMMENT {
    return Intl.message(
      'Send Report',
      name: 'SEND_COMMENT',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comme {
    return Intl.message('Comment', name: 'comme', desc: '', args: []);
  }

  /// `Language`
  String get LANGUAGE {
    return Intl.message('Language', name: 'LANGUAGE', desc: '', args: []);
  }

  /// `Theme`
  String get Theme {
    return Intl.message('Theme', name: 'Theme', desc: '', args: []);
  }

  /// `Dark Mode`
  String get Dark_Mode {
    return Intl.message('Dark Mode', name: 'Dark_Mode', desc: '', args: []);
  }

  /// `Light Mode`
  String get Light_Mode {
    return Intl.message('Light Mode', name: 'Light_Mode', desc: '', args: []);
  }

  /// `Automatic`
  String get Automatic {
    return Intl.message('Automatic', name: 'Automatic', desc: '', args: []);
  }

  /// `SIGN OFF`
  String get Sign_Off {
    return Intl.message('SIGN OFF', name: 'Sign_Off', desc: '', args: []);
  }

  /// `Select a language`
  String get SelectLanguage {
    return Intl.message(
      'Select a language',
      name: 'SelectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message('English', name: 'English', desc: '', args: []);
  }

  /// `Spanish`
  String get Spanish {
    return Intl.message('Spanish', name: 'Spanish', desc: '', args: []);
  }

  /// `System`
  String get System {
    return Intl.message('System', name: 'System', desc: '', args: []);
  }

  /// `Edit_Profile`
  String get Edit_Profile {
    return Intl.message(
      'Edit_Profile',
      name: 'Edit_Profile',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get Delete_Account {
    return Intl.message(
      'Delete Account',
      name: 'Delete_Account',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get Change_Password {
    return Intl.message(
      'Change Password',
      name: 'Change_Password',
      desc: '',
      args: [],
    );
  }

  /// `This is the name you want people to use when referring to you`
  String get Name_explanation {
    return Intl.message(
      'This is the name you want people to use when referring to you',
      name: 'Name_explanation',
      desc: '',
      args: [],
    );
  }

  /// `Your phone number can be used to log in and recover your account`
  String get Phone_explanation {
    return Intl.message(
      'Your phone number can be used to log in and recover your account',
      name: 'Phone_explanation',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get Update {
    return Intl.message('Update', name: 'Update', desc: '', args: []);
  }

  /// `A verification code will be sent to this number`
  String get Verification_number {
    return Intl.message(
      'A verification code will be sent to this number',
      name: 'Verification_number',
      desc: '',
      args: [],
    );
  }

  /// `A verification code will be sent to this email`
  String get Verification_email_code {
    return Intl.message(
      'A verification code will be sent to this email',
      name: 'Verification_email_code',
      desc: '',
      args: [],
    );
  }

  /// `Your email number can be used to log in and recover your account`
  String get Verification_email {
    return Intl.message(
      'Your email number can be used to log in and recover your account',
      name: 'Verification_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get Enter_Password {
    return Intl.message(
      'Enter your password',
      name: 'Enter_Password',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get Current_Password {
    return Intl.message(
      'Current Password',
      name: 'Current_Password',
      desc: '',
      args: [],
    );
  }

  /// `Your account will be permanently deleted. Are you sure you want to delete it`
  String get Password_Explanation {
    return Intl.message(
      'Your account will be permanently deleted. Are you sure you want to delete it',
      name: 'Password_Explanation',
      desc: '',
      args: [],
    );
  }

  /// `Surely you want to delete your account`
  String get Surely_Delete {
    return Intl.message(
      'Surely you want to delete your account',
      name: 'Surely_Delete',
      desc: '',
      args: [],
    );
  }

  /// `Saved Locations`
  String get Saved_Locations {
    return Intl.message(
      'Saved Locations',
      name: 'Saved_Locations',
      desc: '',
      args: [],
    );
  }

  /// `Surely you want to log out?`
  String get Log_Out {
    return Intl.message(
      'Surely you want to log out?',
      name: 'Log_Out',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get Send {
    return Intl.message('Send', name: 'Send', desc: '', args: []);
  }

  /// `Developed by NPC's`
  String get Npcs {
    return Intl.message(
      'Developed by NPC\'s',
      name: 'Npcs',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get Description {
    return Intl.message('Description', name: 'Description', desc: '', args: []);
  }

  /// `Edit`
  String get Edit {
    return Intl.message('Edit', name: 'Edit', desc: '', args: []);
  }

  /// `This field is required`
  String get validForm_campoRequerido {
    return Intl.message(
      'This field is required',
      name: 'validForm_campoRequerido',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Name`
  String get validForm_NombreInvalido {
    return Intl.message(
      'Invalid Name',
      name: 'validForm_NombreInvalido',
      desc: '',
      args: [],
    );
  }

  /// `The number is not valid`
  String get validForm_NumeroInvalido {
    return Intl.message(
      'The number is not valid',
      name: 'validForm_NumeroInvalido',
      desc: '',
      args: [],
    );
  }

  /// `The field must have mora then 2 characters`
  String get validForm_SizeName {
    return Intl.message(
      'The field must have mora then 2 characters',
      name: 'validForm_SizeName',
      desc: '',
      args: [],
    );
  }

  /// `Must be a valid number`
  String get validForm_SizeFormat {
    return Intl.message(
      'Must be a valid number',
      name: 'validForm_SizeFormat',
      desc: '',
      args: [],
    );
  }

  /// `Minimum 6 characters`
  String get validForm_Password {
    return Intl.message(
      'Minimum 6 characters',
      name: 'validForm_Password',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get validForm_Email {
    return Intl.message(
      'Invalid email',
      name: 'validForm_Email',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get Password_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'Password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get Username {
    return Intl.message('Username', name: 'Username', desc: '', args: []);
  }

  /// `Account created successfully`
  String get successfully_Account {
    return Intl.message(
      'Account created successfully',
      name: 'successfully_Account',
      desc: '',
      args: [],
    );
  }

  /// `Username already exists`
  String get username_already_exists {
    return Intl.message(
      'Username already exists',
      name: 'username_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `Email already exists`
  String get email_already_exists {
    return Intl.message(
      'Email already exists',
      name: 'email_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `Phone already exists`
  String get phone_already_exists {
    return Intl.message(
      'Phone already exists',
      name: 'phone_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `Error creating account`
  String get error_creating_account {
    return Intl.message(
      'Error creating account',
      name: 'error_creating_account',
      desc: '',
      args: [],
    );
  }

  /// `Language not defined`
  String get language_not_defined {
    return Intl.message(
      'Language not defined',
      name: 'language_not_defined',
      desc: '',
      args: [],
    );
  }

  /// `Image uploaded successfully`
  String get imagen_subida_con_exito {
    return Intl.message(
      'Image uploaded successfully',
      name: 'imagen_subida_con_exito',
      desc: '',
      args: [],
    );
  }

  /// `Image deleted successfully`
  String get imagen_eliminada_con_exito {
    return Intl.message(
      'Image deleted successfully',
      name: 'imagen_eliminada_con_exito',
      desc: '',
      args: [],
    );
  }

  /// `Error occurred`
  String get errorSended {
    return Intl.message(
      'Error occurred',
      name: 'errorSended',
      desc: '',
      args: [],
    );
  }

  /// `User activated`
  String get user_activated {
    return Intl.message(
      'User activated',
      name: 'user_activated',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get user_not_found {
    return Intl.message(
      'User not found',
      name: 'user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `This account is already active`
  String get this_account_is_already_active {
    return Intl.message(
      'This account is already active',
      name: 'this_account_is_already_active',
      desc: '',
      args: [],
    );
  }

  /// `Account not active`
  String get account_not_active {
    return Intl.message(
      'Account not active',
      name: 'account_not_active',
      desc: '',
      args: [],
    );
  }

  /// `Warehouse`
  String get warehouse {
    return Intl.message('Warehouse', name: 'warehouse', desc: '', args: []);
  }

  /// `Client`
  String get client {
    return Intl.message('Client', name: 'client', desc: '', args: []);
  }

  /// `Get`
  String get get {
    return Intl.message('Get', name: 'get', desc: '', args: []);
  }

  /// `Delivery`
  String get delivery {
    return Intl.message('Delivery', name: 'delivery', desc: '', args: []);
  }

  /// `Note (Optional)`
  String get note {
    return Intl.message('Note (Optional)', name: 'note', desc: '', args: []);
  }

  /// `Digital Signature`
  String get digitalSignature {
    return Intl.message(
      'Digital Signature',
      name: 'digitalSignature',
      desc: '',
      args: [],
    );
  }

  /// `Upload Photo`
  String get uploadPhoto {
    return Intl.message(
      'Upload Photo',
      name: 'uploadPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Close Delivery`
  String get closeDelivery {
    return Intl.message(
      'Close Delivery',
      name: 'closeDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Delivery to Client`
  String get client_delivery {
    return Intl.message(
      'Delivery to Client',
      name: 'client_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect verification code`
  String get incorrect_verification_code {
    return Intl.message(
      'Incorrect verification code',
      name: 'incorrect_verification_code',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
