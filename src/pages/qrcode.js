import React, { useEffect, useState } from "react";
import "firebase/auth";
import "./common.css";
import firebase from "gatsby-plugin-firebase";
import { navigate } from "gatsby-link";
import QRCode from "react-qr-code";

export default function Qrcode() {
  const [msg, setMsg] = useState("");
  const [shopName, setShopName] = useState("");
  var uid;
  useEffect(async () => {
    let check = firebase.auth().onAuthStateChanged(function (user) {
      if (user) {
        uid = user.id;
        setMsg(user.uid + "," + shopName);
      } else {
        navigate("/login");
      }
    });
  });

  function logout() {
    firebase.auth().signOut();
    navigate("/");
  }

  function changeQR(e) {
    setShopName(e.target.value);
  }
  return (
    <>
      <div className="xcenter">
        <h2 className="head">Admin Panel</h2>
        <div className="content">
          <div>
            <input
              type="text"
              className={"shopename"}
              placeholder="Shop name"
              onChange={(e) => changeQR(e)}
            />
            <h1>Share this QR Code for logging your customers.</h1>
            <br />
            {msg != "" ? (
              <QRCode value={msg} />
            ) : (
              <div>Loading QR code ... please wait ...</div>
            )}
          </div>
          <div>
            <img src={"/undraw_Web_developer_re_h7ie.png"} alt="" />
          </div>
        </div>
        <button className="sgoogle" onClick={logout}>
          Logout
        </button>
        <br />
      </div>
      <div className="head2">
        <h2 className="">Customer Logs</h2>
        <br />
        <div>logs here</div>
      </div>
    </>
  );
}
