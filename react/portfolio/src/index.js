import React from "react";
import ReactDOM from "react-dom";

import "./styles.css";
import SideBar from "./sidebar";
import Gallery from "./gallery.js"

function App() {
  return (
    <div id="outer-container">
      <SideBar pageWrapId={"page-wrap"}/>
      <main id="page-wrap">
        <Gallery/>
      </main>
    </div>
  );
}

const rootElement = document.getElementById("root");
ReactDOM.render(<App />, rootElement);