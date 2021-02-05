import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import 'whatwg-fetch';
import { BrowserRouter } from 'react-router-dom';
import FOODBANKS from './foodbanks.json';
import firebase from 'firebase/app';
import 'firebase/auth';
import 'firebase/database';

// Your web app's Firebase configuration
let firebaseConfig = {
  apiKey: "AIzaSyDIkdmzzE90QdPyCiUeGOAJl1xqiK3Ql-o",
  authDomain: "potluck-43be8.firebaseapp.com",
  databaseURL: "https://potluck-43be8.firebaseio.com",
  projectId: "potluck-43be8",
  storageBucket: "potluck-43be8.appspot.com",
  messagingSenderId: "275937285779",
  appId: "1:275937285779:web:f4c81c6828a581b353df66",
  measurementId: "G-3TSY6WMM7L"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);

ReactDOM.render(
  <BrowserRouter>
    <App foodbanks = {FOODBANKS} />
  </BrowserRouter>,
  document.getElementById('root')
);