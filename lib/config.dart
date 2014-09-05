import 'dart:io';
import 'dart:convert';

final __ROOT_DIR = Platform.environment['PWD'];

class config {
  
  static final string = new File(__ROOT_DIR+"/config.json");
  
  
}