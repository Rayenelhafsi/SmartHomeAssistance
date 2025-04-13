// firebase-messaging-sw.js
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging-compat.js');

// Initialize Firebase
firebase.initializeApp({
    apiKey: "AIzaSyB123FsYcRUJBi5Y1wG5trTwWhgT2Qvntw",
    authDomain: "auth-firebase-7a66e.firebaseapp.com",
    databaseURL: "https://auth-firebase-7a66e-default-rtdb.europe-west1.firebasedatabase.app",
    projectId: "auth-firebase-7a66e",
    storageBucket: "auth-firebase-7a66e.firebasestorage.app",
    messagingSenderId: "42087615644",
    appId: "1:42087615644:web:9343fa9ca6b997f5187159"
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/firebase-logo.png', // Optional: Add an icon for the notification
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});