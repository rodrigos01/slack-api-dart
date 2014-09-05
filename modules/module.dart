import 'dart:io';

class module {
  
  
  noSuchMethod(Invocation invocation) {
    
    HttpResponse res = invocation.positionalArguments[1];
    res.statusCode = HttpStatus.NOT_FOUND;
  }
}