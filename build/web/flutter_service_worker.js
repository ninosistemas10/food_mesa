'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "774e2e3e65cf8f255209da7d9745c706",
"index.html": "a35dcc456f374fc5c8aafc668140b817",
"/": "a35dcc456f374fc5c8aafc668140b817",
"main.dart.js": "ecb586731548f7f497c514d794251ded",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "3909cece22959fe2415df5b3e2dfed75",
"assets/AssetManifest.json": "d800feedf71f72233b6c48631af9984a",
"assets/NOTICES": "cb7c828c2ddb0e969b2a1b9301b2ef95",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/AssetManifest.bin.json": "1d1a8f5f85591b3cc8e4c7fe1c0e8731",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "cdb744a0ed1281270a0b0db57ab45ef2",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "5cd42286b625fed18cefca810b518053",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "e551f22e4ec1212d53f9a3d4ba64eac6",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.bin": "23acf5635d940592e66582ab2ffb3073",
"assets/fonts/MaterialIcons-Regular.otf": "22d87e5367a24a77b95a5cbb6f6ef6b7",
"assets/assets/categoria/pizza-item.png": "1283c82e64ebd19c09861faddeddd09d",
"assets/assets/categoria/Spaghetti.png": "d1be65b6efe15f2378ed6a475eccc9cf",
"assets/assets/categoria/hotdog.png": "70d1c45508c7a9ed3a187e2473ef04e6",
"assets/assets/categoria/drink.png": "160c6ace2a9339b30e1e572e1af69b9d",
"assets/assets/categoria/Pizza.png": "f2fa0da88b2c2a0ef6dc6b344d610bbe",
"assets/assets/categoria/sandwich.jpg": "50beb767f0e4132673fad1c6f86f6db3",
"assets/assets/categoria/bar.png": "c23e294cce5da3ad68ffbfa29dd58688",
"assets/assets/categoria/coke.png": "572fdf17b714ff4faffdb9431027b7ed",
"assets/assets/categoria/burger.png": "b4942f2eff7a787a7b28cce0ab6a937c",
"assets/assets/producto/sandwich.jpg": "50beb767f0e4132673fad1c6f86f6db3",
"assets/assets/images/male.png": "846f4af28e42d3cda45d88e32fcd8559",
"assets/assets/images/3410506.jpg": "a2031aca36d2c888f4e6173a57d7c1c8",
"assets/assets/images/madeleyn.jpeg": "7a181ed9da4efa5bd5eeacd56f8b061b",
"assets/assets/images/logop.png": "a2c532837d2f61af6808354603789444",
"assets/assets/images/menu.png": "5eb663a75cf539d561842d2aaceae7d0",
"assets/assets/images/cafe2.jpeg": "8d4291f8cbc9b3a8e28bdbb0d3e9bd92",
"assets/assets/images/logo.png": "135feac0ab16de8a311c9f90b29ecec0",
"assets/assets/images/notification_image.png": "0d291870bd273d45bfc2811cddf7c107",
"assets/assets/images/made.png": "a280d7779dfbd7ad2f8695d54d987cc6",
"assets/assets/images/more.png": "48872501243cd173e89b04d1693ae5f2",
"assets/assets/image/cafe%2520.png": "57225966256cd457ba6eabc87bfde29f",
"assets/assets/image/image1.jpeg": "a2c07ba901c8fcb07c2f5a0d15b41ea8",
"assets/assets/image/image6.jpeg": "15e0070bc4e7c6d4ed2cd9b9bd6a9cf9",
"assets/assets/image/image4.jpeg": "e18b808096ca131b336f0a2edcc75fa9",
"assets/assets/image/image5.jpeg": "2b260236cae2a272084477ab9a20cddf",
"assets/assets/image/image2.jpeg": "f74def0b7d33c559f34ede4c9b612fb6",
"assets/assets/image/image3.jpeg": "7ee174a88e1ca56683e0d02d965912f7",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
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
  for (var resourceKey of Object.keys(RESOURCES)) {
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
