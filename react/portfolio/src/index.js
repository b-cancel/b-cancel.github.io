import React from "react";
import ReactDOM from "react-dom";
import SideBar from "./sidebar";
import Gallery from "./gallery.js";

class App extends React.Component {
  constructor(props) {
    super(props);
    this.childRef = React.createRef();
  }

  //now that everything is loaded...
  componentDidMount() {
    console.log("App mounted");
    //wait a bit and attempt to open the menu
    //200ms works reliably... anything less does not
    this.childRef.current.openMenu();
    
    setTimeout(() => {
//      this.childRef.current.openMenu();
    }, 10);
  }

  render() {
    const gallery = <Gallery />;
    return <ReloadingApp child={gallery} ref={this.childRef} />;
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
  //<Menu width={ '280px' } />
  //<Menu onClose={ handleOnClose } />
  //<Menu onOpen={ handleOnOpen } />

  // This can be used to toggle the menu, e.g. when using a custom icon
  // Tip: You probably want to hide either/both default icons if using a custom icon
  // See https://github.com/negomi/react-burger-menu#custom-icons
  toggleMenu() {
    this.setState((state) => ({ menuOpen: !state.menuOpen }));
  }

  render() {
    
    //#page-wrap styling when open (nothing when closed)
    //OPEN: transform: translate3d(300px, 0px, 0px); 
    //CLOSE: 

    //.bm-menu-wrap styling when open 
    //OPEN: display: block
    //CLOSE: display:none && transform: translate3d(-100%, 0px, 0px);

    //.bm-overlay
    //OPEN: opacity: 1; 
    //CLOSE: opacity: 0;

    //html and body tags
    //OPEN: overflow-x: hidden;
    //CLOSE: overflow-x: auto;

    return (
      <div id="outer-container">
        <SideBar
          pageWrapId={"page-wrap"}
          isOpen={this.state.menuOpen}
          onStateChange={(state) => this.handleStateChange(state)}
        />
        <div id="page-wrap">{this.props.child}</div>
      </div>
    );
  }
}

const rootElement = document.getElementById("app");
ReactDOM.render(<App />, rootElement);