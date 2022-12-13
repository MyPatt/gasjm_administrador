importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-messaging-compat.js");

//firebaseConfig from Firebase Console 
const firebaseConfig = {
    apiKey: "AIzaSyDVl6jmty8Yj9xB80Au-6Tp4roEpXTNcxw",
    authDomain: "gasjm-01.firebaseapp.com",
    databaseURL: "https://gasjm-01-default-rtdb.europe-west1.firebasedatabase.app",
    projectId: "gasjm-01",
    storageBucket: "gasjm-01.appspot.com",
    messagingSenderId: "252556961056",
    appId: "1:252556961056:web:a35f536f1ebaa7c3f0e345",
    measurementId: "G-XEPDDH42WP"
  };



firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

// todo Set up background message handler
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
 });