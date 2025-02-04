

import '../main.dart';

String autoLoginJS(){
  if(MyApp.localStorage.get("nik").toString().length==16) {
    return "\$('#nik-input').val(${MyApp.localStorage.get("nik").toString()});"
        "\$('#password-input').val(${MyApp.localStorage.get("pass")
        .toString()});"
        "\$( '#submit-button' ).trigger( 'click' );";
  }else{
    return "false";
  }
}