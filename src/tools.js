import React from "react";

import {
  //---mobile stuff
  faSwift, //#ec3b2e

  //---web stuff
  faReact, //#62ceec
  faNodeJs, //#84b923
  faAws, //mention amplify, cognito, datastore, rds, //#212d3b
  faPhp, //#828cb5
  faJsSquare, //#e9d137
  faHtml5, //#e36132
  faCss3Alt, //#30a1d2

  //---game stuff
  faUnity, //black

  //---other stuff
  faPython, //black

  //---source control
  faGithub, //black
  faBitbucket, //#1454bc

  //---baby stuff
  faWix, //#efb372 or black
  faShopify, //#8bb04b
  faWordpressSimple, //#0e7090
} from "@fortawesome/free-brands-svg-icons";

import IconTool from "./tools/iconTool.js";
import PngTool from "./tools/pngTool.js";

export default function Tool(props) {
const size = 48;
  switch (props.tool) {
    case "swift":
      return (
        <IconTool
            size={size}
          icon={faSwift}
          hoverColor="#ec3b2e"
          tip="Swift"
          src="https://developer.apple.com/swift/"
        />
      );
    case "react":
      return (
        <IconTool
        size={size}
          icon={faReact}
          hoverColor="#62ceec"
          tip="React JS"
          src="https://reactjs.org/"
        />
      );
    case "node":
      return (
        <IconTool
        size={size}
          icon={faNodeJs}
          hoverColor="#84b923"
          tip="Node JS"
          src="https://nodejs.org/"
        />
      );
    case "aws":
      return (
        <IconTool
        size={size}
          icon={faAws}
          tip="AWS Amplify, Cognito, Datastore, and more"
          src="https://aws.amazon.com/amplify/"
        />
      );
    case "php":
      return (
        <IconTool
        size={size}
          icon={faPhp}
          hoverColor="#828cb5"
          tip="Php"
          src="https://www.php.net/"
        />
      );
    case "js":
      return (
        <IconTool
        size={size}
          icon={faJsSquare}
          hoverColor="#e9d137"
          tip="Javascript"
          src="https://www.javascript.com/"
        />
      );

    case "html":
      return (
        <IconTool
        size={size}
          icon={faHtml5}
          hoverColor="#e36132"
          tip="HTML 5"
          src="https://en.wikipedia.org/wiki/HTML5"
        />
      );
    case "css":
      return (
        <IconTool
        size={size}
          icon={faCss3Alt}
          hoverColor="#30a1d2"
          tip="CSS 3"
          src="https://en.wikipedia.org/wiki/CSS"
        />
      );
    case "unity":
      return (
        <IconTool
        size={size}
          icon={faUnity}
          tip="Unity 3D"
          src="https://unity.com/"
        />
      );
    case "python":
      return (
        <IconTool
        size={size}
          icon={faPython}
          tip="Python"
          src="https://www.python.org/"
        />
      );
    case "github":
      return (
        <IconTool
        size={size}
          icon={faGithub}
          tip="Github"
          src="https://github.com/"
        />
      );
    case "bitbucket":
      return (
        <IconTool
        size={size}
          icon={faBitbucket}
          hoverColor="#1454bc"
          tip="Bit Bucket"
          src="https://bitbucket.org/"
        />
      );
    case "wix":
      return (
        <IconTool
        size={size}
          icon={faWix}
          hoverColor="#efb372"
          tip="Wix"
          src="https://www.wix.com"
        />
      );
    case "shopify":
      return (
        <IconTool
        size={size}
          icon={faShopify}
          hoverColor="#8bb04b"
          tip="Shopify"
          src="https://www.shopify.com"
        />
      );
    case "wordpress":
      return (
        <IconTool
        size={size}
          icon={faWordpressSimple}
          hoverColor="#0e7090"
          tip="Wordpress .COM and .ORG"
          src="https://wordpress.com/"
        />
      );
      
      case "dart":
        return (
          <PngTool
          size={size}
            tip="Dart"
            png="./graphics/tools/dart.png"
            src="https://dart.dev/"
          />
        );
        case "flutter":
        return (
          <PngTool
          size={size}
            tip="Flutter"
            png="./graphics/tools/flutter.png"
            src="https://flutter.dev"
          />
        );
        case "firebase":
        return (
          <PngTool
          size={size}
            tip="Firebase"
            png="./graphics/tools/firebase.png"
            src="https://firebase.google.com"
          />
        );
        //-----
        case "rails":
        return (
          <PngTool
          size={size}
            tip="Ruby On Rails"
            png="./graphics/tools/rails.png"
            src="https://rubyonrails.org/"
          />
        );
        case "dotNet":
          return (
            <PngTool
            size={size}
              tip=".NET Framework"
              png="./graphics/tools/dotNet.png"
              src="https://dotnet.microsoft.com"
            />
          );
          case "webflow":
          return (
            <PngTool
            size={size}
              tip="Webflow"
              png="./graphics/tools/webflow.png"
              src="https://webflow.com"
            />
          );
          case "cSharp":
          return (
            <PngTool
            size={size}
              tip="C#"
              png="./graphics/tools/cSharp.png"
              src="https://docs.microsoft.com/en-us/dotnet/csharp/"
            />
          );
          case "vsCode":
          return (
            <PngTool
            size={size}
              tip="VS Code"
              png="./graphics/tools/vsCode.png"
              src="https://code.visualstudio.com/"
            />
          );
          case "visualStudios":
          return (
            <PngTool
            size={size}
              tip="Visual Studios"
              png="./graphics/tools/visualStudios.png"
              src="https://visualstudio.microsoft.com/"
            />
          );
          case "photoshop":
          return (
            <PngTool
            size={size}
              tip='Photoshop Certified'
              png="./graphics/tools/photoshop.png"
              src="https://www.adobe.com/products/photoshop.html"
            />
          );
          case "premiere":
          return (
            <PngTool
            size={size}
              tip="Premiere Certified"
              png="./graphics/tools/premiere.png"
              src="https://www.adobe.com/products/premiere.html"
            />
          );
          case "c":
          return (
            <PngTool
            size={size}
              tip="C"
              png="./graphics/tools/c.png"
              src="https://en.wikipedia.org/wiki/C_(programming_language)"
            />
          );
          case "cPlusPlus":
          return (
            <PngTool
            size={size}
              tip="C++"
              png="./graphics/tools/cPlusPlus.png"
              src="https://en.wikipedia.org/wiki/C%2B%2B"
            />
          );
          case "java":
          return (
            <PngTool
            size={size}
              tip="Java"
              png="./graphics/tools/java.png"
              src="https://www.java.com/"
            />
          );
    default:
      return (
        <IconTool
          icon={faSwift}
          hoverColor="#ec3b2e"
          tip="Swift"
          src="https://developer.apple.com/swift/"
        />
      );
  }
}
