// A "copy" button on every code block: the pages' <pre> blocks, and the input
// cells of the notebooks rendered by tools/render_notebooks.sh.
(function () {
    document.querySelectorAll("article pre, .jp-InputArea-editor pre").forEach(function (pre) {
        if (pre.closest(".language-mermaid") || pre.querySelector("code.language-mermaid")) return;
        var wrap = document.createElement("div");
        wrap.className = "code-wrap";
        pre.parentNode.insertBefore(wrap, pre);
        wrap.appendChild(pre);
        var btn = document.createElement("button");
        btn.type = "button";
        btn.className = "code-copy";
        btn.textContent = "copy";
        btn.setAttribute("aria-label", "Copy code to clipboard");
        wrap.appendChild(btn);
        btn.addEventListener("click", function () {
            var text = pre.innerText;
            function done(ok) {
                btn.textContent = ok ? "copied" : "failed";
                btn.classList.add("copied");
                setTimeout(function () { btn.textContent = "copy"; btn.classList.remove("copied"); }, 1500);
            }
            if (navigator.clipboard && window.isSecureContext) {
                navigator.clipboard.writeText(text).then(function () { done(true); }, function () { done(false); });
            } else {
                var ta = document.createElement("textarea");
                ta.value = text;
                ta.style.position = "fixed";
                ta.style.opacity = "0";
                document.body.appendChild(ta);
                ta.select();
                var ok = false;
                try { ok = document.execCommand("copy"); } catch (e) {}
                document.body.removeChild(ta);
                done(ok);
            }
        });
    });
})();
