'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "eef281e5a2e977a07c879e9aefa194d1",
"assets/assets/face/white.png": "96e5af238d41c3b724ed489101f825ce",
"assets/assets/qrCode.png": "b167196513f0837c1b3d4e77babbbab0",
"assets/assets/title/large.gif": "17ab3532d35a610277b494b2712875ee",
"assets/assets/title/small.gif": "28d38cee5b1adadbfaedcc38e7bf3dc2",
"assets/assets/vcards/Bryan_Cancel_Contact_V2P1.vcf": "327d07c6bc5aecac573f1d99a2e75329",
"assets/FontManifest.json": "94a2494f1e7ff74a7d0b6cf4f3d4e39d",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/LICENSE": "773f4d87b1994cc464ad89078a3c5cf9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/flutter_icons/fonts/AntDesign.ttf": "3a2ba31570920eeb9b1d217cabe58315",
"assets/packages/flutter_icons/fonts/Entypo.ttf": "744ce60078c17d86006dd0edabcd59a7",
"assets/packages/flutter_icons/fonts/EvilIcons.ttf": "140c53a7643ea949007aa9a282153849",
"assets/packages/flutter_icons/fonts/Feather.ttf": "6beba7e6834963f7f171d3bdd075c915",
"assets/packages/flutter_icons/fonts/FontAwesome.ttf": "b06871f281fee6b241d60582ae9369b9",
"assets/packages/flutter_icons/fonts/FontAwesome5_Brands.ttf": "c39278f7abfc798a241551194f55e29f",
"assets/packages/flutter_icons/fonts/FontAwesome5_Regular.ttf": "f6c6f6c8cb7784254ad00056f6fbd74e",
"assets/packages/flutter_icons/fonts/FontAwesome5_Solid.ttf": "b70cea0339374107969eb53e5b1f603f",
"assets/packages/flutter_icons/fonts/Foundation.ttf": "e20945d7c929279ef7a6f1db184a4470",
"assets/packages/flutter_icons/fonts/Ionicons.ttf": "b2e0fc821c6886fb3940f85a3320003e",
"assets/packages/flutter_icons/fonts/MaterialCommunityIcons.ttf": "3c851d60ad5ef3f2fe43ebd263490d78",
"assets/packages/flutter_icons/fonts/MaterialIcons.ttf": "a37b0c01c0baf1888ca812cc0508f6e2",
"assets/packages/flutter_icons/fonts/Octicons.ttf": "73b8cff012825060b308d2162f31dbb2",
"assets/packages/flutter_icons/fonts/SimpleLineIcons.ttf": "d2285965fe34b05465047401b8595dd0",
"assets/packages/flutter_icons/fonts/weathericons.ttf": "4618f0de2a818e7ad3fe880e0b74d04a",
"assets/packages/flutter_icons/fonts/Zocial.ttf": "5cdf883b18a5651a29a4d1ef276d2457",
"faviconit/browserconfig.xml": "2077dd3fa170043e91525d9cd4cdd1ac",
"faviconit/favicon-114.png": "ac68092d20f0e6f924c4716babb7bd76",
"faviconit/favicon-120.png": "77fac968f73e94320e493fa064b8a563",
"faviconit/favicon-144.png": "ec2c3ec1f900c22124e53063c1910161",
"faviconit/favicon-150.png": "f842f38f2469539adda680c2f002dbc7",
"faviconit/favicon-152.png": "e87d9916ff42811a0e91c9f73a53adb8",
"faviconit/favicon-16.png": "4d6691541b612ce1004f94578f96537b",
"faviconit/favicon-160.png": "7f030a13df5eb990e34878e679569b74",
"faviconit/favicon-180.png": "5511aaf99cb8e3a61c6ce53b359528bb",
"faviconit/favicon-192.png": "0132065bf5fdadbac04e39a3463e220f",
"faviconit/favicon-310.png": "0abe029e12d008ec0b5ee2c1d32a6d83",
"faviconit/favicon-32.png": "a387b07572a916d38a167da3739c86a1",
"faviconit/favicon-57.png": "fa5665ad6f43d44d60877dae65593aff",
"faviconit/favicon-60.png": "5a519cedc411f36ccfa20a4e558347da",
"faviconit/favicon-64.png": "3317e7264e3b5c0149c50390746eddd4",
"faviconit/favicon-70.png": "5246815e5ba306d7157210f5c0cce97b",
"faviconit/favicon-72.png": "63003c9bd48bb79da3cd83ef68f39291",
"faviconit/favicon-76.png": "4e89bcaadbeea5e04307998c516bfd60",
"faviconit/favicon-96.png": "bfec43944dbeb6f416e57b4144ff98d8",
"faviconit/favicon.ico": "d9578e79850907c2d75fb6d2727626e9",
"faviconit/faviconit-instructions.txt": "53f9f214c478b425a7fb737b9f02eb1e",
"index.html": "76f5be450c11f2bf637369050ff28d99",
"/": "76f5be450c11f2bf637369050ff28d99",
"main.dart.js": "56a5bb8c0a3b3bbe38fb8c74434939d2",
"manifest.json": "14e919b7b1dde549ab334b7ee3ce8412"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
