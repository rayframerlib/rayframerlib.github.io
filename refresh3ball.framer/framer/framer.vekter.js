(function(scope) {var mainScreen = new Layer({"name":"mainScreen","backgroundColor":"#eeeeee","width":375,"height":667,"constraintValues":{"height":667,"heightFactor":1,"width":375,"widthFactor":1},"blending":"normal","clip":true,"borderStyle":"solid"});var container = new Layer({"parent":mainScreen,"name":"container","backgroundColor":null,"width":375,"height":603,"constraintValues":{"height":603,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"top":64,"centerAnchorY":0.54797601199400303},"blending":"normal","clip":false,"borderStyle":"solid","y":64});var feedContent = new Layer({"parent":container,"name":"feedContent","backgroundColor":"rgba(0, 170, 255, 0)","width":375,"height":1000,"constraintValues":{"height":1000,"centerAnchorX":0.5,"width":375,"bottom":-397,"right":0,"centerAnchorY":0.82918739635157546},"blending":"normal","clip":false,"borderStyle":"solid"});var feed = new Layer({"parent":feedContent,"name":"feed","backgroundSize":"fill","backgroundColor":null,"width":375,"height":990,"constraintValues":{"height":990,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"top":10,"centerAnchorY":0.50249999999999995},"blending":"normal","image":"images\/design\/FMxs6xxetkcYlNlvaiaJN5CrCbUTV3Z3ztFWME4CfFPsH70QCZvjMwneXvngPG1wKTA65gt6bW3iZBkoLQ","clip":false,"borderStyle":"solid","y":10});var iconContainer = new Layer({"parent":feedContent,"name":"iconContainer","backgroundColor":null,"width":375,"height":40,"constraintValues":{"height":40,"centerAnchorX":0.5,"width":375,"right":0,"top":-30,"centerAnchorY":-0.01},"blending":"normal","clip":false,"borderStyle":"solid","y":-30});var refreshIcon = new Layer({"parent":iconContainer,"name":"refreshIcon","backgroundColor":null,"width":400,"x":-13,"height":100,"constraintValues":{"left":-13,"height":100,"centerAnchorX":0.49866666666666665,"width":400,"bottom":-30,"right":-12,"top":-30,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid","y":-30});var tip = new Layer({"parent":container,"name":"tip","backgroundColor":null,"width":375,"height":40,"constraintValues":{"height":40,"centerAnchorX":0.5,"width":375,"right":0,"top":-30,"centerAnchorY":-0.01658374792703151},"blending":"normal","clip":false,"borderStyle":"solid","y":-30});var tipBg = new Layer({"parent":tip,"name":"tipBg","gradient":new Gradient({angle: 270, start: new Color('hsl(24, 100%, 62%)').multiplyAlpha(1), end: new Color('hsl(41, 100%, 71%)').multiplyAlpha(1)}),"backgroundColor":null,"width":375,"height":40,"constraintValues":{"height":40,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid"});var __layer_0__ = new TextLayer({"parent":tip,"name":"tipText","backgroundColor":null,"width":88,"x":144,"styledText":{"blocks":[{"inlineStyles":[{"css":{"fontSize":"13px","WebkitTextFillColor":"hsl(0, 0%, 100%)","whiteSpace":"pre","fontWeight":400,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Regular\", \"SF UI Text\", sans-serif","lineHeight":"1.3"},"startIndex":0,"endIndex":9}],"text":"更新 10 条微博"}],"alignment":"center"},"height":16,"constraintValues":{"left":null,"height":16,"centerAnchorX":0.5013333333333333,"width":88,"top":null,"centerAnchorY":0.5},"blending":"normal","autoSize":true,"y":12});var navigationBar = new Layer({"parent":mainScreen,"name":"navigationBar","backgroundSize":"fill","backgroundColor":null,"width":375,"height":64,"constraintValues":{"height":64,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.047976011994002997},"blending":"normal","image":"images\/design\/fCvzMnAJJKBMlpMLe0ibdbh37ZgJKm7AJgDoXw5PYBSbrnjK5HEjF8ZqoIo2DX4W3xW4j3O8ytCK0eQ","clip":false,"borderStyle":"solid"});if(iconContainer !== undefined){iconContainer.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|iconContainer","targetName":"iconContainer","vekterClass":"FrameNode"}};if(tip !== undefined){tip.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|tip","targetName":"tip","vekterClass":"FrameNode"}};if(feed !== undefined){feed.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|feed","targetName":"feed","vekterClass":"FrameNode"}};if(refreshIcon !== undefined){refreshIcon.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|refreshIcon","targetName":"refreshIcon","vekterClass":"FrameNode"}};if(mainScreen !== undefined){mainScreen.__framerInstanceInfo = {"deviceName":"Apple iPhone 8","framerClass":"Layer","hash":"#vekter|mainScreen","targetName":"mainScreen","vekterClass":"FrameNode","deviceType":"apple-iphone-8-space-gray"}};if(tipBg !== undefined){tipBg.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|tipBg","targetName":"tipBg","vekterClass":"FrameNode"}};if(feedContent !== undefined){feedContent.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|feedContent","targetName":"feedContent","vekterClass":"FrameNode"}};if(container !== undefined){container.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|container","targetName":"container","vekterClass":"FrameNode"}};if(__layer_0__ !== undefined){__layer_0__.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|__layer_0__","vekterClass":"TextNode","text":"更新 10 条微博"}};if(navigationBar !== undefined){navigationBar.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|navigationBar","targetName":"navigationBar","vekterClass":"FrameNode"}};if (scope["__vekterVariables"]) { scope["__vekterVariables"].map(function(variable) { delete scope[variable] } ) };Object.assign(scope, {mainScreen, container, feedContent, feed, iconContainer, refreshIcon, tip, tipBg, navigationBar});scope["__vekterVariables"] = ["mainScreen", "container", "feedContent", "feed", "iconContainer", "refreshIcon", "tip", "tipBg", "navigationBar"];if (typeof Framer.CurrentContext.layout === 'function') {Framer.CurrentContext.layout()};})(window);