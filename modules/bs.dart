import 'dart:io';
import 'module.dart';

class BS extends module {
  
  
  void info(Map parameters, HttpResponse res) {
    
    parameters.forEach( (k, v) {
      print("parameters[${k}] = ${v}");
    });
    
    res.write("**info**");
    
  }
  
  void status(Map parameters, HttpResponse res) {
    
    
    res.write("**status**");
  }
  
}