import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdManager {
  List<NativeAd> _nativeAds = [];
  bool _nativeAdsAreLoaded = false;

  final String _adUnitId =
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/2247696110' : 'ca-app-pub-3940256099942544/3986624511';

  void loadAds(int numberOfAds, Function(List<NativeAd>) onAdsLoaded,
      Function onAdFailed) {
    _nativeAds.clear(); // Clear previous ads
    _nativeAdsAreLoaded = false;
    final loadedAds = <NativeAd>[];
    for (int i = 0; i < numberOfAds; i++) {
      final ad = NativeAd(
        adUnitId: _adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            loadedAds.add(ad as NativeAd);
            if (loadedAds.length == numberOfAds) {
              _nativeAdsAreLoaded = true;
              onAdsLoaded(loadedAds);
            }
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            onAdFailed();
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(
          templateType: TemplateType.small,
          mainBackgroundColor: Colors.purple,
          cornerRadius: 10.0,
          callToActionTextStyle: NativeTemplateTextStyle(
            textColor: Colors.cyan,
            backgroundColor: Colors.red,
            style: NativeTemplateFontStyle.monospace,
            size: 16.0,
          ),
          primaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.red,
            backgroundColor: Colors.cyan,
            style: NativeTemplateFontStyle.italic,
            size: 16.0,
          ),
          secondaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.green,
            backgroundColor: Colors.black,
            style: NativeTemplateFontStyle.bold,
            size: 16.0,
          ),
          tertiaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.brown,
            backgroundColor: Colors.amber,
            style: NativeTemplateFontStyle.normal,
            size: 16.0,
          ),
        ),
      )..load();
      _nativeAds.add(ad);
    }
  }

  NativeAd? getNativeAd(int index) {
    if (index >= 0 && index < _nativeAds.length) {
      return _nativeAds[index];
    }
    return null;
  }

  void dispose() {
    for (var ad in _nativeAds) {
      ad.dispose();
    }
  }

  bool get areAdsLoaded => _nativeAdsAreLoaded;
}

class NativeAdWidget extends StatelessWidget {
  final NativeAd nativeAd;

  const NativeAdWidget({super.key, required this.nativeAd});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(9)),
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/pfp/default.jpg'),
                        radius: 15,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.left,
                      '• Promoted',
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ],
                ),
              ),
              SafeArea(
                  child: SizedBox(height: 100, child: AdWidget(ad: nativeAd))),
            ],
          ),
        ),
      ],
    );
  }
}
