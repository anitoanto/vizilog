import React, { useEffect, useState } from "react";
import "firebase/auth";
import "firebase/firestore";

import "./common.css";
import firebase from "gatsby-plugin-firebase";
import { navigate } from "gatsby-link";
import QRCode from "react-qr-code";

import DialogActions from "@material-ui/core/DialogActions";
import DialogContent from "@material-ui/core/DialogContent";
import DialogTitle from "@material-ui/core/DialogTitle";
import DialogContentText from "@material-ui/core/DialogContentText";
import Dialog from "@material-ui/core/Dialog";
import Button from "@material-ui/core/Button";

export default function Qrcode() {
  const [msg, setMsg] = useState("");
  const [shopName, setShopName] = useState("");
  var uid;
  useEffect(async () => {
    let check = firebase.auth().onAuthStateChanged(function (user) {
      if (user) {
        uid = user.id;
        setMsg(user.uid + "," + shopName.trim().toLowerCase());
      } else {
        navigate("/login");
      }
    });
  }, [shopName]);

  useEffect(() => {
    loadLogs();
  }, []);

  const [customers, setCustomers] = useState([]);

  function loadLogs() {
    let customersList = [];
    firebase.auth().onAuthStateChanged(function (user) {
      // console.log(user.uid);
      if (user) {
        firebase
          .firestore()
          .collection("shopEntries")
          .where("merchantId", "==", user.uid)
          .get()
          .then((querySnapshot) => {
            querySnapshot.docs.forEach((doc) => {
              // console.log(doc.data()["customerId"]);
              customersList.push({
                name: doc.data()["customerName"],
                timestamp: doc.data()["timestamp"].toDate().toString(),
                id: doc.data()["customerId"],
              });
            });

            // console.log(customersList);
            setCustomers(customersList);
          });
      }
    });
  }

  function logout() {
    firebase.auth().signOut();
    navigate("/");
  }

  function changeQR(e) {
    setShopName(e.target.value);
  }

  const [open, setOpen] = React.useState(false);
  const [tempData, setTempData] = useState("");

  const handleClickOpen = (id) => {
    firebase.auth().onAuthStateChanged(function (user) {
      // console.log(user.uid);
      if (user) {
        firebase
          .firestore()
          .collection("user")
          .doc(id)
          .onSnapshot((data) => {
            let j = data.data();
            setTempData({
              name: j["name"],
              address: j["address"],
              email: j["email"],
              pincode: j["pincode"],
              vaccinationStatus: j["vaccinationStatus"].toString(),
            });
          });
      }
    });
  };

  useEffect(() => {
    if (tempData != "") {
      setOpen(true);
    }
    return () => {};
  }, [tempData]);

  const handleClose = () => {
    setOpen(false);
  };

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

      <Dialog open={open} onClose={handleClose}>
        <DialogTitle>Customer Detail</DialogTitle>
        <DialogContent>
          <DialogContentText>
            <h1>{tempData["name"]}</h1>
            <div>{tempData["email"]}</div>
            <div>{tempData["address"]}</div>
            <div>{tempData["pincode"]}</div>
            {tempData["vaccinationStatus"] == "true" ? (
              <b>Vaccination DONE.</b>
            ) : (
              <b>NOT vaccinated</b>
            )}
          </DialogContentText>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleClose} color="primary">
            Close
          </Button>
        </DialogActions>
      </Dialog>

      <div className="head2">
        <h2 className="">Customer Logs</h2>
        <br />
        <div>
          {customers.map((val, index) => {
            return (
              <div key={index} className="nameTile">
                <div>{val.name}</div>
                <div>{val.timestamp}</div>
                <div>
                  <Button
                    variant="outlined"
                    color="primary"
                    onClick={() => handleClickOpen(val.id)}
                  >
                    Details
                  </Button>
                </div>
              </div>
            );
          })}
        </div>
        <br />
        <br />
      </div>
    </>
  );
}
