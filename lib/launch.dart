import 'package:url_launcher/url_launcher.dart';
class UrlLauncher{
  UrlLauncher._();
  static final urlLuncher=  UrlLauncher._();
  String _url;

  lunch(_url)async{
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  sendPhone(){
    try{
      _url="tel:+972 59-558-8163";
      lunch(_url);
    }catch(e){
      print(e);
    }
  }

  openWhatsApp(var num){
    try{
      _url="https://wa.me/$num";
      lunch(_url);
    }catch(e){
      print(e);
    }
  }

  openFacebook(){
    try{
      _url="https://www.facebook.com/AbrarCenter";
      lunch(_url);
    }catch(e){
      print(e);
    }
  }







}
