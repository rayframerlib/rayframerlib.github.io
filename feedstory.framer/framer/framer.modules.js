require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"Bodymovin1":[function(require,module,exports){
var bodymovinLayer,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

bodymovinLayer = (function(superClass) {
  var _loop, animationObj, timer;

  extend(bodymovinLayer, superClass);

  animationObj = null;

  timer = null;

  function bodymovinLayer(options) {
    var _loadJSON, anmiLayer, base, base1, base2, base3, base4, base5, base6, bodymovinTimer, elId, isAutoplay, isLoop, jsonPath, renderer;
    this.options = options != null ? options : {};
    if ((base = this.options).jsonPath == null) {
      base.jsonPath = 'data.json';
    }
    if ((base1 = this.options).width == null) {
      base1.width = 200;
    }
    if ((base2 = this.options).height == null) {
      base2.height = 200;
    }
    if ((base3 = this.options).backgroundColor == null) {
      base3.backgroundColor = 'transparent';
    }
    if ((base4 = this.options).renderer == null) {
      base4.renderer = 'svg';
    }
    if ((base5 = this.options).looping == null) {
      base5.looping = true;
    }
    if ((base6 = this.options).autoplay == null) {
      base6.autoplay = true;
    }
    bodymovinLayer.__super__.constructor.call(this, this.options);
    anmiLayer = new Layer({
      parent: this,
      width: this.options.width,
      height: this.options.height,
      backgroundColor: this.options.backgroundColor
    });
    anmiLayer.html = "<div id='lottie-animation-" + anmiLayer.id + "'></div>";
    anmiLayer._element.childNodes[0].style.height = '100%';
    anmiLayer._element.childNodes[0].childNodes[0].style.height = '100%';
    jsonPath = this.options.jsonPath;
    renderer = this.options.renderer;
    isLoop = this.options.looping;
    isAutoplay = this.options.autoplay;
    elId = "lottie-animation-" + anmiLayer.id;
    if (document.bodymovinScript) {
      bodymovinTimer = Utils.interval(0.02, function() {
        if (bodymovin) {
          _loadJSON(jsonPath, elId, renderer, isLoop, isAutoplay, bodymovin);
          return window.clearInterval(bodymovinTimer);
        }
      });
    } else {
      document.bodymovinScript = Utils.domLoadScript('bodymovin.min.js', function() {
        return _loadJSON(jsonPath, elId, renderer, isLoop, isAutoplay, bodymovin);
      });
    }
    _loadJSON = function(jsonPath, elId, renderer, isLoop, isAutoplay, bodymovin) {
      return Utils.domLoadJSON(jsonPath, function(err, data) {
        var aniObj;
        aniObj = {
          container: document.getElementById(elId),
          renderer: renderer,
          loop: isLoop,
          autoplay: isAutoplay,
          animationData: data
        };
        return animationObj = bodymovin.loadAnimation(aniObj);
      });
    };
  }

  _loop = function(callback) {
    timer = Utils.interval(0.02, function() {});
    if (animationObj) {
      window.clearInterval(timer);
      return callback();
    }
  };

  bodymovinLayer.prototype.play = function() {
    return _loop(function() {
      return animationObj.play();
    });
  };

  bodymovinLayer.prototype.stop = function() {
    return _loop(function() {
      return animationObj.stop();
    });
  };

  bodymovinLayer.prototype.pause = function() {
    return _loop(function() {
      return animationObj.pause();
    });
  };

  bodymovinLayer.prototype.setSpeed = function(speed) {
    return _loop(function() {
      return animationObj.setSpeed(speed);
    });
  };

  bodymovinLayer.prototype.goToAndStop = function(value, isFrame) {
    return _loop(function() {
      return animationObj.goToAndStop(value, isFrame);
    });
  };

  bodymovinLayer.prototype.goToAndPlay = function(value, isFrame) {
    return _loop(function() {
      return animationObj.goToAndPlay(value, isFrame);
    });
  };

  bodymovinLayer.prototype.setDirection = function(direction) {
    return _loop(function() {
      return animationObj.setDirection(direction);
    });
  };

  bodymovinLayer.prototype.playSegments = function(segments, forceFlag) {
    return _loop(function() {
      return animationObj.playSegments(segments, forceFlag);
    });
  };

  bodymovinLayer.prototype.destroy = function() {
    return _loop(function() {
      return animationObj.destroy();
    });
  };

  return bodymovinLayer;

})(Layer);

module.exports = bodymovinLayer;


},{}],"Bodymovin2":[function(require,module,exports){
var bodymovinLayer,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

bodymovinLayer = (function(superClass) {
  var _loop, animationObj;

  extend(bodymovinLayer, superClass);

  animationObj = null;

  function bodymovinLayer(options) {
    var _loadJSON, anmiLayer, base, base1, base2, base3, base4, base5, base6, bodymovinTimer, elId, isAutoplay, isLoop, jsonPath, renderer;
    this.options = options != null ? options : {};
    if ((base = this.options).jsonPath == null) {
      base.jsonPath = 'data.json';
    }
    if ((base1 = this.options).width == null) {
      base1.width = 200;
    }
    if ((base2 = this.options).height == null) {
      base2.height = 200;
    }
    if ((base3 = this.options).backgroundColor == null) {
      base3.backgroundColor = 'transparent';
    }
    if ((base4 = this.options).renderer == null) {
      base4.renderer = 'svg';
    }
    if ((base5 = this.options).looping == null) {
      base5.looping = true;
    }
    if ((base6 = this.options).autoplay == null) {
      base6.autoplay = true;
    }
    bodymovinLayer.__super__.constructor.call(this, this.options);
    anmiLayer = new Layer({
      parent: this,
      width: this.options.width,
      height: this.options.height,
      backgroundColor: this.options.backgroundColor
    });
    anmiLayer.html = "<div id='lottie-animation-" + anmiLayer.id + "'></div>";
    anmiLayer._element.childNodes[0].style.height = '100%';
    anmiLayer._element.childNodes[0].childNodes[0].style.height = '100%';
    jsonPath = this.options.jsonPath;
    renderer = this.options.renderer;
    isLoop = this.options.looping;
    isAutoplay = this.options.autoplay;
    elId = "lottie-animation-" + anmiLayer.id;
    if (document.bodymovinScript) {
      bodymovinTimer = Utils.interval(0.1, function() {
        if (bodymovin) {
          _loadJSON(jsonPath, elId, renderer, isLoop, isAutoplay, bodymovin);
          return window.clearInterval(bodymovinTimer);
        }
      });
    } else {
      document.bodymovinScript = Utils.domLoadScript('bodymovin.min.js', function() {
        return _loadJSON(jsonPath, elId, renderer, isLoop, isAutoplay, bodymovin);
      });
    }
    _loadJSON = function(jsonPath, elId, renderer, isLoop, isAutoplay, bodymovin) {
      return Utils.domLoadJSON(jsonPath, function(err, data) {
        var aniObj;
        aniObj = {
          container: document.getElementById(elId),
          renderer: renderer,
          loop: isLoop,
          autoplay: isAutoplay,
          animationData: data
        };
        return animationObj = bodymovin.loadAnimation(aniObj);
      });
    };
  }

  _loop = function(callback) {
    if (animationObj) {
      return callback();
    }
  };

  bodymovinLayer.prototype.play = function() {
    return _loop(function() {
      return animationObj.play();
    });
  };

  bodymovinLayer.prototype.stop = function() {
    return _loop(function() {
      return animationObj.stop();
    });
  };

  bodymovinLayer.prototype.pause = function() {
    return _loop(function() {
      return animationObj.pause();
    });
  };

  bodymovinLayer.prototype.setSpeed = function(speed) {
    return _loop(function() {
      return animationObj.setSpeed(speed);
    });
  };

  bodymovinLayer.prototype.goToAndStop = function(value, isFrame) {
    return _loop(function() {
      return animationObj.goToAndStop(value, isFrame);
    });
  };

  bodymovinLayer.prototype.goToAndPlay = function(value, isFrame) {
    return _loop(function() {
      return animationObj.goToAndPlay(value, isFrame);
    });
  };

  bodymovinLayer.prototype.setDirection = function(direction) {
    return _loop(function() {
      return animationObj.setDirection(direction);
    });
  };

  bodymovinLayer.prototype.playSegments = function(segments, forceFlag) {
    return _loop(function() {
      return animationObj.playSegments(segments, forceFlag);
    });
  };

  bodymovinLayer.prototype.destroy = function() {
    return _loop(function() {
      return animationObj.destroy();
    });
  };

  return bodymovinLayer;

})(Layer);

module.exports = bodymovinLayer;


},{}],"Bodymovin3":[function(require,module,exports){
var bodymovinLayer,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

bodymovinLayer = (function(superClass) {
  var _loop, animationObj;

  extend(bodymovinLayer, superClass);

  animationObj = null;

  function bodymovinLayer(options) {
    var _loadJSON, anmiLayer, base, base1, base2, base3, base4, base5, base6, bodymovinTimer, elId, isAutoplay, isLoop, jsonPath, renderer;
    this.options = options != null ? options : {};
    if ((base = this.options).jsonPath == null) {
      base.jsonPath = 'data.json';
    }
    if ((base1 = this.options).width == null) {
      base1.width = 200;
    }
    if ((base2 = this.options).height == null) {
      base2.height = 200;
    }
    if ((base3 = this.options).backgroundColor == null) {
      base3.backgroundColor = 'transparent';
    }
    if ((base4 = this.options).renderer == null) {
      base4.renderer = 'svg';
    }
    if ((base5 = this.options).looping == null) {
      base5.looping = true;
    }
    if ((base6 = this.options).autoplay == null) {
      base6.autoplay = true;
    }
    bodymovinLayer.__super__.constructor.call(this, this.options);
    anmiLayer = new Layer({
      parent: this,
      width: this.options.width,
      height: this.options.height,
      backgroundColor: this.options.backgroundColor
    });
    anmiLayer.html = "<div id='lottie-animation-" + anmiLayer.id + "'></div>";
    anmiLayer._element.childNodes[0].style.height = '100%';
    anmiLayer._element.childNodes[0].childNodes[0].style.height = '100%';
    jsonPath = this.options.jsonPath;
    renderer = this.options.renderer;
    isLoop = this.options.looping;
    isAutoplay = this.options.autoplay;
    elId = "lottie-animation-" + anmiLayer.id;
    if (document.bodymovinScript) {
      bodymovinTimer = Utils.interval(0.1, function() {
        if (bodymovin) {
          _loadJSON(jsonPath, elId, renderer, isLoop, isAutoplay, bodymovin);
          return window.clearInterval(bodymovinTimer);
        }
      });
    } else {
      document.bodymovinScript = Utils.domLoadScript('bodymovin.min.js', function() {
        return _loadJSON(jsonPath, elId, renderer, isLoop, isAutoplay, bodymovin);
      });
    }
    _loadJSON = function(jsonPath, elId, renderer, isLoop, isAutoplay, bodymovin) {
      return Utils.domLoadJSON(jsonPath, function(err, data) {
        var aniObj;
        aniObj = {
          container: document.getElementById(elId),
          renderer: renderer,
          loop: isLoop,
          autoplay: isAutoplay,
          animationData: data
        };
        return animationObj = bodymovin.loadAnimation(aniObj);
      });
    };
  }

  _loop = function(callback) {
    if (animationObj) {
      return callback();
    }
  };

  bodymovinLayer.prototype.play = function() {
    return _loop(function() {
      return animationObj.play();
    });
  };

  bodymovinLayer.prototype.stop = function() {
    return _loop(function() {
      return animationObj.stop();
    });
  };

  bodymovinLayer.prototype.pause = function() {
    return _loop(function() {
      return animationObj.pause();
    });
  };

  bodymovinLayer.prototype.setSpeed = function(speed) {
    return _loop(function() {
      return animationObj.setSpeed(speed);
    });
  };

  bodymovinLayer.prototype.goToAndStop = function(value, isFrame) {
    return _loop(function() {
      return animationObj.goToAndStop(value, isFrame);
    });
  };

  bodymovinLayer.prototype.goToAndPlay = function(value, isFrame) {
    return _loop(function() {
      return animationObj.goToAndPlay(value, isFrame);
    });
  };

  bodymovinLayer.prototype.setDirection = function(direction) {
    return _loop(function() {
      return animationObj.setDirection(direction);
    });
  };

  bodymovinLayer.prototype.playSegments = function(segments, forceFlag) {
    return _loop(function() {
      return animationObj.playSegments(segments, forceFlag);
    });
  };

  bodymovinLayer.prototype.destroy = function() {
    return _loop(function() {
      return animationObj.destroy();
    });
  };

  return bodymovinLayer;

})(Layer);

module.exports = bodymovinLayer;


},{}],"Bodymovin4":[function(require,module,exports){
var bodymovinLayer,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

bodymovinLayer = (function(superClass) {
  var _loop, animationObj;

  extend(bodymovinLayer, superClass);

  animationObj = null;

  function bodymovinLayer(options) {
    var _loadJSON, anmiLayer, base, base1, base2, base3, base4, base5, base6, bodymovinTimer, elId, isAutoplay, isLoop, jsonPath, renderer;
    this.options = options != null ? options : {};
    if ((base = this.options).jsonPath == null) {
      base.jsonPath = 'data.json';
    }
    if ((base1 = this.options).width == null) {
      base1.width = 200;
    }
    if ((base2 = this.options).height == null) {
      base2.height = 200;
    }
    if ((base3 = this.options).backgroundColor == null) {
      base3.backgroundColor = 'transparent';
    }
    if ((base4 = this.options).renderer == null) {
      base4.renderer = 'svg';
    }
    if ((base5 = this.options).looping == null) {
      base5.looping = true;
    }
    if ((base6 = this.options).autoplay == null) {
      base6.autoplay = true;
    }
    bodymovinLayer.__super__.constructor.call(this, this.options);
    anmiLayer = new Layer({
      parent: this,
      width: this.options.width,
      height: this.options.height,
      backgroundColor: this.options.backgroundColor
    });
    anmiLayer.html = "<div id='lottie-animation-" + anmiLayer.id + "'></div>";
    anmiLayer._element.childNodes[0].style.height = '100%';
    anmiLayer._element.childNodes[0].childNodes[0].style.height = '100%';
    jsonPath = this.options.jsonPath;
    renderer = this.options.renderer;
    isLoop = this.options.looping;
    isAutoplay = this.options.autoplay;
    elId = "lottie-animation-" + anmiLayer.id;
    if (document.bodymovinScript) {
      bodymovinTimer = Utils.interval(0.1, function() {
        if (bodymovin) {
          _loadJSON(jsonPath, elId, renderer, isLoop, isAutoplay, bodymovin);
          return window.clearInterval(bodymovinTimer);
        }
      });
    } else {
      document.bodymovinScript = Utils.domLoadScript('bodymovin.min.js', function() {
        return _loadJSON(jsonPath, elId, renderer, isLoop, isAutoplay, bodymovin);
      });
    }
    _loadJSON = function(jsonPath, elId, renderer, isLoop, isAutoplay, bodymovin) {
      return Utils.domLoadJSON(jsonPath, function(err, data) {
        var aniObj;
        aniObj = {
          container: document.getElementById(elId),
          renderer: renderer,
          loop: isLoop,
          autoplay: isAutoplay,
          animationData: data
        };
        return animationObj = bodymovin.loadAnimation(aniObj);
      });
    };
  }

  _loop = function(callback) {
    if (animationObj) {
      return callback();
    }
  };

  bodymovinLayer.prototype.play = function() {
    return _loop(function() {
      return animationObj.play();
    });
  };

  bodymovinLayer.prototype.stop = function() {
    return _loop(function() {
      return animationObj.stop();
    });
  };

  bodymovinLayer.prototype.pause = function() {
    return _loop(function() {
      return animationObj.pause();
    });
  };

  bodymovinLayer.prototype.setSpeed = function(speed) {
    return _loop(function() {
      return animationObj.setSpeed(speed);
    });
  };

  bodymovinLayer.prototype.goToAndStop = function(value, isFrame) {
    return _loop(function() {
      return animationObj.goToAndStop(value, isFrame);
    });
  };

  bodymovinLayer.prototype.goToAndPlay = function(value, isFrame) {
    return _loop(function() {
      return animationObj.goToAndPlay(value, isFrame);
    });
  };

  bodymovinLayer.prototype.setDirection = function(direction) {
    return _loop(function() {
      return animationObj.setDirection(direction);
    });
  };

  bodymovinLayer.prototype.playSegments = function(segments, forceFlag) {
    return _loop(function() {
      return animationObj.playSegments(segments, forceFlag);
    });
  };

  bodymovinLayer.prototype.destroy = function() {
    return _loop(function() {
      return animationObj.destroy();
    });
  };

  return bodymovinLayer;

})(Layer);

module.exports = bodymovinLayer;


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZnJhbWVyLm1vZHVsZXMuanMiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL1VzZXJzL3JheS9MaWJyYXJ5L01vYmlsZSBEb2N1bWVudHMvY29tfmFwcGxlfkNsb3VkRG9jcy9XZWliby8xNzA2MzBfRmVlZOaVheS6i+e7huiKguWKqOaViC9jaXJjbGVBdmVudGFyLmZyYW1lci9tb2R1bGVzL0JvZHltb3ZpbjQuY29mZmVlIiwiLi4vLi4vLi4vLi4vLi4vVXNlcnMvcmF5L0xpYnJhcnkvTW9iaWxlIERvY3VtZW50cy9jb21+YXBwbGV+Q2xvdWREb2NzL1dlaWJvLzE3MDYzMF9GZWVk5pWF5LqL57uG6IqC5Yqo5pWIL2NpcmNsZUF2ZW50YXIuZnJhbWVyL21vZHVsZXMvQm9keW1vdmluMy5jb2ZmZWUiLCIuLi8uLi8uLi8uLi8uLi9Vc2Vycy9yYXkvTGlicmFyeS9Nb2JpbGUgRG9jdW1lbnRzL2NvbX5hcHBsZX5DbG91ZERvY3MvV2VpYm8vMTcwNjMwX0ZlZWTmlYXkuovnu4boioLliqjmlYgvY2lyY2xlQXZlbnRhci5mcmFtZXIvbW9kdWxlcy9Cb2R5bW92aW4yLmNvZmZlZSIsIi4uLy4uLy4uLy4uLy4uL1VzZXJzL3JheS9MaWJyYXJ5L01vYmlsZSBEb2N1bWVudHMvY29tfmFwcGxlfkNsb3VkRG9jcy9XZWliby8xNzA2MzBfRmVlZOaVheS6i+e7huiKguWKqOaViC9jaXJjbGVBdmVudGFyLmZyYW1lci9tb2R1bGVzL0JvZHltb3ZpbjEuY29mZmVlIiwibm9kZV9tb2R1bGVzL2Jyb3dzZXItcGFjay9fcHJlbHVkZS5qcyJdLCJzb3VyY2VzQ29udGVudCI6WyJjbGFzcyBib2R5bW92aW5MYXllciBleHRlbmRzIExheWVyXG5cdGFuaW1hdGlvbk9iaiA9IG51bGxcblx0IyB0aW1lciA9IG51bGxcblx0IyDmnoTpgKDlmahcblx0Y29uc3RydWN0b3I6IChAb3B0aW9ucz17fSkgLT5cblx0XHQjIOWfuuacrOmFjee9rumhuVxuXHRcdEBvcHRpb25zLmpzb25QYXRoID89ICdkYXRhLmpzb24nXG5cdFx0QG9wdGlvbnMud2lkdGggPz0gMjAwXG5cdFx0QG9wdGlvbnMuaGVpZ2h0ID89IDIwMFxuXHRcdEBvcHRpb25zLmJhY2tncm91bmRDb2xvciA/PSAndHJhbnNwYXJlbnQnXG5cdFx0QG9wdGlvbnMucmVuZGVyZXIgPz0gJ3N2Zydcblx0XHRAb3B0aW9ucy5sb29waW5nID89IHRydWVcblx0XHRAb3B0aW9ucy5hdXRvcGxheSA/PSB0cnVlXG5cblx0XHRzdXBlciBAb3B0aW9uc1xuXG5cdFx0YW5taUxheWVyID0gbmV3IExheWVyXG5cdFx0XHRwYXJlbnQ6IEBcblx0XHRcdHdpZHRoOiBAb3B0aW9ucy53aWR0aFxuXHRcdFx0aGVpZ2h0OiBAb3B0aW9ucy5oZWlnaHRcblx0XHRcdGJhY2tncm91bmRDb2xvcjogQG9wdGlvbnMuYmFja2dyb3VuZENvbG9yXG5cblx0XHRhbm1pTGF5ZXIuaHRtbCA9IFwiPGRpdiBpZD0nbG90dGllLWFuaW1hdGlvbi1cIithbm1pTGF5ZXIuaWQrXCInPjwvZGl2PlwiXG5cdFx0YW5taUxheWVyLl9lbGVtZW50LmNoaWxkTm9kZXNbMF0uc3R5bGUuaGVpZ2h0ID0gJzEwMCUnXG5cdFx0YW5taUxheWVyLl9lbGVtZW50LmNoaWxkTm9kZXNbMF0uY2hpbGROb2Rlc1swXS5zdHlsZS5oZWlnaHQgPSAnMTAwJSdcblxuXHRcdGpzb25QYXRoID0gQG9wdGlvbnMuanNvblBhdGhcblx0XHRyZW5kZXJlciA9IEBvcHRpb25zLnJlbmRlcmVyXG5cdFx0aXNMb29wID0gQG9wdGlvbnMubG9vcGluZ1xuXHRcdGlzQXV0b3BsYXkgPSBAb3B0aW9ucy5hdXRvcGxheVxuXG5cdFx0ZWxJZCA9IFwibG90dGllLWFuaW1hdGlvbi1cIithbm1pTGF5ZXIuaWRcblxuXHRcdGlmKGRvY3VtZW50LmJvZHltb3ZpblNjcmlwdClcblx0XHRcdGJvZHltb3ZpblRpbWVyID0gVXRpbHMuaW50ZXJ2YWwgMC4xLC0+XG5cdFx0XHRcdGlmKGJvZHltb3Zpbilcblx0XHRcdFx0XHRfbG9hZEpTT04oanNvblBhdGgsZWxJZCxyZW5kZXJlcixpc0xvb3AsaXNBdXRvcGxheSxib2R5bW92aW4pXG5cdFx0XHRcdFx0d2luZG93LmNsZWFySW50ZXJ2YWwoYm9keW1vdmluVGltZXIpXG5cdFx0ZWxzZVxuXHRcdFx0ZG9jdW1lbnQuYm9keW1vdmluU2NyaXB0ID0gVXRpbHMuZG9tTG9hZFNjcmlwdCAnYm9keW1vdmluLm1pbi5qcycsIC0+XG5cdFx0XHRcdF9sb2FkSlNPTihqc29uUGF0aCxlbElkLHJlbmRlcmVyLGlzTG9vcCxpc0F1dG9wbGF5LGJvZHltb3ZpbilcblxuXHRcdF9sb2FkSlNPTiA9IChqc29uUGF0aCxlbElkLHJlbmRlcmVyLGlzTG9vcCxpc0F1dG9wbGF5LGJvZHltb3ZpbikgLT5cblx0XHRcdFV0aWxzLmRvbUxvYWRKU09OIGpzb25QYXRoLCAoZXJyLCBkYXRhKS0+XG5cdFx0XHRcdGFuaU9iaiA9XG5cdFx0XHRcdFx0Y29udGFpbmVyOiBkb2N1bWVudC5nZXRFbGVtZW50QnlJZChlbElkKVxuXHRcdFx0XHRcdHJlbmRlcmVyOiByZW5kZXJlclxuXHRcdFx0XHRcdGxvb3A6IGlzTG9vcFxuXHRcdFx0XHRcdGF1dG9wbGF5OiBpc0F1dG9wbGF5XG5cdFx0XHRcdFx0YW5pbWF0aW9uRGF0YTogZGF0YVxuXHRcdFx0XHRhbmltYXRpb25PYmogPSBib2R5bW92aW4ubG9hZEFuaW1hdGlvbihhbmlPYmopXG5cblx0X2xvb3AgPSAoY2FsbGJhY2spLT5cblx0XHQjIHRpbWVyID0gVXRpbHMuaW50ZXJ2YWwgMC4wMiwtPlxuXHRcdGlmKGFuaW1hdGlvbk9iailcblx0XHRcdCMgd2luZG93LmNsZWFySW50ZXJ2YWwodGltZXIpXG5cdFx0XHRjYWxsYmFjaygpXG5cdHBsYXk6KCktPlxuXHRcdF9sb29wICgpLT5cblx0XHRcdGFuaW1hdGlvbk9iai5wbGF5KClcblx0c3RvcDooKS0+XG5cdFx0X2xvb3AgKCktPlxuXHRcdFx0YW5pbWF0aW9uT2JqLnN0b3AoKVxuXHRwYXVzZTooKS0+XG5cdFx0X2xvb3AgKCktPlxuXHRcdFx0YW5pbWF0aW9uT2JqLnBhdXNlKClcblx0c2V0U3BlZWQ6KHNwZWVkKS0+XG5cdFx0X2xvb3AgKCktPlxuXHRcdFx0YW5pbWF0aW9uT2JqLnNldFNwZWVkKHNwZWVkKVxuXHRnb1RvQW5kU3RvcDoodmFsdWUsIGlzRnJhbWUpLT5cblx0XHRfbG9vcCAoKS0+XG5cdFx0XHRhbmltYXRpb25PYmouZ29Ub0FuZFN0b3AodmFsdWUsIGlzRnJhbWUpXG5cdGdvVG9BbmRQbGF5Oih2YWx1ZSwgaXNGcmFtZSktPlxuXHRcdF9sb29wICgpLT5cblx0XHRcdGFuaW1hdGlvbk9iai5nb1RvQW5kUGxheSh2YWx1ZSwgaXNGcmFtZSlcblx0c2V0RGlyZWN0aW9uOihkaXJlY3Rpb24pLT5cblx0XHRfbG9vcCAoKS0+XG5cdFx0XHRhbmltYXRpb25PYmouc2V0RGlyZWN0aW9uKGRpcmVjdGlvbilcblx0cGxheVNlZ21lbnRzOihzZWdtZW50cywgZm9yY2VGbGFnKS0+XG5cdFx0X2xvb3AgKCktPlxuXHRcdFx0YW5pbWF0aW9uT2JqLnBsYXlTZWdtZW50cyhzZWdtZW50cywgZm9yY2VGbGFnKVxuXHRkZXN0cm95OigpLT5cblx0XHRfbG9vcCAoKS0+XG5cdFx0XHRhbmltYXRpb25PYmouZGVzdHJveSgpXG5cbm1vZHVsZS5leHBvcnRzID0gYm9keW1vdmluTGF5ZXJcbiIsImNsYXNzIGJvZHltb3ZpbkxheWVyIGV4dGVuZHMgTGF5ZXJcblx0YW5pbWF0aW9uT2JqID0gbnVsbFxuXHQjIHRpbWVyID0gbnVsbFxuXHQjIOaehOmAoOWZqFxuXHRjb25zdHJ1Y3RvcjogKEBvcHRpb25zPXt9KSAtPlxuXHRcdCMg5Z+65pys6YWN572u6aG5XG5cdFx0QG9wdGlvbnMuanNvblBhdGggPz0gJ2RhdGEuanNvbidcblx0XHRAb3B0aW9ucy53aWR0aCA/PSAyMDBcblx0XHRAb3B0aW9ucy5oZWlnaHQgPz0gMjAwXG5cdFx0QG9wdGlvbnMuYmFja2dyb3VuZENvbG9yID89ICd0cmFuc3BhcmVudCdcblx0XHRAb3B0aW9ucy5yZW5kZXJlciA/PSAnc3ZnJ1xuXHRcdEBvcHRpb25zLmxvb3BpbmcgPz0gdHJ1ZVxuXHRcdEBvcHRpb25zLmF1dG9wbGF5ID89IHRydWVcblxuXHRcdHN1cGVyIEBvcHRpb25zXG5cblx0XHRhbm1pTGF5ZXIgPSBuZXcgTGF5ZXJcblx0XHRcdHBhcmVudDogQFxuXHRcdFx0d2lkdGg6IEBvcHRpb25zLndpZHRoXG5cdFx0XHRoZWlnaHQ6IEBvcHRpb25zLmhlaWdodFxuXHRcdFx0YmFja2dyb3VuZENvbG9yOiBAb3B0aW9ucy5iYWNrZ3JvdW5kQ29sb3JcblxuXHRcdGFubWlMYXllci5odG1sID0gXCI8ZGl2IGlkPSdsb3R0aWUtYW5pbWF0aW9uLVwiK2FubWlMYXllci5pZCtcIic+PC9kaXY+XCJcblx0XHRhbm1pTGF5ZXIuX2VsZW1lbnQuY2hpbGROb2Rlc1swXS5zdHlsZS5oZWlnaHQgPSAnMTAwJSdcblx0XHRhbm1pTGF5ZXIuX2VsZW1lbnQuY2hpbGROb2Rlc1swXS5jaGlsZE5vZGVzWzBdLnN0eWxlLmhlaWdodCA9ICcxMDAlJ1xuXG5cdFx0anNvblBhdGggPSBAb3B0aW9ucy5qc29uUGF0aFxuXHRcdHJlbmRlcmVyID0gQG9wdGlvbnMucmVuZGVyZXJcblx0XHRpc0xvb3AgPSBAb3B0aW9ucy5sb29waW5nXG5cdFx0aXNBdXRvcGxheSA9IEBvcHRpb25zLmF1dG9wbGF5XG5cblx0XHRlbElkID0gXCJsb3R0aWUtYW5pbWF0aW9uLVwiK2FubWlMYXllci5pZFxuXG5cdFx0aWYoZG9jdW1lbnQuYm9keW1vdmluU2NyaXB0KVxuXHRcdFx0Ym9keW1vdmluVGltZXIgPSBVdGlscy5pbnRlcnZhbCAwLjEsLT5cblx0XHRcdFx0aWYoYm9keW1vdmluKVxuXHRcdFx0XHRcdF9sb2FkSlNPTihqc29uUGF0aCxlbElkLHJlbmRlcmVyLGlzTG9vcCxpc0F1dG9wbGF5LGJvZHltb3Zpbilcblx0XHRcdFx0XHR3aW5kb3cuY2xlYXJJbnRlcnZhbChib2R5bW92aW5UaW1lcilcblx0XHRlbHNlXG5cdFx0XHRkb2N1bWVudC5ib2R5bW92aW5TY3JpcHQgPSBVdGlscy5kb21Mb2FkU2NyaXB0ICdib2R5bW92aW4ubWluLmpzJywgLT5cblx0XHRcdFx0X2xvYWRKU09OKGpzb25QYXRoLGVsSWQscmVuZGVyZXIsaXNMb29wLGlzQXV0b3BsYXksYm9keW1vdmluKVxuXG5cdFx0X2xvYWRKU09OID0gKGpzb25QYXRoLGVsSWQscmVuZGVyZXIsaXNMb29wLGlzQXV0b3BsYXksYm9keW1vdmluKSAtPlxuXHRcdFx0VXRpbHMuZG9tTG9hZEpTT04ganNvblBhdGgsIChlcnIsIGRhdGEpLT5cblx0XHRcdFx0YW5pT2JqID1cblx0XHRcdFx0XHRjb250YWluZXI6IGRvY3VtZW50LmdldEVsZW1lbnRCeUlkKGVsSWQpXG5cdFx0XHRcdFx0cmVuZGVyZXI6IHJlbmRlcmVyXG5cdFx0XHRcdFx0bG9vcDogaXNMb29wXG5cdFx0XHRcdFx0YXV0b3BsYXk6IGlzQXV0b3BsYXlcblx0XHRcdFx0XHRhbmltYXRpb25EYXRhOiBkYXRhXG5cdFx0XHRcdGFuaW1hdGlvbk9iaiA9IGJvZHltb3Zpbi5sb2FkQW5pbWF0aW9uKGFuaU9iailcblxuXHRfbG9vcCA9IChjYWxsYmFjayktPlxuXHRcdCMgdGltZXIgPSBVdGlscy5pbnRlcnZhbCAwLjAyLC0+XG5cdFx0aWYoYW5pbWF0aW9uT2JqKVxuXHRcdFx0IyB3aW5kb3cuY2xlYXJJbnRlcnZhbCh0aW1lcilcblx0XHRcdGNhbGxiYWNrKClcblx0cGxheTooKS0+XG5cdFx0X2xvb3AgKCktPlxuXHRcdFx0YW5pbWF0aW9uT2JqLnBsYXkoKVxuXHRzdG9wOigpLT5cblx0XHRfbG9vcCAoKS0+XG5cdFx0XHRhbmltYXRpb25PYmouc3RvcCgpXG5cdHBhdXNlOigpLT5cblx0XHRfbG9vcCAoKS0+XG5cdFx0XHRhbmltYXRpb25PYmoucGF1c2UoKVxuXHRzZXRTcGVlZDooc3BlZWQpLT5cblx0XHRfbG9vcCAoKS0+XG5cdFx0XHRhbmltYXRpb25PYmouc2V0U3BlZWQoc3BlZWQpXG5cdGdvVG9BbmRTdG9wOih2YWx1ZSwgaXNGcmFtZSktPlxuXHRcdF9sb29wICgpLT5cblx0XHRcdGFuaW1hdGlvbk9iai5nb1RvQW5kU3RvcCh2YWx1ZSwgaXNGcmFtZSlcblx0Z29Ub0FuZFBsYXk6KHZhbHVlLCBpc0ZyYW1lKS0+XG5cdFx0X2xvb3AgKCktPlxuXHRcdFx0YW5pbWF0aW9uT2JqLmdvVG9BbmRQbGF5KHZhbHVlLCBpc0ZyYW1lKVxuXHRzZXREaXJlY3Rpb246KGRpcmVjdGlvbiktPlxuXHRcdF9sb29wICgpLT5cblx0XHRcdGFuaW1hdGlvbk9iai5zZXREaXJlY3Rpb24oZGlyZWN0aW9uKVxuXHRwbGF5U2VnbWVudHM6KHNlZ21lbnRzLCBmb3JjZUZsYWcpLT5cblx0XHRfbG9vcCAoKS0+XG5cdFx0XHRhbmltYXRpb25PYmoucGxheVNlZ21lbnRzKHNlZ21lbnRzLCBmb3JjZUZsYWcpXG5cdGRlc3Ryb3k6KCktPlxuXHRcdF9sb29wICgpLT5cblx0XHRcdGFuaW1hdGlvbk9iai5kZXN0cm95KClcblxubW9kdWxlLmV4cG9ydHMgPSBib2R5bW92aW5MYXllclxuIiwiY2xhc3MgYm9keW1vdmluTGF5ZXIgZXh0ZW5kcyBMYXllclxuXHRhbmltYXRpb25PYmogPSBudWxsXG5cdCMgdGltZXIgPSBudWxsXG5cdCMg5p6E6YCg5ZmoXG5cdGNvbnN0cnVjdG9yOiAoQG9wdGlvbnM9e30pIC0+XG5cdFx0IyDln7rmnKzphY3nva7poblcblx0XHRAb3B0aW9ucy5qc29uUGF0aCA/PSAnZGF0YS5qc29uJ1xuXHRcdEBvcHRpb25zLndpZHRoID89IDIwMFxuXHRcdEBvcHRpb25zLmhlaWdodCA/PSAyMDBcblx0XHRAb3B0aW9ucy5iYWNrZ3JvdW5kQ29sb3IgPz0gJ3RyYW5zcGFyZW50J1xuXHRcdEBvcHRpb25zLnJlbmRlcmVyID89ICdzdmcnXG5cdFx0QG9wdGlvbnMubG9vcGluZyA/PSB0cnVlXG5cdFx0QG9wdGlvbnMuYXV0b3BsYXkgPz0gdHJ1ZVxuXG5cdFx0c3VwZXIgQG9wdGlvbnNcblxuXHRcdGFubWlMYXllciA9IG5ldyBMYXllclxuXHRcdFx0cGFyZW50OiBAXG5cdFx0XHR3aWR0aDogQG9wdGlvbnMud2lkdGhcblx0XHRcdGhlaWdodDogQG9wdGlvbnMuaGVpZ2h0XG5cdFx0XHRiYWNrZ3JvdW5kQ29sb3I6IEBvcHRpb25zLmJhY2tncm91bmRDb2xvclxuXG5cdFx0YW5taUxheWVyLmh0bWwgPSBcIjxkaXYgaWQ9J2xvdHRpZS1hbmltYXRpb24tXCIrYW5taUxheWVyLmlkK1wiJz48L2Rpdj5cIlxuXHRcdGFubWlMYXllci5fZWxlbWVudC5jaGlsZE5vZGVzWzBdLnN0eWxlLmhlaWdodCA9ICcxMDAlJ1xuXHRcdGFubWlMYXllci5fZWxlbWVudC5jaGlsZE5vZGVzWzBdLmNoaWxkTm9kZXNbMF0uc3R5bGUuaGVpZ2h0ID0gJzEwMCUnXG5cblx0XHRqc29uUGF0aCA9IEBvcHRpb25zLmpzb25QYXRoXG5cdFx0cmVuZGVyZXIgPSBAb3B0aW9ucy5yZW5kZXJlclxuXHRcdGlzTG9vcCA9IEBvcHRpb25zLmxvb3Bpbmdcblx0XHRpc0F1dG9wbGF5ID0gQG9wdGlvbnMuYXV0b3BsYXlcblxuXHRcdGVsSWQgPSBcImxvdHRpZS1hbmltYXRpb24tXCIrYW5taUxheWVyLmlkXG5cblx0XHRpZihkb2N1bWVudC5ib2R5bW92aW5TY3JpcHQpXG5cdFx0XHRib2R5bW92aW5UaW1lciA9IFV0aWxzLmludGVydmFsIDAuMSwtPlxuXHRcdFx0XHRpZihib2R5bW92aW4pXG5cdFx0XHRcdFx0X2xvYWRKU09OKGpzb25QYXRoLGVsSWQscmVuZGVyZXIsaXNMb29wLGlzQXV0b3BsYXksYm9keW1vdmluKVxuXHRcdFx0XHRcdHdpbmRvdy5jbGVhckludGVydmFsKGJvZHltb3ZpblRpbWVyKVxuXHRcdGVsc2Vcblx0XHRcdGRvY3VtZW50LmJvZHltb3ZpblNjcmlwdCA9IFV0aWxzLmRvbUxvYWRTY3JpcHQgJ2JvZHltb3Zpbi5taW4uanMnLCAtPlxuXHRcdFx0XHRfbG9hZEpTT04oanNvblBhdGgsZWxJZCxyZW5kZXJlcixpc0xvb3AsaXNBdXRvcGxheSxib2R5bW92aW4pXG5cblx0XHRfbG9hZEpTT04gPSAoanNvblBhdGgsZWxJZCxyZW5kZXJlcixpc0xvb3AsaXNBdXRvcGxheSxib2R5bW92aW4pIC0+XG5cdFx0XHRVdGlscy5kb21Mb2FkSlNPTiBqc29uUGF0aCwgKGVyciwgZGF0YSktPlxuXHRcdFx0XHRhbmlPYmogPVxuXHRcdFx0XHRcdGNvbnRhaW5lcjogZG9jdW1lbnQuZ2V0RWxlbWVudEJ5SWQoZWxJZClcblx0XHRcdFx0XHRyZW5kZXJlcjogcmVuZGVyZXJcblx0XHRcdFx0XHRsb29wOiBpc0xvb3Bcblx0XHRcdFx0XHRhdXRvcGxheTogaXNBdXRvcGxheVxuXHRcdFx0XHRcdGFuaW1hdGlvbkRhdGE6IGRhdGFcblx0XHRcdFx0YW5pbWF0aW9uT2JqID0gYm9keW1vdmluLmxvYWRBbmltYXRpb24oYW5pT2JqKVxuXG5cdF9sb29wID0gKGNhbGxiYWNrKS0+XG5cdFx0IyB0aW1lciA9IFV0aWxzLmludGVydmFsIDAuMDIsLT5cblx0XHRpZihhbmltYXRpb25PYmopXG5cdFx0XHQjIHdpbmRvdy5jbGVhckludGVydmFsKHRpbWVyKVxuXHRcdFx0Y2FsbGJhY2soKVxuXHRwbGF5OigpLT5cblx0XHRfbG9vcCAoKS0+XG5cdFx0XHRhbmltYXRpb25PYmoucGxheSgpXG5cdHN0b3A6KCktPlxuXHRcdF9sb29wICgpLT5cblx0XHRcdGFuaW1hdGlvbk9iai5zdG9wKClcblx0cGF1c2U6KCktPlxuXHRcdF9sb29wICgpLT5cblx0XHRcdGFuaW1hdGlvbk9iai5wYXVzZSgpXG5cdHNldFNwZWVkOihzcGVlZCktPlxuXHRcdF9sb29wICgpLT5cblx0XHRcdGFuaW1hdGlvbk9iai5zZXRTcGVlZChzcGVlZClcblx0Z29Ub0FuZFN0b3A6KHZhbHVlLCBpc0ZyYW1lKS0+XG5cdFx0X2xvb3AgKCktPlxuXHRcdFx0YW5pbWF0aW9uT2JqLmdvVG9BbmRTdG9wKHZhbHVlLCBpc0ZyYW1lKVxuXHRnb1RvQW5kUGxheToodmFsdWUsIGlzRnJhbWUpLT5cblx0XHRfbG9vcCAoKS0+XG5cdFx0XHRhbmltYXRpb25PYmouZ29Ub0FuZFBsYXkodmFsdWUsIGlzRnJhbWUpXG5cdHNldERpcmVjdGlvbjooZGlyZWN0aW9uKS0+XG5cdFx0X2xvb3AgKCktPlxuXHRcdFx0YW5pbWF0aW9uT2JqLnNldERpcmVjdGlvbihkaXJlY3Rpb24pXG5cdHBsYXlTZWdtZW50czooc2VnbWVudHMsIGZvcmNlRmxhZyktPlxuXHRcdF9sb29wICgpLT5cblx0XHRcdGFuaW1hdGlvbk9iai5wbGF5U2VnbWVudHMoc2VnbWVudHMsIGZvcmNlRmxhZylcblx0ZGVzdHJveTooKS0+XG5cdFx0X2xvb3AgKCktPlxuXHRcdFx0YW5pbWF0aW9uT2JqLmRlc3Ryb3koKVxuXG5tb2R1bGUuZXhwb3J0cyA9IGJvZHltb3ZpbkxheWVyXG4iLCJjbGFzcyBib2R5bW92aW5MYXllciBleHRlbmRzIExheWVyXG5cdGFuaW1hdGlvbk9iaiA9IG51bGxcblx0dGltZXIgPSBudWxsXG5cdCMg5p6E6YCg5ZmoXG5cdGNvbnN0cnVjdG9yOiAoQG9wdGlvbnM9e30pIC0+XG5cdFx0IyDln7rmnKzphY3nva7poblcblx0XHRAb3B0aW9ucy5qc29uUGF0aCA/PSAnZGF0YS5qc29uJ1xuXHRcdEBvcHRpb25zLndpZHRoID89IDIwMFxuXHRcdEBvcHRpb25zLmhlaWdodCA/PSAyMDBcblx0XHRAb3B0aW9ucy5iYWNrZ3JvdW5kQ29sb3IgPz0gJ3RyYW5zcGFyZW50J1xuXHRcdEBvcHRpb25zLnJlbmRlcmVyID89ICdzdmcnXG5cdFx0QG9wdGlvbnMubG9vcGluZyA/PSB0cnVlXG5cdFx0QG9wdGlvbnMuYXV0b3BsYXkgPz0gdHJ1ZVxuXG5cdFx0c3VwZXIgQG9wdGlvbnNcblxuXHRcdGFubWlMYXllciA9IG5ldyBMYXllclxuXHRcdFx0cGFyZW50OiBAXG5cdFx0XHR3aWR0aDogQG9wdGlvbnMud2lkdGhcblx0XHRcdGhlaWdodDogQG9wdGlvbnMuaGVpZ2h0XG5cdFx0XHRiYWNrZ3JvdW5kQ29sb3I6IEBvcHRpb25zLmJhY2tncm91bmRDb2xvclxuXG5cdFx0YW5taUxheWVyLmh0bWwgPSBcIjxkaXYgaWQ9J2xvdHRpZS1hbmltYXRpb24tXCIrYW5taUxheWVyLmlkK1wiJz48L2Rpdj5cIlxuXHRcdGFubWlMYXllci5fZWxlbWVudC5jaGlsZE5vZGVzWzBdLnN0eWxlLmhlaWdodCA9ICcxMDAlJ1xuXHRcdGFubWlMYXllci5fZWxlbWVudC5jaGlsZE5vZGVzWzBdLmNoaWxkTm9kZXNbMF0uc3R5bGUuaGVpZ2h0ID0gJzEwMCUnXG5cblx0XHRqc29uUGF0aCA9IEBvcHRpb25zLmpzb25QYXRoXG5cdFx0cmVuZGVyZXIgPSBAb3B0aW9ucy5yZW5kZXJlclxuXHRcdGlzTG9vcCA9IEBvcHRpb25zLmxvb3Bpbmdcblx0XHRpc0F1dG9wbGF5ID0gQG9wdGlvbnMuYXV0b3BsYXlcblxuXHRcdGVsSWQgPSBcImxvdHRpZS1hbmltYXRpb24tXCIrYW5taUxheWVyLmlkXG5cblx0XHRpZihkb2N1bWVudC5ib2R5bW92aW5TY3JpcHQpXG5cdFx0XHRib2R5bW92aW5UaW1lciA9IFV0aWxzLmludGVydmFsIDAuMDIsLT5cblx0XHRcdFx0aWYoYm9keW1vdmluKVxuXHRcdFx0XHRcdF9sb2FkSlNPTihqc29uUGF0aCxlbElkLHJlbmRlcmVyLGlzTG9vcCxpc0F1dG9wbGF5LGJvZHltb3Zpbilcblx0XHRcdFx0XHR3aW5kb3cuY2xlYXJJbnRlcnZhbChib2R5bW92aW5UaW1lcilcblx0XHRlbHNlXG5cdFx0XHRkb2N1bWVudC5ib2R5bW92aW5TY3JpcHQgPSBVdGlscy5kb21Mb2FkU2NyaXB0ICdib2R5bW92aW4ubWluLmpzJywgLT5cblx0XHRcdFx0X2xvYWRKU09OKGpzb25QYXRoLGVsSWQscmVuZGVyZXIsaXNMb29wLGlzQXV0b3BsYXksYm9keW1vdmluKVxuXG5cdFx0X2xvYWRKU09OID0gKGpzb25QYXRoLGVsSWQscmVuZGVyZXIsaXNMb29wLGlzQXV0b3BsYXksYm9keW1vdmluKSAtPlxuXHRcdFx0VXRpbHMuZG9tTG9hZEpTT04ganNvblBhdGgsIChlcnIsIGRhdGEpLT5cblx0XHRcdFx0YW5pT2JqID1cblx0XHRcdFx0XHRjb250YWluZXI6IGRvY3VtZW50LmdldEVsZW1lbnRCeUlkKGVsSWQpXG5cdFx0XHRcdFx0cmVuZGVyZXI6IHJlbmRlcmVyXG5cdFx0XHRcdFx0bG9vcDogaXNMb29wXG5cdFx0XHRcdFx0YXV0b3BsYXk6IGlzQXV0b3BsYXlcblx0XHRcdFx0XHRhbmltYXRpb25EYXRhOiBkYXRhXG5cdFx0XHRcdGFuaW1hdGlvbk9iaiA9IGJvZHltb3Zpbi5sb2FkQW5pbWF0aW9uKGFuaU9iailcblxuXHRfbG9vcCA9IChjYWxsYmFjayktPlxuXHRcdHRpbWVyID0gVXRpbHMuaW50ZXJ2YWwgMC4wMiwtPlxuXHRcdGlmKGFuaW1hdGlvbk9iailcblx0XHRcdHdpbmRvdy5jbGVhckludGVydmFsKHRpbWVyKVxuXHRcdFx0Y2FsbGJhY2soKVxuXHRwbGF5OigpLT5cblx0XHRfbG9vcCAoKS0+XG5cdFx0XHRhbmltYXRpb25PYmoucGxheSgpXG5cdHN0b3A6KCktPlxuXHRcdF9sb29wICgpLT5cblx0XHRcdGFuaW1hdGlvbk9iai5zdG9wKClcblx0cGF1c2U6KCktPlxuXHRcdF9sb29wICgpLT5cblx0XHRcdGFuaW1hdGlvbk9iai5wYXVzZSgpXG5cdHNldFNwZWVkOihzcGVlZCktPlxuXHRcdF9sb29wICgpLT5cblx0XHRcdGFuaW1hdGlvbk9iai5zZXRTcGVlZChzcGVlZClcblx0Z29Ub0FuZFN0b3A6KHZhbHVlLCBpc0ZyYW1lKS0+XG5cdFx0X2xvb3AgKCktPlxuXHRcdFx0YW5pbWF0aW9uT2JqLmdvVG9BbmRTdG9wKHZhbHVlLCBpc0ZyYW1lKVxuXHRnb1RvQW5kUGxheToodmFsdWUsIGlzRnJhbWUpLT5cblx0XHRfbG9vcCAoKS0+XG5cdFx0XHRhbmltYXRpb25PYmouZ29Ub0FuZFBsYXkodmFsdWUsIGlzRnJhbWUpXG5cdHNldERpcmVjdGlvbjooZGlyZWN0aW9uKS0+XG5cdFx0X2xvb3AgKCktPlxuXHRcdFx0YW5pbWF0aW9uT2JqLnNldERpcmVjdGlvbihkaXJlY3Rpb24pXG5cdHBsYXlTZWdtZW50czooc2VnbWVudHMsIGZvcmNlRmxhZyktPlxuXHRcdF9sb29wICgpLT5cblx0XHRcdGFuaW1hdGlvbk9iai5wbGF5U2VnbWVudHMoc2VnbWVudHMsIGZvcmNlRmxhZylcblx0ZGVzdHJveTooKS0+XG5cdFx0X2xvb3AgKCktPlxuXHRcdFx0YW5pbWF0aW9uT2JqLmRlc3Ryb3koKVxuXG5tb2R1bGUuZXhwb3J0cyA9IGJvZHltb3ZpbkxheWVyXG4iLCIoZnVuY3Rpb24gZSh0LG4scil7ZnVuY3Rpb24gcyhvLHUpe2lmKCFuW29dKXtpZighdFtvXSl7dmFyIGE9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtpZighdSYmYSlyZXR1cm4gYShvLCEwKTtpZihpKXJldHVybiBpKG8sITApO3ZhciBmPW5ldyBFcnJvcihcIkNhbm5vdCBmaW5kIG1vZHVsZSAnXCIrbytcIidcIik7dGhyb3cgZi5jb2RlPVwiTU9EVUxFX05PVF9GT1VORFwiLGZ9dmFyIGw9bltvXT17ZXhwb3J0czp7fX07dFtvXVswXS5jYWxsKGwuZXhwb3J0cyxmdW5jdGlvbihlKXt2YXIgbj10W29dWzFdW2VdO3JldHVybiBzKG4/bjplKX0sbCxsLmV4cG9ydHMsZSx0LG4scil9cmV0dXJuIG5bb10uZXhwb3J0c312YXIgaT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2Zvcih2YXIgbz0wO288ci5sZW5ndGg7bysrKXMocltvXSk7cmV0dXJuIHN9KSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUlBQTtBREFBLElBQUEsY0FBQTtFQUFBOzs7QUFBTTtBQUNMLE1BQUE7Ozs7RUFBQSxZQUFBLEdBQWU7O0VBQ2YsS0FBQSxHQUFROztFQUVLLHdCQUFDLE9BQUQ7QUFFWixRQUFBO0lBRmEsSUFBQyxDQUFBLDRCQUFELFVBQVM7O1VB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
