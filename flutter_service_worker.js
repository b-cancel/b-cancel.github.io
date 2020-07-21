'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "894be1ce9c71f0195e02def372f68756",
"assets/assets/fonts/PortfolioIcons.ttf": "1349202f69777724328456aa7621446f",
"assets/FontManifest.json": "20d01602a32ed903679c1106a208e5fb",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/google_fonts/LICENSE.txt": "d273d63619c9aeaf15cdaf76422c4f87",
"assets/google_fonts/RobotoMono-Bold.ttf": "7c13b04382bb3c4a6a50211300a1b072",
"assets/google_fonts/RobotoMono-BoldItalic.ttf": "4a0b78a48050f97c16ef6fc518afd362",
"assets/google_fonts/RobotoMono-Italic.ttf": "c37c35a80051edc42d141ec301066052",
"assets/google_fonts/RobotoMono-Light.ttf": "9d1044ccdbba0efa9a2bfc719a446702",
"assets/google_fonts/RobotoMono-LightItalic.ttf": "85fb02352b0167446e71a91a35d4d6cc",
"assets/google_fonts/RobotoMono-Medium.ttf": "7cfbd4284ec01b7ace2f8edb5cddae84",
"assets/google_fonts/RobotoMono-MediumItalic.ttf": "c1d4ca93da41dc3f8382ec6798d3708e",
"assets/google_fonts/RobotoMono-Regular.ttf": "b4618f1f7f4cee0ac09873fcc5a966f9",
"assets/google_fonts/RobotoMono-Thin.ttf": "288302ea531af8be59f6ac2b5bbbfdd3",
"assets/google_fonts/RobotoMono-ThinItalic.ttf": "355d559cc860016a068bcd16b66e4bd3",
"assets/NOTICES": "cd985b669ee7e5d56559614cdc2a6a12",
"assets/packages/giphy_picker/assets/PoweredBy_200px-Black_HorizText.png": "439da1ed3ca70fb090eb98698485c21e",
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
"index.html": "110577fc0a42c78821acbbbb4285b409",
"/": "110577fc0a42c78821acbbbb4285b409",
"main.dart.js": "6614da984fbc925b7b5ddfb070e5c798",
"manifest.json": "d27d045a0c173386d93a4368bcf11389"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/LICENSE",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      // Provide a no-cache param to ensure the latest version is downloaded.
      return cache.addAll(CORE.map((value) => new Request(value, {'cache': 'no-cache'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');

      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }

      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#')) {
    key = '/';
  }
  // If the URL is not the the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache. Ensure the resources are not cached
        // by the browser for longer than the service worker expects.
        var modifiedRequest = new Request(event.request, {'cache': 'no-cache'});
        return response || fetch(modifiedRequest).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.message == 'skipWaiting') {
    return self.skipWaiting();
  }

  if (event.message = 'downloadOffline') {
    downloadOffline();
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.add(resourceKey);
    }
  }
  return Cache.addAll(resources);
}
