import { EditorView } from "@codemirror/view";
import { tags } from "@lezer/highlight";
import { HighlightStyle } from "@codemirror/language";

export const highlightDark = HighlightStyle.define([
  { tag: tags.comment, color: "#8b949e" },
  { tag: tags.keyword, color: "#ff7b72" },
  { tag: tags.string, color: "#a5d6ff" },
  { tag: tags.variableName, color: "#ffa657" },
  { tag: tags.regexp, color: "#7ee787" },
  { tag: tags.propertyName, color: "#d2a8ff" },
  { tag: tags.attributeName, color: "#d2a8ff" },
  { tag: tags.bracket, color: "#dfe1e8" },
  { tag: tags.tagName, color: "#7ee787" },
]);

export const themeDark = EditorView.theme(
  {
    "&.cm-editor *": {
      fontFamily: "Source Code Pro",
      fontSize: "16px",
    },
    "&": {
      color: "#c9d1d9",
      backgroundColor: "transparent",
    },
    ".cm-selectionBackground": {
      backgroundColor: "rgba(56,139,253,0.4)",
    },
    ".cm-selectionMatch": {
      backgroundColor: "rgba(56,139,253,0.3)",
    },
    ".cm-activeLineGutter": {
      backgroundColor: "rgba(110,118,129,0.1)",
    },
    ".cm-activeLine": {
      backgroundColor: "rgba(110,118,129,0.1)",
    },
    ".cm-foldGutter": {
      opacity: 0,
      transition: "opacity 0.2s",
    },
    ".cm-foldGutter:hover": {
      opacity: 100,
    },
    ".cm-foldPlaceholder": {
      color: "#ff7b72",
      fontFamily: "SF Pro",
      fontWeight: 900,
      backgroundColor: "transparent",
      border: "none",
      margin: 0,
      padding: 0,
    },
    ".cm-gutters": {
      backgroundColor: "transparent",
      border: "none",
    },
    ".cm-linenumber": {
      color: "#6e7681",
    },
    ".cm-cursor": {
      borderLeft: "1px solid #a7adba",
    },
    "&.cm-focused .cm-matchingBracket": {
      backgroundColor: "#328c8200",
    },
    "&.cm-focused": {
      border: "0px",
    },
    ".cm-gutterElement span": {
      fontFamily: "SF Pro",
      fontWeight: 900,
      opacity: 0.7,
      fontSize: "12px",
      transition: "opacity 0.2s",
    },
    ".cm-gutterElement span:hover": {
      fontFamily: "SF Pro",
      fontWeight: 900,
      opacity: 100,
      fontSize: "12px",
    },
  },
  { dark: true }
);
