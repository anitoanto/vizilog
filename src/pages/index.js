import React from "react";
import * as index from "../styles/index.module.css";
import "./global.css";
import NavBar from "@components/NavBar/NavBar.js";
export default function Index() {
  return (
    <div>
      <NavBar />
      <div>
        <div className={index.content}>
          <div>
            <h1>ViziLog, simple solution to log your customer identity.</h1>
            <br />
            <p>Use the app for registering your user with QR code.</p>
          </div>
          <div>
            <img
              src={"/undraw_color__schemes_wv48.png"}
              alt="image"
              className={index.indexImg}
            />
          </div>
        </div>
        <div className="xcenter footer">Build for Build From Home 2021</div>
      </div>
    </div>
  );
}
