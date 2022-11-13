const String tablesettings='tbl_settingss';
const String tablesettingsid='id';
const String tablesettingsprevswitch='prevswitch';
const String tablesettingsshowansswitch='showansswitch';
const String tablesettingstimelimitedwitch='timelimitedswitch';

class SettingsModel{
  int? id;
  int? prevswitch;
  int? showansswitch;
  int? timelimitedswitch;

  SettingsModel(
      {this.id,
        this.prevswitch,
        this.showansswitch,
        this.timelimitedswitch});

  Map<String,dynamic> toMap(){
    var map=<String,dynamic>{
      tablesettingsprevswitch:prevswitch,
      tablesettingsshowansswitch:showansswitch,
      tablesettingstimelimitedwitch:timelimitedswitch,
    };
    if(id!=null){
      map[tablesettingsid]=id;
    }
    return map;
  }
  factory SettingsModel.fromMap(Map<String, dynamic> map) => SettingsModel(
      id: map[tablesettingsid],
      prevswitch: map[tablesettingsprevswitch],
      showansswitch: map[tablesettingsshowansswitch],
      timelimitedswitch: map[tablesettingstimelimitedwitch],
  );
}