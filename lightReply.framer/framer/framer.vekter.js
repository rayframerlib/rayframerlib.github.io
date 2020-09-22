(function(scope) {var mainScreen = new Layer({"name":"mainScreen","backgroundColor":"#161823","width":375,"height":812,"constraintValues":{"height":812,"heightFactor":1,"width":375,"widthFactor":1},"blending":"normal","clip":true,"borderStyle":"solid"});var flowWraper = new Layer({"parent":mainScreen,"name":"flowWraper","backgroundColor":null,"width":375,"height":812,"constraintValues":{"height":812,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"centerAnchorY":0.5},"blending":"normal","clip":true,"borderStyle":"solid"});var imFlow = new Layer({"parent":flowWraper,"name":"imFlow","backgroundColor":null,"width":375,"height":626,"constraintValues":{"height":626,"centerAnchorX":0.5,"width":375,"bottom":98,"right":0,"top":88,"centerAnchorY":0.49384236453201968},"blending":"normal","clip":false,"borderStyle":"solid","y":88});var navigationBar = new Layer({"parent":mainScreen,"backgroundBlur":12,"name":"navigationBar","shadows":[{"spread":0,"x":0,"type":"inset","y":-0.5,"blur":0,"color":"hsla(0, 0%, 100%, 0.12)"}],"backgroundColor":"rgba(22, 24, 35, 0.9)","width":375,"height":88,"constraintValues":{"height":88,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.054187192118226604},"blending":"normal","clip":false,"borderStyle":"solid"});var __layer_0__ = new Layer({"parent":navigationBar,"backgroundSize":"fill","backgroundColor":null,"width":375,"height":44,"constraintValues":{"height":44,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.25,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/auIv3qqA9rhgIWg8XXT1XyHgEklZbb9HKFxbX9QyBsCwHBF0bLJO23VcH6l8mGBMpElkEWRVvzvNJZQ.png","clip":false,"borderStyle":"solid"});var __layer_1__ = new Layer({"parent":navigationBar,"backgroundSize":"fill","backgroundColor":null,"width":375,"height":44,"constraintValues":{"aspectRatioLocked":true,"height":44,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"top":null,"centerAnchorY":0.75},"blending":"normal","image":"images\/design\/DfPmednCLbGKEAo8WN3XeH0CGRrh8pjz0eHmH2R6orSbp6HPztECG0qGujUq6LccdOBj9fFyYgWNhf2tiiXTQ.png","clip":false,"borderStyle":"solid","y":44});var bottomBar = new Layer({"parent":mainScreen,"backgroundBlur":12,"name":"bottomBar","shadows":[{"spread":0,"x":0,"type":"inset","y":0.5,"blur":0,"color":"hsla(0, 0%, 100%, 0.12)"}],"backgroundColor":"rgba(22, 24, 35, 0.9)","width":375,"height":98,"constraintValues":{"height":98,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"top":null,"centerAnchorY":0.93965517241379315},"blending":"normal","clip":false,"borderStyle":"solid","y":714});var bottomBarHitArea = new Layer({"parent":bottomBar,"name":"bottomBarHitArea","backgroundColor":null,"width":375,"height":98,"constraintValues":{"height":98,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid"});var lightBar = new Layer({"parent":bottomBar,"name":"lightBar","backgroundSize":"fill","backgroundColor":null,"width":311,"x":12,"height":44,"constraintValues":{"left":12,"aspectRatioLocked":true,"height":44,"centerAnchorX":0.44666666666666666,"width":311,"right":52,"top":10,"centerAnchorY":0.32653061224489793},"blending":"normal","image":"images\/design\/wCe0jXUrpnWNwzyPHTNHLMhmkfwmksqcepDwRHUTORL49okVsrHrTj6HEZgqGJHuJ7Y9FMgFpfVm8QScw.png","opacity":0,"clip":false,"borderStyle":"solid","y":10});var darkBar = new Layer({"parent":bottomBar,"name":"darkBar","backgroundSize":"fill","backgroundColor":null,"width":311,"x":12,"height":44,"constraintValues":{"left":12,"aspectRatioLocked":true,"height":44,"centerAnchorX":0.44666666666666666,"width":311,"right":52,"top":10,"centerAnchorY":0.32653061224489793},"blending":"normal","image":"images\/design\/nuzpROuv1SwAYewcY1djXVlqc5hZSbp8XBTLefEtzmmmikS7xLCcHpNxVICmAoi47yNPSG0me4aJCcTyk9Kw.png","clip":false,"borderStyle":"solid","y":10});var heartButton = new Layer({"parent":bottomBar,"name":"heartButton","backgroundColor":null,"width":28,"x":335,"height":28,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":28,"centerAnchorX":0.93066666666666664,"width":28,"right":12,"top":18,"centerAnchorY":0.32653061224489793},"blending":"normal","clip":false,"borderStyle":"solid","y":18});var heartButtonCore = new Layer({"parent":heartButton,"name":"heartButtonCore","backgroundSize":"fill","backgroundColor":null,"width":28,"height":28,"constraintValues":{"height":28,"centerAnchorX":0.5,"width":28,"right":0,"centerAnchorY":0.5,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/ZUyXVpjAXncZQiCHnZ4yWlVibRx81rVzXKbvdDRfJYKmrDTaThFOwC0rCtVsHkXrnpojsvUXs2TKSVw.png","clip":false,"borderStyle":"solid"});var heartHandler = new Layer({"parent":bottomBar,"name":"heartHandler","backgroundColor":null,"width":28,"x":335,"height":28,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":28,"centerAnchorX":0.93066666666666664,"width":28,"right":12,"top":18,"centerAnchorY":0.32653061224489793},"blending":"normal","clip":false,"borderStyle":"solid","y":18});var keyboard = new Layer({"parent":mainScreen,"name":"keyboard","backgroundSize":"fill","backgroundColor":null,"width":375,"height":335,"constraintValues":{"aspectRatioLocked":true,"height":335,"centerAnchorX":0.5,"width":375,"bottom":-335,"right":0,"top":null,"centerAnchorY":1.2062807881773399},"blending":"normal","image":"images\/design\/vpuaTwbHrCmrfNfmYWBcBhDi8STzQUNbTJG9qwMG6LR2hs2rFQjp9pGhMLHSgHHyzktEDEreXkWxQfJ4ib1Vuw.png","clip":false,"borderStyle":"solid","y":812});var keyboardHitArea = new Layer({"parent":keyboard,"name":"keyboardHitArea","backgroundColor":null,"width":92,"x":283,"height":45,"constraintValues":{"left":null,"height":45,"centerAnchorX":0.8773333333333333,"width":92,"bottom":78,"right":0,"top":null,"centerAnchorY":0.69999999999999996},"blending":"normal","clip":false,"borderStyle":"solid","y":212});var __layer_2__ = new Layer({"parent":mainScreen,"name":"console","backgroundColor":"rgba(0, 170, 255, 0.5)","width":104,"x":30,"height":30,"constraintValues":{"left":30,"height":30,"centerAnchorX":0.21866666666666668,"width":104,"top":121,"centerAnchorY":0.16748768472906403},"blending":"normal","borderRadius":14,"opacity":0.5,"clip":false,"borderStyle":"solid","y":121});var newButton = new Layer({"parent":__layer_2__,"name":"newButton","backgroundColor":"rgba(0, 170, 255, 0.5)","width":46,"x":4,"height":22,"constraintValues":{"left":4,"height":22,"centerAnchorX":0.19285714285714287,"width":46,"top":4,"centerAnchorY":0.29411764705882354},"blending":"normal","borderRadius":10,"clip":false,"borderStyle":"solid","y":4});var __layer_3__ = new TextLayer({"parent":newButton,"backgroundColor":null,"width":27,"x":9,"styledText":{"blocks":[{"inlineStyles":[{"css":{"fontSize":"12px","WebkitTextFillColor":"hsl(0, 0%, 100%)","whiteSpace":"pre","fontWeight":400,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Regular\", \"SF UI Text\", sans-serif","lineHeight":"1.2"},"startIndex":0,"endIndex":3}],"text":"New"}],"alignment":"center"},"height":14,"constraintValues":{"left":9,"height":14,"centerAnchorX":0.4891304347826087,"width":27,"top":null,"centerAnchorY":0.5},"blending":"normal","autoSize":true,"y":4});var resetButton = new Layer({"parent":__layer_2__,"name":"resetButton","backgroundColor":"rgba(0, 170, 255, 0.5)","width":46,"x":54,"height":22,"constraintValues":{"left":54,"height":22,"centerAnchorX":0.55000000000000004,"width":46,"top":4,"centerAnchorY":0.29411764705882354},"blending":"normal","borderRadius":10,"clip":false,"borderStyle":"solid","y":4});var __layer_4__ = new TextLayer({"parent":resetButton,"backgroundColor":null,"width":34,"x":6,"styledText":{"blocks":[{"inlineStyles":[{"css":{"fontSize":"12px","WebkitTextFillColor":"hsl(0, 0%, 100%)","whiteSpace":"pre","fontWeight":400,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Regular\", \"SF UI Text\", sans-serif","lineHeight":"1.2"},"startIndex":0,"endIndex":5}],"text":"Reset"}],"alignment":"center"},"height":14,"constraintValues":{"left":null,"height":14,"centerAnchorX":0.5,"width":34,"top":null,"centerAnchorY":0.5},"blending":"normal","autoSize":true,"y":4});if(flowWraper !== undefined){flowWraper.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|flowWraper","targetName":"flowWraper","vekterClass":"FrameNode"}};if(lightBar !== undefined){lightBar.__framerInstanceInfo = {"originalFilename":"Group 795.png","framerClass":"Layer","hash":"#vekter|lightBar","targetName":"lightBar","vekterClass":"FrameNode"}};if(heartHandler !== undefined){heartHandler.__framerInstanceInfo = {"originalFilename":"heart.png","framerClass":"Layer","hash":"#vekter|heartHandler","targetName":"heartHandler","vekterClass":"FrameNode"}};if(bottomBar !== undefined){bottomBar.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|bottomBar","targetName":"bottomBar","vekterClass":"FrameNode"}};if(darkBar !== undefined){darkBar.__framerInstanceInfo = {"originalFilename":"Group 794.png","framerClass":"Layer","hash":"#vekter|darkBar","targetName":"darkBar","vekterClass":"FrameNode"}};if(navigationBar !== undefined){navigationBar.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|navigationBar","targetName":"navigationBar","vekterClass":"FrameNode"}};if(heartButtonCore !== undefined){heartButtonCore.__framerInstanceInfo = {"originalFilename":"heart.png","framerClass":"Layer","hash":"#vekter|heartButtonCore","targetName":"heartButtonCore","vekterClass":"FrameNode"}};if(__layer_0__ !== undefined){__layer_0__.__framerInstanceInfo = {"hash":"#vekter|__layer_0__","vekterClass":"FrameNode","framerClass":"Layer"}};if(heartButton !== undefined){heartButton.__framerInstanceInfo = {"originalFilename":"heart.png","framerClass":"Layer","hash":"#vekter|heartButton","targetName":"heartButton","vekterClass":"FrameNode"}};if(keyboardHitArea !== undefined){keyboardHitArea.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|keyboardHitArea","targetName":"keyboardHitArea","vekterClass":"FrameNode"}};if(__layer_2__ !== undefined){__layer_2__.__framerInstanceInfo = {"hash":"#vekter|__layer_2__","vekterClass":"FrameNode","framerClass":"Layer"}};if(resetButton !== undefined){resetButton.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|resetButton","targetName":"resetButton","vekterClass":"FrameNode"}};if(imFlow !== undefined){imFlow.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|imFlow","targetName":"imFlow","vekterClass":"FrameNode"}};if(mainScreen !== undefined){mainScreen.__framerInstanceInfo = {"deviceName":"Apple iPhone X","framerClass":"Layer","hash":"#vekter|mainScreen","targetName":"mainScreen","vekterClass":"FrameNode","deviceType":"apple-iphone-x-space-gray"}};if(__layer_1__ !== undefined){__layer_1__.__framerInstanceInfo = {"hash":"#vekter|__layer_1__","vekterClass":"FrameNode","framerClass":"Layer"}};if(bottomBarHitArea !== undefined){bottomBarHitArea.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|bottomBarHitArea","targetName":"bottomBarHitArea","vekterClass":"FrameNode"}};if(__layer_4__ !== undefined){__layer_4__.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|__layer_4__","vekterClass":"TextNode","text":"Reset"}};if(newButton !== undefined){newButton.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|newButton","targetName":"newButton","vekterClass":"FrameNode"}};if(keyboard !== undefined){keyboard.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|keyboard","targetName":"keyboard","vekterClass":"FrameNode"}};if(__layer_3__ !== undefined){__layer_3__.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|__layer_3__","vekterClass":"TextNode","text":"New"}};if (scope["__vekterVariables"]) { scope["__vekterVariables"].map(function(variable) { delete scope[variable] } ) };Object.assign(scope, {mainScreen, flowWraper, imFlow, navigationBar, bottomBar, bottomBarHitArea, lightBar, darkBar, heartButton, heartButtonCore, heartHandler, keyboard, keyboardHitArea, newButton, resetButton});scope["__vekterVariables"] = ["mainScreen", "flowWraper", "imFlow", "navigationBar", "bottomBar", "bottomBarHitArea", "lightBar", "darkBar", "heartButton", "heartButtonCore", "heartHandler", "keyboard", "keyboardHitArea", "newButton", "resetButton"];if (typeof Framer.CurrentContext.layout === 'function') {Framer.CurrentContext.layout()};})(window);