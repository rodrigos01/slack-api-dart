import 'dart:io';
import 'dart:convert';
import 'dart:mirrors';

import 'config/routes.dart';

void main() {
  
  HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 4040).then((server) {
    print("listening on 4040");
    server.listen((req) {
    
      print("proccessing ${req.method} on ${req.uri}");
      
      ContentType contentType = req.headers.contentType;
      BytesBuilder builder = new BytesBuilder();
      
      if (req.method == 'POST') {
        req.listen((buffer) {
          builder.add(buffer);
        }, onDone: () {
          
          String reqString = UTF8.decode(builder.takeBytes());
          
          print(reqString);
          
          Map parameters = Uri.splitQueryString(reqString);
          
          boot(parameters, req.response);
          
          //req.response.headers.contentType = new ContentType("application", "json", charset: "utf-8");
          req.response.close();
          print("Request ended");
        });
      } else {
        req.response.statusCode = HttpStatus.METHOD_NOT_ALLOWED;
        req.response.write("Unsupported request: ${req.method}.");
        req.response.close();
      }
    });
  });
  
}

void boot(Map parameters, HttpResponse res) {
  
  List call = parameters['text'].split(": ");
  String module = call[0];
  Symbol method = new Symbol(call[1]);
  
  if(!routes.containsKey(module)) {
    res.statusCode = HttpStatus.NOT_FOUND;
    return;
  }
  
  res.write("{\"text\": \"");
  res.write("*Browserstack [DART] infos:* \\n\\n");
  
  InstanceMirror moduleMirror = reflect(routes[module]);
  moduleMirror.invoke(method, [parameters, res]);
  
  res.write("\"}");
  
}
