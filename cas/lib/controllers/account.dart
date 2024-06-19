
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';

class AccountController extends GetxController{

  Client client = Client();
  late Databases database;
  var isLoggedin = false.obs;
  late Account account;
  User? loggedInUser;
  late String docID;


  @override
  void onInit() {
    // TODO: implement onInit
    createClient();
    getAccount();
    // getPrefs();
    super.onInit();
  }

  void createClient(){
    client
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('6672177000182e7229f9') //
    .setSelfSigned(status: true);
    account = Account(client);
  }

  void getAccount() async{
    try{
      var user = await account.get();

    loggedInUser =user;
    if(loggedInUser!=null){
    isLoggedin.value = true;
    // updatePrefs();
    print('Logged in ass ${user.name}');
    if(user.prefs.data.isEmpty){
  }else {
    
  }
  } 
    } on AppwriteException catch(e){
      //
    }
   
  }

  Future<bool> login(email,password) async {
    bool log = false;
    var session = await account.createEmailPasswordSession(
    email: email,
    password: password,
  );


  var user = await account.get();

  loggedInUser =user;
  if(loggedInUser!=null){
    isLoggedin.value = true;
    log  = true;
    print('Logged in as ${user.name}');
  }

// print("Hello ${3+3}");

  return log;
  }
  void logout() async{
    await account.deleteSession(
    sessionId: 'current',
  );
  loggedInUser = null;
      isLoggedin.value = false;
    }
  Future<bool> createAccount({required String email, required String password, required String name}) async{
   bool log = false;
   
       User result = await account.create(
    userId: ID.unique(),
    email: email,
    password: password,
    name: name, // optional
);
  bool success = await login(email, password);

  if(success){
    print('Hello World');
      log = true;
  }

  //  } on AppwriteException {
  //   return false;
    
  //  }
   return log;
  }


 
}