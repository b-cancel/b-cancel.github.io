import React from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import MyToolTip from "../tooltips";

//TODO: show a black icon 
//TODO: on hover color that icon in
//TODO: it also and it displays title of what is being hovered over
//TODO: and it links to that tech stacks page with a link tag

export default function IconTool(props) {
    var theClassName = props.tip;
    theClassName = theClassName.replaceAll(' ','');
    theClassName = theClassName.replaceAll(',','');
    theClassName = theClassName.replaceAll('.','');
    const hoverCode = props.hoverColor ? `color: ${props.hoverColor};` : 'opacity:0.5;'; 
    const tool = (
        
    <a href={props.src} target="_blank" rel="noreferrer" className="tool">
        <style
            dangerouslySetInnerHTML={{
              __html: `
              .tool {
                display:inline-block;
                height:${props.size}px;
                width:${props.size}px
              }

              .${theClassName}{
                font-size: ${props.size}px;
                ${hoverCode}
              }

              .${theClassName}:hover{
                color: black;
                opacity: 1.0;    
              }
                `,
            }}
          />
        <FontAwesomeIcon icon={props.icon} size="lg" className={theClassName} fixedWidth/>
    </a>
    );

    return (<MyToolTip
        title={props.tip}
        placement="top"
        child={tool}
        type="whiteOnBlack" />
        );
}