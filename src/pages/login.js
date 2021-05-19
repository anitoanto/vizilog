import React from "react";
import NavBar from "@components/NavBar/NavBar";
import "firebase/auth";
import "./common.css";
import firebase from "gatsby-plugin-firebase";
import { navigate } from "gatsby-link";

export default function login() {
  function signIn() {
    var provider = new firebase.auth.GoogleAuthProvider();

    firebase
      .auth()
      .signInWithPopup(provider)
      .then((result) => {
        var credential = result.credential;

        // This gives you a Google Access Token. You can use it to access the Google API.
        var token = credential.accessToken;
        // The signed-in user info.
        var user = result.user;
        console.log(user.uid, user.displayName);
        navigate("/qrcode");
      })
      .catch((error) => {
        // Handle Errors here.
        var errorCode = error.code;
        var errorMessage = error.message;
        // The email of the user's account used.
        var email = error.email;
        // The firebase.auth.AuthCredential type that was used.
        var credential = error.credential;
        // ...
      });
  }
  return (
    <div>
      <NavBar />
      <div className="xcenter login">
        <button className="sgoogle" onClick={signIn}>
          Sign in with google
        </button>
      </div>
    </div>
  );
}
