// ==UserScript==
// @match https://*.google.com/*
// @match https://*.youtube.com/*
// @match https://letterboxd.com/*
// ==/UserScript==

const meta = document.createElement('meta');
meta.name = "color-scheme";
meta.content = "dark light";
document.head.appendChild(meta);
