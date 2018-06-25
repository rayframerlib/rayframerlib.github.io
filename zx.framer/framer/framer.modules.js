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
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZnJhbWVyLm1vZHVsZXMuanMiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL1VzZXJzL3JheS9HaXRIdWIvcmF5ZnJhbWVybGliLmdpdGh1Yi5pby96eC5mcmFtZXIvbW9kdWxlcy9teU1vZHVsZS5jb2ZmZWUiLCIuLi8uLi8uLi8uLi8uLi9Vc2Vycy9yYXkvR2l0SHViL3JheWZyYW1lcmxpYi5naXRodWIuaW8venguZnJhbWVyL21vZHVsZXMvVlJDb21wb25lbnQuY29mZmVlIiwibm9kZV9tb2R1bGVzL2Jyb3dzZXItcGFjay9fcHJlbHVkZS5qcyJdLCJzb3VyY2VzQ29udGVudCI6WyIjIEFkZCB0aGUgZm9sbG93aW5nIGxpbmUgdG8geW91ciBwcm9qZWN0IGluIEZyYW1lciBTdHVkaW8uIFxuIyBteU1vZHVsZSA9IHJlcXVpcmUgXCJteU1vZHVsZVwiXG4jIFJlZmVyZW5jZSB0aGUgY29udGVudHMgYnkgbmFtZSwgbGlrZSBteU1vZHVsZS5teUZ1bmN0aW9uKCkgb3IgbXlNb2R1bGUubXlWYXJcblxuZXhwb3J0cy5teVZhciA9IFwibXlWYXJpYWJsZVwiXG5cbmV4cG9ydHMubXlGdW5jdGlvbiA9IC0+XG5cdHByaW50IFwibXlGdW5jdGlvbiBpcyBydW5uaW5nXCJcblxuZXhwb3J0cy5teUFycmF5ID0gWzEsIDIsIDNdIiwiXCJcIlwiXG5cblZSQ29tcG9uZW50IGNsYXNzXG5cbnByb3BlcnRpZXNcbi0gZnJvbnQgKHNldDogaW1hZ2VQYXRoIDxzdHJpbmc+LCBnZXQ6IGxheWVyKVxuLSByaWdodFxuLSBiYWNrXG4tIGxlZnRcbi0gdG9wXG4tIGJvdHRvbVxuLSBoZWFkaW5nIDxudW1iZXI+XG4tIGVsZXZhdGlvbiA8bnVtYmVyPlxuLSB0aWx0IDxudW1iZXI+IHJlYWRvbmx5XG5cbi0gcGFubmluZyA8Ym9vbD5cbi0gbW9iaWxlUGFubmluZyA8Ym9vbD5cbi0gYXJyb3dLZXlzIDxib29sPlxuXG4tIGxvb2tBdExhdGVzdFByb2plY3RlZExheWVyIDxib29sPlxuXG5tZXRob2RzXG4tIHByb2plY3RMYXllcihsYXllcikgIyBoZWFkaW5nIGFuZCBlbGV2YXRpb24gYXJlIHNldCBhcyBwcm9wZXJ0aWVzIG9uIHRoZSBsYXllclxuLSBoaWRlRW52aXJvbWVudCgpXG5cbmV2ZW50c1xuLSBvbk9yaWVudGF0aW9uQ2hhbmdlIChkYXRhIHtoZWFkaW5nLCBlbGV2YXRpb24sIHRpbHR9KVxuXG4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLVxuXG5WUkxheWVyIGNsYXNzXG5cbnByb3BlcnRpZXNcbi0gaGVhZGluZyA8bnVtYmVyPiAoZnJvbSAwIHVwIHRvIDM2MClcbi0gZWxldmF0aW9uIDxudW1iZXI+IChmcm9tIC05MCBkb3duIHRvIDkwIHVwKVxuXG5cIlwiXCJcblxuU0lERVMgPSBbXG5cdFwibm9ydGhcIixcblx0XCJmcm9udFwiLFxuXHRcImVhc3RcIixcblx0XCJyaWdodFwiLFxuXHRcInNvdXRoXCIsXG5cdFwiYmFja1wiLFxuXHRcIndlc3RcIixcblx0XCJsZWZ0XCIsXG5cdFwidG9wXCIsXG5cdFwiYm90dG9tXCIsXG5dXG5cbktFWVMgPSB7XG5cdExlZnRBcnJvdzogMzdcblx0VXBBcnJvdzogMzhcblx0UmlnaHRBcnJvdzogMzlcblx0RG93bkFycm93OiA0MFxufVxuXG5LRVlTRE9XTiA9IHtcblx0bGVmdDogZmFsc2Vcblx0dXA6IGZhbHNlXG5cdHJpZ2h0OiBmYWxzZVxuXHRkb3duOiBmYWxzZVxufVxuXG5FdmVudHMuT3JpZW50YXRpb25EaWRDaGFuZ2UgPSBcIm9yaWVudGF0aW9uZGlkY2hhbmdlXCJcblxuY2xhc3MgVlJBbmNob3JMYXllciBleHRlbmRzIExheWVyXG5cblx0Y29uc3RydWN0b3I6IChsYXllciwgY3ViZVNpZGUpIC0+XG5cdFx0c3VwZXIoKVxuXHRcdEB3aWR0aCA9IDJcblx0XHRAaGVpZ2h0ID0gMlxuXHRcdEBjbGlwID0gZmFsc2Vcblx0XHRAbmFtZSA9IFwiYW5jaG9yXCJcblx0XHRAY3ViZVNpZGUgPSBjdWJlU2lkZVxuXHRcdEBiYWNrZ3JvdW5kQ29sb3IgPSBudWxsXG5cblx0XHRAbGF5ZXIgPSBsYXllclxuXHRcdGxheWVyLnBhcmVudCA9IEBcblx0XHRsYXllci5jZW50ZXIoKVxuXG5cdFx0bGF5ZXIub24gXCJjaGFuZ2U6b3JpZW50YXRpb25cIiwgKG5ld1ZhbHVlLCBsYXllcikgPT4gQHVwZGF0ZVBvc2l0aW9uKGxheWVyKVxuXHRcdEB1cGRhdGVQb3NpdGlvbihsYXllcilcblxuXHRcdGxheWVyLl9jb250ZXh0Lm9uIFwibGF5ZXI6ZGVzdHJveVwiLCAobGF5ZXIpID0+IEBkZXN0cm95KCkgaWYgbGF5ZXIgaXMgQGxheWVyXG5cblx0dXBkYXRlUG9zaXRpb246IChsYXllcikgLT5cblx0XHRoYWxmQ3ViZVNpZGUgPSBAY3ViZVNpZGUgLyAyXG5cdFx0ZHByID0gRnJhbWVyLkN1cnJlbnRDb250ZXh0LnBpeGVsTXVsdGlwbGllclxuXHRcdHggPSAoKEBjdWJlU2lkZSAtIEB3aWR0aCkgLyAyKSAqIGRwclxuXHRcdHkgPSAoKEBjdWJlU2lkZSAtIEBoZWlnaHQpIC8gMikgKiBkcHJcblx0XHR6ID0gbGF5ZXIuZGlzdGFuY2UgKiBkcHJcblx0XHRAc3R5bGUuV2Via2l0VHJhbnNmb3JtID0gXCJ0cmFuc2xhdGVYKCN7eH1weCkgdHJhbnNsYXRlWSgje3l9cHgpIHJvdGF0ZVooI3tsYXllci5oZWFkaW5nfWRlZykgcm90YXRlWCgjezkwLWxheWVyLmVsZXZhdGlvbn1kZWcpIHRyYW5zbGF0ZVooI3t6fXB4KSByb3RhdGVYKDE4MGRlZylcIlxuXG5jbGFzcyBleHBvcnRzLlZSTGF5ZXIgZXh0ZW5kcyBMYXllclxuXG5cdGNvbnN0cnVjdG9yOiAob3B0aW9ucyA9IHt9KSAtPlxuXHRcdG9wdGlvbnMgPSBfLmRlZmF1bHRzIG9wdGlvbnMsXG5cdFx0XHRoZWFkaW5nOiAwXG5cdFx0XHRlbGV2YXRpb246IDBcblx0XHRzdXBlciBvcHRpb25zXG5cblx0QGRlZmluZSBcImhlYWRpbmdcIixcblx0XHRnZXQ6IC0+IEBfaGVhZGluZ1xuXHRcdHNldDogKHZhbHVlKSAtPlxuXHRcdFx0aWYgdmFsdWUgPj0gMzYwXG5cdFx0XHRcdHZhbHVlID0gdmFsdWUgJSAzNjBcblx0XHRcdGVsc2UgaWYgdmFsdWUgPCAwXG5cdFx0XHRcdHJlc3QgPSBNYXRoLmFicyh2YWx1ZSkgJSAzNjBcblx0XHRcdFx0dmFsdWUgPSAzNjAgLSByZXN0XG5cdFx0XHRyb3VuZGVkVmFsdWUgPSBNYXRoLnJvdW5kKHZhbHVlICogMTAwMCkgLyAxMDAwXG5cdFx0XHRpZiBAX2hlYWRpbmcgaXNudCByb3VuZGVkVmFsdWVcblx0XHRcdFx0QF9oZWFkaW5nID0gcm91bmRlZFZhbHVlXG5cdFx0XHRcdEBlbWl0KFwiY2hhbmdlOmhlYWRpbmdcIiwgQF9oZWFkaW5nKVxuXHRcdFx0XHRAZW1pdChcImNoYW5nZTpvcmllbnRhdGlvblwiLCBAX2hlYWRpbmcpXG5cblx0QGRlZmluZSBcImVsZXZhdGlvblwiLFxuXHRcdGdldDogLT4gQF9lbGV2YXRpb25cblx0XHRzZXQ6ICh2YWx1ZSkgLT5cblx0XHRcdHZhbHVlID0gVXRpbHMuY2xhbXAodmFsdWUsIC05MCwgOTApXG5cdFx0XHRyb3VuZGVkVmFsdWUgPSBNYXRoLnJvdW5kKHZhbHVlICogMTAwMCkgLyAxMDAwXG5cdFx0XHRpZiByb3VuZGVkVmFsdWUgaXNudCBAX2VsZXZhdGlvblxuXHRcdFx0XHRAX2VsZXZhdGlvbiA9IHJvdW5kZWRWYWx1ZVxuXHRcdFx0XHRAZW1pdChcImNoYW5nZTplbGV2YXRpb25cIiwgcm91bmRlZFZhbHVlKVxuXHRcdFx0XHRAZW1pdChcImNoYW5nZTpvcmllbnRhdGlvblwiLCByb3VuZGVkVmFsdWUpXG5cblx0QGRlZmluZSBcImRpc3RhbmNlXCIsXG5cdFx0Z2V0OiAtPiBAX2Rpc3RhbmNlXG5cdFx0c2V0OiAodmFsdWUpIC0+XG5cdFx0XHRpZiB2YWx1ZSBpc250IEBfZGlzdGFuY2Vcblx0XHRcdFx0QF9kaXN0YW5jZSA9IHZhbHVlXG5cdFx0XHRcdEBlbWl0KFwiY2hhbmdlOmRpc3RhbmNlXCIsIHZhbHVlKVxuXHRcdFx0XHRAZW1pdChcImNoYW5nZTpvcmllbnRhdGlvblwiLCB2YWx1ZSlcblxuY2xhc3MgZXhwb3J0cy5WUkNvbXBvbmVudCBleHRlbmRzIExheWVyXG5cblx0Y29uc3RydWN0b3I6IChvcHRpb25zID0ge30pIC0+XG5cdFx0b3B0aW9ucyA9IF8uZGVmYXVsdHMgb3B0aW9ucyxcblx0XHRcdGN1YmVTaWRlOiAxNTAwXG5cdFx0XHRwZXJzcGVjdGl2ZTogNjAwXG5cdFx0XHRsb29rQXRMYXRlc3RQcm9qZWN0ZWRMYXllcjogZmFsc2Vcblx0XHRcdHdpZHRoOiBTY3JlZW4ud2lkdGhcblx0XHRcdGhlaWdodDogU2NyZWVuLmhlaWdodFxuXHRcdFx0YXJyb3dLZXlzOiB0cnVlXG5cdFx0XHRwYW5uaW5nOiB0cnVlXG5cdFx0XHRtb2JpbGVQYW5uaW5nOiB0cnVlXG5cdFx0XHRmbGF0OiB0cnVlXG5cdFx0XHRjbGlwOiB0cnVlXG5cdFx0c3VwZXIgb3B0aW9uc1xuXG5cdFx0IyB0byBoaWRlIHRoZSBzZWVtcyB3aGVyZSB0aGUgY3ViZSBzdXJmYWNlcyBjb21lIHRvZ2V0aGVyIHdlIGRpc2FibGUgdGhlIHZpZXdwb3J0IHBlcnNwZWN0aXZlIGFuZCBzZXQgYSBibGFjayBiYWNrZ3JvdW5kXG5cdFx0U2NyZWVuLmJhY2tncm91bmRDb2xvciA9IFwiYmxhY2tcIlxuXHRcdFNjcmVlbi5wZXJzcGVjdGl2ZSA9IDBcblxuXHRcdEBzZXR1cERlZmF1bHRWYWx1ZXMoKVxuXHRcdEBkZWdUb1JhZCA9IE1hdGguUEkgLyAxODBcblx0XHRAYmFja2dyb3VuZENvbG9yID0gbnVsbFxuXG5cdFx0QGNyZWF0ZUN1YmUob3B0aW9ucy5jdWJlU2lkZSlcblx0XHRAbG9va0F0TGF0ZXN0UHJvamVjdGVkTGF5ZXIgPSBvcHRpb25zLmxvb2tBdExhdGVzdFByb2plY3RlZExheWVyXG5cdFx0QHNldHVwS2V5cyhvcHRpb25zLmFycm93S2V5cylcblxuXHRcdEBoZWFkaW5nID0gb3B0aW9ucy5oZWFkaW5nIGlmIG9wdGlvbnMuaGVhZGluZz9cblx0XHRAZWxldmF0aW9uID0gb3B0aW9ucy5lbGV2YXRpb24gaWYgb3B0aW9ucy5lbGV2YXRpb24/XG5cblx0XHRAc2V0dXBQYW4ob3B0aW9ucy5wYW5uaW5nKVxuXHRcdEBtb2JpbGVQYW5uaW5nID0gb3B0aW9ucy5tb2JpbGVQYW5uaW5nXG5cblx0XHRpZiBVdGlscy5pc01vYmlsZSgpXG5cdFx0XHR3aW5kb3cuYWRkRXZlbnRMaXN0ZW5lciBcImRldmljZW9yaWVudGF0aW9uXCIsIChldmVudCkgPT4gQG9yaWVudGF0aW9uRGF0YSA9IGV2ZW50XG5cblx0XHRGcmFtZXIuTG9vcC5vbihcInVwZGF0ZVwiLCBAZGV2aWNlT3JpZW50YXRpb25VcGRhdGUpXG5cblx0XHQjIE1ha2Ugc3VyZSB3ZSByZW1vdmUgdGhlIHVwZGF0ZSBmcm9tIHRoZSBsb29wIHdoZW4gd2UgZGVzdHJveSB0aGUgY29udGV4dFxuXHRcdEZyYW1lci5DdXJyZW50Q29udGV4dC5vbiBcInJlc2V0XCIsIC0+IEZyYW1lci5Mb29wLm9mZihcInVwZGF0ZVwiLCBAZGV2aWNlT3JpZW50YXRpb25VcGRhdGUpXG5cblx0XHRAb24gXCJjaGFuZ2U6ZnJhbWVcIiwgLT4gQGRlc2t0b3BQYW4oMCwwKVxuXG5cdHNldHVwRGVmYXVsdFZhbHVlczogPT5cblxuXHRcdEBfaGVhZGluZyA9IDBcblx0XHRAX2VsZXZhdGlvbiA9IDBcblx0XHRAX3RpbHQgPSAwXG5cblx0XHRAX2hlYWRpbmdPZmZzZXQgPSAwXG5cdFx0QF9lbGV2YXRpb25PZmZzZXQgPSAwXG5cdFx0QF9kZXZpY2VIZWFkaW5nID0gMFxuXHRcdEBfZGV2aWNlRWxldmF0aW9uID0gMFxuXG5cdHNldHVwS2V5czogKGVuYWJsZWQpIC0+XG5cblx0XHRAYXJyb3dLZXlzID0gZW5hYmxlZFxuXG5cdFx0ZG9jdW1lbnQuYWRkRXZlbnRMaXN0ZW5lciBcImtleWRvd25cIiwgKGV2ZW50KSA9PlxuXHRcdFx0c3dpdGNoIGV2ZW50LndoaWNoXG5cdFx0XHRcdHdoZW4gS0VZUy5VcEFycm93XG5cdFx0XHRcdFx0S0VZU0RPV04udXAgPSB0cnVlXG5cdFx0XHRcdFx0ZXZlbnQucHJldmVudERlZmF1bHQoKVxuXHRcdFx0XHR3aGVuIEtFWVMuRG93bkFycm93XG5cdFx0XHRcdFx0S0VZU0RPV04uZG93biA9IHRydWVcblx0XHRcdFx0XHRldmVudC5wcmV2ZW50RGVmYXVsdCgpXG5cdFx0XHRcdHdoZW4gS0VZUy5MZWZ0QXJyb3dcblx0XHRcdFx0XHRLRVlTRE9XTi5sZWZ0ID0gdHJ1ZVxuXHRcdFx0XHRcdGV2ZW50LnByZXZlbnREZWZhdWx0KClcblx0XHRcdFx0d2hlbiBLRVlTLlJpZ2h0QXJyb3dcblx0XHRcdFx0XHRLRVlTRE9XTi5yaWdodCA9IHRydWVcblx0XHRcdFx0XHRldmVudC5wcmV2ZW50RGVmYXVsdCgpXG5cblx0XHRkb2N1bWVudC5hZGRFdmVudExpc3RlbmVyIFwia2V5dXBcIiwgKGV2ZW50KSA9PlxuXHRcdFx0c3dpdGNoIGV2ZW50LndoaWNoXG5cdFx0XHRcdHdoZW4gS0VZUy5VcEFycm93XG5cdFx0XHRcdFx0S0VZU0RPV04udXAgPSBmYWxzZVxuXHRcdFx0XHRcdGV2ZW50LnByZXZlbnREZWZhdWx0KClcblx0XHRcdFx0d2hlbiBLRVlTLkRvd25BcnJvd1xuXHRcdFx0XHRcdEtFWVNET1dOLmRvd24gPSBmYWxzZVxuXHRcdFx0XHRcdGV2ZW50LnByZXZlbnREZWZhdWx0KClcblx0XHRcdFx0d2hlbiBLRVlTLkxlZnRBcnJvd1xuXHRcdFx0XHRcdEtFWVNET1dOLmxlZnQgPSBmYWxzZVxuXHRcdFx0XHRcdGV2ZW50LnByZXZlbnREZWZhdWx0KClcblx0XHRcdFx0d2hlbiBLRVlTLlJpZ2h0QXJyb3dcblx0XHRcdFx0XHRLRVlTRE9XTi5yaWdodCA9IGZhbHNlXG5cdFx0XHRcdFx0ZXZlbnQucHJldmVudERlZmF1bHQoKVxuXG5cdFx0d2luZG93Lm9uYmx1ciA9IC0+XG5cdFx0XHRLRVlTRE9XTi51cCA9IGZhbHNlXG5cdFx0XHRLRVlTRE9XTi5kb3duID0gZmFsc2Vcblx0XHRcdEtFWVNET1dOLmxlZnQgPSBmYWxzZVxuXHRcdFx0S0VZU0RPV04ucmlnaHQgPSBmYWxzZVxuXG5cdEBkZWZpbmUgXCJoZWFkaW5nXCIsXG5cdFx0Z2V0OiAtPlxuXHRcdFx0aGVhZGluZyA9IEBfaGVhZGluZyArIEBfaGVhZGluZ09mZnNldFxuXHRcdFx0aWYgaGVhZGluZyA+IDM2MFxuXHRcdFx0XHRoZWFkaW5nID0gaGVhZGluZyAlIDM2MFxuXHRcdFx0ZWxzZSBpZiBoZWFkaW5nIDwgMFxuXHRcdFx0XHRyZXN0ID0gTWF0aC5hYnMoaGVhZGluZykgJSAzNjBcblx0XHRcdFx0aGVhZGluZyA9IDM2MCAtIHJlc3Rcblx0XHRcdHJldHVybiBNYXRoLnJvdW5kKGhlYWRpbmcgKiAxMDAwKSAvIDEwMDBcblx0XHRzZXQ6ICh2YWx1ZSkgLT5cblx0XHRcdEBsb29rQXQodmFsdWUsIEBfZWxldmF0aW9uKVxuXG5cdEBkZWZpbmUgXCJlbGV2YXRpb25cIixcblx0XHRnZXQ6IC0+IE1hdGgucm91bmQoQF9lbGV2YXRpb24gKiAxMDAwKSAvIDEwMDBcblx0XHRzZXQ6ICh2YWx1ZSkgLT5cblx0XHRcdHZhbHVlID0gVXRpbHMuY2xhbXAodmFsdWUsIC05MCwgOTApXG5cdFx0XHRAbG9va0F0KEBfaGVhZGluZywgdmFsdWUpXG5cblx0QGRlZmluZSBcInRpbHRcIixcblx0XHRnZXQ6IC0+IEBfdGlsdFxuXHRcdHNldDogKHZhbHVlKSAtPiB0aHJvdyBcIlRpbHQgaXMgcmVhZG9ubHlcIlxuXG5cdFNJREVTLm1hcCAoZmFjZSkgPT5cblx0XHRAZGVmaW5lIGZhY2UsXG5cdFx0XHRnZXQ6IC0+IEBsYXllckZyb21GYWNlKGZhY2UpICMgQGdldEltYWdlKGZhY2UpXG5cdFx0XHRzZXQ6ICh2YWx1ZSkgLT4gQHNldEltYWdlKGZhY2UsIHZhbHVlKVxuXG5cdGNyZWF0ZUN1YmU6IChjdWJlU2lkZSA9IEBjdWJlU2lkZSkgPT5cblx0XHRAY3ViZVNpZGUgPSBjdWJlU2lkZVxuXG5cdFx0QHdvcmxkPy5kZXN0cm95KClcblx0XHRAd29ybGQgPSBuZXcgTGF5ZXJcblx0XHRcdG5hbWU6IFwid29ybGRcIlxuXHRcdFx0c3VwZXJMYXllcjogQFxuXHRcdFx0c2l6ZTogY3ViZVNpZGVcblx0XHRcdGJhY2tncm91bmRDb2xvcjogbnVsbFxuXHRcdFx0Y2xpcDogZmFsc2Vcblx0XHRAd29ybGQuY2VudGVyKClcblxuXHRcdEBzaWRlcyA9IFtdXG5cdFx0aGFsZkN1YmVTaWRlID0gQGN1YmVTaWRlIC8gMlxuXHRcdGNvbG9ycyA9IFtcIiM4NjZjY2NcIiwgXCIjMjhhZmZhXCIsIFwiIzJkZDdhYVwiLCBcIiNmZmMyMmNcIiwgXCIjN2RkZDExXCIsIFwiI2Y5NWZhYVwiXVxuXHRcdHNpZGVOYW1lcyA9IFtcImZyb250XCIsIFwicmlnaHRcIiwgXCJiYWNrXCIsIFwibGVmdFwiLCBcInRvcFwiLCBcImJvdHRvbVwiXVxuXG5cdFx0Zm9yIHNpZGVJbmRleCBpbiBbMC4uLjZdXG5cblx0XHRcdHJvdGF0aW9uWCA9IDBcblx0XHRcdHJvdGF0aW9uWCA9IC05MCBpZiBzaWRlSW5kZXggaW4gWzAuLi40XVxuXHRcdFx0cm90YXRpb25YID0gMTgwIGlmIHNpZGVJbmRleCBpcyA0XG5cblx0XHRcdHJvdGF0aW9uWSA9IDBcblx0XHRcdHJvdGF0aW9uWSA9IHNpZGVJbmRleCAqIC05MCBpZiBzaWRlSW5kZXggaW4gWzAuLi40XVxuXG5cdFx0XHRzaWRlID0gbmV3IExheWVyXG5cdFx0XHRcdHNpemU6IGN1YmVTaWRlXG5cdFx0XHRcdHo6IC1oYWxmQ3ViZVNpZGVcblx0XHRcdFx0b3JpZ2luWjogaGFsZkN1YmVTaWRlXG5cdFx0XHRcdHJvdGF0aW9uWDogcm90YXRpb25YXG5cdFx0XHRcdHJvdGF0aW9uWTogcm90YXRpb25ZXG5cdFx0XHRcdHBhcmVudDogQHdvcmxkXG5cdFx0XHRcdG5hbWU6IHNpZGVOYW1lc1tzaWRlSW5kZXhdXG5cdFx0XHRcdGh0bWw6IHNpZGVOYW1lc1tzaWRlSW5kZXhdXG5cdFx0XHRcdGNvbG9yOiBcIndoaXRlXCJcblx0XHRcdFx0YmFja2dyb3VuZENvbG9yOiBjb2xvcnNbc2lkZUluZGV4XVxuXHRcdFx0XHRzdHlsZTpcblx0XHRcdFx0XHRsaW5lSGVpZ2h0OiBcIiN7Y3ViZVNpZGV9cHhcIlxuXHRcdFx0XHRcdHRleHRBbGlnbjogXCJjZW50ZXJcIlxuXHRcdFx0XHRcdGZvbnRTaXplOiBcIiN7Y3ViZVNpZGUgLyAxMH1weFwiXG5cdFx0XHRcdFx0Zm9udFdlaWdodDogXCIxMDBcIlxuXHRcdFx0XHRcdGZvbnRGYW1pbHk6IFwiSGVsdmV0aWNhIE5ldWVcIlxuXHRcdFx0QHNpZGVzLnB1c2goc2lkZSlcblx0XHRcdHNpZGUuX2JhY2tncm91bmRDb2xvciA9IHNpZGUuYmFja2dyb3VuZENvbG9yXG5cblx0XHRmb3Iga2V5IG9mIEBzaWRlSW1hZ2VzIHdoZW4gQHNpZGVJbWFnZXM/XG5cdFx0XHRAc2V0SW1hZ2Uga2V5LCBAc2lkZUltYWdlc1trZXldXG5cblx0aGlkZUVudmlyb21lbnQ6IC0+XG5cdFx0Zm9yIHNpZGUgaW4gQHNpZGVzXG5cdFx0XHRzaWRlLmRlc3Ryb3koKVxuXG5cdGxheWVyRnJvbUZhY2U6IChmYWNlKSAtPlxuXHRcdHJldHVybiB1bmxlc3MgQHNpZGVzP1xuXHRcdG1hcCA9XG5cdFx0XHRub3J0aDogQHNpZGVzWzBdXG5cdFx0XHRmcm9udDogQHNpZGVzWzBdXG5cdFx0XHRlYXN0OiAgQHNpZGVzWzFdXG5cdFx0XHRyaWdodDogQHNpZGVzWzFdXG5cdFx0XHRzb3V0aDogQHNpZGVzWzJdXG5cdFx0XHRiYWNrOiAgQHNpZGVzWzJdXG5cdFx0XHR3ZXN0OiAgQHNpZGVzWzNdXG5cdFx0XHRsZWZ0OiAgQHNpZGVzWzNdXG5cdFx0XHR0b3A6ICAgQHNpZGVzWzRdXG5cdFx0XHRib3R0b206QHNpZGVzWzVdXG5cdFx0cmV0dXJuIG1hcFtmYWNlXVxuXG5cdHNldEltYWdlOiAoZmFjZSwgaW1hZ2VQYXRoKSAtPlxuXG5cdFx0dGhyb3cgRXJyb3IgXCJWUkNvbXBvbmVudCBzZXRJbWFnZSwgd3JvbmcgbmFtZSBmb3IgZmFjZTogXCIgKyBmYWNlICsgXCIsIHZhbGlkIG9wdGlvbnM6IGZyb250LCByaWdodCwgYmFjaywgbGVmdCwgdG9wLCBib3R0b20sIG5vcnRoLCBlYXN0LCBzb3V0aCwgd2VzdFwiIHVubGVzcyBmYWNlIGluIFNJREVTXG5cblx0XHRAc2lkZUltYWdlcyA9IHt9IHVubGVzcyBAc2lkZUltYWdlcz9cblx0XHRAc2lkZUltYWdlc1tmYWNlXSA9IGltYWdlUGF0aFxuXG5cdFx0bGF5ZXIgPSBAbGF5ZXJGcm9tRmFjZShmYWNlKVxuXG5cdFx0aWYgaW1hZ2VQYXRoP1xuXHRcdFx0bGF5ZXI/Lmh0bWwgPSBcIlwiXG5cdFx0XHRsYXllcj8uaW1hZ2UgPSBpbWFnZVBhdGhcblx0XHRlbHNlXG5cdFx0XHRsYXllcj8uaHRtbCA9IGxheWVyPy5uYW1lXG5cdFx0XHRsYXllcj8uYmFja2dyb3VuZENvbG9yID0gbGF5ZXI/Ll9iYWNrZ3JvdW5kQ29sb3JcblxuXHRnZXRJbWFnZTogKGZhY2UpIC0+XG5cblx0XHR0aHJvdyBFcnJvciBcIlZSQ29tcG9uZW50IGdldEltYWdlLCB3cm9uZyBuYW1lIGZvciBmYWNlOiBcIiArIGZhY2UgKyBcIiwgdmFsaWQgb3B0aW9uczogZnJvbnQsIHJpZ2h0LCBiYWNrLCBsZWZ0LCB0b3AsIGJvdHRvbSwgbm9ydGgsIGVhc3QsIHNvdXRoLCB3ZXN0XCIgdW5sZXNzIGZhY2UgaW4gU0lERVNcblxuXHRcdGxheWVyID0gQGxheWVyRnJvbUZhY2UoZmFjZSlcblx0XHRyZXR1cm4gbGF5ZXIuaW1hZ2UgaWYgbGF5ZXI/XG5cblx0cHJvamVjdExheWVyOiAoaW5zZXJ0TGF5ZXIpIC0+XG5cblx0XHRoZWFkaW5nID0gaW5zZXJ0TGF5ZXIuaGVhZGluZ1xuXHRcdGhlYWRpbmcgPSAwIHVubGVzcyBoZWFkaW5nP1xuXG5cdFx0aWYgaGVhZGluZyA+PSAzNjBcblx0XHRcdGhlYWRpbmcgPSB2YWx1ZSAlIDM2MFxuXHRcdGVsc2UgaWYgaGVhZGluZyA8IDBcblx0XHRcdHJlc3QgPSBNYXRoLmFicyhoZWFkaW5nKSAlIDM2MFxuXHRcdFx0aGVhZGluZyA9IDM2MCAtIHJlc3RcblxuXHRcdGVsZXZhdGlvbiA9IGluc2VydExheWVyLmVsZXZhdGlvblxuXHRcdGVsZXZhdGlvbiA9IDAgdW5sZXNzIGVsZXZhdGlvbj9cblx0XHRlbGV2YXRpb24gPSBVdGlscy5jbGFtcChlbGV2YXRpb24sIC05MCwgOTApXG5cblx0XHRkaXN0YW5jZSA9IGluc2VydExheWVyLmRpc3RhbmNlXG5cdFx0ZGlzdGFuY2UgPSA2MDAgdW5sZXNzIGRpc3RhbmNlP1xuXG5cdFx0aW5zZXJ0TGF5ZXIuaGVhZGluZyA9IGhlYWRpbmdcblx0XHRpbnNlcnRMYXllci5lbGV2YXRpb24gPSBlbGV2YXRpb25cblx0XHRpbnNlcnRMYXllci5kaXN0YW5jZSA9IGRpc3RhbmNlXG5cblx0XHRhbmNob3IgPSBuZXcgVlJBbmNob3JMYXllcihpbnNlcnRMYXllciwgQGN1YmVTaWRlKVxuXHRcdGFuY2hvci5zdXBlckxheWVyID0gQHdvcmxkXG5cblx0XHRAbG9va0F0KGhlYWRpbmcsIGVsZXZhdGlvbikgaWYgQGxvb2tBdExhdGVzdFByb2plY3RlZExheWVyXG5cblx0IyBNb2JpbGUgZGV2aWNlIG9yaWVudGF0aW9uXG5cblx0ZGV2aWNlT3JpZW50YXRpb25VcGRhdGU6ID0+XG5cblx0XHRpZiBVdGlscy5pc0Rlc2t0b3AoKVxuXHRcdFx0aWYgQGFycm93S2V5c1xuXHRcdFx0XHRpZiBAX2xhc3RDYWxsSG9yaXpvbnRhbCBpcyB1bmRlZmluZWRcblx0XHRcdFx0XHRAX2xhc3RDYWxsSG9yaXpvbnRhbCA9IDBcblx0XHRcdFx0XHRAX2xhc3RDYWxsVmVydGljYWwgPSAwXG5cdFx0XHRcdFx0QF9hY2NlbGVyYXRpb25Ib3Jpem9udGFsID0gMVxuXHRcdFx0XHRcdEBfYWNjZWxlcmF0aW9uVmVydGljYWwgPSAxXG5cdFx0XHRcdFx0QF9nb2luZ1VwID0gZmFsc2Vcblx0XHRcdFx0XHRAX2dvaW5nTGVmdCA9IGZhbHNlXG5cblx0XHRcdFx0ZGF0ZSA9IG5ldyBEYXRlKClcblx0XHRcdFx0eCA9IC4xXG5cdFx0XHRcdGlmIEtFWVNET1dOLnVwIG9yIEtFWVNET1dOLmRvd25cblx0XHRcdFx0XHRkaWZmID0gZGF0ZSAtIEBfbGFzdENhbGxWZXJ0aWNhbFxuXHRcdFx0XHRcdGlmIGRpZmYgPCAzMFxuXHRcdFx0XHRcdFx0aWYgQF9hY2NlbGVyYXRpb25WZXJ0aWNhbCA8IDMwXG5cdFx0XHRcdFx0XHRcdEBfYWNjZWxlcmF0aW9uVmVydGljYWwgKz0gMC4xOFxuXHRcdFx0XHRcdGlmIEtFWVNET1dOLnVwXG5cdFx0XHRcdFx0XHRpZiBAX2dvaW5nVXAgaXMgZmFsc2Vcblx0XHRcdFx0XHRcdFx0QF9hY2NlbGVyYXRpb25WZXJ0aWNhbCA9IDFcblx0XHRcdFx0XHRcdFx0QF9nb2luZ1VwID0gdHJ1ZVxuXHRcdFx0XHRcdFx0QGRlc2t0b3BQYW4oMCwgMSAqIEBfYWNjZWxlcmF0aW9uVmVydGljYWwgKiB4KVxuXHRcdFx0XHRcdGVsc2Vcblx0XHRcdFx0XHRcdGlmIEBfZ29pbmdVcCBpcyB0cnVlXG5cdFx0XHRcdFx0XHRcdEBfYWNjZWxlcmF0aW9uVmVydGljYWwgPSAxXG5cdFx0XHRcdFx0XHRcdEBfZ29pbmdVcCA9IGZhbHNlXG5cblx0XHRcdFx0XHRcdEBkZXNrdG9wUGFuKDAsIC0xICogQF9hY2NlbGVyYXRpb25WZXJ0aWNhbCAqIHgpXG5cdFx0XHRcdFx0QF9sYXN0Q2FsbFZlcnRpY2FsID0gZGF0ZVxuXG5cdFx0XHRcdGVsc2Vcblx0XHRcdFx0XHRAX2FjY2VsZXJhdGlvblZlcnRpY2FsID0gMVxuXG5cdFx0XHRcdGlmIEtFWVNET1dOLmxlZnQgb3IgS0VZU0RPV04ucmlnaHRcblx0XHRcdFx0XHRkaWZmID0gZGF0ZSAtIEBfbGFzdENhbGxIb3Jpem9udGFsXG5cdFx0XHRcdFx0aWYgZGlmZiA8IDMwXG5cdFx0XHRcdFx0XHRpZiBAX2FjY2VsZXJhdGlvbkhvcml6b250YWwgPCAyNVxuXHRcdFx0XHRcdFx0XHRAX2FjY2VsZXJhdGlvbkhvcml6b250YWwgKz0gMC4xOFxuXHRcdFx0XHRcdGlmIEtFWVNET1dOLmxlZnRcblx0XHRcdFx0XHRcdGlmIEBfZ29pbmdMZWZ0IGlzIGZhbHNlXG5cdFx0XHRcdFx0XHRcdEBfYWNjZWxlcmF0aW9uSG9yaXpvbnRhbCA9IDFcblx0XHRcdFx0XHRcdFx0QF9nb2luZ0xlZnQgPSB0cnVlXG5cdFx0XHRcdFx0XHRAZGVza3RvcFBhbigxICogQF9hY2NlbGVyYXRpb25Ib3Jpem9udGFsICogeCwgMClcblx0XHRcdFx0XHRlbHNlXG5cdFx0XHRcdFx0XHRpZiBAX2dvaW5nTGVmdCBpcyB0cnVlXG5cdFx0XHRcdFx0XHRcdEBfYWNjZWxlcmF0aW9uSG9yaXpvbnRhbCA9IDFcblx0XHRcdFx0XHRcdFx0QF9nb2luZ0xlZnQgPSBmYWxzZVxuXHRcdFx0XHRcdFx0QGRlc2t0b3BQYW4oLTEgKiBAX2FjY2VsZXJhdGlvbkhvcml6b250YWwgKiB4LCAwKVxuXHRcdFx0XHRcdEBfbGFzdENhbGxIb3Jpem9udGFsID0gZGF0ZVxuXHRcdFx0XHRlbHNlXG5cdFx0XHRcdFx0QF9hY2NlbGVyYXRpb25Ib3Jpem9udGFsID0gMVxuXG5cdFx0ZWxzZSBpZiBAb3JpZW50YXRpb25EYXRhP1xuXG5cdFx0XHRhbHBoYSA9IEBvcmllbnRhdGlvbkRhdGEuYWxwaGFcblx0XHRcdGJldGEgPSBAb3JpZW50YXRpb25EYXRhLmJldGFcblx0XHRcdGdhbW1hID0gQG9yaWVudGF0aW9uRGF0YS5nYW1tYVxuXG5cdFx0XHRAZGlyZWN0aW9uUGFyYW1zKGFscGhhLCBiZXRhLCBnYW1tYSkgaWYgYWxwaGEgaXNudCAwIGFuZCBiZXRhIGlzbnQgMCBhbmQgZ2FtbWEgaXNudCAwXG5cblx0XHRcdHhBbmdsZSA9IGJldGFcblx0XHRcdHlBbmdsZSA9IC1nYW1tYVxuXHRcdFx0ekFuZ2xlID0gYWxwaGFcblxuXHRcdFx0aGFsZkN1YmVTaWRlID0gQGN1YmVTaWRlLzJcblx0XHRcdG9yaWVudGF0aW9uID0gXCJyb3RhdGUoI3t3aW5kb3cub3JpZW50YXRpb24gKiAtMX1kZWcpIFwiXG5cdFx0XHR0cmFuc2xhdGlvblggPSBcInRyYW5zbGF0ZVgoI3soKEB3aWR0aCAvIDIpIC0gaGFsZkN1YmVTaWRlKSAqIEZyYW1lci5DdXJyZW50Q29udGV4dC5waXhlbE11bHRpcGxpZXJ9cHgpXCJcblx0XHRcdHRyYW5zbGF0aW9uWSA9IFwiIHRyYW5zbGF0ZVkoI3soKEBoZWlnaHQgLyAyKSAtIGhhbGZDdWJlU2lkZSkgKiBGcmFtZXIuQ3VycmVudENvbnRleHQucGl4ZWxNdWx0aXBsaWVyfXB4KVwiXG5cdFx0XHR0cmFuc2xhdGlvblogPSBcIiB0cmFuc2xhdGVaKCN7QHBlcnNwZWN0aXZlICogRnJhbWVyLkN1cnJlbnRDb250ZXh0LnBpeGVsTXVsdGlwbGllcn1weClcIlxuXHRcdFx0cm90YXRpb24gPSB0cmFuc2xhdGlvblogKyB0cmFuc2xhdGlvblggKyB0cmFuc2xhdGlvblkgKyBvcmllbnRhdGlvbiArIFwiIHJvdGF0ZVkoI3t5QW5nbGV9ZGVnKSByb3RhdGVYKCN7eEFuZ2xlfWRlZykgcm90YXRlWigje3pBbmdsZX1kZWcpXCIgKyBcIiByb3RhdGVaKCN7LUBfaGVhZGluZ09mZnNldH1kZWcpXCJcblx0XHRcdEB3b3JsZC5zdHlsZVtcIndlYmtpdFRyYW5zZm9ybVwiXSA9IHJvdGF0aW9uXG5cblx0ZGlyZWN0aW9uUGFyYW1zOiAoYWxwaGEsIGJldGEsIGdhbW1hKSAtPlxuXG5cdFx0YWxwaGFSYWQgPSBhbHBoYSAqIEBkZWdUb1JhZFxuXHRcdGJldGFSYWQgPSBiZXRhICogQGRlZ1RvUmFkXG5cdFx0Z2FtbWFSYWQgPSBnYW1tYSAqIEBkZWdUb1JhZFxuXG5cdFx0IyBDYWxjdWxhdGUgZXF1YXRpb24gY29tcG9uZW50c1xuXHRcdGNBID0gTWF0aC5jb3MoYWxwaGFSYWQpXG5cdFx0c0EgPSBNYXRoLnNpbihhbHBoYVJhZClcblx0XHRjQiA9IE1hdGguY29zKGJldGFSYWQpXG5cdFx0c0IgPSBNYXRoLnNpbihiZXRhUmFkKVxuXHRcdGNHID0gTWF0aC5jb3MoZ2FtbWFSYWQpXG5cdFx0c0cgPSBNYXRoLnNpbihnYW1tYVJhZClcblxuXHRcdCMgeCB1bml0dmVjdG9yXG5cdFx0eHJBID0gLXNBICogc0IgKiBzRyArIGNBICogY0dcblx0XHR4ckIgPSBjQSAqIHNCICogc0cgKyBzQSAqIGNHXG5cdFx0eHJDID0gY0IgKiBzR1xuXG5cdFx0IyB5IHVuaXR2ZWN0b3Jcblx0XHR5ckEgPSAtc0EgKiBjQlxuXHRcdHlyQiA9IGNBICogY0Jcblx0XHR5ckMgPSAtc0JcblxuXHRcdCMgLXogdW5pdHZlY3RvclxuXHRcdHpyQSA9IC1zQSAqIHNCICogY0cgLSBjQSAqIHNHXG5cdFx0enJCID0gY0EgKiBzQiAqIGNHIC0gc0EgKiBzR1xuXHRcdHpyQyA9IGNCICogY0dcblxuXHRcdCMgQ2FsY3VsYXRlIGhlYWRpbmdcblx0XHRoZWFkaW5nID0gTWF0aC5hdGFuKHpyQSAvIHpyQilcblxuXHRcdCMgQ29udmVydCBmcm9tIGhhbGYgdW5pdCBjaXJjbGUgdG8gd2hvbGUgdW5pdCBjaXJjbGVcblx0XHRpZiB6ckIgPCAwXG5cdFx0XHRoZWFkaW5nICs9IE1hdGguUElcblx0XHRlbHNlIGlmIHpyQSA8IDBcblx0XHRcdGhlYWRpbmcgKz0gMiAqIE1hdGguUElcblxuXHRcdCMgIyBDYWxjdWxhdGUgQWx0aXR1ZGUgKGluIGRlZ3JlZXMpXG5cdFx0ZWxldmF0aW9uID0gTWF0aC5QSSAvIDIgLSBNYXRoLmFjb3MoLXpyQylcblxuXHRcdGNIID0gTWF0aC5zcXJ0KDEgLSAoenJDICogenJDKSlcblx0XHR0aWx0ID0gTWF0aC5hY29zKC14ckMgLyBjSCkgKiBNYXRoLnNpZ24oeXJDKVxuXG5cdFx0IyBDb252ZXJ0IHJhZGlhbnMgdG8gZGVncmVlc1xuXHRcdGhlYWRpbmcgKj0gMTgwIC8gTWF0aC5QSVxuXHRcdGVsZXZhdGlvbiAqPSAxODAgLyBNYXRoLlBJXG5cdFx0dGlsdCAqPSAxODAgLyBNYXRoLlBJXG5cblx0XHRAX2hlYWRpbmcgPSBNYXRoLnJvdW5kKGhlYWRpbmcgKiAxMDAwKSAvIDEwMDBcblx0XHRAX2VsZXZhdGlvbiA9IE1hdGgucm91bmQoZWxldmF0aW9uICogMTAwMCkgLyAxMDAwXG5cblx0XHR0aWx0ID0gTWF0aC5yb3VuZCh0aWx0ICogMTAwMCkgLyAxMDAwXG5cdFx0b3JpZW50YXRpb25UaWx0T2Zmc2V0ID0gKHdpbmRvdy5vcmllbnRhdGlvbiAqIC0xKSArIDkwXG5cdFx0dGlsdCArPSBvcmllbnRhdGlvblRpbHRPZmZzZXRcblx0XHR0aWx0IC09IDM2MCBpZiB0aWx0ID4gMTgwXG5cdFx0QF90aWx0ID0gdGlsdFxuXG5cdFx0QF9kZXZpY2VIZWFkaW5nID0gQF9oZWFkaW5nXG5cdFx0QF9kZXZpY2VFbGV2YXRpb24gPSBAX2VsZXZhdGlvblxuXHRcdEBfZW1pdE9yaWVudGF0aW9uRGlkQ2hhbmdlRXZlbnQoKVxuXG5cdCMgUGFubmluZ1xuXG5cdF9jYW52YXNUb0NvbXBvbmVudFJhdGlvOiA9PlxuXHRcdHBvaW50QSA9IFV0aWxzLmNvbnZlcnRQb2ludEZyb21Db250ZXh0KHt4OjAsIHk6MH0sIEAsIHRydWUpXG5cdFx0cG9pbnRCID0gVXRpbHMuY29udmVydFBvaW50RnJvbUNvbnRleHQoe3g6MSwgeToxfSwgQCwgdHJ1ZSlcblx0XHR4RGlzdCA9IE1hdGguYWJzKHBvaW50QS54IC0gcG9pbnRCLngpXG5cdFx0eURpc3QgPSBNYXRoLmFicyhwb2ludEEueSAtIHBvaW50Qi55KVxuXHRcdHJldHVybiB7eDp4RGlzdCwgeTp5RGlzdH1cblxuXHRzZXR1cFBhbjogKGVuYWJsZWQpID0+XG5cblx0XHRAcGFubmluZyA9IGVuYWJsZWRcblx0XHRAZGVza3RvcFBhbigwLCAwKVxuXG5cdFx0QG9uTW91c2VEb3duID0+IEBhbmltYXRlU3RvcCgpXG5cblx0XHRAb25QYW4gKGRhdGEpID0+XG5cdFx0XHRyZXR1cm4gaWYgbm90IEBwYW5uaW5nXG5cdFx0XHRyYXRpbyA9IEBfY2FudmFzVG9Db21wb25lbnRSYXRpbygpXG5cdFx0XHRkZWx0YVggPSBkYXRhLmRlbHRhWCAqIHJhdGlvLnhcblx0XHRcdGRlbHRhWSA9IGRhdGEuZGVsdGFZICogcmF0aW8ueVxuXHRcdFx0c3RyZW5ndGggPSBVdGlscy5tb2R1bGF0ZShAcGVyc3BlY3RpdmUsIFsxMjAwLCA5MDBdLCBbMjIsIDE3LjVdKVxuXG5cdFx0XHRpZiBVdGlscy5pc01vYmlsZSgpXG5cdFx0XHRcdEBfaGVhZGluZ09mZnNldCAtPSAoZGVsdGFYIC8gc3RyZW5ndGgpIGlmIEBtb2JpbGVQYW5uaW5nXG5cdFx0XHRlbHNlXG5cdFx0XHRcdEBkZXNrdG9wUGFuKGRlbHRhWCAvIHN0cmVuZ3RoLCBkZWx0YVkgLyBzdHJlbmd0aClcblxuXHRcdFx0QF9wcmV2VmVsb1ggPSBkYXRhLnZlbG9jaXR5WFxuXHRcdFx0QF9wcmV2VmVsb1UgPSBkYXRhLnZlbG9jaXR5WVxuXG5cdFx0QG9uUGFuRW5kIChkYXRhKSA9PlxuXHRcdFx0cmV0dXJuIGlmIG5vdCBAcGFubmluZyBvciBVdGlscy5pc01vYmlsZSgpXG5cdFx0XHRyYXRpbyA9IEBfY2FudmFzVG9Db21wb25lbnRSYXRpbygpXG5cdFx0XHR2ZWxvY2l0eVggPSAoZGF0YS52ZWxvY2l0eVggKyBAX3ByZXZWZWxvWCkgKiAwLjVcblx0XHRcdHZlbG9jaXR5WSA9IChkYXRhLnZlbG9jaXR5WSArIEBfcHJldlZlbG9ZKSAqIDAuNVxuXHRcdFx0dmVsb2NpdHlYICo9IHZlbG9jaXR5WFxuXHRcdFx0dmVsb2NpdHlZICo9IHZlbG9jaXR5WVxuXHRcdFx0dmVsb2NpdHlYICo9IHJhdGlvLnhcblx0XHRcdHZlbG9jaXR5WSAqPSByYXRpby55XG5cdFx0XHRzdHJlbmd0aCA9IFV0aWxzLm1vZHVsYXRlKEBwZXJzcGVjdGl2ZSwgWzEyMDAsIDkwMF0sIFsyMiwgMTcuNV0pXG5cblx0XHRcdEBhbmltYXRlXG5cdFx0XHRcdGhlYWRpbmc6IEBoZWFkaW5nIC0gKGRhdGEudmVsb2NpdHlYICogcmF0aW8ueCAqIDIwMCkgLyBzdHJlbmd0aFxuXHRcdFx0XHRlbGV2YXRpb246IEBlbGV2YXRpb24gKyAoZGF0YS52ZWxvY2l0eVkgKiByYXRpby55ICogMjAwKSAvIHN0cmVuZ3RoXG5cdFx0XHRcdG9wdGlvbnM6IGN1cnZlOiBcInNwcmluZygzMDAsMTAwKVwiXG5cblx0ZGVza3RvcFBhbjogKGRlbHRhRGlyLCBkZWx0YUhlaWdodCkgLT5cblx0XHRoYWxmQ3ViZVNpZGUgPSBAY3ViZVNpZGUvMlxuXHRcdHRyYW5zbGF0aW9uWCA9IFwidHJhbnNsYXRlWCgjeygoQHdpZHRoIC8gMikgLSBoYWxmQ3ViZVNpZGUpICogRnJhbWVyLkN1cnJlbnRDb250ZXh0LnBpeGVsTXVsdGlwbGllcn1weClcIlxuXHRcdHRyYW5zbGF0aW9uWSA9IFwiIHRyYW5zbGF0ZVkoI3soKEBoZWlnaHQgLyAyKSAtIGhhbGZDdWJlU2lkZSkgKiBGcmFtZXIuQ3VycmVudENvbnRleHQucGl4ZWxNdWx0aXBsaWVyfXB4KVwiXG5cdFx0dHJhbnNsYXRpb25aID0gXCIgdHJhbnNsYXRlWigje0BwZXJzcGVjdGl2ZSAqIEZyYW1lci5DdXJyZW50Q29udGV4dC5waXhlbE11bHRpcGxpZXJ9cHgpXCJcblx0XHRAX2hlYWRpbmcgLT0gZGVsdGFEaXJcblxuXHRcdGlmIEBfaGVhZGluZyA+IDM2MFxuXHRcdFx0QF9oZWFkaW5nIC09IDM2MFxuXHRcdGVsc2UgaWYgQF9oZWFkaW5nIDwgMFxuXHRcdFx0QF9oZWFkaW5nICs9IDM2MFxuXG5cdFx0QF9lbGV2YXRpb24gKz0gZGVsdGFIZWlnaHRcblx0XHRAX2VsZXZhdGlvbiA9IFV0aWxzLmNsYW1wKEBfZWxldmF0aW9uLCAtOTAsIDkwKVxuXG5cdFx0cm90YXRpb24gPSB0cmFuc2xhdGlvblogKyB0cmFuc2xhdGlvblggKyB0cmFuc2xhdGlvblkgKyBcIiByb3RhdGVYKCN7QF9lbGV2YXRpb24gKyA5MH1kZWcpIHJvdGF0ZVooI3szNjAgLSBAX2hlYWRpbmd9ZGVnKVwiICsgXCIgcm90YXRlWigjey1AX2hlYWRpbmdPZmZzZXR9ZGVnKVwiXG5cdFx0QHdvcmxkLnN0eWxlW1wid2Via2l0VHJhbnNmb3JtXCJdID0gcm90YXRpb25cblxuXHRcdEBfZW1pdE9yaWVudGF0aW9uRGlkQ2hhbmdlRXZlbnQoKVxuXG5cdGxvb2tBdDogKGhlYWRpbmcsIGVsZXZhdGlvbikgLT5cblx0XHRoYWxmQ3ViZVNpZGUgPSBAY3ViZVNpZGUvMlxuXHRcdHRyYW5zbGF0aW9uWCA9IFwidHJhbnNsYXRlWCgjeygoQHdpZHRoIC8gMikgLSBoYWxmQ3ViZVNpZGUpICogRnJhbWVyLkN1cnJlbnRDb250ZXh0LnBpeGVsTXVsdGlwbGllcn1weClcIlxuXHRcdHRyYW5zbGF0aW9uWSA9IFwiIHRyYW5zbGF0ZVkoI3soKEBoZWlnaHQgLyAyKSAtIGhhbGZDdWJlU2lkZSkgKiBGcmFtZXIuQ3VycmVudENvbnRleHQucGl4ZWxNdWx0aXBsaWVyfXB4KVwiXG5cdFx0dHJhbnNsYXRpb25aID0gXCIgdHJhbnNsYXRlWigje0BwZXJzcGVjdGl2ZSAqIEZyYW1lci5DdXJyZW50Q29udGV4dC5waXhlbE11bHRpcGxpZXJ9cHgpXCJcblx0XHRyb3RhdGlvbiA9IHRyYW5zbGF0aW9uWiArIHRyYW5zbGF0aW9uWCArIHRyYW5zbGF0aW9uWSArIFwiIHJvdGF0ZVooI3tAX3RpbHR9ZGVnKSByb3RhdGVYKCN7ZWxldmF0aW9uICsgOTB9ZGVnKSByb3RhdGVaKCN7LWhlYWRpbmd9ZGVnKVwiXG5cblx0XHRAd29ybGQ/LnN0eWxlW1wid2Via2l0VHJhbnNmb3JtXCJdID0gcm90YXRpb25cblx0XHRAX2hlYWRpbmcgPSBoZWFkaW5nXG5cdFx0QF9lbGV2YXRpb24gPSBlbGV2YXRpb25cblx0XHRAX2hlYWRpbmdPZmZzZXQgPSBAX2hlYWRpbmcgLSBAX2RldmljZUhlYWRpbmcgaWYgVXRpbHMuaXNNb2JpbGUoKVxuXHRcdEBfZWxldmF0aW9uT2Zmc2V0ID0gQF9lbGV2YXRpb24gLSBAX2RldmljZUVsZXZhdGlvblxuXG5cdFx0aGVhZGluZyA9IEBfaGVhZGluZ1xuXHRcdGlmIGhlYWRpbmcgPCAwXG5cdFx0XHRoZWFkaW5nICs9IDM2MFxuXHRcdGVsc2UgaWYgaGVhZGluZyA+IDM2MFxuXHRcdFx0aGVhZGluZyAtPSAzNjBcblxuXHRcdEBfZW1pdE9yaWVudGF0aW9uRGlkQ2hhbmdlRXZlbnQoKVxuXG5cdF9lbWl0T3JpZW50YXRpb25EaWRDaGFuZ2VFdmVudDogPT5cblx0XHRAZW1pdChFdmVudHMuT3JpZW50YXRpb25EaWRDaGFuZ2UsIHtoZWFkaW5nOiBAaGVhZGluZywgZWxldmF0aW9uOiBAZWxldmF0aW9uLCB0aWx0OiBAdGlsdH0pXG5cblx0IyBldmVudCBzaG9ydGN1dHNcblxuXHRvbk9yaWVudGF0aW9uQ2hhbmdlOihjYikgLT4gQG9uKEV2ZW50cy5PcmllbnRhdGlvbkRpZENoYW5nZSwgY2IpXG4iLCIoZnVuY3Rpb24gZSh0LG4scil7ZnVuY3Rpb24gcyhvLHUpe2lmKCFuW29dKXtpZighdFtvXSl7dmFyIGE9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtpZighdSYmYSlyZXR1cm4gYShvLCEwKTtpZihpKXJldHVybiBpKG8sITApO3ZhciBmPW5ldyBFcnJvcihcIkNhbm5vdCBmaW5kIG1vZHVsZSAnXCIrbytcIidcIik7dGhyb3cgZi5jb2RlPVwiTU9EVUxFX05PVF9GT1VORFwiLGZ9dmFyIGw9bltvXT17ZXhwb3J0czp7fX07dFtvXVswXS5jYWxsKGwuZXhwb3J0cyxmdW5jdGlvbihlKXt2YXIgbj10W29dWzFdW2VdO3JldHVybiBzKG4/bjplKX0sbCxsLmV4cG9ydHMsZSx0LG4scil9cmV0dXJuIG5bb10uZXhwb3J0c312YXIgaT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2Zvcih2YXIgbz0wO288ci5sZW5ndGg7bysrKXMocltvXSk7cmV0dXJuIHN9KSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUVBQTtBREFB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
