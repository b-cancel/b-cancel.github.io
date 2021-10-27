import React from "react";
import ReactDOM from "react-dom";

import "./styles.css";
import SideBar from "./sidebar";

import Gallery from "./gallery.js"

function App() {
  return (
    <div id="App">
      <SideBar pageWrapId={"page-wrap"} outerContainerId={"App"} />
      <div id="page-wrap">
        <Gallery/>
      </div>
    </div>
  );
}

const rootElement = document.getElementById("root");
ReactDOM.render(<App />, rootElement);