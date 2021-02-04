require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"lottieLayer":[function(require,module,exports){
var lottieLayer,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

lottieLayer = (function(superClass) {
  extend(lottieLayer, superClass);

  function lottieLayer(options) {
    var _loadJSON, _this, anmiLayer, base, base1, base2, base3, base4, base5, base6, bodymovinTimer, elId, isAutoplay, isLoop, jsonPath, renderer;
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
    lottieLayer.__super__.constructor.call(this, this.options);
    this.anim = null;
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
    _this = this;
    if (document.bodymovinScript) {
      bodymovinTimer = Utils.interval(0.1, function() {
        if (window.bodymovin) {
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
        return _this.anim = bodymovin.loadAnimation(aniObj);
      });
    };
  }

  return lottieLayer;

})(Layer);

module.exports = lottieLayer;


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZnJhbWVyLm1vZHVsZXMuanMiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL1VzZXJzL0JsYWNrUmF5L0dpdEh1Yi9yYXlmcmFtZXJsaWIuZ2l0aHViLmlvL3Nzc3MuZnJhbWVyL21vZHVsZXMvbG90dGllTGF5ZXIuY29mZmVlIiwibm9kZV9tb2R1bGVzL2Jyb3dzZXItcGFjay9fcHJlbHVkZS5qcyJdLCJzb3VyY2VzQ29udGVudCI6WyJjbGFzcyBsb3R0aWVMYXllciBleHRlbmRzIExheWVyXG5cdCMg5p6E6YCg5ZmoXG5cdGNvbnN0cnVjdG9yOiAoQG9wdGlvbnM9e30pIC0+XG5cdFx0IyDln7rmnKzphY3nva7poblcblx0XHRAb3B0aW9ucy5qc29uUGF0aCA/PSAnZGF0YS5qc29uJ1xuXHRcdEBvcHRpb25zLndpZHRoID89IDIwMFxuXHRcdEBvcHRpb25zLmhlaWdodCA/PSAyMDBcblx0XHRAb3B0aW9ucy5iYWNrZ3JvdW5kQ29sb3IgPz0gJ3RyYW5zcGFyZW50J1xuXHRcdEBvcHRpb25zLnJlbmRlcmVyID89ICdzdmcnXG5cdFx0QG9wdGlvbnMubG9vcGluZyA/PSB0cnVlXG5cdFx0QG9wdGlvbnMuYXV0b3BsYXkgPz0gdHJ1ZVxuXG5cdFx0c3VwZXIgQG9wdGlvbnNcblxuXHRcdEBhbmltID0gbnVsbFxuXG5cdFx0YW5taUxheWVyID0gbmV3IExheWVyXG5cdFx0XHRwYXJlbnQ6IEBcblx0XHRcdHdpZHRoOiBAb3B0aW9ucy53aWR0aFxuXHRcdFx0aGVpZ2h0OiBAb3B0aW9ucy5oZWlnaHRcblx0XHRcdGJhY2tncm91bmRDb2xvcjogQG9wdGlvbnMuYmFja2dyb3VuZENvbG9yXG5cblx0XHRhbm1pTGF5ZXIuaHRtbCA9IFwiPGRpdiBpZD0nbG90dGllLWFuaW1hdGlvbi1cIithbm1pTGF5ZXIuaWQrXCInPjwvZGl2PlwiXG5cdFx0YW5taUxheWVyLl9lbGVtZW50LmNoaWxkTm9kZXNbMF0uc3R5bGUuaGVpZ2h0ID0gJzEwMCUnXG5cdFx0YW5taUxheWVyLl9lbGVtZW50LmNoaWxkTm9kZXNbMF0uY2hpbGROb2Rlc1swXS5zdHlsZS5oZWlnaHQgPSAnMTAwJSdcblxuXHRcdGpzb25QYXRoID0gQG9wdGlvbnMuanNvblBhdGhcblx0XHRyZW5kZXJlciA9IEBvcHRpb25zLnJlbmRlcmVyXG5cdFx0aXNMb29wID0gQG9wdGlvbnMubG9vcGluZ1xuXHRcdGlzQXV0b3BsYXkgPSBAb3B0aW9ucy5hdXRvcGxheVxuXG5cdFx0ZWxJZCA9IFwibG90dGllLWFuaW1hdGlvbi1cIithbm1pTGF5ZXIuaWRcblxuXHRcdF90aGlzID0gQFxuXG5cdFx0aWYoZG9jdW1lbnQuYm9keW1vdmluU2NyaXB0KVxuXHRcdFx0Ym9keW1vdmluVGltZXIgPSBVdGlscy5pbnRlcnZhbCAwLjEsLT5cblx0XHRcdFx0aWYod2luZG93LmJvZHltb3Zpbilcblx0XHRcdFx0XHRfbG9hZEpTT04oanNvblBhdGgsZWxJZCxyZW5kZXJlcixpc0xvb3AsaXNBdXRvcGxheSxib2R5bW92aW4pXG5cdFx0XHRcdFx0d2luZG93LmNsZWFySW50ZXJ2YWwoYm9keW1vdmluVGltZXIpXG5cdFx0ZWxzZVxuXHRcdFx0ZG9jdW1lbnQuYm9keW1vdmluU2NyaXB0ID0gVXRpbHMuZG9tTG9hZFNjcmlwdCAnYm9keW1vdmluLm1pbi5qcycsIC0+XG5cdFx0XHRcdF9sb2FkSlNPTihqc29uUGF0aCxlbElkLHJlbmRlcmVyLGlzTG9vcCxpc0F1dG9wbGF5LGJvZHltb3ZpbilcblxuXHRcdF9sb2FkSlNPTiA9IChqc29uUGF0aCxlbElkLHJlbmRlcmVyLGlzTG9vcCxpc0F1dG9wbGF5LGJvZHltb3ZpbikgLT5cblx0XHRcdFV0aWxzLmRvbUxvYWRKU09OIGpzb25QYXRoLCAoZXJyLCBkYXRhKS0+XG5cdFx0XHRcdGFuaU9iaiA9XG5cdFx0XHRcdFx0Y29udGFpbmVyOiBkb2N1bWVudC5nZXRFbGVtZW50QnlJZChlbElkKVxuXHRcdFx0XHRcdHJlbmRlcmVyOiByZW5kZXJlclxuXHRcdFx0XHRcdGxvb3A6IGlzTG9vcFxuXHRcdFx0XHRcdGF1dG9wbGF5OmlzQXV0b3BsYXlcblx0XHRcdFx0XHRhbmltYXRpb25EYXRhOiBkYXRhXG5cdFx0XHRcdF90aGlzLmFuaW0gPSBib2R5bW92aW4ubG9hZEFuaW1hdGlvbihhbmlPYmopXG5cbm1vZHVsZS5leHBvcnRzID0gbG90dGllTGF5ZXJcbiIsIihmdW5jdGlvbiBlKHQsbixyKXtmdW5jdGlvbiBzKG8sdSl7aWYoIW5bb10pe2lmKCF0W29dKXt2YXIgYT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2lmKCF1JiZhKXJldHVybiBhKG8sITApO2lmKGkpcmV0dXJuIGkobywhMCk7dmFyIGY9bmV3IEVycm9yKFwiQ2Fubm90IGZpbmQgbW9kdWxlICdcIitvK1wiJ1wiKTt0aHJvdyBmLmNvZGU9XCJNT0RVTEVfTk9UX0ZPVU5EXCIsZn12YXIgbD1uW29dPXtleHBvcnRzOnt9fTt0W29dWzBdLmNhbGwobC5leHBvcnRzLGZ1bmN0aW9uKGUpe3ZhciBuPXRbb11bMV1bZV07cmV0dXJuIHMobj9uOmUpfSxsLGwuZXhwb3J0cyxlLHQsbixyKX1yZXR1cm4gbltvXS5leHBvcnRzfXZhciBpPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7Zm9yKHZhciBvPTA7bzxyLmxlbmd0aDtvKyspcyhyW29dKTtyZXR1cm4gc30pIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQ0FBO0FEQUEsSUFBQSxXQUFBO0VBQUE7OztBQUFNOzs7RUFFUSxxQkFBQyxPQUFEO0FBRVosUUFBQTtJQUZhLElBQUMsQ0FBQSw0QkFBRCxVQUFTOztVQUVkLENBQUMsV0FBWTs7O1dBQ2IsQ0FBQyxRQUFTOzs7V0FDVixDQUFDLFNBQVU7OztXQUNYLENBQUMsa0JBQW1COzs7V0FDcEIsQ0FBQyxXQUFZOzs7V0FDYixDQUFDLFVBQVc7OztXQUNaLENBQUMsV0FBWTs7SUFFckIsNkNBQU0sSUFBQyxDQUFBLE9BQVA7SUFFQSxJQUFDLENBQUEsSUFBRCxHQUFRO0lBRVIsU0FBQSxHQUFnQixJQUFBLEtBQUEsQ0FDZjtNQUFBLE1BQUEsRUFBUSxJQUFSO01BQ0EsS0FBQSxFQUFPLElBQUMsQ0FBQSxPQUFPLENBQUMsS0FEaEI7TUFFQSxNQUFBLEVBQVEsSUFBQyxDQUFBLE9BQU8sQ0FBQyxNQUZqQjtNQUdBLGVBQUEsRUFBaUIsSUFBQyxDQUFBLE9BQU8sQ0FBQyxlQUgxQjtLQURlO0lBTWhCLFNBQVMsQ0FBQyxJQUFWLEdBQWlCLDRCQUFBLEdBQTZCLFNBQVMsQ0FBQyxFQUF2QyxHQUEwQztJQUMzRCxTQUFTLENBQUMsUUFBUSxDQUFDLFVBQVcsQ0FBQSxDQUFBLENBQUUsQ0FBQyxLQUFLLENBQUMsTUFBdkMsR0FBZ0Q7SUFDaEQsU0FBUyxDQUFDLFFBQVEsQ0FBQyxVQUFXLENBQUEsQ0FBQSxDQUFFLENBQUMsVUFBVyxDQUFBLENBQUEsQ0FBRSxDQUFDLEtBQUssQ0FBQyxNQUFyRCxHQUE4RDtJQUU5RCxRQUFBLEdBQVcsSUFBQyxDQUFBLE9BQU8sQ0FBQztJQUNwQixRQUFBLEdBQVcsSUFBQyxDQUFBLE9BQU8sQ0FBQztJQUNwQixNQUFBLEdBQVMsSUFBQyxDQUFBLE9BQU8sQ0FBQztJQUNsQixVQUFBLEdBQWEsSUFBQyxDQUFBLE9BQU8sQ0FBQztJQUV0QixJQUFBLEdBQU8sbUJBQUEsR0FBb0IsU0FBUyxDQUFDO0lBRXJDLEtBQUEsR0FBUTtJQUVSLElBQUcsUUFBUSxDQUFDLGVBQVo7TUFDQyxjQUFBLEdBQWlCLEtBQUssQ0FBQyxRQUFOLENBQWUsR0FBZixFQUFtQixTQUFBO1FBQ25DLElBQUcsTUFBTSxDQUFDLFNBQVY7VUFDQyxTQUFBLENBQVUsUUFBVixFQUFtQixJQUFuQixFQUF3QixRQUF4QixFQUFpQyxNQUFqQyxFQUF3QyxVQUF4QyxFQUFtRCxTQUFuRDtpQkFDQSxNQUFNLENBQUMsYUFBUCxDQUFxQixjQUFyQixFQUZEOztNQURtQyxDQUFuQixFQURsQjtLQUFBLE1BQUE7TUFNQyxRQUFRLENBQUMsZUFBVCxHQUEyQixLQUFLLENBQUMsYUFBTixDQUFvQixrQkFBcEIsRUFBd0MsU0FBQTtlQUNsRSxTQUFBLENBQVUsUUFBVixFQUFtQixJQUFuQixFQUF3QixRQUF4QixFQUFpQyxNQUFqQyxFQUF3QyxVQUF4QyxFQUFtRCxTQUFuRDtNQURrRSxDQUF4QyxFQU41Qjs7SUFTQSxTQUFBLEdBQVksU0FBQyxRQUFELEVBQVUsSUFBVixFQUFlLFFBQWYsRUFBd0IsTUFBeEIsRUFBK0IsVUFBL0IsRUFBMEMsU0FBMUM7YUFDWCxLQUFLLENBQUMsV0FBTixDQUFrQixRQUFsQixFQUE0QixTQUFDLEdBQUQsRUFBTSxJQUFOO0FBQzNCLFlBQUE7UUFBQSxNQUFBLEdBQ0M7VUFBQSxTQUFBLEVBQVcsUUFBUSxDQUFDLGNBQVQsQ0FBd0IsSUFBeEIsQ0FBWDtVQUNBLFFBQUEsRUFBVSxRQURWO1VBRUEsSUFBQSxFQUFNLE1BRk47VUFHQSxRQUFBLEVBQVMsVUFIVDtVQUlBLGFBQUEsRUFBZSxJQUpmOztlQUtELEtBQUssQ0FBQyxJQUFOLEdBQWEsU0FBUyxDQUFDLGFBQVYsQ0FBd0IsTUFBeEI7TUFQYyxDQUE1QjtJQURXO0VBMUNBOzs7O0dBRlk7O0FBc0QxQixNQUFNLENBQUMsT0FBUCxHQUFpQiJ9
