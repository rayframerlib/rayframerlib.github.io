(function(scope) {var mainScreen = new Layer({"name":"mainScreen","backgroundColor":"rgba(255,255,255,1)","width":375,"height":812,"constraintValues":{"height":812,"heightFactor":1,"width":375,"widthFactor":1},"blending":"normal","clip":true,"borderStyle":"solid"});var videoContainer = new Layer({"parent":mainScreen,"name":"videoContainer","backgroundColor":"rgba(255,255,255,1)","width":375,"height":729,"constraintValues":{"height":729,"centerAnchorX":0.5,"width":375,"bottom":83,"right":0,"centerAnchorY":0.44889162561576357},"blending":"normal","clip":true,"borderStyle":"solid"});var bottom = new Layer({"parent":mainScreen,"name":"bottom","backgroundSize":"fill","backgroundColor":null,"width":375,"height":83,"constraintValues":{"aspectRatioLocked":true,"height":83,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"top":null,"centerAnchorY":0.94889162561576357},"blending":"normal","image":"images\/design\/m5OP3FFByCUgQCsvDaekRCo64nXHaBaGzjVMkKEgw7fy7Xp4YeUWoXcEiD4Q4NAjiAW5nQGlljJkrjFZ0aA.png","clip":false,"borderStyle":"solid","y":729});var navi = new Layer({"parent":mainScreen,"name":" navi","backgroundSize":"fill","backgroundColor":null,"width":375,"height":108,"constraintValues":{"height":108,"centerAnchorX":0.7506666666666667,"width":375,"right":0,"centerAnchorY":0.099753694581280791,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/YXG9GVywAOkUY71VZEkIxflJZcZTXGvv8ht0AWMT9uOFTtt6uAK8G7oYMqdP8KAtpwHTw68FyUJ1CVYvq1JILw.png","clip":false,"borderStyle":"solid"});if(bottom !== undefined){bottom.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|bottom","targetName":"bottom","vekterClass":"FrameNode"}};if(navi !== undefined){navi.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|navi","targetName":"navi","vekterClass":"FrameNode"}};if(videoContainer !== undefined){videoContainer.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|videoContainer","targetName":"videoContainer","vekterClass":"FrameNode"}};if(mainScreen !== undefined){mainScreen.__framerInstanceInfo = {"deviceName":"Apple iPhone X","framerClass":"Layer","hash":"#vekter|mainScreen","targetName":"mainScreen","vekterClass":"FrameNode","deviceType":"apple-iphone-x-space-gray"}};if (scope["__vekterVariables"]) { scope["__vekterVariables"].map(function(variable) { delete scope[variable] } ) };Object.assign(scope, {mainScreen, videoContainer, bottom, navi});scope["__vekterVariables"] = ["mainScreen", "videoContainer", "bottom", "navi"];if (typeof Framer.CurrentContext.layout === 'function') {Framer.CurrentContext.layout()};})(window);