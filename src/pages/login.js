import React from "react";
import NavBar from "@components/NavBar/NavBar";
import "./common.css";

export default function login() {
  function signIn() {
    // login
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
