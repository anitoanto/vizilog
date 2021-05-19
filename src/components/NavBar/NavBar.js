import React from "react";
import * as NavBarStyle from "./NavBar.module.css";
import { Link } from "gatsby";

export default function NavBar() {
  return (
    <div>
      <nav className={NavBarStyle.nav}>
        <ul>
          <Link to="/">
            <li>Home</li>
          </Link>

          <Link to="/login">
            <li>Login</li>
          </Link>
          <Link to="https://github.com/anitoanto/vizilog/tree/admin-web">
            <li>Github</li>
          </Link>
        </ul>
      </nav>
    </div>
  );
}
