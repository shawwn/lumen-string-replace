string_replace = function (str, a, b, count, pos) {
  var k = _35(a);
  var n = count || inf;
  if (count === 0 || n <= 0 || k <= 0) {
    return(str);
  } else {
    var i = pos || 0;
    var j = search(str, a, i);
    var s = clip(str, 0, i);
    while ((j || j === 0) && n > 0) {
      n = n - 1;
      s = s + clip(str, i, j) + b;
      i = j + k;
      j = search(str, a, i);
    }
    s = s + clip(str, i);
    return(s);
  }
};
exports["string-replace"] = string_replace;
