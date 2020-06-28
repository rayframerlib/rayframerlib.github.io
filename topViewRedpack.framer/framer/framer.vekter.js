(function(scope) {var mainScreen = new Layer({"name":"mainScreen","backgroundColor":"rgba(255,255,255,1)","width":375,"x":46,"height":667,"constraintValues":null,"blending":"normal","clip":true,"borderStyle":"solid","y":139});var ui = new Layer({"parent":mainScreen,"name":"ui","backgroundSize":"fill","backgroundColor":null,"width":375,"height":667,"constraintValues":{"height":667,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.5,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/DinKRpF5NKMibIr5tCB22EEaKJQGJTmTuUmpiybZbRIbyFt8sdkGZxnbLCorL9fla6ymHIYRRNgSBh3MxOanQ.png","clip":false,"borderStyle":"solid"});var jumpAD = new Layer({"parent":mainScreen,"name":"jumpAD","backgroundSize":"fill","backgroundColor":null,"width":84,"x":281,"height":24,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":24,"centerAnchorX":0.86133333333333328,"width":84,"right":10,"top":40,"centerAnchorY":0.077961019490254871},"blending":"normal","image":"images\/design\/Y3aVoYmGQTOiHkk6Fsi1m85xqwkh2Ek8aBJ39BY0SMCLMJFesXVGs4qalpXzF7U1ztN0pigZYHUQkKWnQ.png","clip":false,"borderStyle":"solid","y":40});var redPacketHold = new Layer({"parent":mainScreen,"name":"redPacketHold","backgroundSize":"fill","backgroundColor":null,"width":64,"x":12,"height":62,"constraintValues":{"left":12,"aspectRatioLocked":true,"height":62,"centerAnchorX":0.11733333333333333,"width":64,"bottom":205,"top":null,"centerAnchorY":0.64617691154422785},"blending":"normal","image":"images\/design\/RYX5ljyj3uuPuX7Vt89D8kgL4I5hw5L8rmp6FbZFF4dkVTQE7sbYd6otNmdcK6sHmMQmKA5FS75IfiCiXouVA.png","clip":false,"borderStyle":"solid","y":400});var mask = new Layer({"parent":mainScreen,"backgroundBlur":12,"name":"mask","backgroundColor":"hsla(0, 0%, 0%, 0.5)","width":375,"height":667,"constraintValues":{"height":667,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid"});var cancelIcon = new Layer({"parent":mainScreen,"name":"cancelIcon","backgroundSize":"fill","backgroundColor":null,"width":30,"x":172,"height":30,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":30,"centerAnchorX":0.49866666666666665,"width":30,"bottom":100,"top":null,"centerAnchorY":0.82758620689655171},"blending":"normal","image":"images\/design\/YUAoPu3QhMvhAQQBv0PDeRd37QjpncVfS8gRrb4a6HkLIYvJpRlLX78NP4graJDm4uaeMDbjQVSC9CgAh19MQ.png","clip":false,"borderStyle":"solid","y":537});var redPacket = new Layer({"parent":mainScreen,"name":"redPacket","backgroundColor":null,"width":300,"x":38,"height":412,"constraintValues":{"left":38,"aspectRatioLocked":true,"height":412,"centerAnchorX":0.5013333333333333,"width":300,"right":37,"top":101,"centerAnchorY":0.46026986506746626},"blending":"normal","clip":false,"borderStyle":"solid","y":101});var bg = new Layer({"parent":redPacket,"name":"bg","backgroundSize":"fill","backgroundColor":null,"width":300,"height":411,"constraintValues":{"height":411,"centerAnchorX":0.5,"width":300,"right":0,"centerAnchorY":0.49878640776699029,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/c6eeRi0seIDj7a9XJXNL3cSXNne3aVIzicPazSufXxayCzMwKCbxCMxGIJpDSwOPCLdbO3QvKADyszzivQ14g.png","clip":false,"borderStyle":"solid"});var text = new Layer({"parent":redPacket,"name":"text","backgroundSize":"fill","backgroundColor":null,"width":300,"height":411,"constraintValues":{"height":411,"centerAnchorX":0.5,"width":300,"right":0,"centerAnchorY":0.49878640776699029,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/IhYkWe3JHqEGjSTVOy2h8bhtOVkxwvwFGO8jT4e4IOfxG1LLHUB1r6qErCqhRtQ3BYCw6kj2N9K4LK4Ou3eA.png","clip":false,"borderStyle":"solid"});var packetHitArea = new Layer({"parent":redPacket,"name":"packetHitArea","backgroundColor":null,"width":108,"x":95,"height":108,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":108,"centerAnchorX":0.49666666666666665,"width":108,"bottom":59,"top":null,"centerAnchorY":0.72572815533980584},"blending":"normal","clip":false,"borderStyle":"solid","y":245});var dialog = new Layer({"parent":mainScreen,"name":"dialog","backgroundSize":"fill","backgroundColor":null,"width":280,"x":48,"height":237,"constraintValues":{"left":48,"aspectRatioLocked":true,"height":237,"centerAnchorX":0.5013333333333333,"width":280,"bottom":203,"right":47,"top":null,"centerAnchorY":0.51799100449775115},"blending":"normal","image":"images\/design\/DYIw0aXWz32WXkp56QthTJEGmYT4dPdfxd8i5lS1E6YjfM1WNbPJrEPH1FkcZK126BNqBSabmN62TrA2IQRKQ.png","clip":false,"borderStyle":"solid","y":227});var newPage = new Layer({"parent":mainScreen,"name":"newPage","backgroundColor":null,"width":375,"height":667,"constraintValues":{"height":667,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.5,"aspectRatioLocked":true},"blending":"normal","clip":false,"borderStyle":"solid"});var pageContent = new Layer({"parent":newPage,"name":"pageContent","backgroundSize":"fill","backgroundColor":null,"width":375,"height":667,"constraintValues":{"height":667,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.5,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/jLlVmKX2TA6nW6tiddIWeRU1yQp5C1hp4i8vVskYHFOuI2q2aDXI9FdLq9ctk8TPHVilCFmDx4Fyl8m7xipA.png","clip":false,"borderStyle":"solid"});var pageAnimeBottom = new Layer({"parent":newPage,"name":"pageAnimeBottom","backgroundSize":"fill","backgroundColor":null,"width":375,"height":667,"constraintValues":{"aspectRatioLocked":true,"height":667,"centerAnchorX":0.5,"width":375,"bottom":-262,"right":0,"top":null,"centerAnchorY":0.8928035982008995},"blending":"normal","image":"images\/design\/4NAeuwVn468o8Nx92rEV7TU7s3Zcf3oetKvRbnRJ22XuE7AyJ48uvtbrqwrpBCSUwxYlQhmJPnlSgAC9Eg.png","clip":false,"borderStyle":"solid","y":262});var pageAnimeTop = new Layer({"parent":newPage,"name":"pageAnimeTop","backgroundSize":"fill","backgroundColor":null,"width":375,"height":667,"constraintValues":{"height":667,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.5,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/Zho47wdXsaTA8WQODynRwfEdtkYhTqdI4SsTwcl11zs0kAKbfujIW4OWW0RwwpVUNcjIH93DrnP80Byzw.png","clip":false,"borderStyle":"solid"});var view = new Layer({"parent":mainScreen,"name":"view","backgroundSize":"fill","backgroundColor":null,"width":375,"height":811,"constraintValues":{"aspectRatioLocked":true,"height":811,"centerAnchorX":0.5,"width":375,"bottom":-84,"right":0,"top":null,"centerAnchorY":0.51799100449775115},"blending":"normal","image":"images\/design\/gryzXqSrgPGFJqEuYJvzFide7cHksR36VapPExx6s8Wf0HeoqBYHG0645rdJZpGYwIKJo26xGrLKvF6s1bw.png","clip":false,"borderStyle":"solid","y":-60});var __layer_0__ = new Layer({"parent":mainScreen,"name":"statusBar","backgroundSize":"fill","backgroundColor":null,"width":375,"height":20,"constraintValues":{"height":20,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.014992503748125937,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/CWvaBUWxUkJtfQFWxJUbKAV3g1YZRLRcLTmE6dpIqx8mjfF92TS1Qj0rz28dndUAFU8YJ4gnhecJm7NsaqbuA.png","clip":false,"borderStyle":"solid"});if(pageAnimeBottom !== undefined){pageAnimeBottom.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|pageAnimeBottom","targetName":"pageAnimeBottom","vekterClass":"FrameNode"}};if(mask !== undefined){mask.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|mask","targetName":"mask","vekterClass":"FrameNode"}};if(ui !== undefined){ui.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|ui","targetName":"ui","vekterClass":"FrameNode"}};if(pageAnimeTop !== undefined){pageAnimeTop.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|pageAnimeTop","targetName":"pageAnimeTop","vekterClass":"FrameNode"}};if(redPacket !== undefined){redPacket.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|redPacket","targetName":"redPacket","vekterClass":"FrameNode"}};if(jumpAD !== undefined){jumpAD.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|jumpAD","targetName":"jumpAD","vekterClass":"FrameNode"}};if(cancelIcon !== undefined){cancelIcon.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|cancelIcon","targetName":"cancelIcon","vekterClass":"FrameNode"}};if(__layer_0__ !== undefined){__layer_0__.__framerInstanceInfo = {"hash":"#vekter|__layer_0__","vekterClass":"FrameNode","framerClass":"Layer"}};if(dialog !== undefined){dialog.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|dialog","targetName":"dialog","vekterClass":"FrameNode"}};if(view !== undefined){view.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|view","targetName":"view","vekterClass":"FrameNode"}};if(text !== undefined){text.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|text","targetName":"text","vekterClass":"FrameNode"}};if(packetHitArea !== undefined){packetHitArea.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|packetHitArea","targetName":"packetHitArea","vekterClass":"FrameNode"}};if(mainScreen !== undefined){mainScreen.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|mainScreen","targetName":"mainScreen","vekterClass":"FrameNode"}};if(bg !== undefined){bg.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|bg","targetName":"bg","vekterClass":"FrameNode"}};if(newPage !== undefined){newPage.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|newPage","targetName":"newPage","vekterClass":"FrameNode"}};if(pageContent !== undefined){pageContent.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|pageContent","targetName":"pageContent","vekterClass":"FrameNode"}};if(redPacketHold !== undefined){redPacketHold.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|redPacketHold","targetName":"redPacketHold","vekterClass":"FrameNode"}};if (scope["__vekterVariables"]) { scope["__vekterVariables"].map(function(variable) { delete scope[variable] } ) };Object.assign(scope, {mainScreen, ui, jumpAD, redPacketHold, mask, cancelIcon, redPacket, bg, text, packetHitArea, dialog, newPage, pageContent, pageAnimeBottom, pageAnimeTop, view});scope["__vekterVariables"] = ["mainScreen", "ui", "jumpAD", "redPacketHold", "mask", "cancelIcon", "redPacket", "bg", "text", "packetHitArea", "dialog", "newPage", "pageContent", "pageAnimeBottom", "pageAnimeTop", "view"];if (typeof Framer.CurrentContext.layout === 'function') {Framer.CurrentContext.layout()};})(window);