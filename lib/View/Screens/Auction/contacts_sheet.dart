import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/app_logger.dart';
import '../../../utils/constants.dart';

class ContactsSheet extends StatefulWidget {
  const ContactsSheet({super.key});

  @override
  State<ContactsSheet> createState() => _ContactsSheetState();
}

class _ContactsSheetState extends State<ContactsSheet> {
  String mobileNumber = "+91 9999999999";

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Dimensions.screenWidth(context),
        padding: const EdgeInsets.all(16),
        child: Container(
          width: Dimensions.screenWidth(context),
          height: 400,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact Franchise",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return contactCard();
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget contactCard() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 8,
        left: 2,
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              width: 1, color: Theme.of(context).colorScheme.outline)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Lufga',
                    color: Theme.of(context).colorScheme.surfaceDim,
                  ),
                  children: [
                    const TextSpan(
                      text: "Suresh",
                    ),
                    TextSpan(
                        text: "\n+91 9182726356",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.surfaceDim)),
                  ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => copyToClipboard(context),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  child: Icon(
                    Icons.copy,
                    color: Theme.of(context).colorScheme.surfaceDim,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () => openDialer,
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(
                    Icons.call,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: mobileNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Copied to clipboard: $mobileNumber")),
    );
  }

  void openDialer() async {
    final Uri dialerUri = Uri(scheme: "tel", path: mobileNumber);
    if (await canLaunchUrl(dialerUri)) {
      await launchUrl(dialerUri);
    } else {
      AppLogger.log("Could not open dialer");
    }
  }
}
