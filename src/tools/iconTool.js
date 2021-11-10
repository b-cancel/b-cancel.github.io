import React from "react";
import { isMobile } from "react-device-detect";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import Box from "@mui/material/Box";
import MyToolTip from "../tooltips";

export default function IconTool(props) {
  var theClassName = props.tip;
  theClassName = theClassName.replaceAll(" ", "");
  theClassName = theClassName.replaceAll(",", "");
  theClassName = theClassName.replaceAll(".", "");
  const hoverCode = props.hoverColor
    ? `color: ${props.hoverColor};`
    : "opacity:0.5;";
  const tool = (
    <MyToolTip
      title={props.tip}
      placement="top"
      child={
        <Box>
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
          <FontAwesomeIcon
            icon={props.icon}
            size="lg"
            className={theClassName}
            fixedWidth
          />
        </Box>
      }
      type="whiteOnBlack"
    />
  );

  if (isMobile) {
    return (<Box>{ tool }</Box>);
  } else {
    return (
      <a href={props.src} target="_blank" rel="noreferrer" className="tool">
        {tool}
      </a>
    );
  }
}
