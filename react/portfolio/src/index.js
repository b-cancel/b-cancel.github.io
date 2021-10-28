import React from "react";
import ReactDOM from "react-dom";

import "./styles.css";
import SideBar from "./sidebar";
import Gallery from "./gallery.js"

function App() {
  //<Menu isOpen={ true } />
  //<Menu width={ '280px' } />
  //<Menu onClose={ handleOnClose } />
  //<Menu onOpen={ handleOnOpen } />

  //TODO: trigger the variable change... then use 
  /*
  Note: If you want to render the menu open initially, 
  you will need to set this property in your parent component's componentDidMount() function.
  https://github.com/negomi/react-burger-menu/wiki/FAQ#i-want-to-control-the-open-state-programmatically-but-i-dont-understand-how-to-use-the-isopen-prop
  */
  function onMenuOpen(){
    window.onMenuOpened();
  }

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