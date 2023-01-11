// ignore_for_file: camel_case_types

abstract class AppStates {}

class InitialAppState extends AppStates {}

class ChangeBottomNavState extends AppStates {}

class changeSelectedCountryState extends AppStates {}

class changeSelectedCategoryState extends AppStates {}

class GetDataFormApiState extends AppStates {}

class GetSearchDataState extends AppStates {}

class CreateDatabaseState extends AppStates {}

class LoadingDuringGettingDataFromApi extends AppStates {}

class InsertToDatabaseState extends AppStates {}

class GetDataFromDatabaseState extends AppStates {}

class DeletedItemFromDatabaseState extends AppStates {}
