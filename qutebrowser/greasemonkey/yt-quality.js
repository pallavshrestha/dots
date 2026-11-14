// ==UserScript==
// @name unAV01fy
// @match *://*/*
// @run-at       document-start
// @qute-js-world main
// ==/UserScript==

// Adapted from h264ify (disables vp8,9 and av1)
// const bloc = /vp0?[89]|av01|av1/i;
// https://www.reddit.com/r/qutebrowser/s/BcoRNob2JG

(function () {
  const block = /av01|av1/i;

  const origIsTypeSupported = MediaSource.isTypeSupported.bind(MediaSource);
  MediaSource.isTypeSupported = (t) => block.test(t) ? false : origIsTypeSupported(t);

  const origCanPlay = HTMLMediaElement.prototype.canPlayType;
  HTMLMediaElement.prototype.canPlayType = function (t) {
    return block.test(t) ? '' : origCanPlay.call(this, t);
  };

  if (navigator.mediaCapabilities && navigator.mediaCapabilities.decodingInfo) {
    const origDecodingInfo = navigator.mediaCapabilities.decodingInfo.bind(navigator.mediaCapabilities);
    navigator.mediaCapabilities.decodingInfo = (cfg) => {
      const ct = cfg && cfg.video && cfg.video.contentType;
      if (ct && block.test(ct)) {
        return Promise.resolve({ supported: false, smooth: false, powerEfficient: false });
      }
      return origDecodingInfo(cfg);
    };
  }
})();
