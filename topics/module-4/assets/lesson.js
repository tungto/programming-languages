/* lesson.js - shared behaviour for lessons, reference pages and reports. Load with `defer`.
   Every block is a no-op when its elements are absent, so a short lesson can link it too.
   UI words come from data-* attributes on <body>, so any language works:
     data-ui-dark="Dark"  data-ui-light="Light"  data-ui-pause="Pause"  data-ui-resume="Resume" */
(function () {
  var root = document.documentElement;
  var body = document.body;
  function ui(name, fallback) { return (body && body.getAttribute('data-ui-' + name)) || fallback; }

  /* ---- rail: mobile toggle ---- */
  var toggle = document.getElementById('navToggle');
  var toc = document.getElementById('toc');
  if (toggle && toc) {
    toggle.addEventListener('click', function () {
      var open = toc.classList.toggle('open');
      toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
    });
  }

  /* ---- rail: highlight the section being read ---- */
  var links = Array.prototype.slice.call(document.querySelectorAll('.rail a[href^="#"]'));
  var map = {};
  links.forEach(function (a) {
    var id = a.getAttribute('href').slice(1);
    if (document.getElementById(id)) map[id] = a;
  });
  if (links.length && 'IntersectionObserver' in window) {
    var current = null;
    var obs = new IntersectionObserver(function (entries) {
      entries.forEach(function (e) {
        if (!e.isIntersecting) return;
        var a = map[e.target.id];
        if (!a || a === current) return;
        if (current) current.classList.remove('on');
        a.classList.add('on');
        current = a;
      });
    }, { rootMargin: '-10% 0px -70% 0px', threshold: 0 });
    Object.keys(map).forEach(function (id) { obs.observe(document.getElementById(id)); });
  }

  /* ---- theme: light unless the reader opts into dark ---- */
  var KEY = 'lesson-theme';
  try {
    var saved = localStorage.getItem(KEY);
    if (saved === 'dark' || saved === 'light') root.setAttribute('data-theme', saved);
  } catch (e) {}
  if (!root.hasAttribute('data-theme')) root.setAttribute('data-theme', 'light');

  var btn = document.createElement('button');
  btn.className = 'theme-toggle';
  btn.type = 'button';
  function label() {
    var dark = root.getAttribute('data-theme') === 'dark';
    btn.textContent = dark ? ui('light', 'Light') : ui('dark', 'Dark');
    btn.setAttribute('aria-pressed', dark ? 'true' : 'false');
  }
  btn.addEventListener('click', function () {
    var next = root.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
    root.setAttribute('data-theme', next);
    try { localStorage.setItem(KEY, next); } catch (e) {}
    label();
  });
  label();
  if (body) body.appendChild(btn);

  /* ---- animated SVG diagrams: pause / restart (SMIL lives on SVGSVGElement) ---- */
  document.querySelectorAll('[data-toggle]').forEach(function (b) {
    b.addEventListener('click', function () {
      var svg = document.getElementById(b.getAttribute('data-toggle'));
      if (!svg || !svg.pauseAnimations) return;
      if (svg.animationsPaused()) { svg.unpauseAnimations(); b.textContent = ui('pause', 'Pause'); }
      else { svg.pauseAnimations(); b.textContent = ui('resume', 'Resume'); }
    });
  });
  document.querySelectorAll('[data-restart]').forEach(function (b) {
    b.addEventListener('click', function () {
      var svg = document.getElementById(b.getAttribute('data-restart'));
      if (!svg || !svg.setCurrentTime) return;
      svg.setCurrentTime(0);
      if (svg.animationsPaused()) {
        svg.unpauseAnimations();
        var t = document.querySelector('[data-toggle="' + svg.id + '"]');
        if (t) t.textContent = ui('pause', 'Pause');
      }
    });
  });
})();
