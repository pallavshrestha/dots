// ==UserScript==
// @name         Dark Mode with Nord Colors
// @namespace    http://tampermonkey.net/
// @version      1.1
// @description  Converts light colors to dark using the Nord color scheme
// @author       Your Name
// @match        *://*/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // Nord color scheme
    const nordColors = {
        background: "#2E3440", // Polar Night
        foreground: "#D8DEE9", // Snow Storm
        accent1: "#88C0D0", // Frost
        accent2: "#81A1C1", // Light Frost
        accent3: "#5E81AC", // Arctic
        accent4: "#BF616A", // Red
        accent5: "#A3BE8C", // Green
        accent6: "#EBCB8B", // Yellow
    };

    // Function to convert hex color to RGB
    const hexToRgb = (hex) => {
        const bigint = parseInt(hex.replace('#', ''), 16);
        return [(bigint >> 16) & 255, (bigint >> 8) & 255, bigint & 255];
    };

    // Compare two colors (RGB)
    const isDarkerThan = (color1, color2) => {
        const rgb1 = hexToRgb(color1);
        const rgb2 = hexToRgb(color2);
        return luminance(`rgb(${rgb1[0]}, ${rgb1[1]}, ${rgb1[2]}`) < luminance(`rgb(${rgb2[0]}, ${rgb2[1]}, ${rgb2[2]}`);
    };

    // Apply the color changes
    const applyDarkMode = () => {
        // Set global background and foreground
        document.body.style.backgroundColor = nordColors.background;
        document.body.style.color = nordColors.foreground;

        // Select all elements and apply styles
        const allElements = document.querySelectorAll('*');

        allElements.forEach(el => {
            // Check if the current background color is too light
            const currentBgColor = window.getComputedStyle(el).backgroundColor;
            const currentColor = window.getComputedStyle(el).color;

            // Change any background darker than #2E3440
            if (isDarkerThan(currentBgColor, nordColors.background) && el instanceof HTMLElement) {
                el.style.backgroundColor = nordColors.background; // Change to dark
            }

            // Check if the text color is dark
            // if (luminance(currentColor) < 0.5 && el instanceof HTMLElement) {
            if (isDarkerThan(nordColor.foreground, currentColor) && el instanceof HTMLElement) {
                el.style.color = nordColors.foreground; // Change to light
            }
        });
    };

    // Function to calculate luminance for contrast
    const luminance = (rgb) => {
        const rgbArray = rgb.match(/\d+/g)?.map(Number);
        if (!rgbArray) return 0; // Edge case for invalid RGB
        return (0.299 * rgbArray[0] + 0.587 * rgbArray[1] + 0.114 * rgbArray[2]) / 255;
    };

    // Initial application
    applyDarkMode();

    // Observe changes in the document (optional)
    const observer = new MutationObserver(applyDarkMode);
    observer.observe(document.body, { childList: true, subtree: true });

})();

