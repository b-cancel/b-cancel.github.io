'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "a396d12e420ab096e4b373e9ef95e165",
"assets/assets/assets/BryanCancelsResume_10_2020.pdf": "f62297a600ae5ad5600f99233dce93ec",
"assets/assets/fonts/PortfolioIcons.ttf": "1349202f69777724328456aa7621446f",
"assets/assets/miniLoader.gif": "0098d8c7100448172595966afe90273d",
"assets/assets/vcards/Bryan_Cancel.vcf": "30e33d3198e95fc43998e59c3bcd2295",
"assets/FontManifest.json": "8368539e784a4624749c39fd749b422a",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/NOTICES": "0c5dc9f897791476941290e231d2a9f5",
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
"index.html": "1b4f0686d09f7328af5e636512e38e91",
"/": "1b4f0686d09f7328af5e636512e38e91",
"main.dart.js": "18b1960fed91ce5171749fa3c3764841",
"manifest.json": "d27d045a0c173386d93a4368bcf11389",
"miniLoader.gif": "0098d8c7100448172595966afe90273d"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
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
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
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
  if (event.data === 'skipWaiting') {
    return self.skipWaiting();
  }
  if (event.message === 'downloadOffline') {
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
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
