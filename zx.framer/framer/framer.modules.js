require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"VRComponent":[function(require,module,exports){
"\nVRComponent class\n\nproperties\n- front (set: imagePath <string>, get: layer)\n- right\n- back\n- left\n- top\n- bottom\n- heading <number>\n- elevation <number>\n- tilt <number> readonly\n\n- panning <bool>\n- mobilePanning <bool>\n- arrowKeys <bool>\n\n- lookAtLatestProjectedLayer <bool>\n\nmethods\n- projectLayer(layer) # heading and elevation are set as properties on the layer\n- hideEnviroment()\n\nevents\n- onOrientationChange (data {heading, elevation, tilt})\n\n--------------------------------------------------------------------------------\n\nVRLayer class\n\nproperties\n- heading <number> (from 0 up to 360)\n- elevation <number> (from -90 down to 90 up)\n";
var KEYS, KEYSDOWN, SIDES, VRAnchorLayer,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

SIDES = ["north", "front", "east", "right", "south", "back", "west", "left", "top", "bottom"];

KEYS = {
  LeftArrow: 37,
  UpArrow: 38,
  RightArrow: 39,
  DownArrow: 40
};

KEYSDOWN = {
  left: false,
  up: false,
  right: false,
  down: false
};

Events.OrientationDidChange = "orientationdidchange";

VRAnchorLayer = (function(superClass) {
  extend(VRAnchorLayer, superClass);

  function VRAnchorLayer(layer, cubeSide) {
    VRAnchorLayer.__super__.constructor.call(this);
    this.width = 2;
    this.height = 2;
    this.clip = false;
    this.name = "anchor";
    this.cubeSide = cubeSide;
    this.backgroundColor = null;
    this.layer = layer;
    layer.parent = this;
    layer.center();
    layer.on("change:orientation", (function(_this) {
      return function(newValue, layer) {
        return _this.updatePosition(layer);
      };
    })(this));
    this.updatePosition(layer);
    layer._context.on("layer:destroy", (function(_this) {
      return function(layer) {
        if (layer === _this.layer) {
          return _this.destroy();
        }
      };
    })(this));
  }

  VRAnchorLayer.prototype.updatePosition = function(layer) {
    var dpr, halfCubeSide, x, y, z;
    halfCubeSide = this.cubeSide / 2;
    dpr = Framer.CurrentContext.pixelMultiplier;
    x = ((this.cubeSide - this.width) / 2) * dpr;
    y = ((this.cubeSide - this.height) / 2) * dpr;
    z = layer.distance * dpr;
    return this.style.WebkitTransform = "translateX(" + x + "px) translateY(" + y + "px) rotateZ(" + layer.heading + "deg) rotateX(" + (90 - layer.elevation) + "deg) translateZ(" + z + "px) rotateX(180deg)";
  };

  return VRAnchorLayer;

})(Layer);

exports.VRLayer = (function(superClass) {
  extend(VRLayer, superClass);

  function VRLayer(options) {
    if (options == null) {
      options = {};
    }
    options = _.defaults(options, {
      heading: 0,
      elevation: 0
    });
    VRLayer.__super__.constructor.call(this, options);
  }

  VRLayer.define("heading", {
    get: function() {
      return this._heading;
    },
    set: function(value) {
      var rest, roundedValue;
      if (value >= 360) {
        value = value % 360;
      } else if (value < 0) {
        rest = Math.abs(value) % 360;
        value = 360 - rest;
      }
      roundedValue = Math.round(value * 1000) / 1000;
      if (this._heading !== roundedValue) {
        this._heading = roundedValue;
        this.emit("change:heading", this._heading);
        return this.emit("change:orientation", this._heading);
      }
    }
  });

  VRLayer.define("elevation", {
    get: function() {
      return this._elevation;
    },
    set: function(value) {
      var roundedValue;
      value = Utils.clamp(value, -90, 90);
      roundedValue = Math.round(value * 1000) / 1000;
      if (roundedValue !== this._elevation) {
        this._elevation = roundedValue;
        this.emit("change:elevation", roundedValue);
        return this.emit("change:orientation", roundedValue);
      }
    }
  });

  VRLayer.define("distance", {
    get: function() {
      return this._distance;
    },
    set: function(value) {
      if (value !== this._distance) {
        this._distance = value;
        this.emit("change:distance", value);
        return this.emit("change:orientation", value);
      }
    }
  });

  return VRLayer;

})(Layer);

exports.VRComponent = (function(superClass) {
  extend(VRComponent, superClass);

  function VRComponent(options) {
    if (options == null) {
      options = {};
    }
    this._emitOrientationDidChangeEvent = bind(this._emitOrientationDidChangeEvent, this);
    this.setupPan = bind(this.setupPan, this);
    this._canvasToComponentRatio = bind(this._canvasToComponentRatio, this);
    this.deviceOrientationUpdate = bind(this.deviceOrientationUpdate, this);
    this.createCube = bind(this.createCube, this);
    this.setupDefaultValues = bind(this.setupDefaultValues, this);
    options = _.defaults(options, {
      cubeSide: 1500,
      perspective: 600,
      lookAtLatestProjectedLayer: false,
      width: Screen.width,
      height: Screen.height,
      arrowKeys: true,
      panning: true,
      mobilePanning: true,
      flat: true,
      clip: true
    });
    VRComponent.__super__.constructor.call(this, options);
    Screen.backgroundColor = "black";
    Screen.perspective = 0;
    this.setupDefaultValues();
    this.degToRad = Math.PI / 180;
    this.backgroundColor = null;
    this.createCube(options.cubeSide);
    this.lookAtLatestProjectedLayer = options.lookAtLatestProjectedLayer;
    this.setupKeys(options.arrowKeys);
    if (options.heading != null) {
      this.heading = options.heading;
    }
    if (options.elevation != null) {
      this.elevation = options.elevation;
    }
    this.setupPan(options.panning);
    this.mobilePanning = options.mobilePanning;
    if (Utils.isMobile()) {
      window.addEventListener("deviceorientation", (function(_this) {
        return function(event) {
          return _this.orientationData = event;
        };
      })(this));
    }
    Framer.Loop.on("update", this.deviceOrientationUpdate);
    Framer.CurrentContext.on("reset", function() {
      return Framer.Loop.off("update", this.deviceOrientationUpdate);
    });
    this.on("change:frame", function() {
      return this.desktopPan(0, 0);
    });
  }

  VRComponent.prototype.setupDefaultValues = function() {
    this._heading = 0;
    this._elevation = 0;
    this._tilt = 0;
    this._headingOffset = 0;
    this._elevationOffset = 0;
    this._deviceHeading = 0;
    return this._deviceElevation = 0;
  };

  VRComponent.prototype.setupKeys = function(enabled) {
    this.arrowKeys = enabled;
    document.addEventListener("keydown", (function(_this) {
      return function(event) {
        switch (event.which) {
          case KEYS.UpArrow:
            KEYSDOWN.up = true;
            return event.preventDefault();
          case KEYS.DownArrow:
            KEYSDOWN.down = true;
            return event.preventDefault();
          case KEYS.LeftArrow:
            KEYSDOWN.left = true;
            return event.preventDefault();
          case KEYS.RightArrow:
            KEYSDOWN.right = true;
            return event.preventDefault();
        }
      };
    })(this));
    document.addEventListener("keyup", (function(_this) {
      return function(event) {
        switch (event.which) {
          case KEYS.UpArrow:
            KEYSDOWN.up = false;
            return event.preventDefault();
          case KEYS.DownArrow:
            KEYSDOWN.down = false;
            return event.preventDefault();
          case KEYS.LeftArrow:
            KEYSDOWN.left = false;
            return event.preventDefault();
          case KEYS.RightArrow:
            KEYSDOWN.right = false;
            return event.preventDefault();
        }
      };
    })(this));
    return window.onblur = function() {
      KEYSDOWN.up = false;
      KEYSDOWN.down = false;
      KEYSDOWN.left = false;
      return KEYSDOWN.right = false;
    };
  };

  VRComponent.define("heading", {
    get: function() {
      var heading, rest;
      heading = this._heading + this._headingOffset;
      if (heading > 360) {
        heading = heading % 360;
      } else if (heading < 0) {
        rest = Math.abs(heading) % 360;
        heading = 360 - rest;
      }
      return Math.round(heading * 1000) / 1000;
    },
    set: function(value) {
      return this.lookAt(value, this._elevation);
    }
  });

  VRComponent.define("elevation", {
    get: function() {
      return Math.round(this._elevation * 1000) / 1000;
    },
    set: function(value) {
      value = Utils.clamp(value, -90, 90);
      return this.lookAt(this._heading, value);
    }
  });

  VRComponent.define("tilt", {
    get: function() {
      return this._tilt;
    },
    set: function(value) {
      throw "Tilt is readonly";
    }
  });

  SIDES.map(function(face) {
    return VRComponent.define(face, {
      get: function() {
        return this.layerFromFace(face);
      },
      set: function(value) {
        return this.setImage(face, value);
      }
    });
  });

  VRComponent.prototype.createCube = function(cubeSide) {
    var colors, halfCubeSide, i, key, ref, results, rotationX, rotationY, side, sideIndex, sideNames;
    if (cubeSide == null) {
      cubeSide = this.cubeSide;
    }
    this.cubeSide = cubeSide;
    if ((ref = this.world) != null) {
      ref.destroy();
    }
    this.world = new Layer({
      name: "world",
      superLayer: this,
      size: cubeSide,
      backgroundColor: null,
      clip: false
    });
    this.world.center();
    this.sides = [];
    halfCubeSide = this.cubeSide / 2;
    colors = ["#866ccc", "#28affa", "#2dd7aa", "#ffc22c", "#7ddd11", "#f95faa"];
    sideNames = ["front", "right", "back", "left", "top", "bottom"];
    for (sideIndex = i = 0; i < 6; sideIndex = ++i) {
      rotationX = 0;
      if (indexOf.call([0, 1, 2, 3], sideIndex) >= 0) {
        rotationX = -90;
      }
      if (sideIndex === 4) {
        rotationX = 180;
      }
      rotationY = 0;
      if (indexOf.call([0, 1, 2, 3], sideIndex) >= 0) {
        rotationY = sideIndex * -90;
      }
      side = new Layer({
        size: cubeSide,
        z: -halfCubeSide,
        originZ: halfCubeSide,
        rotationX: rotationX,
        rotationY: rotationY,
        parent: this.world,
        name: sideNames[sideIndex],
        html: sideNames[sideIndex],
        color: "white",
        backgroundColor: colors[sideIndex],
        style: {
          lineHeight: cubeSide + "px",
          textAlign: "center",
          fontSize: (cubeSide / 10) + "px",
          fontWeight: "100",
          fontFamily: "Helvetica Neue"
        }
      });
      this.sides.push(side);
      side._backgroundColor = side.backgroundColor;
    }
    results = [];
    for (key in this.sideImages) {
      if (this.sideImages != null) {
        results.push(this.setImage(key, this.sideImages[key]));
      }
    }
    return results;
  };

  VRComponent.prototype.hideEnviroment = function() {
    var i, len, ref, results, side;
    ref = this.sides;
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      side = ref[i];
      results.push(side.destroy());
    }
    return results;
  };

  VRComponent.prototype.layerFromFace = function(face) {
    var map;
    if (this.sides == null) {
      return;
    }
    map = {
      north: this.sides[0],
      front: this.sides[0],
      east: this.sides[1],
      right: this.sides[1],
      south: this.sides[2],
      back: this.sides[2],
      west: this.sides[3],
      left: this.sides[3],
      top: this.sides[4],
      bottom: this.sides[5]
    };
    return map[face];
  };

  VRComponent.prototype.setImage = function(face, imagePath) {
    var layer;
    if (indexOf.call(SIDES, face) < 0) {
      throw Error("VRComponent setImage, wrong name for face: " + face + ", valid options: front, right, back, left, top, bottom, north, east, south, west");
    }
    if (this.sideImages == null) {
      this.sideImages = {};
    }
    this.sideImages[face] = imagePath;
    layer = this.layerFromFace(face);
    if (imagePath != null) {
      if (layer != null) {
        layer.html = "";
      }
      return layer != null ? layer.image = imagePath : void 0;
    } else {
      if (layer != null) {
        layer.html = layer != null ? layer.name : void 0;
      }
      return layer != null ? layer.backgroundColor = layer != null ? layer._backgroundColor : void 0 : void 0;
    }
  };

  VRComponent.prototype.getImage = function(face) {
    var layer;
    if (indexOf.call(SIDES, face) < 0) {
      throw Error("VRComponent getImage, wrong name for face: " + face + ", valid options: front, right, back, left, top, bottom, north, east, south, west");
    }
    layer = this.layerFromFace(face);
    if (layer != null) {
      return layer.image;
    }
  };

  VRComponent.prototype.projectLayer = function(insertLayer) {
    var anchor, distance, elevation, heading, rest;
    heading = insertLayer.heading;
    if (heading == null) {
      heading = 0;
    }
    if (heading >= 360) {
      heading = value % 360;
    } else if (heading < 0) {
      rest = Math.abs(heading) % 360;
      heading = 360 - rest;
    }
    elevation = insertLayer.elevation;
    if (elevation == null) {
      elevation = 0;
    }
    elevation = Utils.clamp(elevation, -90, 90);
    distance = insertLayer.distance;
    if (distance == null) {
      distance = 600;
    }
    insertLayer.heading = heading;
    insertLayer.elevation = elevation;
    insertLayer.distance = distance;
    anchor = new VRAnchorLayer(insertLayer, this.cubeSide);
    anchor.superLayer = this.world;
    if (this.lookAtLatestProjectedLayer) {
      return this.lookAt(heading, elevation);
    }
  };

  VRComponent.prototype.deviceOrientationUpdate = function() {
    var alpha, beta, date, diff, gamma, halfCubeSide, orientation, rotation, translationX, translationY, translationZ, x, xAngle, yAngle, zAngle;
    if (Utils.isDesktop()) {
      if (this.arrowKeys) {
        if (this._lastCallHorizontal === void 0) {
          this._lastCallHorizontal = 0;
          this._lastCallVertical = 0;
          this._accelerationHorizontal = 1;
          this._accelerationVertical = 1;
          this._goingUp = false;
          this._goingLeft = false;
        }
        date = new Date();
        x = .1;
        if (KEYSDOWN.up || KEYSDOWN.down) {
          diff = date - this._lastCallVertical;
          if (diff < 30) {
            if (this._accelerationVertical < 30) {
              this._accelerationVertical += 0.18;
            }
          }
          if (KEYSDOWN.up) {
            if (this._goingUp === false) {
              this._accelerationVertical = 1;
              this._goingUp = true;
            }
            this.desktopPan(0, 1 * this._accelerationVertical * x);
          } else {
            if (this._goingUp === true) {
              this._accelerationVertical = 1;
              this._goingUp = false;
            }
            this.desktopPan(0, -1 * this._accelerationVertical * x);
          }
          this._lastCallVertical = date;
        } else {
          this._accelerationVertical = 1;
        }
        if (KEYSDOWN.left || KEYSDOWN.right) {
          diff = date - this._lastCallHorizontal;
          if (diff < 30) {
            if (this._accelerationHorizontal < 25) {
              this._accelerationHorizontal += 0.18;
            }
          }
          if (KEYSDOWN.left) {
            if (this._goingLeft === false) {
              this._accelerationHorizontal = 1;
              this._goingLeft = true;
            }
            this.desktopPan(1 * this._accelerationHorizontal * x, 0);
          } else {
            if (this._goingLeft === true) {
              this._accelerationHorizontal = 1;
              this._goingLeft = false;
            }
            this.desktopPan(-1 * this._accelerationHorizontal * x, 0);
          }
          return this._lastCallHorizontal = date;
        } else {
          return this._accelerationHorizontal = 1;
        }
      }
    } else if (this.orientationData != null) {
      alpha = this.orientationData.alpha;
      beta = this.orientationData.beta;
      gamma = this.orientationData.gamma;
      if (alpha !== 0 && beta !== 0 && gamma !== 0) {
        this.directionParams(alpha, beta, gamma);
      }
      xAngle = beta;
      yAngle = -gamma;
      zAngle = alpha;
      halfCubeSide = this.cubeSide / 2;
      orientation = "rotate(" + (window.orientation * -1) + "deg) ";
      translationX = "translateX(" + (((this.width / 2) - halfCubeSide) * Framer.CurrentContext.pixelMultiplier) + "px)";
      translationY = " translateY(" + (((this.height / 2) - halfCubeSide) * Framer.CurrentContext.pixelMultiplier) + "px)";
      translationZ = " translateZ(" + (this.perspective * Framer.CurrentContext.pixelMultiplier) + "px)";
      rotation = translationZ + translationX + translationY + orientation + (" rotateY(" + yAngle + "deg) rotateX(" + xAngle + "deg) rotateZ(" + zAngle + "deg)") + (" rotateZ(" + (-this._headingOffset) + "deg)");
      return this.world.style["webkitTransform"] = rotation;
    }
  };

  VRComponent.prototype.directionParams = function(alpha, beta, gamma) {
    var alphaRad, betaRad, cA, cB, cG, cH, elevation, gammaRad, heading, orientationTiltOffset, sA, sB, sG, tilt, xrA, xrB, xrC, yrA, yrB, yrC, zrA, zrB, zrC;
    alphaRad = alpha * this.degToRad;
    betaRad = beta * this.degToRad;
    gammaRad = gamma * this.degToRad;
    cA = Math.cos(alphaRad);
    sA = Math.sin(alphaRad);
    cB = Math.cos(betaRad);
    sB = Math.sin(betaRad);
    cG = Math.cos(gammaRad);
    sG = Math.sin(gammaRad);
    xrA = -sA * sB * sG + cA * cG;
    xrB = cA * sB * sG + sA * cG;
    xrC = cB * sG;
    yrA = -sA * cB;
    yrB = cA * cB;
    yrC = -sB;
    zrA = -sA * sB * cG - cA * sG;
    zrB = cA * sB * cG - sA * sG;
    zrC = cB * cG;
    heading = Math.atan(zrA / zrB);
    if (zrB < 0) {
      heading += Math.PI;
    } else if (zrA < 0) {
      heading += 2 * Math.PI;
    }
    elevation = Math.PI / 2 - Math.acos(-zrC);
    cH = Math.sqrt(1 - (zrC * zrC));
    tilt = Math.acos(-xrC / cH) * Math.sign(yrC);
    heading *= 180 / Math.PI;
    elevation *= 180 / Math.PI;
    tilt *= 180 / Math.PI;
    this._heading = Math.round(heading * 1000) / 1000;
    this._elevation = Math.round(elevation * 1000) / 1000;
    tilt = Math.round(tilt * 1000) / 1000;
    orientationTiltOffset = (window.orientation * -1) + 90;
    tilt += orientationTiltOffset;
    if (tilt > 180) {
      tilt -= 360;
    }
    this._tilt = tilt;
    this._deviceHeading = this._heading;
    this._deviceElevation = this._elevation;
    return this._emitOrientationDidChangeEvent();
  };

  VRComponent.prototype._canvasToComponentRatio = function() {
    var pointA, pointB, xDist, yDist;
    pointA = Utils.convertPointFromContext({
      x: 0,
      y: 0
    }, this, true);
    pointB = Utils.convertPointFromContext({
      x: 1,
      y: 1
    }, this, true);
    xDist = Math.abs(pointA.x - pointB.x);
    yDist = Math.abs(pointA.y - pointB.y);
    return {
      x: xDist,
      y: yDist
    };
  };

  VRComponent.prototype.setupPan = function(enabled) {
    this.panning = enabled;
    this.desktopPan(0, 0);
    this.onMouseDown((function(_this) {
      return function() {
        return _this.animateStop();
      };
    })(this));
    this.onPan((function(_this) {
      return function(data) {
        var deltaX, deltaY, ratio, strength;
        if (!_this.panning) {
          return;
        }
        ratio = _this._canvasToComponentRatio();
        deltaX = data.deltaX * ratio.x;
        deltaY = data.deltaY * ratio.y;
        strength = Utils.modulate(_this.perspective, [1200, 900], [22, 17.5]);
        if (Utils.isMobile()) {
          if (_this.mobilePanning) {
            _this._headingOffset -= deltaX / strength;
          }
        } else {
          _this.desktopPan(deltaX / strength, deltaY / strength);
        }
        _this._prevVeloX = data.velocityX;
        return _this._prevVeloU = data.velocityY;
      };
    })(this));
    return this.onPanEnd((function(_this) {
      return function(data) {
        var ratio, strength, velocityX, velocityY;
        if (!_this.panning || Utils.isMobile()) {
          return;
        }
        ratio = _this._canvasToComponentRatio();
        velocityX = (data.velocityX + _this._prevVeloX) * 0.5;
        velocityY = (data.velocityY + _this._prevVeloY) * 0.5;
        velocityX *= velocityX;
        velocityY *= velocityY;
        velocityX *= ratio.x;
        velocityY *= ratio.y;
        strength = Utils.modulate(_this.perspective, [1200, 900], [22, 17.5]);
        return _this.animate({
          heading: _this.heading - (data.velocityX * ratio.x * 200) / strength,
          elevation: _this.elevation + (data.velocityY * ratio.y * 200) / strength,
          options: {
            curve: "spring(300,100)"
          }
        });
      };
    })(this));
  };

  VRComponent.prototype.desktopPan = function(deltaDir, deltaHeight) {
    var halfCubeSide, rotation, translationX, translationY, translationZ;
    halfCubeSide = this.cubeSide / 2;
    translationX = "translateX(" + (((this.width / 2) - halfCubeSide) * Framer.CurrentContext.pixelMultiplier) + "px)";
    translationY = " translateY(" + (((this.height / 2) - halfCubeSide) * Framer.CurrentContext.pixelMultiplier) + "px)";
    translationZ = " translateZ(" + (this.perspective * Framer.CurrentContext.pixelMultiplier) + "px)";
    this._heading -= deltaDir;
    if (this._heading > 360) {
      this._heading -= 360;
    } else if (this._heading < 0) {
      this._heading += 360;
    }
    this._elevation += deltaHeight;
    this._elevation = Utils.clamp(this._elevation, -90, 90);
    rotation = translationZ + translationX + translationY + (" rotateX(" + (this._elevation + 90) + "deg) rotateZ(" + (360 - this._heading) + "deg)") + (" rotateZ(" + (-this._headingOffset) + "deg)");
    this.world.style["webkitTransform"] = rotation;
    return this._emitOrientationDidChangeEvent();
  };

  VRComponent.prototype.lookAt = function(heading, elevation) {
    var halfCubeSide, ref, rotation, translationX, translationY, translationZ;
    halfCubeSide = this.cubeSide / 2;
    translationX = "translateX(" + (((this.width / 2) - halfCubeSide) * Framer.CurrentContext.pixelMultiplier) + "px)";
    translationY = " translateY(" + (((this.height / 2) - halfCubeSide) * Framer.CurrentContext.pixelMultiplier) + "px)";
    translationZ = " translateZ(" + (this.perspective * Framer.CurrentContext.pixelMultiplier) + "px)";
    rotation = translationZ + translationX + translationY + (" rotateZ(" + this._tilt + "deg) rotateX(" + (elevation + 90) + "deg) rotateZ(" + (-heading) + "deg)");
    if ((ref = this.world) != null) {
      ref.style["webkitTransform"] = rotation;
    }
    this._heading = heading;
    this._elevation = elevation;
    if (Utils.isMobile()) {
      this._headingOffset = this._heading - this._deviceHeading;
    }
    this._elevationOffset = this._elevation - this._deviceElevation;
    heading = this._heading;
    if (heading < 0) {
      heading += 360;
    } else if (heading > 360) {
      heading -= 360;
    }
    return this._emitOrientationDidChangeEvent();
  };

  VRComponent.prototype._emitOrientationDidChangeEvent = function() {
    return this.emit(Events.OrientationDidChange, {
      heading: this.heading,
      elevation: this.elevation,
      tilt: this.tilt
    });
  };

  VRComponent.prototype.onOrientationChange = function(cb) {
    return this.on(Events.OrientationDidChange, cb);
  };

  return VRComponent;

})(Layer);


},{}],"myModule":[function(require,module,exports){
exports.myVar = "myVariable";

exports.myFunction = function() {
  return print("myFunction is running");
};

exports.myArray = [1, 2, 3];


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZnJhbWVyLm1vZHVsZXMuanMiLCJzb3VyY2VzIjpbIi4uL21vZHVsZXMvbXlNb2R1bGUuY29mZmVlIiwiLi4vbW9kdWxlcy9WUkNvbXBvbmVudC5jb2ZmZWUiLCJub2RlX21vZHVsZXMvYnJvd3Nlci1wYWNrL19wcmVsdWRlLmpzIl0sInNvdXJjZXNDb250ZW50IjpbIiMgQWRkIHRoZSBmb2xsb3dpbmcgbGluZSB0byB5b3VyIHByb2plY3QgaW4gRnJhbWVyIFN0dWRpby4gXG4jIG15TW9kdWxlID0gcmVxdWlyZSBcIm15TW9kdWxlXCJcbiMgUmVmZXJlbmNlIHRoZSBjb250ZW50cyBieSBuYW1lLCBsaWtlIG15TW9kdWxlLm15RnVuY3Rpb24oKSBvciBteU1vZHVsZS5teVZhclxuXG5leHBvcnRzLm15VmFyID0gXCJteVZhcmlhYmxlXCJcblxuZXhwb3J0cy5teUZ1bmN0aW9uID0gLT5cblx0cHJpbnQgXCJteUZ1bmN0aW9uIGlzIHJ1bm5pbmdcIlxuXG5leHBvcnRzLm15QXJyYXkgPSBbMSwgMiwgM10iLCJcIlwiXCJcblxuVlJDb21wb25lbnQgY2xhc3NcblxucHJvcGVydGllc1xuLSBmcm9udCAoc2V0OiBpbWFnZVBhdGggPHN0cmluZz4sIGdldDogbGF5ZXIpXG4tIHJpZ2h0XG4tIGJhY2tcbi0gbGVmdFxuLSB0b3Bcbi0gYm90dG9tXG4tIGhlYWRpbmcgPG51bWJlcj5cbi0gZWxldmF0aW9uIDxudW1iZXI+XG4tIHRpbHQgPG51bWJlcj4gcmVhZG9ubHlcblxuLSBwYW5uaW5nIDxib29sPlxuLSBtb2JpbGVQYW5uaW5nIDxib29sPlxuLSBhcnJvd0tleXMgPGJvb2w+XG5cbi0gbG9va0F0TGF0ZXN0UHJvamVjdGVkTGF5ZXIgPGJvb2w+XG5cbm1ldGhvZHNcbi0gcHJvamVjdExheWVyKGxheWVyKSAjIGhlYWRpbmcgYW5kIGVsZXZhdGlvbiBhcmUgc2V0IGFzIHByb3BlcnRpZXMgb24gdGhlIGxheWVyXG4tIGhpZGVFbnZpcm9tZW50KClcblxuZXZlbnRzXG4tIG9uT3JpZW50YXRpb25DaGFuZ2UgKGRhdGEge2hlYWRpbmcsIGVsZXZhdGlvbiwgdGlsdH0pXG5cbi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tXG5cblZSTGF5ZXIgY2xhc3NcblxucHJvcGVydGllc1xuLSBoZWFkaW5nIDxudW1iZXI+IChmcm9tIDAgdXAgdG8gMzYwKVxuLSBlbGV2YXRpb24gPG51bWJlcj4gKGZyb20gLTkwIGRvd24gdG8gOTAgdXApXG5cblwiXCJcIlxuXG5TSURFUyA9IFtcblx0XCJub3J0aFwiLFxuXHRcImZyb250XCIsXG5cdFwiZWFzdFwiLFxuXHRcInJpZ2h0XCIsXG5cdFwic291dGhcIixcblx0XCJiYWNrXCIsXG5cdFwid2VzdFwiLFxuXHRcImxlZnRcIixcblx0XCJ0b3BcIixcblx0XCJib3R0b21cIixcbl1cblxuS0VZUyA9IHtcblx0TGVmdEFycm93OiAzN1xuXHRVcEFycm93OiAzOFxuXHRSaWdodEFycm93OiAzOVxuXHREb3duQXJyb3c6IDQwXG59XG5cbktFWVNET1dOID0ge1xuXHRsZWZ0OiBmYWxzZVxuXHR1cDogZmFsc2Vcblx0cmlnaHQ6IGZhbHNlXG5cdGRvd246IGZhbHNlXG59XG5cbkV2ZW50cy5PcmllbnRhdGlvbkRpZENoYW5nZSA9IFwib3JpZW50YXRpb25kaWRjaGFuZ2VcIlxuXG5jbGFzcyBWUkFuY2hvckxheWVyIGV4dGVuZHMgTGF5ZXJcblxuXHRjb25zdHJ1Y3RvcjogKGxheWVyLCBjdWJlU2lkZSkgLT5cblx0XHRzdXBlcigpXG5cdFx0QHdpZHRoID0gMlxuXHRcdEBoZWlnaHQgPSAyXG5cdFx0QGNsaXAgPSBmYWxzZVxuXHRcdEBuYW1lID0gXCJhbmNob3JcIlxuXHRcdEBjdWJlU2lkZSA9IGN1YmVTaWRlXG5cdFx0QGJhY2tncm91bmRDb2xvciA9IG51bGxcblxuXHRcdEBsYXllciA9IGxheWVyXG5cdFx0bGF5ZXIucGFyZW50ID0gQFxuXHRcdGxheWVyLmNlbnRlcigpXG5cblx0XHRsYXllci5vbiBcImNoYW5nZTpvcmllbnRhdGlvblwiLCAobmV3VmFsdWUsIGxheWVyKSA9PiBAdXBkYXRlUG9zaXRpb24obGF5ZXIpXG5cdFx0QHVwZGF0ZVBvc2l0aW9uKGxheWVyKVxuXG5cdFx0bGF5ZXIuX2NvbnRleHQub24gXCJsYXllcjpkZXN0cm95XCIsIChsYXllcikgPT4gQGRlc3Ryb3koKSBpZiBsYXllciBpcyBAbGF5ZXJcblxuXHR1cGRhdGVQb3NpdGlvbjogKGxheWVyKSAtPlxuXHRcdGhhbGZDdWJlU2lkZSA9IEBjdWJlU2lkZSAvIDJcblx0XHRkcHIgPSBGcmFtZXIuQ3VycmVudENvbnRleHQucGl4ZWxNdWx0aXBsaWVyXG5cdFx0eCA9ICgoQGN1YmVTaWRlIC0gQHdpZHRoKSAvIDIpICogZHByXG5cdFx0eSA9ICgoQGN1YmVTaWRlIC0gQGhlaWdodCkgLyAyKSAqIGRwclxuXHRcdHogPSBsYXllci5kaXN0YW5jZSAqIGRwclxuXHRcdEBzdHlsZS5XZWJraXRUcmFuc2Zvcm0gPSBcInRyYW5zbGF0ZVgoI3t4fXB4KSB0cmFuc2xhdGVZKCN7eX1weCkgcm90YXRlWigje2xheWVyLmhlYWRpbmd9ZGVnKSByb3RhdGVYKCN7OTAtbGF5ZXIuZWxldmF0aW9ufWRlZykgdHJhbnNsYXRlWigje3p9cHgpIHJvdGF0ZVgoMTgwZGVnKVwiXG5cbmNsYXNzIGV4cG9ydHMuVlJMYXllciBleHRlbmRzIExheWVyXG5cblx0Y29uc3RydWN0b3I6IChvcHRpb25zID0ge30pIC0+XG5cdFx0b3B0aW9ucyA9IF8uZGVmYXVsdHMgb3B0aW9ucyxcblx0XHRcdGhlYWRpbmc6IDBcblx0XHRcdGVsZXZhdGlvbjogMFxuXHRcdHN1cGVyIG9wdGlvbnNcblxuXHRAZGVmaW5lIFwiaGVhZGluZ1wiLFxuXHRcdGdldDogLT4gQF9oZWFkaW5nXG5cdFx0c2V0OiAodmFsdWUpIC0+XG5cdFx0XHRpZiB2YWx1ZSA+PSAzNjBcblx0XHRcdFx0dmFsdWUgPSB2YWx1ZSAlIDM2MFxuXHRcdFx0ZWxzZSBpZiB2YWx1ZSA8IDBcblx0XHRcdFx0cmVzdCA9IE1hdGguYWJzKHZhbHVlKSAlIDM2MFxuXHRcdFx0XHR2YWx1ZSA9IDM2MCAtIHJlc3Rcblx0XHRcdHJvdW5kZWRWYWx1ZSA9IE1hdGgucm91bmQodmFsdWUgKiAxMDAwKSAvIDEwMDBcblx0XHRcdGlmIEBfaGVhZGluZyBpc250IHJvdW5kZWRWYWx1ZVxuXHRcdFx0XHRAX2hlYWRpbmcgPSByb3VuZGVkVmFsdWVcblx0XHRcdFx0QGVtaXQoXCJjaGFuZ2U6aGVhZGluZ1wiLCBAX2hlYWRpbmcpXG5cdFx0XHRcdEBlbWl0KFwiY2hhbmdlOm9yaWVudGF0aW9uXCIsIEBfaGVhZGluZylcblxuXHRAZGVmaW5lIFwiZWxldmF0aW9uXCIsXG5cdFx0Z2V0OiAtPiBAX2VsZXZhdGlvblxuXHRcdHNldDogKHZhbHVlKSAtPlxuXHRcdFx0dmFsdWUgPSBVdGlscy5jbGFtcCh2YWx1ZSwgLTkwLCA5MClcblx0XHRcdHJvdW5kZWRWYWx1ZSA9IE1hdGgucm91bmQodmFsdWUgKiAxMDAwKSAvIDEwMDBcblx0XHRcdGlmIHJvdW5kZWRWYWx1ZSBpc250IEBfZWxldmF0aW9uXG5cdFx0XHRcdEBfZWxldmF0aW9uID0gcm91bmRlZFZhbHVlXG5cdFx0XHRcdEBlbWl0KFwiY2hhbmdlOmVsZXZhdGlvblwiLCByb3VuZGVkVmFsdWUpXG5cdFx0XHRcdEBlbWl0KFwiY2hhbmdlOm9yaWVudGF0aW9uXCIsIHJvdW5kZWRWYWx1ZSlcblxuXHRAZGVmaW5lIFwiZGlzdGFuY2VcIixcblx0XHRnZXQ6IC0+IEBfZGlzdGFuY2Vcblx0XHRzZXQ6ICh2YWx1ZSkgLT5cblx0XHRcdGlmIHZhbHVlIGlzbnQgQF9kaXN0YW5jZVxuXHRcdFx0XHRAX2Rpc3RhbmNlID0gdmFsdWVcblx0XHRcdFx0QGVtaXQoXCJjaGFuZ2U6ZGlzdGFuY2VcIiwgdmFsdWUpXG5cdFx0XHRcdEBlbWl0KFwiY2hhbmdlOm9yaWVudGF0aW9uXCIsIHZhbHVlKVxuXG5jbGFzcyBleHBvcnRzLlZSQ29tcG9uZW50IGV4dGVuZHMgTGF5ZXJcblxuXHRjb25zdHJ1Y3RvcjogKG9wdGlvbnMgPSB7fSkgLT5cblx0XHRvcHRpb25zID0gXy5kZWZhdWx0cyBvcHRpb25zLFxuXHRcdFx0Y3ViZVNpZGU6IDE1MDBcblx0XHRcdHBlcnNwZWN0aXZlOiA2MDBcblx0XHRcdGxvb2tBdExhdGVzdFByb2plY3RlZExheWVyOiBmYWxzZVxuXHRcdFx0d2lkdGg6IFNjcmVlbi53aWR0aFxuXHRcdFx0aGVpZ2h0OiBTY3JlZW4uaGVpZ2h0XG5cdFx0XHRhcnJvd0tleXM6IHRydWVcblx0XHRcdHBhbm5pbmc6IHRydWVcblx0XHRcdG1vYmlsZVBhbm5pbmc6IHRydWVcblx0XHRcdGZsYXQ6IHRydWVcblx0XHRcdGNsaXA6IHRydWVcblx0XHRzdXBlciBvcHRpb25zXG5cblx0XHQjIHRvIGhpZGUgdGhlIHNlZW1zIHdoZXJlIHRoZSBjdWJlIHN1cmZhY2VzIGNvbWUgdG9nZXRoZXIgd2UgZGlzYWJsZSB0aGUgdmlld3BvcnQgcGVyc3BlY3RpdmUgYW5kIHNldCBhIGJsYWNrIGJhY2tncm91bmRcblx0XHRTY3JlZW4uYmFja2dyb3VuZENvbG9yID0gXCJibGFja1wiXG5cdFx0U2NyZWVuLnBlcnNwZWN0aXZlID0gMFxuXG5cdFx0QHNldHVwRGVmYXVsdFZhbHVlcygpXG5cdFx0QGRlZ1RvUmFkID0gTWF0aC5QSSAvIDE4MFxuXHRcdEBiYWNrZ3JvdW5kQ29sb3IgPSBudWxsXG5cblx0XHRAY3JlYXRlQ3ViZShvcHRpb25zLmN1YmVTaWRlKVxuXHRcdEBsb29rQXRMYXRlc3RQcm9qZWN0ZWRMYXllciA9IG9wdGlvbnMubG9va0F0TGF0ZXN0UHJvamVjdGVkTGF5ZXJcblx0XHRAc2V0dXBLZXlzKG9wdGlvbnMuYXJyb3dLZXlzKVxuXG5cdFx0QGhlYWRpbmcgPSBvcHRpb25zLmhlYWRpbmcgaWYgb3B0aW9ucy5oZWFkaW5nP1xuXHRcdEBlbGV2YXRpb24gPSBvcHRpb25zLmVsZXZhdGlvbiBpZiBvcHRpb25zLmVsZXZhdGlvbj9cblxuXHRcdEBzZXR1cFBhbihvcHRpb25zLnBhbm5pbmcpXG5cdFx0QG1vYmlsZVBhbm5pbmcgPSBvcHRpb25zLm1vYmlsZVBhbm5pbmdcblxuXHRcdGlmIFV0aWxzLmlzTW9iaWxlKClcblx0XHRcdHdpbmRvdy5hZGRFdmVudExpc3RlbmVyIFwiZGV2aWNlb3JpZW50YXRpb25cIiwgKGV2ZW50KSA9PiBAb3JpZW50YXRpb25EYXRhID0gZXZlbnRcblxuXHRcdEZyYW1lci5Mb29wLm9uKFwidXBkYXRlXCIsIEBkZXZpY2VPcmllbnRhdGlvblVwZGF0ZSlcblxuXHRcdCMgTWFrZSBzdXJlIHdlIHJlbW92ZSB0aGUgdXBkYXRlIGZyb20gdGhlIGxvb3Agd2hlbiB3ZSBkZXN0cm95IHRoZSBjb250ZXh0XG5cdFx0RnJhbWVyLkN1cnJlbnRDb250ZXh0Lm9uIFwicmVzZXRcIiwgLT4gRnJhbWVyLkxvb3Aub2ZmKFwidXBkYXRlXCIsIEBkZXZpY2VPcmllbnRhdGlvblVwZGF0ZSlcblxuXHRcdEBvbiBcImNoYW5nZTpmcmFtZVwiLCAtPiBAZGVza3RvcFBhbigwLDApXG5cblx0c2V0dXBEZWZhdWx0VmFsdWVzOiA9PlxuXG5cdFx0QF9oZWFkaW5nID0gMFxuXHRcdEBfZWxldmF0aW9uID0gMFxuXHRcdEBfdGlsdCA9IDBcblxuXHRcdEBfaGVhZGluZ09mZnNldCA9IDBcblx0XHRAX2VsZXZhdGlvbk9mZnNldCA9IDBcblx0XHRAX2RldmljZUhlYWRpbmcgPSAwXG5cdFx0QF9kZXZpY2VFbGV2YXRpb24gPSAwXG5cblx0c2V0dXBLZXlzOiAoZW5hYmxlZCkgLT5cblxuXHRcdEBhcnJvd0tleXMgPSBlbmFibGVkXG5cblx0XHRkb2N1bWVudC5hZGRFdmVudExpc3RlbmVyIFwia2V5ZG93blwiLCAoZXZlbnQpID0+XG5cdFx0XHRzd2l0Y2ggZXZlbnQud2hpY2hcblx0XHRcdFx0d2hlbiBLRVlTLlVwQXJyb3dcblx0XHRcdFx0XHRLRVlTRE9XTi51cCA9IHRydWVcblx0XHRcdFx0XHRldmVudC5wcmV2ZW50RGVmYXVsdCgpXG5cdFx0XHRcdHdoZW4gS0VZUy5Eb3duQXJyb3dcblx0XHRcdFx0XHRLRVlTRE9XTi5kb3duID0gdHJ1ZVxuXHRcdFx0XHRcdGV2ZW50LnByZXZlbnREZWZhdWx0KClcblx0XHRcdFx0d2hlbiBLRVlTLkxlZnRBcnJvd1xuXHRcdFx0XHRcdEtFWVNET1dOLmxlZnQgPSB0cnVlXG5cdFx0XHRcdFx0ZXZlbnQucHJldmVudERlZmF1bHQoKVxuXHRcdFx0XHR3aGVuIEtFWVMuUmlnaHRBcnJvd1xuXHRcdFx0XHRcdEtFWVNET1dOLnJpZ2h0ID0gdHJ1ZVxuXHRcdFx0XHRcdGV2ZW50LnByZXZlbnREZWZhdWx0KClcblxuXHRcdGRvY3VtZW50LmFkZEV2ZW50TGlzdGVuZXIgXCJrZXl1cFwiLCAoZXZlbnQpID0+XG5cdFx0XHRzd2l0Y2ggZXZlbnQud2hpY2hcblx0XHRcdFx0d2hlbiBLRVlTLlVwQXJyb3dcblx0XHRcdFx0XHRLRVlTRE9XTi51cCA9IGZhbHNlXG5cdFx0XHRcdFx0ZXZlbnQucHJldmVudERlZmF1bHQoKVxuXHRcdFx0XHR3aGVuIEtFWVMuRG93bkFycm93XG5cdFx0XHRcdFx0S0VZU0RPV04uZG93biA9IGZhbHNlXG5cdFx0XHRcdFx0ZXZlbnQucHJldmVudERlZmF1bHQoKVxuXHRcdFx0XHR3aGVuIEtFWVMuTGVmdEFycm93XG5cdFx0XHRcdFx0S0VZU0RPV04ubGVmdCA9IGZhbHNlXG5cdFx0XHRcdFx0ZXZlbnQucHJldmVudERlZmF1bHQoKVxuXHRcdFx0XHR3aGVuIEtFWVMuUmlnaHRBcnJvd1xuXHRcdFx0XHRcdEtFWVNET1dOLnJpZ2h0ID0gZmFsc2Vcblx0XHRcdFx0XHRldmVudC5wcmV2ZW50RGVmYXVsdCgpXG5cblx0XHR3aW5kb3cub25ibHVyID0gLT5cblx0XHRcdEtFWVNET1dOLnVwID0gZmFsc2Vcblx0XHRcdEtFWVNET1dOLmRvd24gPSBmYWxzZVxuXHRcdFx0S0VZU0RPV04ubGVmdCA9IGZhbHNlXG5cdFx0XHRLRVlTRE9XTi5yaWdodCA9IGZhbHNlXG5cblx0QGRlZmluZSBcImhlYWRpbmdcIixcblx0XHRnZXQ6IC0+XG5cdFx0XHRoZWFkaW5nID0gQF9oZWFkaW5nICsgQF9oZWFkaW5nT2Zmc2V0XG5cdFx0XHRpZiBoZWFkaW5nID4gMzYwXG5cdFx0XHRcdGhlYWRpbmcgPSBoZWFkaW5nICUgMzYwXG5cdFx0XHRlbHNlIGlmIGhlYWRpbmcgPCAwXG5cdFx0XHRcdHJlc3QgPSBNYXRoLmFicyhoZWFkaW5nKSAlIDM2MFxuXHRcdFx0XHRoZWFkaW5nID0gMzYwIC0gcmVzdFxuXHRcdFx0cmV0dXJuIE1hdGgucm91bmQoaGVhZGluZyAqIDEwMDApIC8gMTAwMFxuXHRcdHNldDogKHZhbHVlKSAtPlxuXHRcdFx0QGxvb2tBdCh2YWx1ZSwgQF9lbGV2YXRpb24pXG5cblx0QGRlZmluZSBcImVsZXZhdGlvblwiLFxuXHRcdGdldDogLT4gTWF0aC5yb3VuZChAX2VsZXZhdGlvbiAqIDEwMDApIC8gMTAwMFxuXHRcdHNldDogKHZhbHVlKSAtPlxuXHRcdFx0dmFsdWUgPSBVdGlscy5jbGFtcCh2YWx1ZSwgLTkwLCA5MClcblx0XHRcdEBsb29rQXQoQF9oZWFkaW5nLCB2YWx1ZSlcblxuXHRAZGVmaW5lIFwidGlsdFwiLFxuXHRcdGdldDogLT4gQF90aWx0XG5cdFx0c2V0OiAodmFsdWUpIC0+IHRocm93IFwiVGlsdCBpcyByZWFkb25seVwiXG5cblx0U0lERVMubWFwIChmYWNlKSA9PlxuXHRcdEBkZWZpbmUgZmFjZSxcblx0XHRcdGdldDogLT4gQGxheWVyRnJvbUZhY2UoZmFjZSkgIyBAZ2V0SW1hZ2UoZmFjZSlcblx0XHRcdHNldDogKHZhbHVlKSAtPiBAc2V0SW1hZ2UoZmFjZSwgdmFsdWUpXG5cblx0Y3JlYXRlQ3ViZTogKGN1YmVTaWRlID0gQGN1YmVTaWRlKSA9PlxuXHRcdEBjdWJlU2lkZSA9IGN1YmVTaWRlXG5cblx0XHRAd29ybGQ/LmRlc3Ryb3koKVxuXHRcdEB3b3JsZCA9IG5ldyBMYXllclxuXHRcdFx0bmFtZTogXCJ3b3JsZFwiXG5cdFx0XHRzdXBlckxheWVyOiBAXG5cdFx0XHRzaXplOiBjdWJlU2lkZVxuXHRcdFx0YmFja2dyb3VuZENvbG9yOiBudWxsXG5cdFx0XHRjbGlwOiBmYWxzZVxuXHRcdEB3b3JsZC5jZW50ZXIoKVxuXG5cdFx0QHNpZGVzID0gW11cblx0XHRoYWxmQ3ViZVNpZGUgPSBAY3ViZVNpZGUgLyAyXG5cdFx0Y29sb3JzID0gW1wiIzg2NmNjY1wiLCBcIiMyOGFmZmFcIiwgXCIjMmRkN2FhXCIsIFwiI2ZmYzIyY1wiLCBcIiM3ZGRkMTFcIiwgXCIjZjk1ZmFhXCJdXG5cdFx0c2lkZU5hbWVzID0gW1wiZnJvbnRcIiwgXCJyaWdodFwiLCBcImJhY2tcIiwgXCJsZWZ0XCIsIFwidG9wXCIsIFwiYm90dG9tXCJdXG5cblx0XHRmb3Igc2lkZUluZGV4IGluIFswLi4uNl1cblxuXHRcdFx0cm90YXRpb25YID0gMFxuXHRcdFx0cm90YXRpb25YID0gLTkwIGlmIHNpZGVJbmRleCBpbiBbMC4uLjRdXG5cdFx0XHRyb3RhdGlvblggPSAxODAgaWYgc2lkZUluZGV4IGlzIDRcblxuXHRcdFx0cm90YXRpb25ZID0gMFxuXHRcdFx0cm90YXRpb25ZID0gc2lkZUluZGV4ICogLTkwIGlmIHNpZGVJbmRleCBpbiBbMC4uLjRdXG5cblx0XHRcdHNpZGUgPSBuZXcgTGF5ZXJcblx0XHRcdFx0c2l6ZTogY3ViZVNpZGVcblx0XHRcdFx0ejogLWhhbGZDdWJlU2lkZVxuXHRcdFx0XHRvcmlnaW5aOiBoYWxmQ3ViZVNpZGVcblx0XHRcdFx0cm90YXRpb25YOiByb3RhdGlvblhcblx0XHRcdFx0cm90YXRpb25ZOiByb3RhdGlvbllcblx0XHRcdFx0cGFyZW50OiBAd29ybGRcblx0XHRcdFx0bmFtZTogc2lkZU5hbWVzW3NpZGVJbmRleF1cblx0XHRcdFx0aHRtbDogc2lkZU5hbWVzW3NpZGVJbmRleF1cblx0XHRcdFx0Y29sb3I6IFwid2hpdGVcIlxuXHRcdFx0XHRiYWNrZ3JvdW5kQ29sb3I6IGNvbG9yc1tzaWRlSW5kZXhdXG5cdFx0XHRcdHN0eWxlOlxuXHRcdFx0XHRcdGxpbmVIZWlnaHQ6IFwiI3tjdWJlU2lkZX1weFwiXG5cdFx0XHRcdFx0dGV4dEFsaWduOiBcImNlbnRlclwiXG5cdFx0XHRcdFx0Zm9udFNpemU6IFwiI3tjdWJlU2lkZSAvIDEwfXB4XCJcblx0XHRcdFx0XHRmb250V2VpZ2h0OiBcIjEwMFwiXG5cdFx0XHRcdFx0Zm9udEZhbWlseTogXCJIZWx2ZXRpY2EgTmV1ZVwiXG5cdFx0XHRAc2lkZXMucHVzaChzaWRlKVxuXHRcdFx0c2lkZS5fYmFja2dyb3VuZENvbG9yID0gc2lkZS5iYWNrZ3JvdW5kQ29sb3JcblxuXHRcdGZvciBrZXkgb2YgQHNpZGVJbWFnZXMgd2hlbiBAc2lkZUltYWdlcz9cblx0XHRcdEBzZXRJbWFnZSBrZXksIEBzaWRlSW1hZ2VzW2tleV1cblxuXHRoaWRlRW52aXJvbWVudDogLT5cblx0XHRmb3Igc2lkZSBpbiBAc2lkZXNcblx0XHRcdHNpZGUuZGVzdHJveSgpXG5cblx0bGF5ZXJGcm9tRmFjZTogKGZhY2UpIC0+XG5cdFx0cmV0dXJuIHVubGVzcyBAc2lkZXM/XG5cdFx0bWFwID1cblx0XHRcdG5vcnRoOiBAc2lkZXNbMF1cblx0XHRcdGZyb250OiBAc2lkZXNbMF1cblx0XHRcdGVhc3Q6ICBAc2lkZXNbMV1cblx0XHRcdHJpZ2h0OiBAc2lkZXNbMV1cblx0XHRcdHNvdXRoOiBAc2lkZXNbMl1cblx0XHRcdGJhY2s6ICBAc2lkZXNbMl1cblx0XHRcdHdlc3Q6ICBAc2lkZXNbM11cblx0XHRcdGxlZnQ6ICBAc2lkZXNbM11cblx0XHRcdHRvcDogICBAc2lkZXNbNF1cblx0XHRcdGJvdHRvbTpAc2lkZXNbNV1cblx0XHRyZXR1cm4gbWFwW2ZhY2VdXG5cblx0c2V0SW1hZ2U6IChmYWNlLCBpbWFnZVBhdGgpIC0+XG5cblx0XHR0aHJvdyBFcnJvciBcIlZSQ29tcG9uZW50IHNldEltYWdlLCB3cm9uZyBuYW1lIGZvciBmYWNlOiBcIiArIGZhY2UgKyBcIiwgdmFsaWQgb3B0aW9uczogZnJvbnQsIHJpZ2h0LCBiYWNrLCBsZWZ0LCB0b3AsIGJvdHRvbSwgbm9ydGgsIGVhc3QsIHNvdXRoLCB3ZXN0XCIgdW5sZXNzIGZhY2UgaW4gU0lERVNcblxuXHRcdEBzaWRlSW1hZ2VzID0ge30gdW5sZXNzIEBzaWRlSW1hZ2VzP1xuXHRcdEBzaWRlSW1hZ2VzW2ZhY2VdID0gaW1hZ2VQYXRoXG5cblx0XHRsYXllciA9IEBsYXllckZyb21GYWNlKGZhY2UpXG5cblx0XHRpZiBpbWFnZVBhdGg/XG5cdFx0XHRsYXllcj8uaHRtbCA9IFwiXCJcblx0XHRcdGxheWVyPy5pbWFnZSA9IGltYWdlUGF0aFxuXHRcdGVsc2Vcblx0XHRcdGxheWVyPy5odG1sID0gbGF5ZXI/Lm5hbWVcblx0XHRcdGxheWVyPy5iYWNrZ3JvdW5kQ29sb3IgPSBsYXllcj8uX2JhY2tncm91bmRDb2xvclxuXG5cdGdldEltYWdlOiAoZmFjZSkgLT5cblxuXHRcdHRocm93IEVycm9yIFwiVlJDb21wb25lbnQgZ2V0SW1hZ2UsIHdyb25nIG5hbWUgZm9yIGZhY2U6IFwiICsgZmFjZSArIFwiLCB2YWxpZCBvcHRpb25zOiBmcm9udCwgcmlnaHQsIGJhY2ssIGxlZnQsIHRvcCwgYm90dG9tLCBub3J0aCwgZWFzdCwgc291dGgsIHdlc3RcIiB1bmxlc3MgZmFjZSBpbiBTSURFU1xuXG5cdFx0bGF5ZXIgPSBAbGF5ZXJGcm9tRmFjZShmYWNlKVxuXHRcdHJldHVybiBsYXllci5pbWFnZSBpZiBsYXllcj9cblxuXHRwcm9qZWN0TGF5ZXI6IChpbnNlcnRMYXllcikgLT5cblxuXHRcdGhlYWRpbmcgPSBpbnNlcnRMYXllci5oZWFkaW5nXG5cdFx0aGVhZGluZyA9IDAgdW5sZXNzIGhlYWRpbmc/XG5cblx0XHRpZiBoZWFkaW5nID49IDM2MFxuXHRcdFx0aGVhZGluZyA9IHZhbHVlICUgMzYwXG5cdFx0ZWxzZSBpZiBoZWFkaW5nIDwgMFxuXHRcdFx0cmVzdCA9IE1hdGguYWJzKGhlYWRpbmcpICUgMzYwXG5cdFx0XHRoZWFkaW5nID0gMzYwIC0gcmVzdFxuXG5cdFx0ZWxldmF0aW9uID0gaW5zZXJ0TGF5ZXIuZWxldmF0aW9uXG5cdFx0ZWxldmF0aW9uID0gMCB1bmxlc3MgZWxldmF0aW9uP1xuXHRcdGVsZXZhdGlvbiA9IFV0aWxzLmNsYW1wKGVsZXZhdGlvbiwgLTkwLCA5MClcblxuXHRcdGRpc3RhbmNlID0gaW5zZXJ0TGF5ZXIuZGlzdGFuY2Vcblx0XHRkaXN0YW5jZSA9IDYwMCB1bmxlc3MgZGlzdGFuY2U/XG5cblx0XHRpbnNlcnRMYXllci5oZWFkaW5nID0gaGVhZGluZ1xuXHRcdGluc2VydExheWVyLmVsZXZhdGlvbiA9IGVsZXZhdGlvblxuXHRcdGluc2VydExheWVyLmRpc3RhbmNlID0gZGlzdGFuY2VcblxuXHRcdGFuY2hvciA9IG5ldyBWUkFuY2hvckxheWVyKGluc2VydExheWVyLCBAY3ViZVNpZGUpXG5cdFx0YW5jaG9yLnN1cGVyTGF5ZXIgPSBAd29ybGRcblxuXHRcdEBsb29rQXQoaGVhZGluZywgZWxldmF0aW9uKSBpZiBAbG9va0F0TGF0ZXN0UHJvamVjdGVkTGF5ZXJcblxuXHQjIE1vYmlsZSBkZXZpY2Ugb3JpZW50YXRpb25cblxuXHRkZXZpY2VPcmllbnRhdGlvblVwZGF0ZTogPT5cblxuXHRcdGlmIFV0aWxzLmlzRGVza3RvcCgpXG5cdFx0XHRpZiBAYXJyb3dLZXlzXG5cdFx0XHRcdGlmIEBfbGFzdENhbGxIb3Jpem9udGFsIGlzIHVuZGVmaW5lZFxuXHRcdFx0XHRcdEBfbGFzdENhbGxIb3Jpem9udGFsID0gMFxuXHRcdFx0XHRcdEBfbGFzdENhbGxWZXJ0aWNhbCA9IDBcblx0XHRcdFx0XHRAX2FjY2VsZXJhdGlvbkhvcml6b250YWwgPSAxXG5cdFx0XHRcdFx0QF9hY2NlbGVyYXRpb25WZXJ0aWNhbCA9IDFcblx0XHRcdFx0XHRAX2dvaW5nVXAgPSBmYWxzZVxuXHRcdFx0XHRcdEBfZ29pbmdMZWZ0ID0gZmFsc2VcblxuXHRcdFx0XHRkYXRlID0gbmV3IERhdGUoKVxuXHRcdFx0XHR4ID0gLjFcblx0XHRcdFx0aWYgS0VZU0RPV04udXAgb3IgS0VZU0RPV04uZG93blxuXHRcdFx0XHRcdGRpZmYgPSBkYXRlIC0gQF9sYXN0Q2FsbFZlcnRpY2FsXG5cdFx0XHRcdFx0aWYgZGlmZiA8IDMwXG5cdFx0XHRcdFx0XHRpZiBAX2FjY2VsZXJhdGlvblZlcnRpY2FsIDwgMzBcblx0XHRcdFx0XHRcdFx0QF9hY2NlbGVyYXRpb25WZXJ0aWNhbCArPSAwLjE4XG5cdFx0XHRcdFx0aWYgS0VZU0RPV04udXBcblx0XHRcdFx0XHRcdGlmIEBfZ29pbmdVcCBpcyBmYWxzZVxuXHRcdFx0XHRcdFx0XHRAX2FjY2VsZXJhdGlvblZlcnRpY2FsID0gMVxuXHRcdFx0XHRcdFx0XHRAX2dvaW5nVXAgPSB0cnVlXG5cdFx0XHRcdFx0XHRAZGVza3RvcFBhbigwLCAxICogQF9hY2NlbGVyYXRpb25WZXJ0aWNhbCAqIHgpXG5cdFx0XHRcdFx0ZWxzZVxuXHRcdFx0XHRcdFx0aWYgQF9nb2luZ1VwIGlzIHRydWVcblx0XHRcdFx0XHRcdFx0QF9hY2NlbGVyYXRpb25WZXJ0aWNhbCA9IDFcblx0XHRcdFx0XHRcdFx0QF9nb2luZ1VwID0gZmFsc2VcblxuXHRcdFx0XHRcdFx0QGRlc2t0b3BQYW4oMCwgLTEgKiBAX2FjY2VsZXJhdGlvblZlcnRpY2FsICogeClcblx0XHRcdFx0XHRAX2xhc3RDYWxsVmVydGljYWwgPSBkYXRlXG5cblx0XHRcdFx0ZWxzZVxuXHRcdFx0XHRcdEBfYWNjZWxlcmF0aW9uVmVydGljYWwgPSAxXG5cblx0XHRcdFx0aWYgS0VZU0RPV04ubGVmdCBvciBLRVlTRE9XTi5yaWdodFxuXHRcdFx0XHRcdGRpZmYgPSBkYXRlIC0gQF9sYXN0Q2FsbEhvcml6b250YWxcblx0XHRcdFx0XHRpZiBkaWZmIDwgMzBcblx0XHRcdFx0XHRcdGlmIEBfYWNjZWxlcmF0aW9uSG9yaXpvbnRhbCA8IDI1XG5cdFx0XHRcdFx0XHRcdEBfYWNjZWxlcmF0aW9uSG9yaXpvbnRhbCArPSAwLjE4XG5cdFx0XHRcdFx0aWYgS0VZU0RPV04ubGVmdFxuXHRcdFx0XHRcdFx0aWYgQF9nb2luZ0xlZnQgaXMgZmFsc2Vcblx0XHRcdFx0XHRcdFx0QF9hY2NlbGVyYXRpb25Ib3Jpem9udGFsID0gMVxuXHRcdFx0XHRcdFx0XHRAX2dvaW5nTGVmdCA9IHRydWVcblx0XHRcdFx0XHRcdEBkZXNrdG9wUGFuKDEgKiBAX2FjY2VsZXJhdGlvbkhvcml6b250YWwgKiB4LCAwKVxuXHRcdFx0XHRcdGVsc2Vcblx0XHRcdFx0XHRcdGlmIEBfZ29pbmdMZWZ0IGlzIHRydWVcblx0XHRcdFx0XHRcdFx0QF9hY2NlbGVyYXRpb25Ib3Jpem9udGFsID0gMVxuXHRcdFx0XHRcdFx0XHRAX2dvaW5nTGVmdCA9IGZhbHNlXG5cdFx0XHRcdFx0XHRAZGVza3RvcFBhbigtMSAqIEBfYWNjZWxlcmF0aW9uSG9yaXpvbnRhbCAqIHgsIDApXG5cdFx0XHRcdFx0QF9sYXN0Q2FsbEhvcml6b250YWwgPSBkYXRlXG5cdFx0XHRcdGVsc2Vcblx0XHRcdFx0XHRAX2FjY2VsZXJhdGlvbkhvcml6b250YWwgPSAxXG5cblx0XHRlbHNlIGlmIEBvcmllbnRhdGlvbkRhdGE/XG5cblx0XHRcdGFscGhhID0gQG9yaWVudGF0aW9uRGF0YS5hbHBoYVxuXHRcdFx0YmV0YSA9IEBvcmllbnRhdGlvbkRhdGEuYmV0YVxuXHRcdFx0Z2FtbWEgPSBAb3JpZW50YXRpb25EYXRhLmdhbW1hXG5cblx0XHRcdEBkaXJlY3Rpb25QYXJhbXMoYWxwaGEsIGJldGEsIGdhbW1hKSBpZiBhbHBoYSBpc250IDAgYW5kIGJldGEgaXNudCAwIGFuZCBnYW1tYSBpc250IDBcblxuXHRcdFx0eEFuZ2xlID0gYmV0YVxuXHRcdFx0eUFuZ2xlID0gLWdhbW1hXG5cdFx0XHR6QW5nbGUgPSBhbHBoYVxuXG5cdFx0XHRoYWxmQ3ViZVNpZGUgPSBAY3ViZVNpZGUvMlxuXHRcdFx0b3JpZW50YXRpb24gPSBcInJvdGF0ZSgje3dpbmRvdy5vcmllbnRhdGlvbiAqIC0xfWRlZykgXCJcblx0XHRcdHRyYW5zbGF0aW9uWCA9IFwidHJhbnNsYXRlWCgjeygoQHdpZHRoIC8gMikgLSBoYWxmQ3ViZVNpZGUpICogRnJhbWVyLkN1cnJlbnRDb250ZXh0LnBpeGVsTXVsdGlwbGllcn1weClcIlxuXHRcdFx0dHJhbnNsYXRpb25ZID0gXCIgdHJhbnNsYXRlWSgjeygoQGhlaWdodCAvIDIpIC0gaGFsZkN1YmVTaWRlKSAqIEZyYW1lci5DdXJyZW50Q29udGV4dC5waXhlbE11bHRpcGxpZXJ9cHgpXCJcblx0XHRcdHRyYW5zbGF0aW9uWiA9IFwiIHRyYW5zbGF0ZVooI3tAcGVyc3BlY3RpdmUgKiBGcmFtZXIuQ3VycmVudENvbnRleHQucGl4ZWxNdWx0aXBsaWVyfXB4KVwiXG5cdFx0XHRyb3RhdGlvbiA9IHRyYW5zbGF0aW9uWiArIHRyYW5zbGF0aW9uWCArIHRyYW5zbGF0aW9uWSArIG9yaWVudGF0aW9uICsgXCIgcm90YXRlWSgje3lBbmdsZX1kZWcpIHJvdGF0ZVgoI3t4QW5nbGV9ZGVnKSByb3RhdGVaKCN7ekFuZ2xlfWRlZylcIiArIFwiIHJvdGF0ZVooI3stQF9oZWFkaW5nT2Zmc2V0fWRlZylcIlxuXHRcdFx0QHdvcmxkLnN0eWxlW1wid2Via2l0VHJhbnNmb3JtXCJdID0gcm90YXRpb25cblxuXHRkaXJlY3Rpb25QYXJhbXM6IChhbHBoYSwgYmV0YSwgZ2FtbWEpIC0+XG5cblx0XHRhbHBoYVJhZCA9IGFscGhhICogQGRlZ1RvUmFkXG5cdFx0YmV0YVJhZCA9IGJldGEgKiBAZGVnVG9SYWRcblx0XHRnYW1tYVJhZCA9IGdhbW1hICogQGRlZ1RvUmFkXG5cblx0XHQjIENhbGN1bGF0ZSBlcXVhdGlvbiBjb21wb25lbnRzXG5cdFx0Y0EgPSBNYXRoLmNvcyhhbHBoYVJhZClcblx0XHRzQSA9IE1hdGguc2luKGFscGhhUmFkKVxuXHRcdGNCID0gTWF0aC5jb3MoYmV0YVJhZClcblx0XHRzQiA9IE1hdGguc2luKGJldGFSYWQpXG5cdFx0Y0cgPSBNYXRoLmNvcyhnYW1tYVJhZClcblx0XHRzRyA9IE1hdGguc2luKGdhbW1hUmFkKVxuXG5cdFx0IyB4IHVuaXR2ZWN0b3Jcblx0XHR4ckEgPSAtc0EgKiBzQiAqIHNHICsgY0EgKiBjR1xuXHRcdHhyQiA9IGNBICogc0IgKiBzRyArIHNBICogY0dcblx0XHR4ckMgPSBjQiAqIHNHXG5cblx0XHQjIHkgdW5pdHZlY3RvclxuXHRcdHlyQSA9IC1zQSAqIGNCXG5cdFx0eXJCID0gY0EgKiBjQlxuXHRcdHlyQyA9IC1zQlxuXG5cdFx0IyAteiB1bml0dmVjdG9yXG5cdFx0enJBID0gLXNBICogc0IgKiBjRyAtIGNBICogc0dcblx0XHR6ckIgPSBjQSAqIHNCICogY0cgLSBzQSAqIHNHXG5cdFx0enJDID0gY0IgKiBjR1xuXG5cdFx0IyBDYWxjdWxhdGUgaGVhZGluZ1xuXHRcdGhlYWRpbmcgPSBNYXRoLmF0YW4oenJBIC8genJCKVxuXG5cdFx0IyBDb252ZXJ0IGZyb20gaGFsZiB1bml0IGNpcmNsZSB0byB3aG9sZSB1bml0IGNpcmNsZVxuXHRcdGlmIHpyQiA8IDBcblx0XHRcdGhlYWRpbmcgKz0gTWF0aC5QSVxuXHRcdGVsc2UgaWYgenJBIDwgMFxuXHRcdFx0aGVhZGluZyArPSAyICogTWF0aC5QSVxuXG5cdFx0IyAjIENhbGN1bGF0ZSBBbHRpdHVkZSAoaW4gZGVncmVlcylcblx0XHRlbGV2YXRpb24gPSBNYXRoLlBJIC8gMiAtIE1hdGguYWNvcygtenJDKVxuXG5cdFx0Y0ggPSBNYXRoLnNxcnQoMSAtICh6ckMgKiB6ckMpKVxuXHRcdHRpbHQgPSBNYXRoLmFjb3MoLXhyQyAvIGNIKSAqIE1hdGguc2lnbih5ckMpXG5cblx0XHQjIENvbnZlcnQgcmFkaWFucyB0byBkZWdyZWVzXG5cdFx0aGVhZGluZyAqPSAxODAgLyBNYXRoLlBJXG5cdFx0ZWxldmF0aW9uICo9IDE4MCAvIE1hdGguUElcblx0XHR0aWx0ICo9IDE4MCAvIE1hdGguUElcblxuXHRcdEBfaGVhZGluZyA9IE1hdGgucm91bmQoaGVhZGluZyAqIDEwMDApIC8gMTAwMFxuXHRcdEBfZWxldmF0aW9uID0gTWF0aC5yb3VuZChlbGV2YXRpb24gKiAxMDAwKSAvIDEwMDBcblxuXHRcdHRpbHQgPSBNYXRoLnJvdW5kKHRpbHQgKiAxMDAwKSAvIDEwMDBcblx0XHRvcmllbnRhdGlvblRpbHRPZmZzZXQgPSAod2luZG93Lm9yaWVudGF0aW9uICogLTEpICsgOTBcblx0XHR0aWx0ICs9IG9yaWVudGF0aW9uVGlsdE9mZnNldFxuXHRcdHRpbHQgLT0gMzYwIGlmIHRpbHQgPiAxODBcblx0XHRAX3RpbHQgPSB0aWx0XG5cblx0XHRAX2RldmljZUhlYWRpbmcgPSBAX2hlYWRpbmdcblx0XHRAX2RldmljZUVsZXZhdGlvbiA9IEBfZWxldmF0aW9uXG5cdFx0QF9lbWl0T3JpZW50YXRpb25EaWRDaGFuZ2VFdmVudCgpXG5cblx0IyBQYW5uaW5nXG5cblx0X2NhbnZhc1RvQ29tcG9uZW50UmF0aW86ID0+XG5cdFx0cG9pbnRBID0gVXRpbHMuY29udmVydFBvaW50RnJvbUNvbnRleHQoe3g6MCwgeTowfSwgQCwgdHJ1ZSlcblx0XHRwb2ludEIgPSBVdGlscy5jb252ZXJ0UG9pbnRGcm9tQ29udGV4dCh7eDoxLCB5OjF9LCBALCB0cnVlKVxuXHRcdHhEaXN0ID0gTWF0aC5hYnMocG9pbnRBLnggLSBwb2ludEIueClcblx0XHR5RGlzdCA9IE1hdGguYWJzKHBvaW50QS55IC0gcG9pbnRCLnkpXG5cdFx0cmV0dXJuIHt4OnhEaXN0LCB5OnlEaXN0fVxuXG5cdHNldHVwUGFuOiAoZW5hYmxlZCkgPT5cblxuXHRcdEBwYW5uaW5nID0gZW5hYmxlZFxuXHRcdEBkZXNrdG9wUGFuKDAsIDApXG5cblx0XHRAb25Nb3VzZURvd24gPT4gQGFuaW1hdGVTdG9wKClcblxuXHRcdEBvblBhbiAoZGF0YSkgPT5cblx0XHRcdHJldHVybiBpZiBub3QgQHBhbm5pbmdcblx0XHRcdHJhdGlvID0gQF9jYW52YXNUb0NvbXBvbmVudFJhdGlvKClcblx0XHRcdGRlbHRhWCA9IGRhdGEuZGVsdGFYICogcmF0aW8ueFxuXHRcdFx0ZGVsdGFZID0gZGF0YS5kZWx0YVkgKiByYXRpby55XG5cdFx0XHRzdHJlbmd0aCA9IFV0aWxzLm1vZHVsYXRlKEBwZXJzcGVjdGl2ZSwgWzEyMDAsIDkwMF0sIFsyMiwgMTcuNV0pXG5cblx0XHRcdGlmIFV0aWxzLmlzTW9iaWxlKClcblx0XHRcdFx0QF9oZWFkaW5nT2Zmc2V0IC09IChkZWx0YVggLyBzdHJlbmd0aCkgaWYgQG1vYmlsZVBhbm5pbmdcblx0XHRcdGVsc2Vcblx0XHRcdFx0QGRlc2t0b3BQYW4oZGVsdGFYIC8gc3RyZW5ndGgsIGRlbHRhWSAvIHN0cmVuZ3RoKVxuXG5cdFx0XHRAX3ByZXZWZWxvWCA9IGRhdGEudmVsb2NpdHlYXG5cdFx0XHRAX3ByZXZWZWxvVSA9IGRhdGEudmVsb2NpdHlZXG5cblx0XHRAb25QYW5FbmQgKGRhdGEpID0+XG5cdFx0XHRyZXR1cm4gaWYgbm90IEBwYW5uaW5nIG9yIFV0aWxzLmlzTW9iaWxlKClcblx0XHRcdHJhdGlvID0gQF9jYW52YXNUb0NvbXBvbmVudFJhdGlvKClcblx0XHRcdHZlbG9jaXR5WCA9IChkYXRhLnZlbG9jaXR5WCArIEBfcHJldlZlbG9YKSAqIDAuNVxuXHRcdFx0dmVsb2NpdHlZID0gKGRhdGEudmVsb2NpdHlZICsgQF9wcmV2VmVsb1kpICogMC41XG5cdFx0XHR2ZWxvY2l0eVggKj0gdmVsb2NpdHlYXG5cdFx0XHR2ZWxvY2l0eVkgKj0gdmVsb2NpdHlZXG5cdFx0XHR2ZWxvY2l0eVggKj0gcmF0aW8ueFxuXHRcdFx0dmVsb2NpdHlZICo9IHJhdGlvLnlcblx0XHRcdHN0cmVuZ3RoID0gVXRpbHMubW9kdWxhdGUoQHBlcnNwZWN0aXZlLCBbMTIwMCwgOTAwXSwgWzIyLCAxNy41XSlcblxuXHRcdFx0QGFuaW1hdGVcblx0XHRcdFx0aGVhZGluZzogQGhlYWRpbmcgLSAoZGF0YS52ZWxvY2l0eVggKiByYXRpby54ICogMjAwKSAvIHN0cmVuZ3RoXG5cdFx0XHRcdGVsZXZhdGlvbjogQGVsZXZhdGlvbiArIChkYXRhLnZlbG9jaXR5WSAqIHJhdGlvLnkgKiAyMDApIC8gc3RyZW5ndGhcblx0XHRcdFx0b3B0aW9uczogY3VydmU6IFwic3ByaW5nKDMwMCwxMDApXCJcblxuXHRkZXNrdG9wUGFuOiAoZGVsdGFEaXIsIGRlbHRhSGVpZ2h0KSAtPlxuXHRcdGhhbGZDdWJlU2lkZSA9IEBjdWJlU2lkZS8yXG5cdFx0dHJhbnNsYXRpb25YID0gXCJ0cmFuc2xhdGVYKCN7KChAd2lkdGggLyAyKSAtIGhhbGZDdWJlU2lkZSkgKiBGcmFtZXIuQ3VycmVudENvbnRleHQucGl4ZWxNdWx0aXBsaWVyfXB4KVwiXG5cdFx0dHJhbnNsYXRpb25ZID0gXCIgdHJhbnNsYXRlWSgjeygoQGhlaWdodCAvIDIpIC0gaGFsZkN1YmVTaWRlKSAqIEZyYW1lci5DdXJyZW50Q29udGV4dC5waXhlbE11bHRpcGxpZXJ9cHgpXCJcblx0XHR0cmFuc2xhdGlvblogPSBcIiB0cmFuc2xhdGVaKCN7QHBlcnNwZWN0aXZlICogRnJhbWVyLkN1cnJlbnRDb250ZXh0LnBpeGVsTXVsdGlwbGllcn1weClcIlxuXHRcdEBfaGVhZGluZyAtPSBkZWx0YURpclxuXG5cdFx0aWYgQF9oZWFkaW5nID4gMzYwXG5cdFx0XHRAX2hlYWRpbmcgLT0gMzYwXG5cdFx0ZWxzZSBpZiBAX2hlYWRpbmcgPCAwXG5cdFx0XHRAX2hlYWRpbmcgKz0gMzYwXG5cblx0XHRAX2VsZXZhdGlvbiArPSBkZWx0YUhlaWdodFxuXHRcdEBfZWxldmF0aW9uID0gVXRpbHMuY2xhbXAoQF9lbGV2YXRpb24sIC05MCwgOTApXG5cblx0XHRyb3RhdGlvbiA9IHRyYW5zbGF0aW9uWiArIHRyYW5zbGF0aW9uWCArIHRyYW5zbGF0aW9uWSArIFwiIHJvdGF0ZVgoI3tAX2VsZXZhdGlvbiArIDkwfWRlZykgcm90YXRlWigjezM2MCAtIEBfaGVhZGluZ31kZWcpXCIgKyBcIiByb3RhdGVaKCN7LUBfaGVhZGluZ09mZnNldH1kZWcpXCJcblx0XHRAd29ybGQuc3R5bGVbXCJ3ZWJraXRUcmFuc2Zvcm1cIl0gPSByb3RhdGlvblxuXG5cdFx0QF9lbWl0T3JpZW50YXRpb25EaWRDaGFuZ2VFdmVudCgpXG5cblx0bG9va0F0OiAoaGVhZGluZywgZWxldmF0aW9uKSAtPlxuXHRcdGhhbGZDdWJlU2lkZSA9IEBjdWJlU2lkZS8yXG5cdFx0dHJhbnNsYXRpb25YID0gXCJ0cmFuc2xhdGVYKCN7KChAd2lkdGggLyAyKSAtIGhhbGZDdWJlU2lkZSkgKiBGcmFtZXIuQ3VycmVudENvbnRleHQucGl4ZWxNdWx0aXBsaWVyfXB4KVwiXG5cdFx0dHJhbnNsYXRpb25ZID0gXCIgdHJhbnNsYXRlWSgjeygoQGhlaWdodCAvIDIpIC0gaGFsZkN1YmVTaWRlKSAqIEZyYW1lci5DdXJyZW50Q29udGV4dC5waXhlbE11bHRpcGxpZXJ9cHgpXCJcblx0XHR0cmFuc2xhdGlvblogPSBcIiB0cmFuc2xhdGVaKCN7QHBlcnNwZWN0aXZlICogRnJhbWVyLkN1cnJlbnRDb250ZXh0LnBpeGVsTXVsdGlwbGllcn1weClcIlxuXHRcdHJvdGF0aW9uID0gdHJhbnNsYXRpb25aICsgdHJhbnNsYXRpb25YICsgdHJhbnNsYXRpb25ZICsgXCIgcm90YXRlWigje0BfdGlsdH1kZWcpIHJvdGF0ZVgoI3tlbGV2YXRpb24gKyA5MH1kZWcpIHJvdGF0ZVooI3staGVhZGluZ31kZWcpXCJcblxuXHRcdEB3b3JsZD8uc3R5bGVbXCJ3ZWJraXRUcmFuc2Zvcm1cIl0gPSByb3RhdGlvblxuXHRcdEBfaGVhZGluZyA9IGhlYWRpbmdcblx0XHRAX2VsZXZhdGlvbiA9IGVsZXZhdGlvblxuXHRcdEBfaGVhZGluZ09mZnNldCA9IEBfaGVhZGluZyAtIEBfZGV2aWNlSGVhZGluZyBpZiBVdGlscy5pc01vYmlsZSgpXG5cdFx0QF9lbGV2YXRpb25PZmZzZXQgPSBAX2VsZXZhdGlvbiAtIEBfZGV2aWNlRWxldmF0aW9uXG5cblx0XHRoZWFkaW5nID0gQF9oZWFkaW5nXG5cdFx0aWYgaGVhZGluZyA8IDBcblx0XHRcdGhlYWRpbmcgKz0gMzYwXG5cdFx0ZWxzZSBpZiBoZWFkaW5nID4gMzYwXG5cdFx0XHRoZWFkaW5nIC09IDM2MFxuXG5cdFx0QF9lbWl0T3JpZW50YXRpb25EaWRDaGFuZ2VFdmVudCgpXG5cblx0X2VtaXRPcmllbnRhdGlvbkRpZENoYW5nZUV2ZW50OiA9PlxuXHRcdEBlbWl0KEV2ZW50cy5PcmllbnRhdGlvbkRpZENoYW5nZSwge2hlYWRpbmc6IEBoZWFkaW5nLCBlbGV2YXRpb246IEBlbGV2YXRpb24sIHRpbHQ6IEB0aWx0fSlcblxuXHQjIGV2ZW50IHNob3J0Y3V0c1xuXG5cdG9uT3JpZW50YXRpb25DaGFuZ2U6KGNiKSAtPiBAb24oRXZlbnRzLk9yaWVudGF0aW9uRGlkQ2hhbmdlLCBjYilcbiIsIihmdW5jdGlvbiBlKHQsbixyKXtmdW5jdGlvbiBzKG8sdSl7aWYoIW5bb10pe2lmKCF0W29dKXt2YXIgYT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2lmKCF1JiZhKXJldHVybiBhKG8sITApO2lmKGkpcmV0dXJuIGkobywhMCk7dmFyIGY9bmV3IEVycm9yKFwiQ2Fubm90IGZpbmQgbW9kdWxlICdcIitvK1wiJ1wiKTt0aHJvdyBmLmNvZGU9XCJNT0RVTEVfTk9UX0ZPVU5EXCIsZn12YXIgbD1uW29dPXtleHBvcnRzOnt9fTt0W29dWzBdLmNhbGwobC5leHBvcnRzLGZ1bmN0aW9uKGUpe3ZhciBuPXRbb11bMV1bZV07cmV0dXJuIHMobj9uOmUpfSxsLGwuZXhwb3J0cyxlLHQsbixyKX1yZXR1cm4gbltvXS5leHBvcnRzfXZhciBpPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7Zm9yKHZhciBvPTA7bzxyLmxlbmd0aDtvKyspcyhyW29dKTtyZXR1cm4gc30pIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBRUFBO0FEQUE7QUFBQSxJQUFBLG9DQUFBO0VBQUE7Ozs7O0FBc0NBLEtBQUEsR0FBUSxDQUNQLE9BRE8sRUFFUCxPQUZPLEVBR1AsTUFITyxFQUlQLE9BSk8sRUFLUCxPQUxPLEVBTVAsTUFOTyxFQU9QLE1BUE8sRUFRUCxNQVJPLEVB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
