for (var F, D, DATA = TDATA = 0, NI = 3E5, U = 500, M = 1, DIGITS = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", B = DIGITS.length, B2 = B * B, B3 = B * B2, REVERSE = {}, i = 0; i < B; ++i) REVERSE[DIGITS[i]] = i;





function randomize(a, b) {
    return a + (b - a) * Math.random()
}

function col(a) {
    return ("00000" + a.toString(16)).substr(-6)
}

function hex(a) {
    return "#" + col(a)
}

function clamp(a, b, f) {
    return a < b ? b : a > f ? f : a
}

function accesArray(a, b, f, e, c, g) {
    e = clamp(e, 0, b - 1);
    c = clamp(c, 0, c - 1);
    return a[4 * (e + c * b) + g]
}

function precompute(a, b, f, e) {
    var c, g, d = i = 0;
    for (g = 0; g < e; g++)
        for (c = 0; c < f; c++) {
            d = a[4 * i + 3];
            if (c > 0) d += b[(i - 1) * 4 + 3];
            if (g > 0) d += b[(i - f) * 4 + 3];
            if (c > 0 && g > 0) d -= b[(i - f - 1) * 4 + 3];
            b[4 * i + 3] = d;
            i++
        }
}

function blur_box(a, b, f, e) {
    var c = $(a),
        g = cc(c);
    a = c.width;
    var d = c.height;
    b = $(b);
    b = cc(b);
    var k = g.getImageData(0, 0, a, d).data;
    g = b.getImageData(0, 0, a, d);
    var j = g.data;
    if (f < 0 || e < 0) b.drawImage(c, 0, 0);
    TDATA || (TDATA = Array(a * d * 4));
    precompute(k, TDATA, a, d);
    var l, h = i = 0,
        o = 1 / ((f * 2 + 1) * (e * 2 + 1));
    for (k = 0; k < d; k++)
        for (c = 0; c < a; c++) {
            l = accesArray(TDATA, a, c + f, k + e, 3) + accesArray(TDATA, a, c - f, k - e, 3) - accesArray(TDATA, a, c - f, k + e, 3) - accesArray(TDATA, a, c + f, k - e, 3);
            h = i * 4;
            j[h] = 255;
            j[h + 1] = 255;
            j[h + 2] = 255;
            j[h + 3] = l * o;
            i++
        }
    b.putImageData(g, 0, 0)
}

function composite(a, b, f) {
    var e = $(f);
    f = cc(e);
    var c = e.width;
    e = e.height;
    a = cc($(a)).getImageData(0, 0, c, e).data;
    b = cc($(b)).getImageData(0, 0, c, e).data;
    var g = f.getImageData(0, 0, c, e),
        d = g.data,
        k, j, l, h = 0;
    for (j = 0; j < c; j++)
        for (l = 0; l < e; l++) {
            h = (j + l * c) * 4;
            k = a[h + 3] / 255;
            d[h] = k * b[h];
            d[h + 1] = k * b[h + 1];
            d[h + 2] = k * b[h + 2];
            d[h + 3] = 255
        }
    f.putImageData(g, 0, 0)
}

function render_gradient(a, b, f, e, c, g, d, k) {
    var j = $(a);
    a = cc(j);
    var l = j.width;
    j = j.height;
    var h = Math.sqrt(l * l + j * j) / 2,
        o = Math.cos(k),
        p = Math.sin(k);
    k = clamp(l / 2 - o * h, 0, l);
    var u = clamp(j / 2 - p * h, 0, j);
    o = clamp(l / 2 + o * h, 0, l);
    h = clamp(j / 2 + p * h, 0, j);
    h = a.createLinearGradient(k, u, o, h);
    h.addColorStop(b, c);
    h.addColorStop(f, g);
    h.addColorStop(e, d);
    a.fillStyle = h;
    a.fillRect(0, 0, l, j)
}


function generate_parameters(a) {
    var b, f, e, c, g, d, k, j, l;
    for (b = 0; b < a; ++b) {
        f = randomize(-2, 2);
        e = randomize(-2, 2);
        c = randomize(-2, 2);
        g = randomize(0.2, 2);
        d = randomize(-2, 2);
        k = randomize(-2, 2);
        j = randomize(-2, 2);
        l = randomize(0.1, 2);
        var h = test_attractor(f, e, c, g, d, k, j, l,);
        if (h.ok) break
    }
    if (b == a) {
        f = -1.32;
        e = -1.47;
        c = 1.65;
        g = 1.26;
        d = -0.35;
        k = 0.63;
        j = 1.51;
        l = 1.71
    }
    b = height = 300;
    a = Math.min(b / (h.maxx - h.minx), height / (h.maxy - h.miny));
    b = (b - (h.maxx + h.minx)) / 2;
    h = (height - (h.maxy + h.miny)) / 2;
    if (a > 1) a = 1;
    else a *= 0.9;
    a *= 1.5;
    return {
        a: f,
        b: e,
        c: c,
        d: g,
        e: d,
        f: k,
        g: j,
        h: l,
        s1: 0.25,
        s2: 0.5,
        s3: 0.75,
        c1: Math.floor(Math.random() * 16777215),
        c2: Math.floor(Math.random() * 16777215),
        c3: Math.floor(Math.random() * 16777215),
        r: 2 * Math.PI * Math.random(),
        zoom: a,
        dx: b,
        dy: h
    }
}

function ef(a) {
    a = Math.floor((a + 2) / 4 * B3);
    var b = Math.floor(a / B2),
        f = Math.floor((a - b * B2) / B);
    return DIGITS[b] + DIGITS[f] + DIGITS[Math.floor(a - b * B2 - f * B)]
}

function ef2(a) {
    a = a * 100 + B3 / 2;
    var b = Math.floor(a / B3),
        f = Math.floor((a - b * B3) / B2),
        e = Math.floor((a - b * B3 - f * B2) / B);
    return DIGITS[b] + DIGITS[f] + DIGITS[e] + DIGITS[Math.floor(a - b * B3 - f * B2 - e * B)]
}

function er(a) {
    return DIGITS[Math.floor(a * (B - 1))]
}

function ed(a) {
    a = Math.floor(a / (2 * Math.PI) * B2);
    var b = Math.floor(a / B);
    return DIGITS[b] + DIGITS[Math.floor(a - b * B)]
}

function df(a, b) {
    return (B2 * REVERSE[a[b]] + B * REVERSE[a[b + 1]] + REVERSE[a[b + 2]]) / B3 * 4 - 2
}

function df2(a, b) {
    return (B3 * REVERSE[a[b]] + B2 * REVERSE[a[b + 1]] + B * REVERSE[a[b + 2]] + REVERSE[a[b + 3]] - B3 / 2) / 100
}

function dr(a, b) {
    return REVERSE[a[b]] / B
}

function dd(a, b) {
    return 2 * Math.PI * (B * REVERSE[a[b]] + REVERSE[a[b + 1]]) / B2
}

function decode_pars(a) {
    return {
        a: df(a, 0),
        b: df(a, 3),
        c: df(a, 6),
        d: df(a, 9),
        e: df(a, 12),
        f: df(a, 15),
        g: df(a, 18),
        h: df(a, 21),
        s1: dr(a, 24),
        s2: dr(a, 25),
        s3: dr(a, 26),
        c1: parseInt(a.substr(27, 6), 16),
        c2: parseInt(a.substr(33, 6), 16),
        c3: parseInt(a.substr(39, 6), 16),
        r: dd(a, 45),
        zoom: df2(a, 47),
        dx: df2(a, 51),
        dy: df2(a, 55)
    }
}

function encode_pars(a) {
    return ef(a.a) + ef(a.b) + ef(a.c) + ef(a.d) + ef(a.e) + ef(a.f) + ef(a.g) + ef(a.h) + er(a.s1) + er(a.s2) + er(a.s3) + col(a.c1) + col(a.c2) + col(a.c3) + ed(a.r) + ef2(a.zoom) + ef2(a.dx) + ef2(a.dy)
}
	-- 2, 100, 1E3
function test_attractor(a, b, f, e, c, g, d, k, j, l, h) {
    var o, p, u = y = 0,
        w = miny = 9999999999,
        r = maxy = 0,
        m = [],
        s, t, q, v, x;
    for (o = 0; o < h; o++) {
        s = Math.round(150 + u * 50);
        t = Math.round(150 + y * 50);
        p = a * Math.sin(b * y) + f * Math.cos(e * u);
        q = c * Math.sin(g * u) + d * Math.cos(k * y);
        u = p;
        y = q;
        if (m.length == 0) m.push([s, t]);
        else {
            q = 1;
            for (p = 0; p < m.length; p++) {
                v = Math.abs(m[p][0] - s);
                x = Math.abs(m[p][1] - t);
                if (v < j && x < j) q = 0
            }
            if (q) {
                m.push([s, t]);
                if (s < w) w = s;
                else if (s > r) r = s;
                if (t < miny) miny = t;
                else if (t > maxy) maxy = t
            }
        }
    }
    return {
        ok: m.length > l,
        minx: w,
        maxx: r,
        miny: miny,
        maxy: maxy
    }
}

function render_attractor_canvas(a, b, f) {
    render_shape_offline("shape", f, 1, 0, 0, b);
    blur_box("shape", "glow", 5, 5);
    cc($("glow")).drawImage($("shape"), 0, 0);
    render_gradient("color", b.s1, b.s2, b.s3, hex(b.c1), hex(b.c2), hex(b.c3), b.r);
    composite("glow", "color", a)
}

function sz(a, b) {
    var f = $(a);
    f.width = f.height = b
}

function resize(a) {
    a = U * a;
    TDATA = 0;
    sz("shape", a);
    sz("glow", a);
    sz("color", a);
    sz("final", a)
}

function go(a, b, f) {
    var e, c = percent;
    if (a) e = decode_pars(a);
    else {
        e = generate_parameters(20);
        a = encode_pars(e)
    }
    e.zoom *= f;
    render_attractor_canvas("final", e, b);
    set_url(a);
    D.innerHTML = "<p>Computed in " + (percent - c) + " ms</p>"
}

function get_hash(a) {
    a = a.split("#");
    if (a.length == 2) return a[1];
    return ""
}

function set_url(a) {
    window.location.hash = a;
    $("l").href = "http://alteredqualia.com/attractor/#" + a
}

function start() {
    F = $("final");
    D = $("debug");
    go(get_hash(window.location.href), NI, M);
    F.onmousedown = function() {
        go(0, NI, M)
    };
    $("p").onclick = function() {
        $("p").href = F.toDataURL("image/png")
    };
    $("d").onclick = function() {
        go(get_hash(window.location.href), 10 * NI, M)
    };
    $("d2").onclick = function() {
        M = 2;
        resize(M);
        go(get_hash(window.location.href), 20 * NI, M)
    };
    $("d1").onclick = function() {
        M = 1;
        resize(M);
        go(get_hash(window.location.href), 10 * NI, M)
    }
};