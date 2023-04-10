'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "2908fb10e4e6f7355e86af5b585222c5",
"index.html": "ecbc9875480f9e211a922a396162c26b",
"/": "ecbc9875480f9e211a922a396162c26b",
"main.dart.js": "4485b05462b52c76909a68cd228a8a9d",
"flutter.js": "a85fcf6324d3c4d3ae3be1ae4931e9c5",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "aa9c64e93827f7af46aad09f658d4f11",
"assets/AssetManifest.json": "fca0fe4001707bfb26872e295eb94a76",
"assets/NOTICES": "2507009ecaf70a8df9c4bc605f792a6a",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "26f5af2d93473531f82ef5060f9c6d45",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "1f7cb220b3f5309130bd6d9ad87e0fc0",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4e20cb87b0d43808c49449ffd69b1a74",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/girl.png": "7e417837829ed55c255ac9dadcc4124f",
"assets/assets/images/background.jpg": "6e5ce78f6d89f56bcec74d892e5b4b19",
"assets/assets/images/next.png": "6a3d4de4243284425524b7032c7f498a",
"assets/assets/images/boy.png": "c1178fc4f0aa3e83b943db9b2ca27ed6",
"assets/assets/jpg/crying.jpg": "f36927502949ec70bae62578046ef676",
"assets/assets/jpg/my_image.jpg": "ec35268a7d0736ec1cef1e0bf21287ed",
"assets/assets/logo/spaceman.riv": "b8a10d302091e44c11c51c2d8a72fdf3",
"assets/assets/files/NGUYEN-THE-VINH-TopCV.vn-211022.231944.pdf": "585324713d6706321cd400acbf768020",
"assets/google_fonts/SourceSansPro-BlackItalic.ttf": "119307649b6b56cff60007bc0427f682",
"assets/google_fonts/SourceSansPro-SemiBoldItalic.ttf": "9128546958b012c8991fc25bf89b1962",
"assets/google_fonts/SourceSansPro-Regular.ttf": "47dbe5824a2d82b794ef1f52809699a5",
"assets/google_fonts/SourceSansPro-Bold.ttf": "09ad953751e1109778ece9318df70540",
"assets/google_fonts/SourceSansPro-LightItalic.ttf": "9e85b157c839285dbef77b21566eced0",
"assets/google_fonts/SourceSansPro-Light.ttf": "e7208e0bdca1887f658b9ac66c988a95",
"assets/google_fonts/SourceSansPro-Black.ttf": "6aac2bc43f7aa04f6b6fcb218b51bd6b",
"assets/google_fonts/OFL.txt": "f20c9954e7a1c7c2c3d0fa94b7f5bed6",
"assets/google_fonts/SourceSansPro-ExtraLight.ttf": "9abcaabad7edf02f2033933f0a96221d",
"assets/google_fonts/SourceSansPro-BoldItalic.ttf": "6319587c04e562f16b4d37f7152ba02e",
"assets/google_fonts/SourceSansPro-SemiBold.ttf": "c1b4f417cf21451e85a0baccbfd8edc8",
"assets/google_fonts/SourceSansPro-ExtraLightItalic.ttf": "71bc3fb711b39e83bd24ad7f7775369e",
"assets/google_fonts/SourceSansPro-Italic.ttf": "b556f79ff1e9821d6e27ba9b4a985842",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
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
