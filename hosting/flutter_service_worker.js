'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "bc2549525816da469e1e7b16714d87bb",
"assets/AssetManifest.bin.json": "f8335b8e4158e359870ce0e3184e7551",
"assets/AssetManifest.json": "ef0c5873488732c9ab33eb669c91cce2",
"assets/assets/images/branded_logo.jpg": "85210f1edb05a5600520073859dbba66",
"assets/assets/images/logo.jpg": "8f116ece5f892e7462aaf10b08836b59",
"assets/assets/images/logo_no_back.png": "7645b07ac28e54ff661850e7075878e5",
"assets/assets/lottie_animations/delete.json": "f61e4bd050663f5fb1d0decb32142b40",
"assets/assets/lottie_animations/email_verification.json": "23a922b9bab83ad1e5c08719a7f59b7d",
"assets/assets/lottie_animations/noInternetAnim.json": "619052538a7b6bc6acdae85366f834fe",
"assets/assets/lottie_animations/noSessions.json": "76e79c2f3c77381e218fa0ff07d66747",
"assets/assets/lottie_animations/password_reset.json": "482b4e6bbb1e5507f2f805928d7b2390",
"assets/assets/lottie_animations/rocket_animation.json": "3c65c1b3a7dd4a72c41fcac0bdcd5d21",
"assets/assets/sounds/startup.mp3": "f9bce9a76451b0e38ced18dfb8df4835",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "ae7d84f94b7b3fd1fb8db93362dd189c",
"assets/NOTICES": "87121fe8f2a456b637e14a8379373516",
"assets/packages/animated_snack_bar/assets/monochrome/check-circle.svg": "f6d9dd67711da5b6d4d965f66c10cd07",
"assets/packages/animated_snack_bar/assets/monochrome/comment-dots.svg": "44311bf381ea1155bfe38c40d44c577a",
"assets/packages/animated_snack_bar/assets/monochrome/exclamation-circle.svg": "63ffc503c8e024f9752866e021afb744",
"assets/packages/animated_snack_bar/assets/monochrome/exclamation-octagon.svg": "ab5fb6de2478b95f911cebb5cf6af9c3",
"assets/packages/animated_snack_bar/assets/monochrome/exclamation-triangle.svg": "10427de487dc532646c4a11f6be3fe84",
"assets/packages/animated_snack_bar/assets/regular/check-circle.svg": "0936541fbbf9ebf325169373c2d2439a",
"assets/packages/animated_snack_bar/assets/regular/exclamation-circle.svg": "69c777fe5b9ffd2f8286ca47f98d1a31",
"assets/packages/animated_snack_bar/assets/regular/exclamation-triangle.svg": "57a895d149648e4b69c7681d4efb2052",
"assets/packages/animated_snack_bar/assets/regular/info-circle.svg": "e733e8ecda8758e6b69d20cc1ca1c6c4",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/sign_button/images/amazon.png": "af00fbd77763d45afd0131b85e5f78a5",
"assets/packages/sign_button/images/apple.png": "c82fbe8cbcecaa462da7bd30015b3565",
"assets/packages/sign_button/images/appleDark.png": "11238aa9e757b14b5e3460b467e6a2b4",
"assets/packages/sign_button/images/discord.png": "58b6fbbd693837c7782e3efae4619c17",
"assets/packages/sign_button/images/discordCircle.png": "eef106bd4d8b58cf3ef1d257fa53b93e",
"assets/packages/sign_button/images/facebook.png": "f4dfe9871ac8cce8278c2aba8c897e1d",
"assets/packages/sign_button/images/facebookDark.png": "deface349f4fd6bece4039901e8c6c44",
"assets/packages/sign_button/images/github.png": "c67686f615f334806a07d41d594c34c1",
"assets/packages/sign_button/images/githubDark.png": "561b115749533c422a8c02e4843c73d2",
"assets/packages/sign_button/images/google.png": "46039fa62c3167028c4fdb86816c3363",
"assets/packages/sign_button/images/googleDark.png": "3a7df7781108618c2b3d05a5121abdfc",
"assets/packages/sign_button/images/instagram.png": "6c356b0bd4b0f7f80046fc2557e85757",
"assets/packages/sign_button/images/linkedin.png": "e4ae6d8c444c75a24d02cd9995072297",
"assets/packages/sign_button/images/mail.png": "c9172bdda51109489593c86da58f10e8",
"assets/packages/sign_button/images/microsoft.png": "dfb60902957a3204c63d4d3de2ae76ff",
"assets/packages/sign_button/images/pinterest.png": "4e9b78531f5968aad62a1ec26eb75b18",
"assets/packages/sign_button/images/quora.png": "b10aaad4707aad91cbab341ef33ea56c",
"assets/packages/sign_button/images/reddit.png": "1b200a970d87b9ab578ac556b24cf16b",
"assets/packages/sign_button/images/tumblr.png": "695506da08f97651af960af9f268dcc4",
"assets/packages/sign_button/images/twitter.png": "08ed456da7c064a42ed528098c78dfc0",
"assets/packages/sign_button/images/twitterX.png": "6fe57f119159e49f33816e9989b8bc87",
"assets/packages/sign_button/images/yahoo.png": "8d028327c009ae90e08ebfd965176f8b",
"assets/packages/sign_button/images/youtube.png": "615f39ecf21272fec7eceb7984ed8959",
"assets/packages/speedometer_chart/assets/arc.svg": "f6372b785f71d8b428b802fa9ded9174",
"assets/packages/speedometer_chart/assets/arc_tick_1.svg": "9f0c1da01cbe2b6119cc3f6b97eed2b6",
"assets/packages/speedometer_chart/assets/arc_tick_2.svg": "aaf86d5813cdaeaf7154b07f2dd75837",
"assets/packages/speedometer_chart/assets/pointer.svg": "c2f3bd10483ee3f93f828f1bc90185d3",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "7e8dc21231eb578ee00a91a96c729cdb",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "f58c248fe56a324792bb4b42a4e5b276",
"icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/favicon-16x16.png": "d9e623a547350e06719bb9a6c2314a37",
"icons/favicon-32x32.png": "6b763150485858f19c160ae96fa70a94",
"icons/favicon-96x96.png": "c846cf6508d77a9799537db52a5dc282",
"icons/favicon.ico": "b915ab700c95e230c89d90e705b99979",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/manifest.json": "b58fcfa7628c9205cb11a1b2c3e8f99a",
"index.html": "63c58546eea697c5c18014ced60acc58",
"/": "63c58546eea697c5c18014ced60acc58",
"main.dart.js": "374baeb22889eea8a612e5a2316456b2",
"manifest.json": "420e601d6c1fe0661d14479d59553be1",
"splash/img/dark-1x.png": "d4fd843e399281a80b04545306af5251",
"splash/img/dark-2x.png": "bfa82350b9d633cf1fb82c8d41964b50",
"splash/img/dark-3x.png": "df9a81d55d151b22bb7fbba3a0b5cb0d",
"splash/img/dark-4x.png": "b962bb70e9c5d8fbfbef9e51977a3568",
"splash/img/light-1x.png": "d4fd843e399281a80b04545306af5251",
"splash/img/light-2x.png": "bfa82350b9d633cf1fb82c8d41964b50",
"splash/img/light-3x.png": "df9a81d55d151b22bb7fbba3a0b5cb0d",
"splash/img/light-4x.png": "b962bb70e9c5d8fbfbef9e51977a3568",
"version.json": "486b01c9b9db7f8419d1f8f1f138a299"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
