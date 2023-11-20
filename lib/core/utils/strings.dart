class AppStrings {
  AppStrings._();
  static const packageName = 'clearance_processing_system';

  static const appName = 'Clearance Processing System';
  static const name = 'UCPS';

  static const tAndCFirst = 'I agree to the';
  static const tAndCSecond = ' terms and conditions ';
  static const tAndCLast = 'stated to use this app and all it\'s services';

  static const alreadyHaveAccount = 'I already have an account';
  static const forgotPasswordText =
      'Confirm your email and we will send you the instructions.';

  static const errorText = 'Uhh something went wrong';
  static const addressError = 'You will need to set your default address to continue';
  static const authError = 'You will need to logout and log back in to continue';

  static const successText = 'Saved successfully';

  static const successPayment = 'Payment completed';
  static const successCatalogUploadText = 'Uploaded item to catalog';
  static const successUpdatedOrderStatus = 'Updated order status';

  static const addedToCart = 'Item added to cart';

  static const dashboard = 'Dashboard';
  static const userManagement = 'User management';
  static const createNewUser = 'Create a new user';
  static const viewRecords = 'User records';
  static const studentManagement = 'Student management';
  static const viewStudents = 'Student records';
  static const createNewStudent = 'Register student';
  static const feeManagement = 'Fee management';
  static const postAFee = 'Post a fee';
  static const viewFees = 'Fee records';
  static const requirements = 'Requirements';
  static const wallet = 'Wallet';
  static const transactionHistory = 'Transaction history';
  static const myProfile = 'My profile';
  static const clearance = 'Clearance';
}

class ButtonStrings {
  ButtonStrings._();

  static const alreadyAccount = 'Already have an account? ';
  static const signIn = 'Log in';
  static const dont = 'Don\'t have an account? ';

  static const click = 'Sign up';
  static const createAcc = 'Create Account';
  static const next = 'Next';
  static const done = 'Done';
  static const add = 'Add';
  static const finish = 'Finish';
  static const save = 'Save';
  static const whatAreThese = 'What are these?';
}

class LabelStrings {
  LabelStrings._();

  static const email = 'Email';
  static const emailAdd = 'Email Address';
  static const username = 'Username';
  static const phoneNumber = 'Phone Number';
  static const password = 'Create a Password';
  static const fname = 'Full Name';

  static const accountNumber = 'Account number';
  static const bankName = 'Bank name';
  static const accountName = 'Account name';
}

class AssetStrings {
  AssetStrings._();

  static const logo = 'assets/images/app_logo.png';
}

class FireStoreCollectionStrings {
  FireStoreCollectionStrings._();

  static const admin = 'admin';
  static const students = 'students';
  static const fees = 'fees';
  static const requirements = 'requirements';
  static const uploadedRequirements = 'uploadedRequirements';
  static const transactions = 'transactions';
}

class FBRealtimeDBCollectionStrings {
  FBRealtimeDBCollectionStrings._();

  static const categories = 'categories';
  static const homepageImages = 'homepageImages';
  static const customerCategoryImages = 'customerCategoryImages';
}
