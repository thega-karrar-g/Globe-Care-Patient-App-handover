import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class Launcher {
  static phoneCall(String phone) async {
    //  var url='tel:$phone';
    String url = Platform.isIOS ? 'tel://$phone' : 'tel:$phone';
    //controller.saveProfileForm(_profileForm);
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl( Uri.parse( url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static openEmail(String email,
      {String subject = '', String body = ''}) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': subject,
        'body': body,
      }),
    );

    launchUrl( Uri.parse( emailLaunchUri.toString()));
    try {
      await launchUrl( Uri.parse( emailLaunchUri.toString()));
    } catch (e) {
      await launchUrl( Uri.parse( emailLaunchUri.toString(),));
    }
  }

  static Future<void> launchInBrowser(String url,{bool externalApp=false}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl( Uri.parse(
      url,

      ),
        mode:externalApp? LaunchMode.externalApplication:LaunchMode.platformDefault
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static openWhatsApp(String phone) async {
    var url = '';
    if (Platform.isAndroid) {
      // add the [https]
      url = "https://wa.me/$phone/?text="; // new line
    } else {
      // add the [https]
      // url= "https://api.whatsapp.com/send?phone=$phone=${Uri.parse('')}"; // new line
      url = "https://wa.me/$phone"; // new line
    }

    if (await canLaunchUrl(Uri.parse(url),)) {
      await launchUrl( Uri.parse( (url)),mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  static openFacebook() async {
    String fbPageId = '105313478699877',
        fbPageName = 'Globcare-105313478699877';

    String fbProtocolUrl = '';
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/$fbPageId';
    } else {
      fbProtocolUrl = 'fb://page/$fbPageId';
    }

    String fallbackUrl = 'https://www.facebook.com/$fbPageName';

    try {
      bool launched = await launchUrl( Uri.parse( fbProtocolUrl),  );

      if (!launched) {
        await launchUrl( Uri.parse( (fallbackUrl),));
      }
    } catch (e) {
      await launchUrl( Uri.parse( fallbackUrl,));
    }
  }

  static openInstagram() async {
    var url = 'https://www.instagram.com/glob_care';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(
        url),
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  static openTwitter() async {
    var url = 'https://twitter.com/glob_care';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl( Uri.parse(
      url),
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }
}
