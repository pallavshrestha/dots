// ==UserScript==
// @name         Reddit Hide Promoted Links (New Design)
// @namespace    http://github.com/rohenaz
// @version      0.1
// @description  remove promoted posts and advertisements
// @author       Satchmo
// @match        https://www.reddit.com/*
// @grant        none
// ==/UserScript==
// https://gist.github.com/rohenaz/8b0528add5c03c1788af46cbf97f4089

(function() {
    'use strict';

    let els = document.getElementsByClassName('promotedlink')
    clean(els)
    setInterval(() => {
        let adEls = document.querySelectorAll('[data-google-query-id]')
        clean(adEls)
    }, 2000)
})();

function clean(els) {
    if(els) {
        let x = els.length
        while(x--) {
            if (els[x].getAttribute('data-slot')) {
                els[x] = els[x].parentElement.parentElement.parentElement
            }
            els[x].style.display = 'none'
        }
    }
}
