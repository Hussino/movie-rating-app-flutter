import 'package:movies/db/db_helper.dart';
import 'package:movies/models/UserModel.dart';

class UserRepository
{
  Future<List<UserModel>> getAll()async{
    try{
      await Future.delayed(Duration(seconds: 1));
      var result = await DbHelper().getAll(DbTables.Users);
      List<UserModel> userlist = [];
      if(result != null)
        {for(var item in result)
            {
              userlist.add(UserModel.fromJson(item));
            }
        }
      return userlist;
    }
    catch(e){
      rethrow;
    }
  }
  Future<UserModel?> getUserById(int id)async{
    try{
      var result = await DbHelper().getById(DbTables.Users, id);
      if (result != null)
        {
          return UserModel.fromJson(result);
        }
      return null;
    }
    catch(e){
      rethrow;
    }
  }

  Future<int> addUser(Map<String, dynamic>obj)async
  {
    try
    {
      await Future.delayed(Duration(seconds: 1));
      var result = await DbHelper().add(DbTables.Users, obj);
      return result;
    }
    catch(e)
    {
      return 0;
    }
  }

  Future<int> editUser(Map<String, dynamic>obj, id)async
  {
    try
    {
      var result = await DbHelper().update(DbTables.Users, obj, id);
      return result;
    }
    catch(e)
    {
      return 0;
    }
  }

  Future<int> deleteUser(int Id)async
  {
    try
    {
      await Future.delayed(Duration(seconds: 1));
      var result = await DbHelper().delete(DbTables.Users, Id);
      return result;
    }
    catch(e)
    {
      return 0;
    }
  }
}