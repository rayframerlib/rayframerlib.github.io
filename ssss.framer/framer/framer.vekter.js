(function(scope) {var mainScreen = new Layer({"name":"mainScreen","backgroundColor":"#161823","width":375,"height":812,"constraintValues":{"height":812,"heightFactor":1,"width":375,"widthFactor":1},"blending":"normal","clip":true,"borderStyle":"solid"});var videoArea = new Layer({"parent":mainScreen,"name":"videoArea","backgroundColor":"#161823","width":375,"height":716,"constraintValues":{"height":716,"centerAnchorX":0.5,"width":375,"bottom":96,"right":0,"centerAnchorY":0.44088669950738918},"blending":"normal","clip":false,"borderStyle":"solid"});var __layer_0__ = new Layer({"parent":videoArea,"name":"themeColor","backgroundColor":"#9c9cff","width":375,"height":716,"constraintValues":{"height":716,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid"});var bgColor = new Layer({"parent":videoArea,"name":"bgColor","gradient":new Gradient({angle: 205, start: new Color('#7A3346').multiplyAlpha(0.3), end: new Color('#0F1442').multiplyAlpha(0.3)}),"backgroundColor":null,"width":375,"height":716,"constraintValues":{"height":716,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid"});var __layer_1__ = new Layer({"parent":videoArea,"backgroundSize":"fill","backgroundColor":null,"width":407,"height":880,"constraintValues":{"aspectRatioLocked":true,"height":880,"centerAnchorX":0.54266666666666663,"width":407,"bottom":-164,"right":-32,"top":null,"centerAnchorY":0.61452513966480449},"blending":"normal","image":"images\/design\/5CGdIYtZhQDnhuiFWAUTbnXUGnnedmAG9XtI0CtMuFJaOneFpdqZ8n2d1rMHYDRv14K95StI1tOs2Dtdzeng.png","clip":false,"borderStyle":"solid"});var __layer_2__ = new Layer({"parent":videoArea,"backgroundSize":"fill","backgroundColor":null,"width":203,"height":329,"constraintValues":{"aspectRatioLocked":true,"height":329,"centerAnchorX":0.27066666666666667,"width":203,"bottom":-184,"top":null,"centerAnchorY":1.0272346368715084},"blending":"normal","image":"images\/design\/aS6Nrdm9NpPGd7FSoN1Iz3pmT5Xj69VUI6fP2PaAdMoifNP3u1Hnookl8045B2JNYZttGbD6e9eSR0aTZdlYmw.png","opacity":0.40000000000000002,"clip":false,"borderStyle":"solid","y":571});var __layer_3__ = new Layer({"parent":videoArea,"backgroundSize":"fill","backgroundColor":null,"width":28,"x":347,"height":57,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":57,"centerAnchorX":0.96266666666666667,"width":28,"bottom":101,"right":0,"top":null,"centerAnchorY":0.81913407821229045},"blending":"normal","image":"images\/design\/X9tTk9krPZbhtMAOiRRPSgYDYsl8DUkgWtX2K1D9aeYIauUnt4Ja2HhC1zkxKnH6hgsHsHxY2PRPjj4A.png","opacity":0.40000000000000002,"clip":false,"borderStyle":"solid","y":558});var music = new Layer({"parent":videoArea,"name":"music","backgroundSize":"fill","backgroundColor":null,"width":216,"x":81,"height":245,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":245,"centerAnchorX":0.504,"width":216,"top":219,"centerAnchorY":0.47695530726256985},"blending":"normal","image":"images\/design\/rNd268qmaVJldJqQ9yMQhONsQp5zT7U2u2MPuWoMOOpBDRf1l6LY3DnLsxc57gXFr9gq985b87U9U79w.png","opacity":0.80000000000000004,"clip":false,"borderStyle":"solid","y":219});var __layer_4__ = new Layer({"parent":videoArea,"name":"planetBig","backgroundSize":"fill","backgroundColor":null,"width":303,"x":154,"height":303,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":303,"centerAnchorX":0.81466666666666665,"width":303,"right":-82,"top":-147,"centerAnchorY":0.006284916201117319},"blending":"normal","image":"images\/design\/Sz2nM4qtChTMFhVAPF5NbcFn6aGiGUfTmwaVZtwNoZG9M3RlmxllpxCsjSVRHNcdBQpGy1Rd422nZkbJ5A.png","opacity":0.40000000000000002,"clip":false,"borderStyle":"solid","y":-147});var __layer_5__ = new Layer({"parent":videoArea,"name":"leftline","backgroundSize":"fill","backgroundColor":null,"width":484,"x":-152,"height":337,"constraintValues":{"left":-152,"aspectRatioLocked":true,"height":337,"centerAnchorX":0.23999999999999999,"width":484,"bottom":60,"right":43,"top":null,"centerAnchorY":0.68086592178770955},"blending":"color-dodge","image":"images\/design\/jqLLBMDY1E2cJnCwz0LnEdzvzfttGzpNrNFfQObCLrSog4otnq9yJKysRw9tt74tGnVVPw1AVcHl8X8obAw.png","clip":false,"borderStyle":"solid","y":319});var __layer_6__ = new Layer({"parent":videoArea,"name":"rightLine","backgroundSize":"fill","backgroundColor":null,"width":213,"x":214,"height":270,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":270,"centerAnchorX":0.85466666666666669,"width":213,"bottom":31,"right":-52,"top":null,"centerAnchorY":0.76815642458100564},"blending":"color-dodge","image":"images\/design\/UMZYnXUHGOIjAI7g2M53aEBHt4wzgLJHG4sFAqxc8SOaW8RNwszwEpUcpTf9LVyosDNfRXz18ZL9z0LMLA.png","clip":false,"borderStyle":"solid","y":415});var frontBalls = new Layer({"parent":videoArea,"name":"frontBalls","backgroundColor":null,"width":375,"height":716,"constraintValues":{"height":716,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"centerAnchorY":0.5},"blending":"normal","clip":false,"borderStyle":"solid"});var backBalls = new Layer({"parent":videoArea,"name":"backBalls","backgroundColor":null,"width":375,"height":716,"constraintValues":{"height":716,"centerAnchorX":0.5,"width":375,"bottom":-10,"right":0,"top":10,"centerAnchorY":0.51396648044692739},"blending":"normal","clip":false,"borderStyle":"solid","y":10});var backBlur = new Layer({"parent":videoArea,"name":"backBlur","backgroundColor":null,"width":375,"height":181,"constraintValues":{"height":181,"centerAnchorX":0.5,"width":375,"right":0,"top":null,"centerAnchorY":0.50069832402234637},"blending":"normal","clip":false,"borderStyle":"solid","y":268,"blur":120});var __layer_7__ = new SVGLayer({"parent":backBlur,"name":".SVGLayer","backgroundColor":"rgba(104, 45, 69, 0.2)","width":375,"strokeWidth":1,"htmlIntrinsicSize":{"height":181,"width":375},"rotation":null,"height":181,"fill":"rgba(104, 45, 69, 0.2)","opacity":null,"svg":"<svg xmlns=\"http:\/\/www.w3.org\/2000\/svg\" width=\"375\" height=\"181\"><path d=\"M 187.5 0 C 291.053 0 375 40.518 375 90.5 C 375 140.482 291.053 181 187.5 181 C 83.947 181 0 140.482 0 90.5 C 0 40.518 83.947 0 187.5 0 Z\" name=\"backBlur\"><\/path><\/svg>"});var __layer_8__ = new Layer({"parent":videoArea,"name":"frontBlur","backgroundColor":null,"width":182,"x":97,"height":182,"constraintValues":{"left":null,"height":182,"centerAnchorX":0.5013333333333333,"width":182,"bottom":246,"top":null,"centerAnchorY":0.52932960893854752},"blending":"normal","clip":false,"borderStyle":"solid","y":288,"blur":120});var __layer_9__ = new SVGLayer({"parent":__layer_8__,"name":".SVGLayer","backgroundColor":"rgba(104, 45, 69, 0.2)","width":182,"strokeWidth":1,"htmlIntrinsicSize":{"height":182,"width":182},"rotation":null,"height":182,"fill":"rgba(104, 45, 69, 0.2)","opacity":null,"svg":"<svg xmlns=\"http:\/\/www.w3.org\/2000\/svg\" width=\"182\" height=\"182\"><path d=\"M 91 0 C 141.258 0 182 40.742 182 91 C 182 141.258 141.258 182 91 182 C 40.742 182 0 141.258 0 91 C 0 40.742 40.742 0 91 0 Z\" name=\"backBlur\"><\/path><\/svg>"});var oval = new Layer({"parent":videoArea,"name":"oval","backgroundSize":"fill","backgroundColor":null,"width":376,"x":-1,"height":375,"constraintValues":{"left":-1,"aspectRatioLocked":true,"height":375,"centerAnchorX":0.49866666666666665,"width":376,"bottom":148,"right":0,"top":null,"centerAnchorY":0.53142458100558654},"blending":"screen","image":"images\/design\/qCQYdwuEQYfdYKnCk80ucwTPzjQa2mc3w6y3qriVSOT7bI016jyRtQvWyKuIW7qeeGImEcwAKbKqlsu7o5Q.png","opacity":0.80000000000000004,"clip":false,"borderStyle":"solid","y":193});var planetMedium = new Layer({"parent":videoArea,"name":"planetMedium","backgroundSize":"fill","backgroundColor":null,"width":39,"x":60,"height":39,"constraintValues":{"left":60,"aspectRatioLocked":true,"height":39,"centerAnchorX":0.21199999999999999,"width":39,"bottom":216,"top":null,"centerAnchorY":0.6710893854748603},"blending":"normal","image":"images\/design\/ylOJ13Gs2EPfV2M4c6h5RUJLAbbhJJQHArV5V7Gv0OXIxjBeI0ZPr6wrLtZl1jOR6ecRP8ogtnuMPFRLDoQA.png","clip":false,"borderStyle":"solid","y":461});var planetMiniContainer = new Layer({"parent":videoArea,"name":"planetMiniContainer","backgroundColor":null,"width":376,"x":-1,"rotation":360,"height":375,"constraintValues":{"left":-1,"aspectRatioLocked":true,"height":375,"centerAnchorX":0.49866666666666665,"width":376,"bottom":148,"right":0,"top":null,"centerAnchorY":0.53142458100558654},"blending":"normal","clip":false,"borderStyle":"solid","y":193});var planetMini = new Layer({"parent":planetMiniContainer,"name":"planetMini","backgroundSize":"fill","backgroundColor":null,"width":17,"x":269,"height":17,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":17,"centerAnchorX":0.73803191489361697,"width":17,"right":90,"top":75,"centerAnchorY":0.22266666666666668},"blending":"normal","image":"images\/design\/NTSJMYfkZ3pQTzfvDZHjDzsvRoU8rT1RqYnSdxJz9tgGbdaLu0gij5n68kQeB82QAQbaryKSaOCuqG4azg.png","opacity":0.90000000000000002,"clip":false,"borderStyle":"solid","y":75});var planetTinyContainer = new Layer({"parent":videoArea,"name":"planetTinyContainer","backgroundColor":null,"width":376,"x":-1,"height":375,"constraintValues":{"left":-1,"aspectRatioLocked":true,"height":375,"centerAnchorX":0.49866666666666665,"width":376,"bottom":148,"right":0,"top":null,"centerAnchorY":0.53142458100558654},"blending":"normal","clip":false,"borderStyle":"solid","y":193});var planetTiny = new Layer({"parent":planetTinyContainer,"name":"planetTiny","backgroundSize":"fill","backgroundColor":null,"width":10,"x":98,"height":10,"constraintValues":{"left":98,"aspectRatioLocked":true,"height":10,"centerAnchorX":0.27393617021276595,"width":10,"top":16,"centerAnchorY":0.056000000000000001},"blending":"normal","image":"images\/design\/TXw58HLIBlBWMDhpal6286zur3xg3Wx1q8mKa6VRrgAzpAPsb6KO0oJKpVmhFTWe7whZeuoEI9WhDTNT3PFQ.png","opacity":0.5,"clip":false,"borderStyle":"solid","y":16});var light = new Layer({"parent":videoArea,"name":"light","backgroundSize":"fill","backgroundColor":null,"width":310,"x":32,"height":310,"constraintValues":{"left":32,"aspectRatioLocked":true,"height":310,"centerAnchorX":0.49866666666666665,"width":310,"bottom":193,"right":33,"top":null,"centerAnchorY":0.51396648044692739},"blending":"normal","image":"images\/design\/A84T7K83D7SYdsroD0Qym68vjR2v9pudg3htJPc2TIsfqW3sOFFwmbLCXc2Axi8fhqJujz2kyklLdHDMw.png","clip":false,"borderStyle":"solid","y":213});var queryContainer = new Layer({"parent":videoArea,"name":"queryContainer","backgroundColor":null,"width":375,"height":716,"constraintValues":{"height":716,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"centerAnchorY":0.5},"blending":"normal","clip":true,"borderStyle":"solid"});var mask = new Layer({"parent":videoArea,"name":"mask","backgroundSize":"fill","backgroundColor":null,"width":1875,"height":812,"constraintValues":{"aspectRatioLocked":true,"height":812,"centerAnchorX":2.5,"width":1875,"bottom":-96,"right":-1500,"top":null,"centerAnchorY":0.56703910614525144},"blending":"normal","image":"images\/design\/S7W1APvTGzQAaJ57xXogSlwlTOUKSCuvUtTCyqVyDI6TzhilKrXEdPnPt8nOjId2QFdrox6N3OiaV7Og9g.png","opacity":0,"clip":false,"borderStyle":"solid"});var search = new Layer({"parent":videoArea,"name":"search","backgroundColor":null,"width":270,"x":52,"height":56,"constraintValues":{"left":52,"height":56,"centerAnchorX":0.49866666666666665,"width":270,"bottom":320,"right":53,"top":null,"centerAnchorY":0.51396648044692739},"blending":"normal","clip":false,"borderStyle":"solid","y":340});var searchBarGlow = new Layer({"parent":search,"name":"searchBarGlow","backgroundColor":null,"width":280,"x":-5,"height":66,"constraintValues":{"left":-5,"height":66,"centerAnchorX":0.5,"width":280,"bottom":-5,"right":-5,"top":-5,"centerAnchorY":0.5},"blending":"normal","borderRadius":100,"clip":false,"borderStyle":"solid","y":-5,"blur":25});var glowGradient = new Layer({"parent":searchBarGlow,"name":"glowGradient","gradient":new Gradient({angle: 0, start: new Color('#cfc5fb').multiplyAlpha(1), end: new Color('hsla(251, 87%, 88%, 0)').multiplyAlpha(1)}),"backgroundColor":null,"width":290,"x":-5,"height":290,"constraintValues":{"left":-5,"height":290,"centerAnchorX":0.5,"width":290,"bottom":-112,"right":-5,"top":-112,"centerAnchorY":0.5},"blending":"normal","borderRadius":140,"opacity":0,"clip":false,"borderStyle":"solid","y":-112});var searchBar = new Layer({"parent":search,"name":"searchBar","backgroundColor":null,"width":270,"height":56,"constraintValues":{"height":56,"centerAnchorX":0.5,"width":270,"bottom":0,"right":0,"centerAnchorY":0.5},"blending":"normal","borderRadius":100,"clip":false,"borderStyle":"solid"});var gradient = new Layer({"parent":searchBar,"name":"gradient","gradient":new Gradient({angle: 0, start: new Color('rgba(161, 162, 232, 1.00)').multiplyAlpha(1), end: new Color('hsl(0, 0%, 100%)').multiplyAlpha(1)}),"backgroundColor":null,"width":280,"x":-5,"height":280,"constraintValues":{"left":-5,"height":280,"centerAnchorX":0.5,"width":280,"bottom":-112,"right":-5,"top":-112,"centerAnchorY":0.5},"blending":"normal","borderRadius":140,"opacity":0,"clip":false,"borderStyle":"solid","y":-112});var __layer_10__ = new Layer({"parent":searchBar,"name":"searchBar","backgroundColor":"hsl(0, 0%, 100%)","width":264,"x":3,"height":50,"constraintValues":{"left":3,"height":50,"centerAnchorX":0.5,"width":264,"bottom":3,"right":3,"top":3,"centerAnchorY":0.5},"blending":"normal","borderRadius":100,"clip":false,"borderStyle":"solid","y":3});var textArea = new Layer({"parent":searchBar,"name":"textArea","backgroundColor":"hsl(272, 18%, 19%)","width":264,"x":3,"height":50,"constraintValues":{"left":3,"height":50,"centerAnchorX":0.5,"width":264,"bottom":3,"right":3,"top":3,"centerAnchorY":0.5},"blending":"normal","borderRadius":100,"clip":false,"borderStyle":"solid","y":3});var textMask = new Layer({"parent":textArea,"name":"textMask","backgroundColor":"rgba(0, 0, 0, 0.34)","width":264,"height":50,"constraintValues":{"height":50,"centerAnchorX":0.5,"width":264,"bottom":0,"right":0,"centerAnchorY":0.5},"blending":"normal","borderRadius":100,"clip":false,"borderStyle":"solid"});var coreText = new TextLayer({"parent":textArea,"name":"coreText","shadows":[{"x":0,"type":"text","y":1,"blur":2,"color":"rgba(0,0,0,0.25)"}],"backgroundColor":null,"width":155,"x":18,"styledText":{"blocks":[{"inlineStyles":[{"css":{"fontSize":"22px","WebkitTextFillColor":"hsl(0, 0%, 100%)","whiteSpace":"pre","fontWeight":700,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Bold\", \"SF UI Text\", sans-serif","lineHeight":"1.2"},"startIndex":0,"endIndex":7}],"text":"看见搜索的力量"}]},"height":26,"constraintValues":{"left":18,"height":26,"centerAnchorX":0.36174242424242425,"width":155,"top":null,"centerAnchorY":0.5},"blending":"normal","autoSize":true,"y":12});var icon = new Layer({"parent":searchBar,"name":"icon","backgroundSize":"fill","backgroundColor":null,"width":20,"x":235,"height":23,"constraintValues":{"left":null,"aspectRatioLocked":true,"height":23,"centerAnchorX":0.90740740740740744,"width":20,"right":15,"top":null,"centerAnchorY":0.48958333333333331},"blending":"normal","image":"images\/design\/My7qYDuSa6BHbgR3wcL8Lc6uXJZjnVcLRlhpea8WkN59MyqIVgsCHpqucsGOxZZMoTZqtFdL0lSL0tx7QzxT1g.png","clip":false,"borderStyle":"solid","y":16});var button = new Layer({"parent":searchBar,"name":"button","backgroundColor":"rgba(255, 255, 255, 0.2)","width":71,"x":190,"height":39,"constraintValues":{"left":null,"height":39,"centerAnchorX":0.83518518518518514,"width":71,"bottom":9,"right":9,"top":8,"centerAnchorY":0.48958333333333331},"blending":"normal","borderRadius":100,"clip":false,"borderStyle":"solid","y":8});var __layer_11__ = new TextLayer({"parent":button,"shadows":[{"x":0,"type":"text","y":1,"blur":2,"color":"rgba(0,0,0,0.25)"}],"backgroundColor":null,"width":49,"x":11,"styledText":{"blocks":[{"inlineStyles":[{"css":{"fontSize":"16px","WebkitTextFillColor":"hsla(0, 0%, 100%, 0.9)","whiteSpace":"pre","fontWeight":500,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Medium\", \"SF UI Text\", sans-serif","lineHeight":"1.2"},"startIndex":0,"endIndex":3}],"text":"去搜索"}],"alignment":"center"},"height":19,"constraintValues":{"left":null,"height":19,"centerAnchorX":0.5,"width":49,"top":null,"centerAnchorY":0.5},"blending":"normal","autoSize":true,"y":10});var __layer_12__ = new Layer({"parent":search,"name":"tapToSearch","backgroundColor":null,"width":253,"x":9,"height":19,"constraintValues":{"left":9,"height":19,"centerAnchorX":0.50185185185185188,"width":253,"bottom":-26,"right":8,"top":null,"centerAnchorY":1.2946428571428572},"blending":"normal","clip":false,"borderStyle":"solid","y":63});var __layer_13__ = new TextLayer({"parent":__layer_12__,"backgroundColor":null,"width":49,"x":102,"styledText":{"blocks":[{"inlineStyles":[{"css":{"fontSize":"12px","WebkitTextFillColor":"hsla(0, 0%, 100%, 0.6)","whiteSpace":"pre","fontWeight":500,"letterSpacing":"0px","tabSize":4,"fontFamily":"\"SFUIText-Medium\", \"SF UI Text\", sans-serif","lineHeight":"1.2"},"startIndex":0,"endIndex":4}],"text":"点击进入"}],"alignment":"center"},"height":14,"constraintValues":{"left":null,"height":14,"centerAnchorX":0.5,"width":49,"top":null,"centerAnchorY":0.52631578947368418},"blending":"normal","autoSize":true,"y":3});var __layer_14__ = new SVGLayer({"parent":__layer_12__,"name":".SVGLayer","gradient":new Gradient({angle: 90, start: new Color('hsl(0, 0%, 100%)').multiplyAlpha(0.34), end: new Color('hsla(0, 0%, 100%, 0)').multiplyAlpha(0.34)}),"backgroundColor":null,"width":64,"strokeWidth":1,"x":157,"htmlIntrinsicSize":{"height":1,"width":64},"rotation":null,"height":1,"borderRadius":1,"opacity":null,"y":9,"svg":"<svg xmlns=\"http:\/\/www.w3.org\/2000\/svg\" width=\"64\" height=\"1\"><g><defs><linearGradient id=\"idCCOiMadqNg407092373\" gradientTransform=\"rotate(0, 0.5, 0.5)\"><stop offset=\"0\" stop-color=\"hsl(0, 0%, 100%)\" stop-opacity=\"0.34\"><\/stop><stop offset=\"1\" stop-color=\"hsla(0, 0%, 100%, 0)\" stop-opacity=\"0\"><\/stop><\/linearGradient><\/defs><path d=\"M 0 0.5 C 0 0.224 0.224 0 0.5 0 L 63.5 0 C 63.776 0 64 0.224 64 0.5 L 64 0.5 C 64 0.776 63.776 1 63.5 1 L 0.5 1 C 0.224 1 0 0.776 0 0.5 Z\" fill=\"url(#idCCOiMadqNg407092373)\" name=\"Rectangle\"><\/path><\/g><\/svg>"});var __layer_15__ = new SVGLayer({"parent":__layer_12__,"name":".SVGLayer","gradient":new Gradient({angle: 270, start: new Color('hsl(0, 0%, 100%)').multiplyAlpha(0.34), end: new Color('hsla(0, 0%, 100%, 0)').multiplyAlpha(0.34)}),"backgroundColor":null,"width":64,"strokeWidth":1,"x":32,"htmlIntrinsicSize":{"height":1,"width":64},"rotation":null,"height":1,"borderRadius":1,"opacity":null,"y":9,"svg":"<svg xmlns=\"http:\/\/www.w3.org\/2000\/svg\" width=\"64\" height=\"1\"><g><defs><linearGradient id=\"idMAr0ouei2g-242346562\" gradientTransform=\"rotate(180, 0.5, 0.5)\"><stop offset=\"0\" stop-color=\"hsl(0, 0%, 100%)\" stop-opacity=\"0.34\"><\/stop><stop offset=\"1\" stop-color=\"hsla(0, 0%, 100%, 0)\" stop-opacity=\"0\"><\/stop><\/linearGradient><\/defs><path d=\"M 0 0.5 C 0 0.224 0.224 0 0.5 0 L 63.5 0 C 63.776 0 64 0.224 64 0.5 L 64 0.5 C 64 0.776 63.776 1 63.5 1 L 0.5 1 C 0.224 1 0 0.776 0 0.5 Z\" fill=\"url(#idMAr0ouei2g-242346562)\" name=\"Rectangle\"><\/path><\/g><\/svg>"});var texts = new Layer({"parent":mainScreen,"name":"texts","backgroundSize":"fill","backgroundColor":null,"width":375,"height":360,"constraintValues":{"height":360,"centerAnchorX":0.5,"width":375,"bottom":96,"right":0,"top":null,"centerAnchorY":0.66009852216748766},"blending":"normal","image":"images\/design\/LM4RpuhULebASV6xFEP1EIMU2lyUX3asZrobzZZTLkHbMifG45B2qtKKnu3aq7WBTQebQvJOSUDNtR5hx5LEQ.png","clip":false,"borderStyle":"solid","y":356});var bottom = new Layer({"parent":mainScreen,"name":"bottom","backgroundColor":"#161823","width":375,"height":96,"constraintValues":{"height":96,"centerAnchorX":0.5,"width":375,"bottom":0,"right":0,"top":null,"centerAnchorY":0.94088669950738912},"blending":"normal","clip":false,"borderStyle":"solid","y":716});var __layer_16__ = new Layer({"parent":bottom,"name":"bottom","backgroundSize":"fit","backgroundColor":null,"width":375,"height":108,"constraintValues":{"aspectRatioLocked":true,"height":108,"centerAnchorX":0.5,"width":375,"right":0,"top":-12,"centerAnchorY":0.4375},"blending":"normal","image":"images\/design\/lZ7XXf7kjI9SrFmqTJZrmoDvLZcNNXh02Y3Svz8OG38zAxWzuA2dfpJRqzU3gBSLviq2EIudnZp554yiZIOg.png","clip":false,"borderStyle":"solid","y":-12});var navigationbar = new Layer({"parent":mainScreen,"name":"navigationbar","backgroundSize":"fill","backgroundColor":null,"width":375,"height":108,"constraintValues":{"height":108,"centerAnchorX":0.5,"width":375,"right":0,"centerAnchorY":0.066502463054187194,"aspectRatioLocked":true},"blending":"normal","image":"images\/design\/PNw1a15SRuFqrbHKjWQfj8ODh5lJv5WB7U8siJQkIcxm2L7NWTi3Ar7tMunBxdm2L2tSHd2Y2VhgE4V1g.png","clip":false,"borderStyle":"solid"});if(__layer_9__ !== undefined){__layer_9__.__framerInstanceInfo = {"hash":"#vekter|__layer_9__","vekterClass":"OvalShapeNode","framerClass":"SVGLayer"}};if(textArea !== undefined){textArea.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|textArea","targetName":"textArea","vekterClass":"FrameNode"}};if(planetMiniContainer !== undefined){planetMiniContainer.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|planetMiniContainer","targetName":"planetMiniContainer","vekterClass":"FrameNode"}};if(search !== undefined){search.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|search","targetName":"search","vekterClass":"FrameNode"}};if(textMask !== undefined){textMask.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|textMask","targetName":"textMask","vekterClass":"FrameNode"}};if(__layer_10__ !== undefined){__layer_10__.__framerInstanceInfo = {"hash":"#vekter|__layer_10__","vekterClass":"FrameNode","framerClass":"Layer"}};if(glowGradient !== undefined){glowGradient.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|glowGradient","targetName":"glowGradient","vekterClass":"FrameNode"}};if(bottom !== undefined){bottom.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|bottom","targetName":"bottom","vekterClass":"FrameNode"}};if(__layer_0__ !== undefined){__layer_0__.__framerInstanceInfo = {"hash":"#vekter|__layer_0__","vekterClass":"FrameNode","framerClass":"Layer"}};if(__layer_12__ !== undefined){__layer_12__.__framerInstanceInfo = {"hash":"#vekter|__layer_12__","vekterClass":"FrameNode","framerClass":"Layer"}};if(backBalls !== undefined){backBalls.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|backBalls","targetName":"backBalls","vekterClass":"FrameNode"}};if(planetTinyContainer !== undefined){planetTinyContainer.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|planetTinyContainer","targetName":"planetTinyContainer","vekterClass":"FrameNode"}};if(button !== undefined){button.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|button","targetName":"button","vekterClass":"FrameNode"}};if(searchBar !== undefined){searchBar.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|searchBar","targetName":"searchBar","vekterClass":"FrameNode"}};if(mainScreen !== undefined){mainScreen.__framerInstanceInfo = {"deviceName":"Apple iPhone X","framerClass":"Layer","hash":"#vekter|mainScreen","targetName":"mainScreen","vekterClass":"FrameNode","deviceType":"apple-iphone-x-space-gray"}};if(__layer_4__ !== undefined){__layer_4__.__framerInstanceInfo = {"hash":"#vekter|__layer_4__","vekterClass":"FrameNode","framerClass":"Layer"}};if(videoArea !== undefined){videoArea.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|videoArea","targetName":"videoArea","vekterClass":"FrameNode"}};if(planetMedium !== undefined){planetMedium.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|planetMedium","targetName":"planetMedium","vekterClass":"FrameNode"}};if(coreText !== undefined){coreText.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|coreText","targetName":"coreText","vekterClass":"TextNode","text":"看见搜索的力量"}};if(planetTiny !== undefined){planetTiny.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|planetTiny","targetName":"planetTiny","vekterClass":"FrameNode"}};if(frontBalls !== undefined){frontBalls.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|frontBalls","targetName":"frontBalls","vekterClass":"FrameNode"}};if(light !== undefined){light.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|light","targetName":"light","vekterClass":"FrameNode"}};if(queryContainer !== undefined){queryContainer.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|queryContainer","targetName":"queryContainer","vekterClass":"FrameNode"}};if(icon !== undefined){icon.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|icon","targetName":"icon","vekterClass":"FrameNode"}};if(mask !== undefined){mask.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|mask","targetName":"mask","vekterClass":"FrameNode"}};if(gradient !== undefined){gradient.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|gradient","targetName":"gradient","vekterClass":"FrameNode"}};if(bgColor !== undefined){bgColor.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|bgColor","targetName":"bgColor","vekterClass":"FrameNode"}};if(__layer_7__ !== undefined){__layer_7__.__framerInstanceInfo = {"hash":"#vekter|__layer_7__","vekterClass":"OvalShapeNode","framerClass":"SVGLayer"}};if(__layer_2__ !== undefined){__layer_2__.__framerInstanceInfo = {"hash":"#vekter|__layer_2__","vekterClass":"FrameNode","framerClass":"Layer"}};if(music !== undefined){music.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|music","targetName":"music","vekterClass":"FrameNode"}};if(__layer_8__ !== undefined){__layer_8__.__framerInstanceInfo = {"hash":"#vekter|__layer_8__","vekterClass":"FrameNode","framerClass":"Layer"}};if(__layer_14__ !== undefined){__layer_14__.__framerInstanceInfo = {"hash":"#vekter|__layer_14__","vekterClass":"RectangleShapeNode","framerClass":"SVGLayer"}};if(__layer_15__ !== undefined){__layer_15__.__framerInstanceInfo = {"hash":"#vekter|__layer_15__","vekterClass":"RectangleShapeNode","framerClass":"SVGLayer"}};if(__layer_13__ !== undefined){__layer_13__.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|__layer_13__","vekterClass":"TextNode","text":"点击进入"}};if(backBlur !== undefined){backBlur.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|backBlur","targetName":"backBlur","vekterClass":"FrameNode"}};if(oval !== undefined){oval.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|oval","targetName":"oval","vekterClass":"FrameNode"}};if(searchBarGlow !== undefined){searchBarGlow.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|searchBarGlow","targetName":"searchBarGlow","vekterClass":"FrameNode"}};if(__layer_11__ !== undefined){__layer_11__.__framerInstanceInfo = {"framerClass":"TextLayer","hash":"#vekter|__layer_11__","vekterClass":"TextNode","text":"去搜索"}};if(texts !== undefined){texts.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|texts","targetName":"texts","vekterClass":"FrameNode"}};if(__layer_16__ !== undefined){__layer_16__.__framerInstanceInfo = {"hash":"#vekter|__layer_16__","vekterClass":"FrameNode","framerClass":"Layer"}};if(navigationbar !== undefined){navigationbar.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|navigationbar","targetName":"navigationbar","vekterClass":"FrameNode"}};if(planetMini !== undefined){planetMini.__framerInstanceInfo = {"framerClass":"Layer","hash":"#vekter|planetMini","targetName":"planetMini","vekterClass":"FrameNode"}};if(__layer_6__ !== undefined){__layer_6__.__framerInstanceInfo = {"hash":"#vekter|__layer_6__","vekterClass":"FrameNode","framerClass":"Layer"}};if(__layer_1__ !== undefined){__layer_1__.__framerInstanceInfo = {"hash":"#vekter|__layer_1__","vekterClass":"FrameNode","framerClass":"Layer"}};if(__layer_3__ !== undefined){__layer_3__.__framerInstanceInfo = {"hash":"#vekter|__layer_3__","vekterClass":"FrameNode","framerClass":"Layer"}};if(__layer_5__ !== undefined){__layer_5__.__framerInstanceInfo = {"hash":"#vekter|__layer_5__","vekterClass":"FrameNode","framerClass":"Layer"}};if (scope["__vekterVariables"]) { scope["__vekterVariables"].map(function(variable) { delete scope[variable] } ) };Object.assign(scope, {mainScreen, videoArea, bgColor, music, frontBalls, backBalls, backBlur, oval, planetMedium, planetMiniContainer, planetMini, planetTinyContainer, planetTiny, light, queryContainer, mask, search, searchBarGlow, glowGradient, searchBar, gradient, textArea, textMask, coreText, icon, button, texts, bottom, navigationbar});scope["__vekterVariables"] = ["mainScreen", "videoArea", "bgColor", "music", "frontBalls", "backBalls", "backBlur", "oval", "planetMedium", "planetMiniContainer", "planetMini", "planetTinyContainer", "planetTiny", "light", "queryContainer", "mask", "search", "searchBarGlow", "glowGradient", "searchBar", "gradient", "textArea", "textMask", "coreText", "icon", "button", "texts", "bottom", "navigationbar"];if (typeof Framer.CurrentContext.layout === 'function') {Framer.CurrentContext.layout()};})(window);