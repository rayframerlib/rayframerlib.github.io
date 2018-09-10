(function(scope) {var mainScreen = new Layer({"name":"mainScreen","backgroundColor":"rgba(255,255,255,1)","width":375,"height":667,"constraintValues":{"height":667,"heightFactor":1,"width":375,"widthFactor":1},"blending":"normal","clip":true,"borderStyle":"solid"});var reset = new Layer({"parent":mainScreen,"name":"reset","backgroundColor":"rgba(0, 170, 255, 0.5)","width":121,"x":127,"height":41,"constraintValues":{"left":null,"height":41,"centerAnchorX":0.5,"width":121,"top":null,"centerAnchorY":0.42353823088455772},"blending":"normal","clip":false,"borderStyle":"solid","y":262});var __layer_0__ = new TextLayer({"parent":reset,"backgroundColor":null,"width":45,"x":38,"styledText":{"blocks":[{"inlineStyles":[{"css":{"fontSize":"16px","WebkitTextFillColor":"hsl(202, 100%, 38%)","whiteSpace":"pre","fontWeight":500,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Medium\", \"SF UI Text\", sans-serif","lineHeight":"1.2"},"startIndex":0,"endIndex":5}],"text":"Reset"}],"alignment":"center"},"height":19,"constraintValues":{"left":null,"height":19,"centerAnchorX":0.5,"width":45,"top":null,"centerAnchorY":0.5},"blending":"normal","autoSize":true,"y":11});var feed = new Layer({"parent":mainScreen,"name":"feed","backgroundColor":"rgba(0, 170, 255, 0)","width":375,"height":920,"constraintValues":{"left":null,"height":920,"heightFactor":1.3793103448275863,"centerAnchorX":0.5,"width":375,"widthFactor":1,"top":74,"centerAnchorY":0.80059970014992499},"blending":"normal","clip":false,"borderStyle":"solid","y":74});var __layer_1__ = new Layer({"parent":feed,"name":"Frame","backgroundColor":"hsla(200, 100%, 70%, 0.2)","width":375,"height":300,"constraintValues":{"left":null,"height":300,"heightFactor":0.32608695652173914,"centerAnchorX":0.5,"width":375,"widthFactor":1,"top":null,"centerAnchorY":0.16304347826086957},"blending":"normal","clip":false,"borderStyle":"solid"});var __layer_2__ = new Layer({"parent":feed,"backgroundColor":"hsla(200, 100%, 70%, 0.2)","width":375,"height":300,"constraintValues":{"left":null,"height":300,"heightFactor":0.32608695652173914,"centerAnchorX":0.5,"width":375,"widthFactor":1,"top":null,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid","y":310});var __layer_3__ = new Layer({"parent":feed,"backgroundColor":"hsla(200, 100%, 70%, 0.2)","width":375,"height":300,"constraintValues":{"left":null,"height":300,"heightFactor":0.32608695652173914,"centerAnchorX":0.5,"width":375,"widthFactor":1,"top":null,"centerAnchorY":0.83695652173913049},"blending":"normal","clip":false,"borderStyle":"solid","y":620});var light = new Layer({"parent":feed,"name":"light","backgroundColor":"rgba(0, 255, 0, 0.5)","width":375,"height":4,"constraintValues":{"height":4,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.004347826086956522},"blending":"normal","clip":false,"borderStyle":"solid"});var bottomBar = new Layer({"parent":mainScreen,"name":"bottomBar","backgroundColor":"rgb(0, 170, 255)","width":375,"height":45,"constraintValues":{"height":45,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"top":null,"centerAnchorY":0.95202398800599697},"blending":"normal","clip":false,"borderStyle":"solid","y":622});var current = new TextLayer({"parent":bottomBar,"name":"current","backgroundColor":null,"width":22,"x":18,"styledText":{"blocks":[{"inlineStyles":[{"startIndex":0,"endIndex":3,"css":{"fontSize":"13px","WebkitTextFillColor":"hsl(202, 100%, 38%)","whiteSpace":"pre","fontWeight":500,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Medium\", \"SF UI Text\", sans-serif","lineHeight":"1.2"}}],"text":"110"}]},"height":15,"constraintValues":{"left":18,"height":15,"centerAnchorX":0.077333333333333337,"width":22,"top":null,"centerAnchorY":0.5},"blending":"normal","autoSize":true,"y":15});var scale = new TextLayer({"parent":bottomBar,"name":"scale","backgroundColor":null,"width":22,"x":335,"styledText":{"blocks":[{"inlineStyles":[{"startIndex":0,"endIndex":3,"css":{"fontSize":"13px","WebkitTextFillColor":"hsl(202, 100%, 38%)","whiteSpace":"pre","fontWeight":500,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Medium\", \"SF UI Text\", sans-serif","lineHeight":"1.2"}}],"text":"110"}]},"height":15,"constraintValues":{"left":null,"height":15,"centerAnchorX":0.92266666666666663,"width":22,"right":18,"top":null,"centerAnchorY":0.5},"blending":"normal","autoSize":true,"y":15});var navigationBar = new Layer({"parent":mainScreen,"name":"navigationBar","backgroundColor":"rgb(0, 170, 255)","width":375,"height":64,"constraintValues":{"height":64,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.047976011994002997},"blending":"normal","clip":false,"borderStyle":"solid"});var $110Button = new Layer({"parent":navigationBar,"name":"110Button","backgroundColor":"hsla(156, 100%, 50%, 0.5)","width":44,"x":18,"height":44,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":44,"centerAnchorX":0.10666666666666667,"width":44,"bottom":10,"widthFactor":0.11733333333333333,"top":null,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid","y":10});var __layer_4__ = new TextLayer({"parent":$110Button,"backgroundColor":null,"width":40,"x":2,"styledText":{"blocks":[{"inlineStyles":[{"startIndex":0,"endIndex":5,"css":{"fontSize":"13px","WebkitTextFillColor":"hsl(202, 100%, 38%)","whiteSpace":"pre","fontWeight":500,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Medium\", \"SF UI Text\", sans-serif","lineHeight":"1.2"}}],"text":"110dp"},{"inlineStyles":[{"startIndex":0,"endIndex":6,"css":{"fontSize":"13px","WebkitTextFillColor":"hsl(202, 100%, 38%)","whiteSpace":"pre","fontWeight":500,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Medium\", \"SF UI Text\", sans-serif","lineHeight":"1.2"}}],"text":"Origin"}],"alignment":"center"},"height":30,"constraintValues":{"left":null,"height":30,"centerAnchorX":0.5,"width":40,"top":null,"centerAnchorY":0.5},"blending":"normal","autoSize":true,"y":7});var $140Button = new Layer({"parent":navigationBar,"name":"140Button","backgroundColor":"hsla(156, 100%, 50%, 0.5)","width":44,"x":77,"height":44,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":44,"centerAnchorX":0.26400000000000001,"width":44,"bottom":10,"widthFactor":0.11733333333333333,"top":null,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid","y":10});var __layer_5__ = new TextLayer({"parent":$140Button,"backgroundColor":null,"width":41,"x":1,"styledText":{"blocks":[{"inlineStyles":[{"startIndex":0,"endIndex":5,"css":{"fontSize":"13px","WebkitTextFillColor":"hsl(202, 100%, 38%)","whiteSpace":"pre","fontWeight":500,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Medium\", \"SF UI Text\", sans-serif","lineHeight":"1.2"}}],"text":"135dp"}],"alignment":"center"},"height":15,"constraintValues":{"left":null,"height":15,"centerAnchorX":0.48863636363636365,"width":41,"top":null,"centerAnchorY":0.48863636363636365},"blending":"normal","autoSize":true,"y":14});var $180Button = new Layer({"parent":navigationBar,"name":"180Button","backgroundColor":"hsla(156, 100%, 50%, 0.5)","width":44,"x":136,"height":44,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":44,"centerAnchorX":0.42133333333333334,"width":44,"bottom":10,"widthFactor":0.11733333333333333,"top":null,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid","y":10});var __layer_6__ = new TextLayer({"parent":$180Button,"backgroundColor":null,"width":41,"x":2,"styledText":{"blocks":[{"inlineStyles":[{"startIndex":0,"endIndex":5,"css":{"fontSize":"13px","WebkitTextFillColor":"hsl(202, 100%, 38%)","whiteSpace":"pre","fontWeight":500,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Medium\", \"SF UI Text\", sans-serif","lineHeight":"1.2"}}],"text":"180dp"}],"alignment":"center"},"height":15,"constraintValues":{"left":null,"height":15,"centerAnchorX":0.51136363636363635,"width":41,"top":null,"centerAnchorY":0.48863636363636365},"blending":"normal","autoSize":true,"y":14});var $1_3Button = new Layer({"parent":navigationBar,"name":"1-3Button","backgroundColor":"hsla(156, 100%, 50%, 0.5)","width":44,"x":195,"height":44,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":44,"centerAnchorX":0.57866666666666666,"width":44,"bottom":10,"widthFactor":0.11733333333333333,"top":null,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid","y":10});var __layer_7__ = new TextLayer({"parent":$1_3Button,"backgroundColor":null,"width":21,"x":11,"styledText":{"blocks":[{"inlineStyles":[{"css":{"fontSize":"13px","WebkitTextFillColor":"hsl(202, 100%, 38%)","whiteSpace":"pre","fontWeight":500,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Medium\", \"SF UI Text\", sans-serif","lineHeight":"1.2"},"startIndex":0,"endIndex":3}],"text":"1\/3"}],"alignment":"center"},"height":15,"constraintValues":{"left":null,"height":15,"centerAnchorX":0.48863636363636365,"width":21,"top":null,"centerAnchorY":0.48863636363636365},"blending":"normal","autoSize":true,"y":14});var $1_4Button = new Layer({"parent":navigationBar,"name":"1-4Button","backgroundColor":"hsla(156, 100%, 50%, 0.5)","width":44,"x":254,"height":44,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":44,"centerAnchorX":0.73599999999999999,"width":44,"bottom":10,"widthFactor":0.11733333333333333,"top":null,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid","y":10});var __layer_8__ = new TextLayer({"parent":$1_4Button,"backgroundColor":null,"width":21,"x":11,"styledText":{"blocks":[{"inlineStyles":[{"css":{"fontSize":"13px","WebkitTextFillColor":"hsl(202, 100%, 38%)","whiteSpace":"pre","fontWeight":500,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Medium\", \"SF UI Text\", sans-serif","lineHeight":"1.2"},"startIndex":0,"endIndex":3}],"text":"1\/4"}],"alignment":"center"},"height":15,"constraintValues":{"left":null,"height":15,"centerAnchorX":0.48863636363636365,"width":21,"top":null,"centerAnchorY":0.48863636363636365},"blending":"normal","autoSize":true,"y":14});var $1_5Button = new Layer({"parent":navigationBar,"name":"1-5Button","backgroundColor":"hsla(156, 100%, 50%, 0.5)","width":44,"x":313,"height":44,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":44,"centerAnchorX":0.89333333333333331,"width":44,"bottom":10,"widthFactor":0.11733333333333333,"top":null,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid","y":10});var __layer_9__ = new TextLayer({"parent":$1_5Button,"backgroundColor":null,"width":21,"x":11,"styledText":{"blocks":[{"inlineStyles":[{"css":{"fontSize":"13px","WebkitTextFillColor":"hsl(202, 100%, 38%)","whiteSpace":"pre","fontWeight":500,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Medium\", \"SF UI Text\", sans-serif","lineHeight":"1.2"},"startIndex":0,"endIndex":3}],"text":"1\/5"}],"alignment":"center"},"height":15,"constraintValues":{"left":null,"height":15,"centerAnchorX":0.48863636363636365,"width":21,"top":null,"centerAnchorY":0.48863636363636365},"blending":"normal","autoSize":true,"y":14});if(light !== undefined){light.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|light","targetName":"light","vekterClass":"FrameNode"}};if($1_3Button !== undefined){$1_3Button.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|$1_3Button","targetName":"$1_3Button","vekterClass":"FrameNode"}};if(__layer_9__ !== undefined){__layer_9__.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|__layer_9__","vekterClass":"TextNode","text":"1\/5"}};if($110Button !== undefined){$110Button.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|$110Button","targetName":"$110Button","vekterClass":"FrameNode"}};if(__layer_7__ !== undefined){__layer_7__.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|__layer_7__","vekterClass":"TextNode","text":"1\/3"}};if(__layer_2__ !== undefined){__layer_2__.__framerInstanceInfo = {"hash":"#vekter|__layer_2__","vekterClass":"FrameNode","framerClass":"Layer"}};if(bottomBar !== undefined){bottomBar.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|bottomBar","targetName":"bottomBar","vekterClass":"FrameNode"}};if(navigationBar !== undefined){navigationBar.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|navigationBar","targetName":"navigationBar","vekterClass":"FrameNode"}};if($140Button !== undefined){$140Button.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|$140Button","targetName":"$140Button","vekterClass":"FrameNode"}};if(__layer_0__ !== undefined){__layer_0__.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|__layer_0__","vekterClass":"TextNode","text":"Reset"}};if($180Button !== undefined){$180Button.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|$180Button","targetName":"$180Button","vekterClass":"FrameNode"}};if(__layer_8__ !== undefined){__layer_8__.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|__layer_8__","vekterClass":"TextNode","text":"1\/4"}};if($1_4Button !== undefined){$1_4Button.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|$1_4Button","targetName":"$1_4Button","vekterClass":"FrameNode"}};if(current !== undefined){current.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|current","targetName":"current","vekterClass":"TextNode","text":"110"}};if(feed !== undefined){feed.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|feed","targetName":"feed","vekterClass":"FrameNode"}};if(scale !== undefined){scale.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|scale","targetName":"scale","vekterClass":"TextNode","text":"110"}};if(mainScreen !== undefined){mainScreen.__framerInstanceInfo = {"deviceName":"Apple iPhone 8","framerClass":"Layer","hash":"#vekter|mainScreen","targetName":"mainScreen","vekterClass":"FrameNode","deviceType":"apple-iphone-8-space-gray"}};if(__layer_1__ !== undefined){__layer_1__.__framerInstanceInfo = {"hash":"#vekter|__layer_1__","vekterClass":"FrameNode","framerClass":"Layer"}};if(reset !== undefined){reset.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|reset","targetName":"reset","vekterClass":"FrameNode"}};if(__layer_4__ !== undefined){__layer_4__.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|__layer_4__","vekterClass":"TextNode","text":"110dp\nOrigin"}};if(__layer_6__ !== undefined){__layer_6__.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|__layer_6__","vekterClass":"TextNode","text":"180dp"}};if($1_5Button !== undefined){$1_5Button.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|$1_5Button","targetName":"$1_5Button","vekterClass":"FrameNode"}};if(__layer_3__ !== undefined){__layer_3__.__framerInstanceInfo = {"hash":"#vekter|__layer_3__","vekterClass":"FrameNode","framerClass":"Layer"}};if(__layer_5__ !== undefined){__layer_5__.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|__layer_5__","vekterClass":"TextNode","text":"135dp"}};if (scope["__vekterVariables"]) { scope["__vekterVariables"].map(function(variable) { delete scope[variable] } ) };Object.assign(scope, {mainScreen, reset, feed, light, bottomBar, current, scale, navigationBar, $110Button, $140Button, $180Button, $1_3Button, $1_4Button, $1_5Button});scope["__vekterVariables"] = ["mainScreen", "reset", "feed", "light", "bottomBar", "current", "scale", "navigationBar", "$110Button", "$140Button", "$180Button", "$1_3Button", "$1_4Button", "$1_5Button"];if (typeof Framer.CurrentContext.layout === 'function') {Framer.CurrentContext.layout()};})(window);