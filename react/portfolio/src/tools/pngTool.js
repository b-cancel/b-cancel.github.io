import React from "react";
import {Image} from 'react-native';
import MyToolTip from "../tooltips";

//TODO: show a png with a black tint at first... 
//TODO: that black tint goes away on hover... 
//TODO: it also and it displays title of what is being hovered over
//TODO: and it links to that tech stacks page with a link tag

export default function PngTool(props) {
    var theClassName = props.tip;
    theClassName = theClassName.replaceAll(' ','');
    theClassName = theClassName.replaceAll(',','');
    theClassName = theClassName.replaceAll('.','');
    const tool = (
    <a href={props.src} target="_blank" rel="noreferrer" className={theClassName}>
        <style
            dangerouslySetInnerHTML={{
              __html: `
              .${theClassName} {
                  display:inline-block;
                  height:${props.size}px;
                  width:${props.size}px
              }
              .${theClassName}:hover div div{
                  filter: none !important;
            }
                `,
            }}
          />
          <Image
        style={{
            tintColor: "black",
          resizeMode: "contain",
          height: `${props.size}px`,
          width: `${props.size}px`,
        }}
        
        source={props.png}
      />
    </a>
    );

    return (<MyToolTip
        title={props.tip}
        placement="top"
        child={tool}
        type="whiteOnBlack" />
        );
}