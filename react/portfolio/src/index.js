import React from "react";
import ReactDOM from "react-dom";
import SideBar from "./sidebar";
import Gallery from "./gallery.js";

class App extends React.Component {
  render() {
    const gallery = <Gallery />;
    return <ReloadingApp child={gallery} />;
  }
}

class ReloadingApp extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      menuOpen: false,
    };
  }

  // This keeps your state in sync with the opening/closing of the menu
  // via the default means, e.g. clicking the X, pressing the ESC key etc.
  handleStateChange(state) {
    console.log("STATE CHANGED TO: " + state.isOpen);
    this.setState({ menuOpen: state.isOpen });
    if(state.isOpen){
      window.openTheMenu();
    } else {
      window.closeTheMenu();
    }

    //we keep track of wether or not the menu is initialized by inspecting this variable
    if(this.isInitialized !== true){
      //when the menu is initialized... open it
      this.isInitialized = true;
      this.openMenu();
      console.log("AUTO OPENING MENU AFTER INITIALIZATION");
    }
  }

  // This can be used to close the menu, e.g. when a user clicks a menu item
  closeMenu() {
    console.log("TRYING TO CLOSE MENU");
    this.setState({ menuOpen: false });
  }

  openMenu() {
    console.log("TRYING TO OPEN MENU");
    this.setState({ menuOpen: true });
  }

  //<Menu isOpen={ true } />
  //<Menu  />
  //<Menu onClose={ handleOnClose } />
  //<Menu onOpen={ handleOnOpen } />

  // This can be used to toggle the menu, e.g. when using a custom icon
  // Tip: You probably want to hide either/both default icons if using a custom icon
  // See https://github.com/negomi/react-burger-menu#custom-icons
  toggleMenu() {
    this.setState((state) => ({ menuOpen: !state.menuOpen }));
  }

  render() {
    const sideBarWidth = "280px";
    return (
      <div id="outer-container">
        <style
            dangerouslySetInnerHTML={{
              __html: `
              .page-wrap-opened {
                transform: translate3d(${sideBarWidth}, 0px, 0px) !important;
              }

              .page-wrap-closed {
                transform: translate3d(0px, 0px, 0px) !important; 
              }
              
              .bm-menu-wrap-opened {
                display: block !important;
                transform: translate3d(0px, 0px, 0px) !important;
              }

              .bm-menu-wrap-closed {
                transform: translate3d(-100%, 0px, 0px) !important;
              }

              .bm-overlay-opened {
                opacity: 1 !important;
              }

              .bm-overlay-closed {
                opacity: 0 !important;
              }

              .other-opened {
                overflow-x: hidden !important;
              }

              .other-closed {
                overflow-x: auto !important;
              }
                `,
            }}
          />
        <SideBar
          pageWrapId={"page-wrap"}
          isOpen={this.state.menuOpen}
          onStateChange={(state) => this.handleStateChange(state)}
          width={sideBarWidth}
        />
        <div id="page-wrap">{this.props.child}</div>
      </div>
    );
  }
}

const rootElement = document.getElementById("app");
ReactDOM.render(<App />, rootElement);