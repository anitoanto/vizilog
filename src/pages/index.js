import React from "react";
import * as index from "../styles/index.module.css";
import "./global.css";
export default function Index() {
  return (
    <div>
      <nav className={index.nav}>
        <ul>
          <li>Home</li>
          <li>Login</li>
          <li>Github</li>
        </ul>
      </nav>
      <div>
        <div className={index.content}>
          <div>
            <h1>ViziLog, simple solution to log your customer identity.</h1>
            <br />
            <p>Use the app for registering your user with QR code.</p>
          </div>
          <div>
            <img src={"/undraw_color__schemes_wv48.png"} alt="image" />
          </div>
        </div>
        <div className="xcenter">Build for Build From Home 2021</div>
      </div>
    </div>
  );
}
