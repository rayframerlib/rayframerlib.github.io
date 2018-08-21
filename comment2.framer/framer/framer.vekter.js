(function(scope) {var mainScreen = new Layer({"name":"mainScreen","backgroundColor":"#eeeeee","width":375,"height":667,"constraintValues":{"height":667,"heightFactor":1,"width":375,"widthFactor":1},"blending":"normal","clip":true,"borderStyle":"solid"});var content = new Layer({"parent":mainScreen,"name":"content","backgroundSize":"fill","backgroundColor":null,"width":375,"height":1352,"constraintValues":{"aspectRatioLocked":true,"height":1352,"centerAnchorX":0.5,"width":375,"bottom":-760,"right":0,"top":null,"centerAnchorY":1.1259370314842578},"blending":"normal","image":"images\/design\/l40BrzwEiH8YQaQ3astSS6Q53ePHJC5Cbx6vA6cGHOSi8nObQ3mYLe5pMnoeofeUIh8LO1HiJxiiZsElhzGw.png","clip":true,"borderStyle":"solid","y":75});var buttonArea = new Layer({"parent":content,"name":"buttonArea","backgroundColor":null,"width":300,"x":64,"height":56,"constraintValues":{"left":64,"height":56,"centerAnchorX":0.57066666666666666,"width":300,"bottom":357,"right":11,"top":null,"centerAnchorY":0.71523668639053251},"blending":"normal","clip":false,"borderStyle":"solid","y":939});var header = new Layer({"parent":mainScreen,"name":"header","backgroundSize":"fill","backgroundColor":null,"width":375,"height":65,"constraintValues":{"height":65,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.048725637181409293,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/KU2zAjOkzSWb006xyFjn33JuaqVR1iTBHJLIauyHJGC7yh23XEPiUb3C8aUeUV1qW5ZZQOwCs9DcQE4X7txQ.png","clip":true,"borderStyle":"solid"});var footer = new Layer({"parent":mainScreen,"name":"footer","backgroundSize":"fill","backgroundColor":null,"width":375,"height":45,"constraintValues":{"aspectRatioLocked":true,"height":45,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"top":null,"centerAnchorY":0.96626686656671668},"blending":"normal","image":"images\/design\/uFx14U1lryjM3b0RfiH8F6evAWjuPEIEJLNYduMfvT2BKteUXJKm1Bo2DrG26yzQ2vsUlj4O2of5wjh41A.png","clip":true,"borderStyle":"solid","y":622});var mask = new Layer({"parent":mainScreen,"name":"mask","backgroundColor":"rgba(0, 0, 0, 0.1)","width":375,"height":676,"constraintValues":{"height":676,"centerAnchorX":0.5,"width":375,"bottom":-9,"right":0,"centerAnchorY":0.50674662668665671},"blending":"normal","clip":true,"borderStyle":"solid"});var secondGroup = new Layer({"parent":mainScreen,"name":"secondGroup","backgroundColor":"rgba(0, 170, 255, 0)","width":375,"height":667,"constraintValues":{"height":667,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid"});var secondLevel = new Layer({"parent":secondGroup,"name":"secondLevel","borderWidth":0.5,"backgroundColor":"rgb(255, 255, 255)","width":375,"borderColor":"#eeeeee","height":995,"constraintValues":{"height":995,"centerAnchorX":0.5,"width":375,"bottom":-393,"right":0,"top":65,"centerAnchorY":0.843328335832084},"borderRadius":{"bottomLeft":0,"topLeft":20,"bottomRight":0,"topRight":20},"blending":"normal","clip":false,"borderStyle":"solid","y":65});var sContent = new Layer({"parent":secondLevel,"name":"sContent","backgroundSize":"fill","backgroundColor":null,"width":375,"height":974,"constraintValues":{"aspectRatioLocked":true,"height":974,"centerAnchorX":0.5,"width":375,"bottom":1,"right":0,"top":null,"centerAnchorY":0.50954773869346737},"blending":"normal","image":"images\/design\/g7lt0Q8Y3U5iEZ57AxFyCyYV1AmGta8Xz1pgY7Uzw2AHXuhtf5jQHL1tUWrndlkimXaahSXZKHXDfQnkiJDQ.png","clip":true,"borderStyle":"solid","y":20});var secondLevelHandler = new Layer({"parent":secondLevel,"name":"secondLevelHandler","backgroundColor":"rgb(255, 255, 255)","width":375,"height":20,"constraintValues":{"height":20,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.016611295681063124},"borderRadius":{"bottomLeft":0,"topLeft":20,"bottomRight":0,"topRight":20},"blending":"normal","clip":false,"borderStyle":"solid"});var __layer_0__ = new SVGLayer({"parent":secondLevelHandler,"name":".SVGLayer","backgroundColor":"#CCC","width":41,"strokeWidth":1,"x":167,"htmlIntrinsicSize":{"height":6,"width":41},"rotation":null,"height":6,"fill":"#CCC","borderRadius":10,"opacity":null,"y":7,"svg":"<svg xmlns=\"http:\/\/www.w3.org\/2000\/svg\" width=\"41\" height=\"6\"><path d=\"M 0 3 C 0 1.343 1.343 0 3 0 L 38 0 C 39.657 0 41 1.343 41 3 L 41 3 C 41 4.657 39.657 6 38 6 L 3 6 C 1.343 6 0 4.657 0 3 Z\" name=\"Rectangle\"><\/path><\/svg>"});var __layer_1__ = new Layer({"parent":secondLevel,"name":"commentButton","shadows":[{"spread":0,"x":0,"type":"drop","y":2,"blur":3,"color":"rgba(0,0,0,0.25)"}],"backgroundSize":"fill","backgroundColor":null,"width":374,"height":45,"constraintValues":{"aspectRatioLocked":true,"height":45,"centerAnchorX":0.49866666666666665,"width":374,"bottom":393,"right":1,"top":null,"centerAnchorY":0.58241206030150749},"blending":"normal","image":"images\/design\/pwdzqWGvg7H4v7lw8bKBMZM83AsRrdpRspEvz5unmr17JkPBFcmlVH55g5E61h6qSfPt5Fu3QIn2ULJQ.png","clip":true,"borderStyle":"solid","y":557});var secondLevelDelegate = new Layer({"parent":secondGroup,"name":"secondLevelDelegate","backgroundColor":"rgba(255, 255, 255, 0)","width":375,"height":995,"constraintValues":{"height":995,"centerAnchorX":0.5,"width":375,"bottom":-393,"right":0,"top":65,"centerAnchorY":0.843328335832084},"borderRadius":{"bottomLeft":0,"topLeft":20,"bottomRight":0,"topRight":20},"blending":"normal","clip":false,"borderStyle":"solid","y":65});var dragDelegate = new Layer({"parent":secondLevelDelegate,"name":"dragDelegate","backgroundColor":"rgba(255, 0, 0, 0)","width":375,"height":994,"constraintValues":{"height":994,"centerAnchorX":0.5,"width":375,"bottom":1,"right":0,"centerAnchorY":0.49949748743718592},"blending":"normal","clip":true,"borderStyle":"solid"});var handlerDelegate = new Layer({"parent":secondLevelDelegate,"name":"handlerDelegate","backgroundColor":"rgba(255, 0, 0, 0)","width":375,"height":20,"constraintValues":{"height":20,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.010050251256281407},"borderRadius":{"bottomLeft":0,"topLeft":20,"bottomRight":0,"topRight":20},"blending":"normal","clip":false,"borderStyle":"solid"});if(secondLevel !== undefined){secondLevel.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|secondLevel","targetName":"secondLevel","vekterClass":"FrameNode"}};if(mask !== undefined){mask.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|mask","targetName":"mask","vekterClass":"FrameNode"}};if(dragDelegate !== undefined){dragDelegate.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|dragDelegate","targetName":"dragDelegate","vekterClass":"FrameNode"}};if(__layer_0__ !== undefined){__layer_0__.__framerInstanceInfo = {"hash":"#vekter|__layer_0__","vekterClass":"RectangleShapeNode","framerClass":"SVGLayer"}};if(header !== undefined){header.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|header","targetName":"header","vekterClass":"FrameNode"}};if(buttonArea !== undefined){buttonArea.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|buttonArea","targetName":"buttonArea","vekterClass":"FrameNode"}};if(content !== undefined){content.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|content","targetName":"content","vekterClass":"FrameNode"}};if(secondLevelHandler !== undefined){secondLevelHandler.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|secondLevelHandler","targetName":"secondLevelHandler","vekterClass":"FrameNode"}};if(mainScreen !== undefined){mainScreen.__framerInstanceInfo = {"deviceName":"Apple iPhone 8","framerClass":"Layer","hash":"#vekter|mainScreen","targetName":"mainScreen","vekterClass":"FrameNode","deviceType":"apple-iphone-8-space-gray"}};if(sContent !== undefined){sContent.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|sContent","targetName":"sContent","vekterClass":"FrameNode"}};if(__layer_1__ !== undefined){__layer_1__.__framerInstanceInfo = {"hash":"#vekter|__layer_1__","vekterClass":"FrameNode","framerClass":"Layer"}};if(secondGroup !== undefined){secondGroup.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|secondGroup","targetName":"secondGroup","vekterClass":"FrameNode"}};if(footer !== undefined){footer.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|footer","targetName":"footer","vekterClass":"FrameNode"}};if(secondLevelDelegate !== undefined){secondLevelDelegate.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|secondLevelDelegate","targetName":"secondLevelDelegate","vekterClass":"FrameNode"}};if(handlerDelegate !== undefined){handlerDelegate.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|handlerDelegate","targetName":"handlerDelegate","vekterClass":"FrameNode"}};if (scope["__vekterVariables"]) { scope["__vekterVariables"].map(function(variable) { delete scope[variable] } ) };Object.assign(scope, {mainScreen, content, buttonArea, header, footer, mask, secondGroup, secondLevel, sContent, secondLevelHandler, secondLevelDelegate, dragDelegate, handlerDelegate});scope["__vekterVariables"] = ["mainScreen", "content", "buttonArea", "header", "footer", "mask", "secondGroup", "secondLevel", "sContent", "secondLevelHandler", "secondLevelDelegate", "dragDelegate", "handlerDelegate"];if (typeof Framer.CurrentContext.layout === 'function') {Framer.CurrentContext.layout()};})(window);