(function(scope) {var mainScreen = new Layer({"name":"mainScreen","backgroundColor":"#161823","width":375,"height":812,"constraintValues":{"height":812,"heightFactor":1,"width":375,"widthFactor":1},"blending":"normal","clip":true,"borderStyle":"solid"});var videoC = new Layer({"parent":mainScreen,"name":"videoC","backgroundColor":null,"width":375,"height":729,"constraintValues":{"height":729,"centerAnchorX":0.5,"width":375,"bottom":-1375,"right":0,"top":null,"centerAnchorY":2.2444581280788176},"blending":"normal","clip":false,"borderStyle":"solid","y":1458});var videoCMask = new Layer({"parent":videoC,"name":"videoCMask","backgroundSize":"fill","backgroundColor":null,"width":375,"height":174,"constraintValues":{"height":174,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.11934156378600823,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/wIe6eMbc8zazfpkssYyjb3Do3VcN3qXJ96gSzehGO06HRuYpKFSf5XdyrL7vCiowEBD43QoeQ9VNByPCQ.png","clip":false,"borderStyle":"solid"});var __layer_0__ = new Layer({"parent":videoC,"name":"videoCStruct","backgroundSize":"fill","backgroundColor":null,"width":375,"height":361,"constraintValues":{"aspectRatioLocked":true,"height":361,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"top":null,"centerAnchorY":0.75240054869684503},"blending":"normal","image":"images\/design\/XQKFSyQVJWDDGE83cNVXjxgdulOm4gqeAyuNXTQqoa0GPDMjixjhp8I1wZQAXzRGfQCD4Obq0ZoOdluGG5oIw.png","clip":false,"borderStyle":"solid","y":368});var videoB = new Layer({"parent":mainScreen,"name":"videoB","backgroundColor":null,"width":375,"height":729,"constraintValues":{"height":729,"centerAnchorX":0.5,"width":375,"bottom":-646,"right":0,"top":null,"centerAnchorY":1.3466748768472907},"blending":"normal","clip":false,"borderStyle":"solid","y":729});var videoBMask = new Layer({"parent":videoB,"name":"videoBMask","backgroundSize":"fill","backgroundColor":null,"width":375,"height":174,"constraintValues":{"height":174,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.11934156378600823,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/wIe6eMbc8zazfpkssYyjb3Do3VcN3qXJ96gSzehGO06HRuYpKFSf5XdyrL7vCiowEBD43QoeQ9VNByPCQ.png","clip":false,"borderStyle":"solid"});var videoBStruct = new Layer({"parent":videoB,"name":"videoBStruct","backgroundSize":"fill","backgroundColor":null,"width":375,"height":361,"constraintValues":{"aspectRatioLocked":true,"height":361,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"top":null,"centerAnchorY":0.75240054869684503},"blending":"normal","image":"images\/design\/XQKFSyQVJWDDGE83cNVXjxgdulOm4gqeAyuNXTQqoa0GPDMjixjhp8I1wZQAXzRGfQCD4Obq0ZoOdluGG5oIw.png","clip":false,"borderStyle":"solid","y":368});var blockShadow = new Layer({"parent":videoB,"name":"blockShadow","backgroundSize":"fill","backgroundColor":null,"width":375,"height":114,"constraintValues":{"aspectRatioLocked":true,"height":114,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"top":null,"centerAnchorY":0.92181069958847739},"blending":"normal","image":"images\/design\/PX1LAgWseaAVlmrbqnBNme3OXE3Qj97v0Hf9uowFOdybtdJxthbmeO6leOqDfqrq91NFgO4C1ifGj3qnzqw.png","clip":false,"borderStyle":"solid","y":615});var block = new Layer({"parent":videoB,"backgroundBlur":20,"name":"block","backgroundColor":"rgba(255, 255, 255, 0.9)","width":343,"x":16,"height":78,"constraintValues":{"left":16,"height":78,"centerAnchorX":0.5,"width":343,"bottom":16,"right":16,"top":null,"centerAnchorY":0.92455418381344312},"blending":"normal","borderRadius":8,"clip":false,"borderStyle":"solid","y":635});var __layer_1__ = new TextLayer({"parent":block,"backgroundColor":null,"width":97,"x":18,"styledText":{"blocks":[{"inlineStyles":[{"css":{"fontSize":"16px","WebkitTextFillColor":"#161823","whiteSpace":"pre","fontWeight":500,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Medium\", \"SF UI Text\", sans-serif","lineHeight":"1.2"},"startIndex":0,"endIndex":6}],"text":"上次看到这里"}]},"height":19,"constraintValues":{"left":18,"height":19,"centerAnchorX":0.19387755102040816,"width":97,"top":19,"centerAnchorY":0.36538461538461536},"blending":"normal","autoSize":true,"y":19});var __layer_2__ = new TextLayer({"parent":block,"backgroundColor":null,"width":92,"x":18,"styledText":{"blocks":[{"inlineStyles":[{"css":{"fontSize":"13px","WebkitTextFillColor":"hsla(231, 23%, 11%, 0.5)","whiteSpace":"pre","fontWeight":400,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Regular\", \"SF UI Text\", sans-serif","lineHeight":"1"},"startIndex":0,"endIndex":7}],"text":"下面为历史内容"}]},"height":13,"constraintValues":{"left":18,"height":13,"centerAnchorX":0.18658892128279883,"width":92,"bottom":20,"top":null,"centerAnchorY":0.66025641025641024},"blending":"normal","autoSize":true,"y":45});var cancel = new Layer({"parent":block,"name":"cancel","backgroundColor":null,"width":24,"x":309,"height":24,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":24,"centerAnchorX":0.93586005830903785,"width":24,"right":10,"top":null,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid","y":27});var __layer_3__ = new Layer({"parent":cancel,"backgroundSize":"fill","backgroundColor":null,"width":8,"x":8,"height":8,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":8,"centerAnchorX":0.5,"width":8,"top":null,"centerAnchorY":0.5},"blending":"normal","image":"images\/design\/U4D3BF2oPGV7TXtAqs5nzxumYhQdmSnXOblPzCqCjaCdPF4vAhDuSXfN7sqG4FQ1ynYidQTJOAoVqk8kLYmQ.png","clip":false,"borderStyle":"solid","y":8});var __layer_4__ = new Layer({"parent":block,"name":"jumpButton","borderWidth":0.5,"backgroundColor":null,"width":88,"x":211,"borderColor":"hsla(231, 23%, 11%, 0.34)","height":32,"constraintValues":{"left":null,"height":32,"centerAnchorX":0.7434402332361516,"width":88,"right":44,"top":null,"centerAnchorY":0.5},"blending":"normal","borderRadius":2,"clip":false,"borderStyle":"solid","y":23});var __layer_5__ = new TextLayer({"parent":__layer_4__,"backgroundColor":null,"width":53,"x":17,"styledText":{"blocks":[{"inlineStyles":[{"css":{"fontSize":"13px","WebkitTextFillColor":"#161823","whiteSpace":"pre","fontWeight":500,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Medium\", \"SF UI Text\", sans-serif","lineHeight":"1.3"},"startIndex":0,"endIndex":4}],"text":"去看推荐"}],"alignment":"center"},"height":16,"constraintValues":{"left":17,"height":16,"centerAnchorX":0.49431818181818182,"width":53,"top":null,"centerAnchorY":0.484375},"blending":"normal","autoSize":true,"y":8});var videoA = new Layer({"parent":mainScreen,"name":"videoA","backgroundColor":null,"width":375,"height":729,"constraintValues":{"height":729,"centerAnchorX":0.5,"width":375,"bottom":83,"right":0,"centerAnchorY":0.44889162561576357},"blending":"normal","clip":false,"borderStyle":"solid"});var videoAMask = new Layer({"parent":videoA,"name":"videoAMask","backgroundSize":"fill","backgroundColor":null,"width":375,"height":174,"constraintValues":{"height":174,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.11934156378600823,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/wIe6eMbc8zazfpkssYyjb3Do3VcN3qXJ96gSzehGO06HRuYpKFSf5XdyrL7vCiowEBD43QoeQ9VNByPCQ.png","clip":false,"borderStyle":"solid"});var __layer_6__ = new Layer({"parent":videoA,"name":"videoAStruct","backgroundSize":"fill","backgroundColor":null,"width":375,"height":361,"constraintValues":{"aspectRatioLocked":true,"height":361,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"top":null,"centerAnchorY":0.75240054869684503},"blending":"normal","image":"images\/design\/XQKFSyQVJWDDGE83cNVXjxgdulOm4gqeAyuNXTQqoa0GPDMjixjhp8I1wZQAXzRGfQCD4Obq0ZoOdluGG5oIw.png","clip":false,"borderStyle":"solid","y":368});var head = new Layer({"parent":mainScreen,"name":"head","backgroundSize":"fill","backgroundColor":null,"width":375,"height":89,"constraintValues":{"height":89,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.054802955665024633,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/GHeNxBYyMN9qMVyIgkSM00PFc2NAFUKnj5whShmoGaXElKzfgZXMGWGx26Qtfd64N5bbQ6GzlF0mSGlENcQ.png","clip":false,"borderStyle":"solid"});var __layer_7__ = new Layer({"parent":mainScreen,"name":"bottom","backgroundColor":"#161823","width":375,"height":83,"constraintValues":{"height":83,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"top":null,"centerAnchorY":0.94889162561576357},"blending":"normal","clip":false,"borderStyle":"solid","y":729});var __layer_8__ = new Layer({"parent":__layer_7__,"name":"im","backgroundSize":"fill","backgroundColor":null,"width":375,"height":50,"constraintValues":{"height":50,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.30120481927710846,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/tq2gDLOwH4xaPv3ZMGUjunmyI4DiNgDApLBGdglV8l1b2s9QTnem69Y2lQBWAmyfxejdLstVHx45iJA.png","clip":false,"borderStyle":"solid"});var refresh = new Layer({"parent":__layer_7__,"name":"refresh","backgroundSize":"fill","backgroundColor":null,"width":26,"x":22,"height":26,"constraintValues":{"left":22,"aspectRatioLocked":true,"height":26,"centerAnchorX":0.093333333333333338,"width":26,"top":12,"centerAnchorY":0.30120481927710846},"blending":"normal","image":"images\/design\/SoYaXn9grTUGhWdyQ1IOULvGFhDwzuOFyE7wzCPKuXduwaj2OBpAAvdCHUuwb2UVEYwaaow7XZZU2d43sRVg.png","clip":false,"borderStyle":"solid","y":12});var tabText = new Layer({"parent":__layer_7__,"name":"tabText","backgroundSize":"fill","backgroundColor":null,"width":32,"x":19,"height":17,"constraintValues":{"left":19,"aspectRatioLocked":true,"height":17,"centerAnchorX":0.093333333333333338,"width":32,"top":16,"centerAnchorY":0.29518072289156627},"blending":"normal","image":"images\/design\/3ac6lrQn3kDNVncduvoxAIYpLmVEpnmITSlpB3jFHuS6zVIHuAM69TR2DRHsjXjhYEXjQrxrQAlWM0bOA.png","clip":false,"borderStyle":"solid","y":16});if(refresh !== undefined){refresh.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|refresh","targetName":"refresh","vekterClass":"FrameNode"}};if(videoB !== undefined){videoB.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|videoB","targetName":"videoB","vekterClass":"FrameNode"}};if(videoC !== undefined){videoC.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|videoC","targetName":"videoC","vekterClass":"FrameNode"}};if(__layer_7__ !== undefined){__layer_7__.__framerInstanceInfo = {"hash":"#vekter|__layer_7__","vekterClass":"FrameNode","framerClass":"Layer"}};if(__layer_2__ !== undefined){__layer_2__.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|__layer_2__","vekterClass":"TextNode","text":"下面为历史内容"}};if(__layer_8__ !== undefined){__layer_8__.__framerInstanceInfo = {"hash":"#vekter|__layer_8__","vekterClass":"FrameNode","framerClass":"Layer"}};if(cancel !== undefined){cancel.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|cancel","targetName":"cancel","vekterClass":"FrameNode"}};if(tabText !== undefined){tabText.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|tabText","targetName":"tabText","vekterClass":"FrameNode"}};if(__layer_0__ !== undefined){__layer_0__.__framerInstanceInfo = {"hash":"#vekter|__layer_0__","vekterClass":"FrameNode","framerClass":"Layer"}};if(block !== undefined){block.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|block","targetName":"block","vekterClass":"FrameNode"}};if(head !== undefined){head.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|head","targetName":"head","vekterClass":"FrameNode"}};if(videoBMask !== undefined){videoBMask.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|videoBMask","targetName":"videoBMask","vekterClass":"FrameNode"}};if(videoCMask !== undefined){videoCMask.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|videoCMask","targetName":"videoCMask","vekterClass":"FrameNode"}};if(videoBStruct !== undefined){videoBStruct.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|videoBStruct","targetName":"videoBStruct","vekterClass":"FrameNode"}};if(mainScreen !== undefined){mainScreen.__framerInstanceInfo = {"deviceName":"Apple iPhone X","framerClass":"Layer","hash":"#vekter|mainScreen","targetName":"mainScreen","vekterClass":"FrameNode","deviceType":"apple-iphone-x-space-gray"}};if(__layer_1__ !== undefined){__layer_1__.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|__layer_1__","vekterClass":"TextNode","text":"上次看到这里"}};if(blockShadow !== undefined){blockShadow.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|blockShadow","targetName":"blockShadow","vekterClass":"FrameNode"}};if(__layer_4__ !== undefined){__layer_4__.__framerInstanceInfo = {"hash":"#vekter|__layer_4__","vekterClass":"FrameNode","framerClass":"Layer"}};if(videoAMask !== undefined){videoAMask.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|videoAMask","targetName":"videoAMask","vekterClass":"FrameNode"}};if(videoA !== undefined){videoA.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|videoA","targetName":"videoA","vekterClass":"FrameNode"}};if(__layer_3__ !== undefined){__layer_3__.__framerInstanceInfo = {"hash":"#vekter|__layer_3__","vekterClass":"FrameNode","framerClass":"Layer"}};if(__layer_6__ !== undefined){__layer_6__.__framerInstanceInfo = {"hash":"#vekter|__layer_6__","vekterClass":"FrameNode","framerClass":"Layer"}};if(__layer_5__ !== undefined){__layer_5__.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|__layer_5__","vekterClass":"TextNode","text":"去看推荐"}};if (scope["__vekterVariables"]) { scope["__vekterVariables"].map(function(variable) { delete scope[variable] } ) };Object.assign(scope, {mainScreen, videoC, videoCMask, videoB, videoBMask, videoBStruct, blockShadow, block, cancel, videoA, videoAMask, head, refresh, tabText});scope["__vekterVariables"] = ["mainScreen", "videoC", "videoCMask", "videoB", "videoBMask", "videoBStruct", "blockShadow", "block", "cancel", "videoA", "videoAMask", "head", "refresh", "tabText"];if (typeof Framer.CurrentContext.layout === 'function') {Framer.CurrentContext.layout()};})(window);