// ==UserScript==
// @name     Hide Reddit's promoted posts
// @namespace HideRedditsPromotedPosts
// @description Hide Reddit's promoted links so they don't bother you.
// @match *://*.reddit.com/*
// @version  1.01
// @grant    none
// ==/UserScript==
 
(function() {
    'use strict';
    const ads = document.querySelectorAll('shreddit-ad-post');
    ads.forEach(ad => ad.remove());
})();
