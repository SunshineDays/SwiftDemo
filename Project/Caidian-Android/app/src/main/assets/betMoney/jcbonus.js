//     Underscore.js 1.8.3
//     http://underscorejs.org
//     (c) 2009-2015 Jeremy Ashkenas, DocumentCloud and Investigative Reporters & Editors
//     Underscore may be freely distributed under the MIT license.
(function(){function n(n){function t(t,r,e,u,i,o){for(;i>=0&&o>i;i+=n){var a=u?u[i]:i;e=r(e,t[a],a,t)}return e}return function(r,e,u,i){e=b(e,i,4);var o=!k(r)&&m.keys(r),a=(o||r).length,c=n>0?0:a-1;return arguments.length<3&&(u=r[o?o[c]:c],c+=n),t(r,e,u,o,c,a)}}function t(n){return function(t,r,e){r=x(r,e);for(var u=O(t),i=n>0?0:u-1;i>=0&&u>i;i+=n)if(r(t[i],i,t))return i;return-1}}function r(n,t,r){return function(e,u,i){var o=0,a=O(e);if("number"==typeof i)n>0?o=i>=0?i:Math.max(i+a,o):a=i>=0?Math.min(i+1,a):i+a+1;else if(r&&i&&a)return i=r(e,u),e[i]===u?i:-1;if(u!==u)return i=t(l.call(e,o,a),m.isNaN),i>=0?i+o:-1;for(i=n>0?o:a-1;i>=0&&a>i;i+=n)if(e[i]===u)return i;return-1}}function e(n,t){var r=I.length,e=n.constructor,u=m.isFunction(e)&&e.prototype||a,i="constructor";for(m.has(n,i)&&!m.contains(t,i)&&t.push(i);r--;)i=I[r],i in n&&n[i]!==u[i]&&!m.contains(t,i)&&t.push(i)}var u=this,i=u._,o=Array.prototype,a=Object.prototype,c=Function.prototype,f=o.push,l=o.slice,s=a.toString,p=a.hasOwnProperty,h=Array.isArray,v=Object.keys,g=c.bind,y=Object.create,d=function(){},m=function(n){return n instanceof m?n:this instanceof m?void(this._wrapped=n):new m(n)};"undefined"!=typeof exports?("undefined"!=typeof module&&module.exports&&(exports=module.exports=m),exports._=m):u._=m,m.VERSION="1.8.3";var b=function(n,t,r){if(t===void 0)return n;switch(null==r?3:r){case 1:return function(r){return n.call(t,r)};case 2:return function(r,e){return n.call(t,r,e)};case 3:return function(r,e,u){return n.call(t,r,e,u)};case 4:return function(r,e,u,i){return n.call(t,r,e,u,i)}}return function(){return n.apply(t,arguments)}},x=function(n,t,r){return null==n?m.identity:m.isFunction(n)?b(n,t,r):m.isObject(n)?m.matcher(n):m.property(n)};m.iteratee=function(n,t){return x(n,t,1/0)};var _=function(n,t){return function(r){var e=arguments.length;if(2>e||null==r)return r;for(var u=1;e>u;u++)for(var i=arguments[u],o=n(i),a=o.length,c=0;a>c;c++){var f=o[c];t&&r[f]!==void 0||(r[f]=i[f])}return r}},j=function(n){if(!m.isObject(n))return{};if(y)return y(n);d.prototype=n;var t=new d;return d.prototype=null,t},w=function(n){return function(t){return null==t?void 0:t[n]}},A=Math.pow(2,53)-1,O=w("length"),k=function(n){var t=O(n);return"number"==typeof t&&t>=0&&A>=t};m.each=m.forEach=function(n,t,r){t=b(t,r);var e,u;if(k(n))for(e=0,u=n.length;u>e;e++)t(n[e],e,n);else{var i=m.keys(n);for(e=0,u=i.length;u>e;e++)t(n[i[e]],i[e],n)}return n},m.map=m.collect=function(n,t,r){t=x(t,r);for(var e=!k(n)&&m.keys(n),u=(e||n).length,i=Array(u),o=0;u>o;o++){var a=e?e[o]:o;i[o]=t(n[a],a,n)}return i},m.reduce=m.foldl=m.inject=n(1),m.reduceRight=m.foldr=n(-1),m.find=m.detect=function(n,t,r){var e;return e=k(n)?m.findIndex(n,t,r):m.findKey(n,t,r),e!==void 0&&e!==-1?n[e]:void 0},m.filter=m.select=function(n,t,r){var e=[];return t=x(t,r),m.each(n,function(n,r,u){t(n,r,u)&&e.push(n)}),e},m.reject=function(n,t,r){return m.filter(n,m.negate(x(t)),r)},m.every=m.all=function(n,t,r){t=x(t,r);for(var e=!k(n)&&m.keys(n),u=(e||n).length,i=0;u>i;i++){var o=e?e[i]:i;if(!t(n[o],o,n))return!1}return!0},m.some=m.any=function(n,t,r){t=x(t,r);for(var e=!k(n)&&m.keys(n),u=(e||n).length,i=0;u>i;i++){var o=e?e[i]:i;if(t(n[o],o,n))return!0}return!1},m.contains=m.includes=m.include=function(n,t,r,e){return k(n)||(n=m.values(n)),("number"!=typeof r||e)&&(r=0),m.indexOf(n,t,r)>=0},m.invoke=function(n,t){var r=l.call(arguments,2),e=m.isFunction(t);return m.map(n,function(n){var u=e?t:n[t];return null==u?u:u.apply(n,r)})},m.pluck=function(n,t){return m.map(n,m.property(t))},m.where=function(n,t){return m.filter(n,m.matcher(t))},m.findWhere=function(n,t){return m.find(n,m.matcher(t))},m.max=function(n,t,r){var e,u,i=-1/0,o=-1/0;if(null==t&&null!=n){n=k(n)?n:m.values(n);for(var a=0,c=n.length;c>a;a++)e=n[a],e>i&&(i=e)}else t=x(t,r),m.each(n,function(n,r,e){u=t(n,r,e),(u>o||u===-1/0&&i===-1/0)&&(i=n,o=u)});return i},m.min=function(n,t,r){var e,u,i=1/0,o=1/0;if(null==t&&null!=n){n=k(n)?n:m.values(n);for(var a=0,c=n.length;c>a;a++)e=n[a],i>e&&(i=e)}else t=x(t,r),m.each(n,function(n,r,e){u=t(n,r,e),(o>u||1/0===u&&1/0===i)&&(i=n,o=u)});return i},m.shuffle=function(n){for(var t,r=k(n)?n:m.values(n),e=r.length,u=Array(e),i=0;e>i;i++)t=m.random(0,i),t!==i&&(u[i]=u[t]),u[t]=r[i];return u},m.sample=function(n,t,r){return null==t||r?(k(n)||(n=m.values(n)),n[m.random(n.length-1)]):m.shuffle(n).slice(0,Math.max(0,t))},m.sortBy=function(n,t,r){return t=x(t,r),m.pluck(m.map(n,function(n,r,e){return{value:n,index:r,criteria:t(n,r,e)}}).sort(function(n,t){var r=n.criteria,e=t.criteria;if(r!==e){if(r>e||r===void 0)return 1;if(e>r||e===void 0)return-1}return n.index-t.index}),"value")};var F=function(n){return function(t,r,e){var u={};return r=x(r,e),m.each(t,function(e,i){var o=r(e,i,t);n(u,e,o)}),u}};m.groupBy=F(function(n,t,r){m.has(n,r)?n[r].push(t):n[r]=[t]}),m.indexBy=F(function(n,t,r){n[r]=t}),m.countBy=F(function(n,t,r){m.has(n,r)?n[r]++:n[r]=1}),m.toArray=function(n){return n?m.isArray(n)?l.call(n):k(n)?m.map(n,m.identity):m.values(n):[]},m.size=function(n){return null==n?0:k(n)?n.length:m.keys(n).length},m.partition=function(n,t,r){t=x(t,r);var e=[],u=[];return m.each(n,function(n,r,i){(t(n,r,i)?e:u).push(n)}),[e,u]},m.first=m.head=m.take=function(n,t,r){return null==n?void 0:null==t||r?n[0]:m.initial(n,n.length-t)},m.initial=function(n,t,r){return l.call(n,0,Math.max(0,n.length-(null==t||r?1:t)))},m.last=function(n,t,r){return null==n?void 0:null==t||r?n[n.length-1]:m.rest(n,Math.max(0,n.length-t))},m.rest=m.tail=m.drop=function(n,t,r){return l.call(n,null==t||r?1:t)},m.compact=function(n){return m.filter(n,m.identity)};var S=function(n,t,r,e){for(var u=[],i=0,o=e||0,a=O(n);a>o;o++){var c=n[o];if(k(c)&&(m.isArray(c)||m.isArguments(c))){t||(c=S(c,t,r));var f=0,l=c.length;for(u.length+=l;l>f;)u[i++]=c[f++]}else r||(u[i++]=c)}return u};m.flatten=function(n,t){return S(n,t,!1)},m.without=function(n){return m.difference(n,l.call(arguments,1))},m.uniq=m.unique=function(n,t,r,e){m.isBoolean(t)||(e=r,r=t,t=!1),null!=r&&(r=x(r,e));for(var u=[],i=[],o=0,a=O(n);a>o;o++){var c=n[o],f=r?r(c,o,n):c;t?(o&&i===f||u.push(c),i=f):r?m.contains(i,f)||(i.push(f),u.push(c)):m.contains(u,c)||u.push(c)}return u},m.union=function(){return m.uniq(S(arguments,!0,!0))},m.intersection=function(n){for(var t=[],r=arguments.length,e=0,u=O(n);u>e;e++){var i=n[e];if(!m.contains(t,i)){for(var o=1;r>o&&m.contains(arguments[o],i);o++);o===r&&t.push(i)}}return t},m.difference=function(n){var t=S(arguments,!0,!0,1);return m.filter(n,function(n){return!m.contains(t,n)})},m.zip=function(){return m.unzip(arguments)},m.unzip=function(n){for(var t=n&&m.max(n,O).length||0,r=Array(t),e=0;t>e;e++)r[e]=m.pluck(n,e);return r},m.object=function(n,t){for(var r={},e=0,u=O(n);u>e;e++)t?r[n[e]]=t[e]:r[n[e][0]]=n[e][1];return r},m.findIndex=t(1),m.findLastIndex=t(-1),m.sortedIndex=function(n,t,r,e){r=x(r,e,1);for(var u=r(t),i=0,o=O(n);o>i;){var a=Math.floor((i+o)/2);r(n[a])<u?i=a+1:o=a}return i},m.indexOf=r(1,m.findIndex,m.sortedIndex),m.lastIndexOf=r(-1,m.findLastIndex),m.range=function(n,t,r){null==t&&(t=n||0,n=0),r=r||1;for(var e=Math.max(Math.ceil((t-n)/r),0),u=Array(e),i=0;e>i;i++,n+=r)u[i]=n;return u};var E=function(n,t,r,e,u){if(!(e instanceof t))return n.apply(r,u);var i=j(n.prototype),o=n.apply(i,u);return m.isObject(o)?o:i};m.bind=function(n,t){if(g&&n.bind===g)return g.apply(n,l.call(arguments,1));if(!m.isFunction(n))throw new TypeError("Bind must be called on a function");var r=l.call(arguments,2),e=function(){return E(n,e,t,this,r.concat(l.call(arguments)))};return e},m.partial=function(n){var t=l.call(arguments,1),r=function(){for(var e=0,u=t.length,i=Array(u),o=0;u>o;o++)i[o]=t[o]===m?arguments[e++]:t[o];for(;e<arguments.length;)i.push(arguments[e++]);return E(n,r,this,this,i)};return r},m.bindAll=function(n){var t,r,e=arguments.length;if(1>=e)throw new Error("bindAll must be passed function names");for(t=1;e>t;t++)r=arguments[t],n[r]=m.bind(n[r],n);return n},m.memoize=function(n,t){var r=function(e){var u=r.cache,i=""+(t?t.apply(this,arguments):e);return m.has(u,i)||(u[i]=n.apply(this,arguments)),u[i]};return r.cache={},r},m.delay=function(n,t){var r=l.call(arguments,2);return setTimeout(function(){return n.apply(null,r)},t)},m.defer=m.partial(m.delay,m,1),m.throttle=function(n,t,r){var e,u,i,o=null,a=0;r||(r={});var c=function(){a=r.leading===!1?0:m.now(),o=null,i=n.apply(e,u),o||(e=u=null)};return function(){var f=m.now();a||r.leading!==!1||(a=f);var l=t-(f-a);return e=this,u=arguments,0>=l||l>t?(o&&(clearTimeout(o),o=null),a=f,i=n.apply(e,u),o||(e=u=null)):o||r.trailing===!1||(o=setTimeout(c,l)),i}},m.debounce=function(n,t,r){var e,u,i,o,a,c=function(){var f=m.now()-o;t>f&&f>=0?e=setTimeout(c,t-f):(e=null,r||(a=n.apply(i,u),e||(i=u=null)))};return function(){i=this,u=arguments,o=m.now();var f=r&&!e;return e||(e=setTimeout(c,t)),f&&(a=n.apply(i,u),i=u=null),a}},m.wrap=function(n,t){return m.partial(t,n)},m.negate=function(n){return function(){return!n.apply(this,arguments)}},m.compose=function(){var n=arguments,t=n.length-1;return function(){for(var r=t,e=n[t].apply(this,arguments);r--;)e=n[r].call(this,e);return e}},m.after=function(n,t){return function(){return--n<1?t.apply(this,arguments):void 0}},m.before=function(n,t){var r;return function(){return--n>0&&(r=t.apply(this,arguments)),1>=n&&(t=null),r}},m.once=m.partial(m.before,2);var M=!{toString:null}.propertyIsEnumerable("toString"),I=["valueOf","isPrototypeOf","toString","propertyIsEnumerable","hasOwnProperty","toLocaleString"];m.keys=function(n){if(!m.isObject(n))return[];if(v)return v(n);var t=[];for(var r in n)m.has(n,r)&&t.push(r);return M&&e(n,t),t},m.allKeys=function(n){if(!m.isObject(n))return[];var t=[];for(var r in n)t.push(r);return M&&e(n,t),t},m.values=function(n){for(var t=m.keys(n),r=t.length,e=Array(r),u=0;r>u;u++)e[u]=n[t[u]];return e},m.mapObject=function(n,t,r){t=x(t,r);for(var e,u=m.keys(n),i=u.length,o={},a=0;i>a;a++)e=u[a],o[e]=t(n[e],e,n);return o},m.pairs=function(n){for(var t=m.keys(n),r=t.length,e=Array(r),u=0;r>u;u++)e[u]=[t[u],n[t[u]]];return e},m.invert=function(n){for(var t={},r=m.keys(n),e=0,u=r.length;u>e;e++)t[n[r[e]]]=r[e];return t},m.functions=m.methods=function(n){var t=[];for(var r in n)m.isFunction(n[r])&&t.push(r);return t.sort()},m.extend=_(m.allKeys),m.extendOwn=m.assign=_(m.keys),m.findKey=function(n,t,r){t=x(t,r);for(var e,u=m.keys(n),i=0,o=u.length;o>i;i++)if(e=u[i],t(n[e],e,n))return e},m.pick=function(n,t,r){var e,u,i={},o=n;if(null==o)return i;m.isFunction(t)?(u=m.allKeys(o),e=b(t,r)):(u=S(arguments,!1,!1,1),e=function(n,t,r){return t in r},o=Object(o));for(var a=0,c=u.length;c>a;a++){var f=u[a],l=o[f];e(l,f,o)&&(i[f]=l)}return i},m.omit=function(n,t,r){if(m.isFunction(t))t=m.negate(t);else{var e=m.map(S(arguments,!1,!1,1),String);t=function(n,t){return!m.contains(e,t)}}return m.pick(n,t,r)},m.defaults=_(m.allKeys,!0),m.create=function(n,t){var r=j(n);return t&&m.extendOwn(r,t),r},m.clone=function(n){return m.isObject(n)?m.isArray(n)?n.slice():m.extend({},n):n},m.tap=function(n,t){return t(n),n},m.isMatch=function(n,t){var r=m.keys(t),e=r.length;if(null==n)return!e;for(var u=Object(n),i=0;e>i;i++){var o=r[i];if(t[o]!==u[o]||!(o in u))return!1}return!0};var N=function(n,t,r,e){if(n===t)return 0!==n||1/n===1/t;if(null==n||null==t)return n===t;n instanceof m&&(n=n._wrapped),t instanceof m&&(t=t._wrapped);var u=s.call(n);if(u!==s.call(t))return!1;switch(u){case"[object RegExp]":case"[object String]":return""+n==""+t;case"[object Number]":return+n!==+n?+t!==+t:0===+n?1/+n===1/t:+n===+t;case"[object Date]":case"[object Boolean]":return+n===+t}var i="[object Array]"===u;if(!i){if("object"!=typeof n||"object"!=typeof t)return!1;var o=n.constructor,a=t.constructor;if(o!==a&&!(m.isFunction(o)&&o instanceof o&&m.isFunction(a)&&a instanceof a)&&"constructor"in n&&"constructor"in t)return!1}r=r||[],e=e||[];for(var c=r.length;c--;)if(r[c]===n)return e[c]===t;if(r.push(n),e.push(t),i){if(c=n.length,c!==t.length)return!1;for(;c--;)if(!N(n[c],t[c],r,e))return!1}else{var f,l=m.keys(n);if(c=l.length,m.keys(t).length!==c)return!1;for(;c--;)if(f=l[c],!m.has(t,f)||!N(n[f],t[f],r,e))return!1}return r.pop(),e.pop(),!0};m.isEqual=function(n,t){return N(n,t)},m.isEmpty=function(n){return null==n?!0:k(n)&&(m.isArray(n)||m.isString(n)||m.isArguments(n))?0===n.length:0===m.keys(n).length},m.isElement=function(n){return!(!n||1!==n.nodeType)},m.isArray=h||function(n){return"[object Array]"===s.call(n)},m.isObject=function(n){var t=typeof n;return"function"===t||"object"===t&&!!n},m.each(["Arguments","Function","String","Number","Date","RegExp","Error"],function(n){m["is"+n]=function(t){return s.call(t)==="[object "+n+"]"}}),m.isArguments(arguments)||(m.isArguments=function(n){return m.has(n,"callee")}),"function"!=typeof/./&&"object"!=typeof Int8Array&&(m.isFunction=function(n){return"function"==typeof n||!1}),m.isFinite=function(n){return isFinite(n)&&!isNaN(parseFloat(n))},m.isNaN=function(n){return m.isNumber(n)&&n!==+n},m.isBoolean=function(n){return n===!0||n===!1||"[object Boolean]"===s.call(n)},m.isNull=function(n){return null===n},m.isUndefined=function(n){return n===void 0},m.has=function(n,t){return null!=n&&p.call(n,t)},m.noConflict=function(){return u._=i,this},m.identity=function(n){return n},m.constant=function(n){return function(){return n}},m.noop=function(){},m.property=w,m.propertyOf=function(n){return null==n?function(){}:function(t){return n[t]}},m.matcher=m.matches=function(n){return n=m.extendOwn({},n),function(t){return m.isMatch(t,n)}},m.times=function(n,t,r){var e=Array(Math.max(0,n));t=b(t,r,1);for(var u=0;n>u;u++)e[u]=t(u);return e},m.random=function(n,t){return null==t&&(t=n,n=0),n+Math.floor(Math.random()*(t-n+1))},m.now=Date.now||function(){return(new Date).getTime()};var B={"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#x27;","`":"&#x60;"},T=m.invert(B),R=function(n){var t=function(t){return n[t]},r="(?:"+m.keys(n).join("|")+")",e=RegExp(r),u=RegExp(r,"g");return function(n){return n=null==n?"":""+n,e.test(n)?n.replace(u,t):n}};m.escape=R(B),m.unescape=R(T),m.result=function(n,t,r){var e=null==n?void 0:n[t];return e===void 0&&(e=r),m.isFunction(e)?e.call(n):e};var q=0;m.uniqueId=function(n){var t=++q+"";return n?n+t:t},m.templateSettings={evaluate:/<%([\s\S]+?)%>/g,interpolate:/<%=([\s\S]+?)%>/g,escape:/<%-([\s\S]+?)%>/g};var K=/(.)^/,z={"'":"'","\\":"\\","\r":"r","\n":"n","\u2028":"u2028","\u2029":"u2029"},D=/\\|'|\r|\n|\u2028|\u2029/g,L=function(n){return"\\"+z[n]};m.template=function(n,t,r){!t&&r&&(t=r),t=m.defaults({},t,m.templateSettings);var e=RegExp([(t.escape||K).source,(t.interpolate||K).source,(t.evaluate||K).source].join("|")+"|$","g"),u=0,i="__p+='";n.replace(e,function(t,r,e,o,a){return i+=n.slice(u,a).replace(D,L),u=a+t.length,r?i+="'+\n((__t=("+r+"))==null?'':_.escape(__t))+\n'":e?i+="'+\n((__t=("+e+"))==null?'':__t)+\n'":o&&(i+="';\n"+o+"\n__p+='"),t}),i+="';\n",t.variable||(i="with(obj||{}){\n"+i+"}\n"),i="var __t,__p='',__j=Array.prototype.join,"+"print=function(){__p+=__j.call(arguments,'');};\n"+i+"return __p;\n";try{var o=new Function(t.variable||"obj","_",i)}catch(a){throw a.source=i,a}var c=function(n){return o.call(this,n,m)},f=t.variable||"obj";return c.source="function("+f+"){\n"+i+"}",c},m.chain=function(n){var t=m(n);return t._chain=!0,t};var P=function(n,t){return n._chain?m(t).chain():t};m.mixin=function(n){m.each(m.functions(n),function(t){var r=m[t]=n[t];m.prototype[t]=function(){var n=[this._wrapped];return f.apply(n,arguments),P(this,r.apply(m,n))}})},m.mixin(m),m.each(["pop","push","reverse","shift","sort","splice","unshift"],function(n){var t=o[n];m.prototype[n]=function(){var r=this._wrapped;return t.apply(r,arguments),"shift"!==n&&"splice"!==n||0!==r.length||delete r[0],P(this,r)}}),m.each(["concat","join","slice"],function(n){var t=o[n];m.prototype[n]=function(){return P(this,t.apply(this._wrapped,arguments))}}),m.prototype.value=function(){return this._wrapped},m.prototype.valueOf=m.prototype.toJSON=m.prototype.value,m.prototype.toString=function(){return""+this._wrapped},"function"==typeof define&&define.amd&&define("underscore",[],function(){return m})}).call(this);
//# sourceMappingURL=underscore-min.map


var JS = _;

JS.intt = function (a) {
    return parseInt(a, 10);
};

JS.trim = function (text) {
    var rtrim = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g
    return text == null ? "" : ( text + "" ).replace( rtrim, "" );
};

var Es = function(){};
Es.algo = function() {};

Math.round2 = function(n) {
    if (/\d+\.\d\d5/.test(n.toString())) {
        var match_ret = n.toString().match(/\d+\.\d(\d)/);
        if (match_ret[1] % 2 == 1) {
            return parseFloat(n).toFixed(2);
        } else {
            return parseFloat(match_ret[0]);
        }
    } else {
        return parseFloat(parseFloat(n).toFixed(2));
    }
};

Math.al = function(b, a) {
    var g = 0
        , c = []
        , h = []
        , f = JS.isFunction(a);
    function d(m, i) {
        if (i >= m.length) {
            if (!f || false !== a(h)) {
                c.push(h.slice());
            }
            h.length = i - 1;
        } else {
            var j = m[i];
            for (var k = 0, l = j.length; k < l; k++) {
                h.push(j[k]);
                d(m, i + 1);
            }
            if (i) {
                h.length = i - 1;
            }
        }
    }
    if (b.length) {
        d(b, g);
    }
    return c;
};
Math.cl = function(d, f, a) {
    var b = [];
    function c(h, j, g) {
        if (g === 0 || a && b.length == a) {
            b[b.length] = h;
            return h;
        }
        for (var i = 0, l = j.length - g; i <= l; i++) {
            if (!a || b.length < a) {
                var k = h.slice();
                k.push(j[i]);
                c(k, j.slice(i + 1), g - 1);
            }
        }
    }
    c([], d, f);
    return b;
};

Math.c =  function(len, m) {
    return (function(n1, n2, j, i, n) {
        for (; j <= m;) {
            n2 *= j++;
            n1 *= i--
        }
        return n1 / n2
    })(1, 1, 1, len, len)
};

Math.dt = function(d, t, m) {
    return d >= m ? 0 : Math.c(t, m - d)
};

Math.dtl = function(g, c, f, a) {
    var b = [];
    if (g.length <= f) {
        b = Math.cl(c, f - g.length, a);
        for (var d = b.length; d--; ) {
            b[d] = g.concat(b[d]);
        }
    }
    return b;
};

Math.a = function(b) {
    var c = 1;
    for (var a = 0, d = b.length; a < d; a++) {
        c *= b[a];
    }
    return d ? c : 0;
};

Es.helper = new (function() {
    var cache = {}
        , NM2N1 = {
        '1*1': [1],
        '2*1': [2],
        '3*1': [3],
        '4*1': [4],
        '5*1': [5],
        '6*1': [6],
        '7*1': [7],
        '8*1': [8],
        '3*3': [2],
        '3*4': [2, 3],
        '4*6': [2],
        '4*11': [2, 3, 4],
        '5*10': [2],
        '5*20': [2, 3],
        '5*26': [2, 3, 4, 5],
        '6*15': [2],
        '6*35': [2, 3],
        '6*50': [2, 3, 4],
        '6*57': [2, 3, 4, 5, 6],
        '4*4': [3],
        '4*5': [3, 4],
        '5*16': [3, 4, 5],
        '6*20': [3],
        '6*42': [3, 4, 5, 6],
        '5*5': [4],
        '5*6': [4, 5],
        '6*22': [4, 5, 6],
        '6*6': [5],
        '6*7': [5, 6],
        '7*7': [6],
        '7*8': [6, 7],
        '7*21': [5],
        '7*35': [4],
        '7*120': [2, 3, 4, 5, 6, 7],
        '8*8': [7],
        '8*9': [7, 8],
        '8*28': [6],
        '8*56': [5],
        '8*70': [4],
        '8*247': [2, 3, 4, 5, 6, 7, 8]
    };

    function getN1(nm) {
        if (nm == '单关') {
            nm = '1*1';
        } else {
            nm = nm.replace('串', '*');
        }
        return NM2N1[nm];
    }

    this.getMinGgNum = function(types) {
        var ntypes = [];
        for (var i = types.length; i--; ) {
            ntypes = ntypes.concat(getN1(types[i]));
        }
        ntypes.sort();
        return parseInt(ntypes[0], 10);
    };

    function parseNM(nm) {
        if (!(nm in cache)) {
            if (nm == '单关') {
                cache[nm] = [1, 1, [1]];
            } else {
                var tmp = JS.trim(nm).split('串');
                cache[nm] = [JS.intt(tmp[0]), JS.intt(tmp[1]), getN1(nm)];
            }
        }
        return cache[nm];
    }

    function countNM(code, n1s) {
        code = JS.map(code, function(c) {
            return JS.intt(c);
        });
        return JS.reduce(n1s, function(zs, type) {
            var cl = Math.cl(code, JS.intt(type));
            return zs + JS.reduce(cl, function(zs, g) {
                    return zs + Math.a(g);
                }, 0);
        }, 0);
    }

    this.getCodesCount = function(d, t, n, del) {
        if (n == '单关') {
            return JS.reduce(t, function(s, l) {
                return s + JS.reduce(l, function(s, t) {
                        return s + JS.intt(t);
                    }, 0);
            }, 0);
        }
        var nm = parseNM(n)
            ,
            group = Math.dtl(d, t, nm[0]);
        return JS.reduce(group, function(zs, g) {
            var al = del ? Math.al(g, function(c) {
                    var flag = '-' + c[0].split('-')[1];
                    return JS.some(c, function() {
                        return this.indexOf(flag) === -1;
                    });
                }) : Math.al(g);
            return zs + JS.reduce(al, function(zs, g) {
                    return zs + countNM(g, nm[2]);
                }, 0);
        }, 0);
    };

    this.getAllc1 = function(types) {
        var g = {}
            , g2 = [];
        JS.forEach(types, function(type) {
            JS.forEach(getN1(type), function(t) {
                g[t] = true;
            });
        });
        for (var k in g) {
            g2.push(k == 1 ? '单关' : (k + '串' + 1));
        }
        g2.sort(function(a, b) {
            return parseInt(a, 10) > parseInt(b, 10) ? 1 : -1;
        });
        return g2;
    };

    function splitNM(code, n1s) {
        return JS.reduce(n1s, function(r, type) {
            return r.concat(Math.cl(code, JS.intt(type)));
        }, []);
    }

    this.getSigleCodes = function(d, t, n, del) {
        var nm = parseNM(n), group, len = nm[0], diff = len - (d.length + t.length);
        if (nm[1] > 1 && diff > 0) {
            for (var i = diff; i--; ) {
                t.push([0]);
            }
        }
        //多串中有子串，用0sp值的补全。
        group = Math.dtl(d, t, len);
        return JS.reduce(group, function(codes, g) {
            var al = Math.al(g);
            return codes.concat(JS.reduce(al, function(rc, c) {
                return rc.concat(splitNM(c, nm[2]));
            }, []));
        }, []);
    };
})();


Es.algo.bonus = new (function() {
    var minRec, maxRec, ggTypes, beishu = 1, cache = [], pl_bs;
    function getPlBs() {
        if (!pl_bs) {
            // pl_bs = $('#ggtype').val() == '40' ? 1 : 2;
            pl_bs = 2;
        }
        return pl_bs;
    }

    function num2Max(n) {
        switch (n) {
            case 1:
                return 500 * 10000;
            case 2:
            case 3:
                return 20 * 10000;
            case 4:
            case 5:
                return 50 * 10000;
            default:
                return 100 * 10000;
        }
    }

    function getMaxVal(max, ggType) {
        var mv = 0;
        for (var i = 0, j = ggType.length; i < j; i++) {
            var n = parseInt(ggType[i], 10) || 1;
            mv += num2Max(n);
        }
        return Math.min(max, mv);
    }

    function getBonusSum(list) {
        var cl = {}
            , sum = 0
            , bs = beishu
            , j = list.length;
        for (var i = 0; i < j; i++) {
            var code = list[i]
                , b = 1
                , len = code.length
                , max = num2Max(len);
            for (var x = code.length; x--; ) {
                b *= code[x];
            }
            if (b) {
                sum += Math.round2(Math.min(max, b * getPlBs())) * bs;
                if (!(len in cl)) {
                    cl[len] = 0;
                }
                cl[len]++;
            }
        }
        return {
            bonus: Math.round2(sum),
            codeCount: cl
        };
    }

    function getHitSingleCodes(n, min) {
        var HR = Es.helper
            , list = []
            , dl = []
            , tl = []
            , danSort = min ? minRec.slice() : maxRec.slice()
            , dir = min ? 1 : -1;
        danSort.sort(function(a, b) {
            if (a.isdan === b.isdan) {
                return (a[0] > b[0] ? 1 : -1) * dir;
            }
            else {
                return a.isdan ? -1 : 1;
            }
        });
        JS.forEach(danSort, function(o, i) {
            if (i >= n) {
                var t = [0];
                t.isdan = o.isdan;
                t.sum = o.sum;
                o = t;
            }
            if (o.isdan) {
                dl.push(o);
            } else {
                tl.push(o);
            }
        });
        JS.forEach(ggTypes, function(type) {
            list = list.concat(HR.getSigleCodes(dl, tl, type));
        });
        return list;
    }

    this.getMaxBonus = function(opts, ggType) {
        if (opts.length < 2 && ggType.indexOf('单关') == -1) {
            return 0;
        }
        ggTypes = ggType;
        maxRec = opts;
        return getBonusSum(getHitSingleCodes(opts.length)).bonus;
    };

    this.setBeishu = function(bs) {
        beishu = bs;
        return this;
    };

    this.getHitList = function(min, max, ggType) {
        var list = [], freeTypes, maxCodes, maxSum, minCodes, minSum;
        minRec = min;
        maxRec = max;
        ggTypes = ggType;
        freeTypes = Es.helper.getAllc1(ggTypes);
        cache = [];
        var i = Math.max(maxRec.length, minRec.length)
            , ii = i
            ,
            isSlide = false//document.getElementById('isjprizesuc')
            ,
            min_hit = Es.helper.getMinGgNum(ggTypes);
        function getHitNums(c) {
            return maxSum.codeCount[parseInt(c, 10) || 1] || 0;
        }
        for (; i >= min_hit; i--) {
            if (isSlide && i < ii && i > min_hit) {
                continue;
            }
            maxCodes = getHitSingleCodes(i);
            maxSum = getBonusSum(maxCodes);
            minCodes = getHitSingleCodes(i, true);
            minSum = getBonusSum(minCodes);
            if (isSlide) {
                list.push({
                    min: minSum.bonus,
                    max: maxSum.bonus
                });
            } else {
                cache[i] = [minCodes, minSum, maxCodes, maxSum];
                list.push({
                    num: i,
                    hitNum: JS.map(freeTypes, getHitNums),
                    bs: beishu,
                    min: minSum.bonus,
                    max: maxSum.bonus
                });
            }
        }
        list.ggTypes = freeTypes;
        return list;
    };

    /*
     JS.message.on('Es.algo.jc.get_mx_list', function(hit_num, isMax, color) {
     var cc = cache[hit_num]
     , data = isMax ? cc[2] : cc[0]
     , list = []
     ,
     cl = {}
     , sum = 0
     , bs = beishu;
     color = color || '#005ebb';
     for (var i = 0, j = data.length; i < j; i++) {
     var code = data[i]
     , b = 1
     , len = code.length
     , txt = code.join('×')
     , m = 0
     , max = num2Max(len);
     for (var x = code.length; x--; ) {
     b *= code[x];
     }
     if (b) {
     m = Math.round2(Math.min(max, b * getPlBs())) * bs;
     sum += m;
     if (!(len in cl)) {
     cl[len] = [];
     cl[len].sum = 0;
     }
     cl[len].push(txt + '×' + bs + '倍×2=<strong style="color:' + color + '">' + m.toFixed(2) + '</strong>');
     cl[len].sum += m;
     }
     }
     for (var k in cl) {
     list.push([k - 0, cl[k]]);
     }
     list.sort(function(a, b) {
     return a[0] > b[0] ? -1 : 1;
     });
     list = JS.map(list, function(r, i) {
     return {
     type: r[0],
     zs: r[1].length,
     split: r[1].join('<br>'),
     money: Math.round2(r[1].sum)
     };
     });
     return {
     money: Math.round2(sum),
     zs: j,
     rows: list
     };
     });
     */
})();

Es.algo.jc = new (function() {
    var algo = this
        , allBf = []
        , len = 0
        , bfCheckMap = {};
    for (var i = 0; i < 6; i++) {
        for (var j = 0; j < 6; j++) {
            if (i == 3 && j > 3 || i > 3 && j > 2) {
                continue;
            }
            allBf[len++] = {
                name: i + '' + j,
                sum: i + j,
                diff: Math.abs(i - j),
                spf: i > j ? 3 : (i < j ? 0 : 1)
            };
        }
    }

    allBf.push({
        name: '3A',
        sum: 7,
        spf: 3
    }, {
        name: '1A',
        sum: 7,
        spf: 1
    }, {
        name: '0A',
        sum: 7,
        spf: 0
    });

    for (i = allBf.length; i--; ) {
        var conf = allBf[i]
            , item = {}
            , jqs = conf.sum
            , spf = conf.spf;
        item['bf-' + conf.name] = 1;
        item['jqs-' + jqs] = 1;
        item['nspf-' + spf] = 1;
        if (spf === 3) {
            if (jqs > 2) {
                item['bqc-03'] = 1;
            }
            item['bqc-13'] = 1;
            item['bqc-33'] = 1;
        } else if (spf === 1) {
            if (jqs > 1) {
                item['bqc-01'] = 1;
                item['bqc-31'] = 1;
            }
            item['bqc-11'] = 1;
        } else if (spf === 0) {
            item['bqc-00'] = 1;
            item['bqc-10'] = 1;
            if (jqs > 2) {
                item['bqc-30'] = 1;
            }
        }
        bfCheckMap[conf.name] = item;
    }

    function testRqSpfByBf(str, bf) {
        var rq = parseInt(str.split('#')[0].split('@')[1], 10);
        if (rq > 0) {
            if (bf.name == '0A') {
                if (rq === 1) {
                    return str.indexOf('spf-0') === 0 || str.indexOf('spf-1') === 0;
                }
                return str.indexOf('spf-') === 0;
            }
            if (bf.spf < 1) {
                if (rq < bf.diff) {
                    return str.indexOf('spf-0') === 0;
                } else if (rq === bf.diff) {
                    return str.indexOf('spf-1') === 0;
                }
            }
            return str.indexOf('spf-3') === 0;
        } else {
            rq = Math.abs(rq);
            if (bf.name == '3A') {
                if (rq === 1) {
                    return str.indexOf('spf-3') === 0 || str.indexOf('spf-1') === 0;
                }
                return str.indexOf('spf-') === 0;
            }
            if (bf.spf > 0) {
                if (bf.diff > rq) {
                    return str.indexOf('spf-3') === 0;
                } else if (bf.diff === rq) {
                    return str.indexOf('spf-1') === 0;
                }
            }
            return str.indexOf('spf-0') === 0;
        }
    }

    function filterInvalidOpts(single, bf) {
        var ret = []
            , len = 0
            , filter = bfCheckMap[bf.name];
        function test(str) {
            if (str.indexOf('spf') === 0) {
                return testRqSpfByBf(str, bf);
            }
            return str.split('#')[0] in filter;
        }
        for (var i = 0, j = single.length; i < j; i++) {
            var types = single[i].split(',').filter(test);
            if (types.length) {
                ret[len++] = types;
            }
        }
        return ret;
    }

    function getSgBound(str) {
        var single = str.split('|'), minSum = 9e9, maxSum = -1, isHhgg = !algo.noHhgg,
            minOpts, maxOpts, minBf, maxBf, dan = str.indexOf('D') > -1;
        if (isHhgg) {
            JS.forEach(allBf, function(bf) {
                var optsAl = Math.al(filterInvalidOpts(single, bf)), hits, sum;
                for (var i = 0, j = optsAl.length; i < j; i++) {
                    hits = optsAl[i];
                    sum = 0;
                    for (var k = hits.length; k--; ) {
                        hits[k] = parseFloat(hits[k].split('#')[1]) || 1;
                        sum += hits[k];
                    }
                    if (sum > maxSum) {
                        maxSum = sum;
                        maxOpts = hits.slice();
                        maxBf = bf.name;
                    }
                    if (sum < minSum) {
                        minSum = sum;
                        minOpts = hits.slice();
                        minBf = bf.name;
                    }
                }
            });
        } else {
            var optsAl = str.split(','), sp;
            for (var i = 0, j = optsAl.length; i < j; i++) {
                sp = parseFloat(optsAl[i].split('#')[1]) || 1;
                if (sp > maxSum) {
                    maxSum = sp;
                    maxOpts = [sp];
                }
                if (sp < minSum) {
                    minSum = sp;
                    minOpts = [sp];
                }
            }
        }
        minOpts.sum = minSum;
        minOpts.bf = minBf;
        maxOpts.sum = maxSum;
        maxOpts.bf = maxBf;
        minOpts.isdan = maxOpts.isdan = dan;
        return [minOpts, maxOpts];
    }

    function getLimitOpts(opts) {
        var minOpts = []
            , maxOpts = []
            , j = 0;
        JS.forEach(opts, function(opt) {
            if (opt) {
                var real = getSgBound(opt);
                minOpts[j] = real[0];
                maxOpts[j++] = real[1];
            }
        });
        minOpts.sort(function(a, b) {
            return a.sum > b.sum ? 1 : -1;
        });
        maxOpts.sort(function(a, b) {
            return a.sum > b.sum ? -1 : 1;
        });
        return {
            min: minOpts,
            max: maxOpts
        };
    }

    algo.setBeishu = function(bs) {
        Es.algo.bonus.setBeishu(bs);
        return algo;
    };

    algo.getBfRange = function(opts) {
        return JS.map(opts, function(opt) {
            var real = getSgBound(opt);
            return [real[0].bf, real[1].bf];
        });
    };

    algo.getBonusRange = function(opts, ggType, noMin, bs) {
        if (bs) {
            this.setBeishu(bs);
        }
        if (noMin) {
            return [0, Es.algo.bonus.getMaxBonus(getLimitOpts(opts).max, ggType)];
        } else {
            var info = Es.algo.jc.getHitList(opts, ggType);
            return [info[info.length - 1].min, info[0].max];
        }
    };

    // var opts = ["spf-3@-1#3.95", "nspf-1#3.30|spf-1@-1#3.55", "nspf-3#1.57,nspf-0#4.80|spf-1@-1#3.35", "nspf-3#2.20|spf-1@-1#3.95"];
    // var ggType = ["2串1", "3串1", "4串1"];
    // var data = Es.algo.jc.getHitList(opts, ggType);
    algo.getHitList = function(opts, ggType) {
        var real = getLimitOpts(opts);
        return Es.algo.bonus.getHitList(real.min, real.max, ggType);
    };

    function getPlayNum(code) {
        return JS.map(code.split('|'), function(plays) {
            return plays.split(',').length + '-' + plays.split('-')[0];
        });
    }

    algo.getCodesCount = function(opts, ggType, del) {
        var HR = Es.helper
            , zs = 0
            , dl = []
            , tl = [];
        JS.forEach(opts, function(lc) {
            var gc = getPlayNum(lc);
            gc.isdan = lc.indexOf('D') > -1;
            if (gc.isdan) {
                dl.push(gc);
            } else {
                tl.push(gc);
            }
        });
        JS.forEach(ggType, function(type) {
            zs += HR.getCodesCount(dl, tl, type, del);
        }, this);
        return zs;
    };

})();

Es.algo.jclq = new (function() {
    var algo = this,
        allSfc = [],
        checkMapBySfc = {};
    for (var i = 0; i < 2; i++) { //0=s,1=f
        for (var j = 0; j < 6; j++) {
            allSfc.push({
                name: i + '' + (j + 1),
                diff: j * 5 + 1,
                win: i == 1 ? 2 : 1
            });
        }
    }
    for (var i = allSfc.length; i--;) {
        var curSfc = allSfc[i],
            item = {};
        item['sfc-' + curSfc.name] = 1;
        item['sf-' + curSfc.win] = 1;
        item['dxf-1'] = 1;
        item['dxf-2'] = 1;
        checkMapBySfc[curSfc.name] = item;
    }
    function testRfSfBySfc(str, sfc, def) {
        var rf = parseInt(str.split('#')[0].split('@')[1], 10),
            isSf1 = str.indexOf('rfsf-1') === 0;
        return sfc.win === 1 ? ((rf + sfc.diff < 0) ? !isSf1 : isSf1) :
            ((rf - sfc.diff > 0) ? isSf1 : !isSf1);
    }
    function filterInvalidOpts(single, bf) {
        var ret = [],
            len = 0,
            filter = checkMapBySfc[bf.name];
        function test(str) {
            if (str.indexOf('rfsf-') === 0) {
                return testRfSfBySfc(str, bf);
            }
            return str.split('#')[0] in filter;
        }
        for (var i = 0, j = single.length; i < j; i++) {
            var types = single[i].split(',').filter(test);
            if (types.length) {
                ret[len++] = types;
            }
        }
        return ret;
    }
    function getSgBound(str) {
        var single = str.split('|'),
            minSum = 9e9,
            maxSum = -1,
            isHhgg = !algo.noHhgg,
            minOpts, maxOpts, minBf, maxBf, dan = str.indexOf('D') > -1;
        if (isHhgg) {
            JS.forEach(allSfc, function(bf) {
                var optsAl = Math.al(filterInvalidOpts(single, bf)),
                    hits, sum;
                for (var i = 0, j = optsAl.length; i < j; i++) {
                    hits = optsAl[i];
                    sum = 0;
                    for (var k = hits.length; k--;) {
                        hits[k] = parseFloat(hits[k].split('#')[1]) || 1;
                        sum += hits[k];
                    }
                    if (sum > maxSum) {
                        maxSum = sum;
                        maxOpts = hits.slice();
                        maxBf = bf.name;
                    }
                    if (sum < minSum) {
                        minSum = sum;
                        minOpts = hits.slice();
                        minBf = bf.name;
                    }
                }
            });
        } else {
            var optsAl = str.split(','),
                sp;
            for (var i = 0, j = optsAl.length; i < j; i++) {
                sp = parseFloat(optsAl[i].split('#')[1]) || 1;
                if (sp > maxSum) {
                    maxSum = sp;
                    maxOpts = [sp];
                }
                if (sp < minSum) {
                    minSum = sp;
                    minOpts = [sp];
                }
            }
        }
        minOpts.sum = minSum;
        minOpts.bf = minBf;
        maxOpts.sum = maxSum;
        maxOpts.bf = maxBf;
        minOpts.isdan = maxOpts.isdan = dan;
        return [minOpts, maxOpts];
    }
    function getLimitOpts(opts) {
        var minOpts = [],
            maxOpts = [],
            j = 0;
        JS.forEach(opts, function(opt) {
            if (opt) {
                var real = getSgBound(opt);
                minOpts[j] = real[0];
                maxOpts[j++] = real[1];
            }
        });
        minOpts.sort(function(a, b) {
            return a.sum > b.sum ? 1 : -1;
        });
        maxOpts.sort(function(a, b) {
            return a.sum > b.sum ? -1 : 1;
        });
        return {
            min: minOpts,
            max: maxOpts
        };
    }
    algo.setBeishu = function(bs) {
        Es.algo.bonus.setBeishu(bs);
        return algo;
    };
    algo.getBfRange = function(opts) {
        return JS.map(opts, function(opt) {
            var real = getSgBound(opt);
            return [real[0].bf, real[1].bf];
        });
    };
    algo.getBonusRange = function(opts, ggType, noMin, bs) {
        if (bs) {
            this.setBeishu(bs);
        }
        if (noMin) {
            return [0, Es.algo.bonus.getMaxBonus(getLimitOpts(opts).max, ggType)];
        } else {
            var info = Es.algo.jclq.getHitList(opts, ggType);
            return info.length ? [info[info.length - 1].min, info[0].max] : [0, 0];
        }
    };
    algo.getHitList = function(opts, ggType) {
        var real = getLimitOpts(opts);
        return Es.algo.bonus.getHitList(real.min, real.max, ggType);
    };
    function getPlayNum(code) {
        return JS.map(code.split('|'), function(plays) {
            return plays.split(',').length + '-' + plays.split('-')[0];
        });
    }
    algo.getCodesCount = function(opts, ggType, del) {
        var HR = Es.helper,
            zs = 0,
            dl = [],
            tl = [];
        JS.forEach(opts, function(lc) {
            var gc = getPlayNum(lc);
            gc.isdan = lc.indexOf('D') > -1;
            if (gc.isdan) {
                dl.push(gc);
            } else {
                tl.push(gc);
            }
        });
        JS.forEach(ggType, function(type) {
            zs += HR.getCodesCount(dl, tl, type, del);
        }, this);
        return zs;
    };

})();

/*
 var opts = [
 "spf-3@-1#3.95",
 "nspf-1#3.30|spf-1@-1#3.55",
 "nspf-3#1.57,nspf-0#4.80|spf-1@-1#3.35",
 "nspf-3#2.20|spf-1@-1#3.95"
 ];
 var ggType = ["2串1", "3串1", "4串1"];
 var mutil = 1;
 var result = calc_jczq(opts, ggType, mutil);
 */
function calc_jczq(opts, serials, mutil) {
    mutil = mutil || 1;
    serials = serials || [];

    Es.algo.jc.setBeishu(mutil);
    var codeCount = Es.algo.jc.getCodesCount(opts, serials);
    var hits = Es.algo.jc.getHitList(opts, serials);
    var maxBouns = hits.length ? hits[0].max : 0;
    var minBouns = hits.length ? hits[hits.length - 1].min : 0;
    var result = {min: minBouns, max: maxBouns, codeCount: codeCount};
    return result;
}

/*
 var opts = [
 "sf-1#4.35,sf-2#1.09",
 "sf-1#1.54,sf-2#2|rfsf-1@3.5#1.75",
 "dxf-1#1.69",
 "rfsf-1@-5.5#1.81",
 "sfc-05#20,sfc-06#23,sfc-14#16"
 ];
 var ggType = ["2串1", "3串1"];
 var mutil = 1;
 var result = calc_jclq(opts, ggType, mutil);
 */
function calc_jclq(opts, serials, mutil) {
    mutil = mutil || 1;
    serials = serials || [];

    Es.algo.jclq.setBeishu(mutil);
    var codeCount = Es.algo.jclq.getCodesCount(opts, serials);
    var hits = Es.algo.jclq.getHitList(opts, serials);
    var maxBouns = hits.length ? hits[0].max : 0;
    var minBouns = hits.length ? hits[hits.length - 1].min : 0;
    var result = {min: minBouns, max: maxBouns, codeCount: codeCount};
    return result;
}