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
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZnJhbWVyLm1vZHVsZXMuanMiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL1VzZXJzL3JheS9HaXRIdWIvcmF5ZnJhbWVybGliLmdpdGh1Yi5pby9saWtlUnVubmVyLmZyYW1lci9tb2R1bGVzL2xvdHRpZUxheWVyLmNvZmZlZSIsIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiXSwic291cmNlc0NvbnRlbnQiOlsiY2xhc3MgbG90dGllTGF5ZXIgZXh0ZW5kcyBMYXllclxuXHQjIOaehOmAoOWZqFxuXHRjb25zdHJ1Y3RvcjogKEBvcHRpb25zPXt9KSAtPlxuXHRcdCMg5Z+65pys6YWN572u6aG5XG5cdFx0QG9wdGlvbnMuanNvblBhdGggPz0gJ2RhdGEuanNvbidcblx0XHRAb3B0aW9ucy53aWR0aCA/PSAyMDBcblx0XHRAb3B0aW9ucy5oZWlnaHQgPz0gMjAwXG5cdFx0QG9wdGlvbnMuYmFja2dyb3VuZENvbG9yID89ICd0cmFuc3BhcmVudCdcblx0XHRAb3B0aW9ucy5yZW5kZXJlciA/PSAnc3ZnJ1xuXHRcdEBvcHRpb25zLmxvb3BpbmcgPz0gdHJ1ZVxuXHRcdEBvcHRpb25zLmF1dG9wbGF5ID89IHRydWVcblxuXHRcdHN1cGVyIEBvcHRpb25zXG5cblx0XHRAYW5pbSA9IG51bGxcblxuXHRcdGFubWlMYXllciA9IG5ldyBMYXllclxuXHRcdFx0cGFyZW50OiBAXG5cdFx0XHR3aWR0aDogQG9wdGlvbnMud2lkdGhcblx0XHRcdGhlaWdodDogQG9wdGlvbnMuaGVpZ2h0XG5cdFx0XHRiYWNrZ3JvdW5kQ29sb3I6IEBvcHRpb25zLmJhY2tncm91bmRDb2xvclxuXG5cdFx0YW5taUxheWVyLmh0bWwgPSBcIjxkaXYgaWQ9J2xvdHRpZS1hbmltYXRpb24tXCIrYW5taUxheWVyLmlkK1wiJz48L2Rpdj5cIlxuXHRcdGFubWlMYXllci5fZWxlbWVudC5jaGlsZE5vZGVzWzBdLnN0eWxlLmhlaWdodCA9ICcxMDAlJ1xuXHRcdGFubWlMYXllci5fZWxlbWVudC5jaGlsZE5vZGVzWzBdLmNoaWxkTm9kZXNbMF0uc3R5bGUuaGVpZ2h0ID0gJzEwMCUnXG5cblx0XHRqc29uUGF0aCA9IEBvcHRpb25zLmpzb25QYXRoXG5cdFx0cmVuZGVyZXIgPSBAb3B0aW9ucy5yZW5kZXJlclxuXHRcdGlzTG9vcCA9IEBvcHRpb25zLmxvb3Bpbmdcblx0XHRpc0F1dG9wbGF5ID0gQG9wdGlvbnMuYXV0b3BsYXlcblxuXHRcdGVsSWQgPSBcImxvdHRpZS1hbmltYXRpb24tXCIrYW5taUxheWVyLmlkXG5cblx0XHRfdGhpcyA9IEBcblxuXHRcdGlmKGRvY3VtZW50LmJvZHltb3ZpblNjcmlwdClcblx0XHRcdGJvZHltb3ZpblRpbWVyID0gVXRpbHMuaW50ZXJ2YWwgMC4xLC0+XG5cdFx0XHRcdGlmKHdpbmRvdy5ib2R5bW92aW4pXG5cdFx0XHRcdFx0X2xvYWRKU09OKGpzb25QYXRoLGVsSWQscmVuZGVyZXIsaXNMb29wLGlzQXV0b3BsYXksYm9keW1vdmluKVxuXHRcdFx0XHRcdHdpbmRvdy5jbGVhckludGVydmFsKGJvZHltb3ZpblRpbWVyKVxuXHRcdGVsc2Vcblx0XHRcdGRvY3VtZW50LmJvZHltb3ZpblNjcmlwdCA9IFV0aWxzLmRvbUxvYWRTY3JpcHQgJ2JvZHltb3Zpbi5taW4uanMnLCAtPlxuXHRcdFx0XHRfbG9hZEpTT04oanNvblBhdGgsZWxJZCxyZW5kZXJlcixpc0xvb3AsaXNBdXRvcGxheSxib2R5bW92aW4pXG5cblx0XHRfbG9hZEpTT04gPSAoanNvblBhdGgsZWxJZCxyZW5kZXJlcixpc0xvb3AsaXNBdXRvcGxheSxib2R5bW92aW4pIC0+XG5cdFx0XHRVdGlscy5kb21Mb2FkSlNPTiBqc29uUGF0aCwgKGVyciwgZGF0YSktPlxuXHRcdFx0XHRhbmlPYmogPVxuXHRcdFx0XHRcdGNvbnRhaW5lcjogZG9jdW1lbnQuZ2V0RWxlbWVudEJ5SWQoZWxJZClcblx0XHRcdFx0XHRyZW5kZXJlcjogcmVuZGVyZXJcblx0XHRcdFx0XHRsb29wOiBpc0xvb3Bcblx0XHRcdFx0XHRhdXRvcGxheTppc0F1dG9wbGF5XG5cdFx0XHRcdFx0YW5pbWF0aW9uRGF0YTogZGF0YVxuXHRcdFx0XHRfdGhpcy5hbmltID0gYm9keW1vdmluLmxvYWRBbmltYXRpb24oYW5pT2JqKVxuXG5tb2R1bGUuZXhwb3J0cyA9IGxvdHRpZUxheWVyXG4iLCIoZnVuY3Rpb24gZSh0LG4scil7ZnVuY3Rpb24gcyhvLHUpe2lmKCFuW29dKXtpZighdFtvXSl7dmFyIGE9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtpZighdSYmYSlyZXR1cm4gYShvLCEwKTtpZihpKXJldHVybiBpKG8sITApO3ZhciBmPW5ldyBFcnJvcihcIkNhbm5vdCBmaW5kIG1vZHVsZSAnXCIrbytcIidcIik7dGhyb3cgZi5jb2RlPVwiTU9EVUxFX05PVF9GT1VORFwiLGZ9dmFyIGw9bltvXT17ZXhwb3J0czp7fX07dFtvXVswXS5jYWxsKGwuZXhwb3J0cyxmdW5jdGlvbihlKXt2YXIgbj10W29dWzFdW2VdO3JldHVybiBzKG4/bjplKX0sbCxsLmV4cG9ydHMsZSx0LG4scil9cmV0dXJuIG5bb10uZXhwb3J0c312YXIgaT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2Zvcih2YXIgbz0wO288ci5sZW5ndGg7bysrKXMocltvXSk7cmV0dXJuIHN9KSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUNBQTtBREFBLElBQUEsV0FBQTtFQUFBOzs7QUFBTTs7O0VBRVEscUJBQUMsT0FBRDtBQUVaLFFBQUE7SUFGYSxJQUFDLENBQUEsNEJBQUQsVUFBUzs7VUFFZCxDQUFDLFdBQVk7OztXQUNiLENBQUMsUUFBUzs7O1dBQ1YsQ0FBQyxTQUFVOzs7V0FDWCxDQUFDLGtCQUFtQjs7O1dBQ3BCLENBQUMsV0FBWTs7O1dBQ2IsQ0FBQyxVQUFXOzs7V0FDWixDQUFDLFdBQVk7O0lBRXJCLDZDQUFNLElBQUMsQ0FBQSxPQUFQO0lBRUEsSUFBQyxDQUFBLElBQUQsR0FBUTtJQUVSLFNBQUEsR0FBZ0IsSUFBQSxLQUFBLENBQ2Y7TUFBQSxNQUFBLEVBQVEsSUFBUjtNQUNBLEtBQUEsRUFBTyxJQUFDLENBQUEsT0FBTyxDQUFDLEtBRGhCO01BRUEsTUFBQSxFQUFRLElBQUMsQ0FBQSxPQUFPLENBQUMsTUFGakI7TUFHQSxlQUFBLEVBQWlCLElBQUMsQ0FBQSxPQUFPLENBQUMsZUFIMUI7S0FEZTtJQU1oQixTQUFTLENBQUMsSUFBVixHQUFpQiw0QkFBQSxHQUE2QixTQUFTLENBQUMsRUFBdkMsR0FBMEM7SUFDM0QsU0FBUyxDQUFDLFFBQVEsQ0FBQyxVQUFXLENBQUEsQ0FBQSxDQUFFLENBQUMsS0FBSyxDQUFDLE1BQXZDLEdBQWdEO0lBQ2hELFNBQVMsQ0FBQyxRQUFRLENBQUMsVUFBVyxDQUFBLENBQUEsQ0FBRSxDQUFDLFVBQVcsQ0FBQSxDQUFBLENBQUUsQ0FBQyxLQUFLLENBQUMsTUFBckQsR0FBOEQ7SUFFOUQsUUFBQSxHQUFXLElBQUMsQ0FBQSxPQUFPLENBQUM7SUFDcEIsUUFBQSxHQUFXLElBQUMsQ0FBQSxPQUFPLENBQUM7SUFDcEIsTUFBQSxHQUFTLElBQUMsQ0FBQSxPQUFPLENBQUM7SUFDbEIsVUFBQSxHQUFhLElBQUMsQ0FBQSxPQUFPLENBQUM7SUFFdEIsSUFBQSxHQUFPLG1CQUFBLEdBQW9CLFNBQVMsQ0FBQztJQUVyQyxLQUFBLEdBQVE7SUFFUixJQUFHLFFBQVEsQ0FBQyxlQUFaO01BQ0MsY0FBQSxHQUFpQixLQUFLLENBQUMsUUFBTixDQUFlLEdBQWYsRUFBbUIsU0FBQTtRQUNuQyxJQUFHLE1BQU0sQ0FBQyxTQUFWO1VBQ0MsU0FBQSxDQUFVLFFBQVYsRUFBbUIsSUFBbkIsRUFBd0IsUUFBeEIsRUFBaUMsTUFBakMsRUFBd0MsVUFBeEMsRUFBbUQsU0FBbkQ7aUJBQ0EsTUFBTSxDQUFDLGFBQVAsQ0FBcUIsY0FBckIsRUFGRDs7TUFEbUMsQ0FBbkIsRUFEbEI7S0FBQSxNQUFBO01BTUMsUUFBUSxDQUFDLGVBQVQsR0FBMkIsS0FBSyxDQUFDLGFBQU4sQ0FBb0Isa0JBQXBCLEVBQXdDLFNBQUE7ZUFDbEUsU0FBQSxDQUFVLFFBQVYsRUFBbUIsSUFBbkIsRUFBd0IsUUFBeEIsRUFBaUMsTUFBakMsRUFBd0MsVUFBeEMsRUFBbUQsU0FBbkQ7TUFEa0UsQ0FBeEMsRUFONUI7O0lBU0EsU0FBQSxHQUFZLFNBQUMsUUFBRCxFQUFVLElBQVYsRUFBZSxRQUFmLEVBQXdCLE1BQXhCLEVBQStCLFVBQS9CLEVBQTBDLFNBQTFDO2FBQ1gsS0FBSyxDQUFDLFdBQU4sQ0FBa0IsUUFBbEIsRUFBNEIsU0FBQyxHQUFELEVBQU0sSUFBTjtBQUMzQixZQUFBO1FBQUEsTUFBQSxHQUNDO1VBQUEsU0FBQSxFQUFXLFFBQVEsQ0FBQyxjQUFULENBQXdCLElBQXhCLENBQVg7VUFDQSxRQUFBLEVBQVUsUUFEVjtVQUVBLElBQUEsRUFBTSxNQUZOO1VBR0EsUUFBQSxFQUFTLFVBSFQ7VUFJQSxhQUFBLEVBQWUsSUFKZjs7ZUFLRCxLQUFLLENBQUMsSUFBTixHQUFhLFNBQVMsQ0FBQyxhQUFWLENBQXdCLE1BQXhCO01BUGMsQ0FBNUI7SUFEVztFQTFDQTs7OztHQUZZOztBQXNEMUIsTUFBTSxDQUFDLE9BQVAsR0FBaUIifQ==
