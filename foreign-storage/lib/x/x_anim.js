/* x_anim.js compiled from X 4.0 with XC 0.27b. Distributed by GNU LGPL. For copyrights, license, documentation and more visit Cross-Browser.com */
function xEllipse(e, xRadius, yRadius, radiusInc, totalTime, startAngle, stopAngle){if (!(e=xGetElementById(e))) return;if (!e.timeout) e.timeout = 25;e.xA = xRadius;e.yA = yRadius;e.radiusInc = radiusInc;e.slideTime = totalTime;startAngle *= (Math.PI / 180);stopAngle *= (Math.PI / 180);var startTime = (startAngle * e.slideTime) / (stopAngle - startAngle);e.stopTime = e.slideTime + startTime;e.B = (stopAngle - startAngle) / e.slideTime;e.xD = xLeft(e) - Math.round(e.xA * Math.cos(e.B * startTime)); e.yD = xTop(e) - Math.round(e.yA * Math.sin(e.B * startTime)); e.xTarget = Math.round(e.xA * Math.cos(e.B * e.stopTime) + e.xD); e.yTarget = Math.round(e.yA * Math.sin(e.B * e.stopTime) + e.yD); var d = new Date();e.C = d.getTime() - startTime;if (!e.moving) {e.stop=false; _xEllipse(e);}}function _xEllipse(e){if (!(e=xGetElementById(e))) return;var now, t, newY, newX;now = new Date();t = now.getTime() - e.C;if (e.stop) { e.moving = false; }else if (t < e.stopTime) {setTimeout("_xEllipse('"+e.id+"')", e.timeout);if (e.radiusInc) {e.xA += e.radiusInc;e.yA += e.radiusInc;}newX = Math.round(e.xA * Math.cos(e.B * t) + e.xD);newY = Math.round(e.yA * Math.sin(e.B * t) + e.yD);xMoveTo(e, newX, newY);e.moving = true;}  else {if (e.radiusInc) {e.xTarget = Math.round(e.xA * Math.cos(e.B * e.slideTime) + e.xD);e.yTarget = Math.round(e.yA * Math.sin(e.B * e.slideTime) + e.yD); }xMoveTo(e, e.xTarget, e.yTarget);e.moving = false;}  }function xParaEq(e, xExpr, yExpr, totalTime){if (!(e=xGetElementById(e))) return;e.t = 0;e.tStep = .008;if (!e.timeout) e.timeout = 25;e.xExpr = xExpr;e.yExpr = yExpr;e.slideTime = totalTime;var d = new Date();e.C = d.getTime();if (!e.moving) {e.stop=false; _xParaEq(e);}}function _xParaEq(e){if (!(e=xGetElementById(e))) return;var now = new Date();var et = now.getTime() - e.C;e.t += e.tStep;t = e.t;if (e.stop) { e.moving = false; }else if (!e.slideTime || et < e.slideTime) {setTimeout("_xParaEq('"+e.id+"')", e.timeout);var p = xParent(e), centerX, centerY;centerX = (xWidth(p)/2)-(xWidth(e)/2);centerY = (xHeight(p)/2)-(xHeight(e)/2);e.xTarget = Math.round((eval(e.xExpr) * centerX) + centerX) + xScrollLeft(p);e.yTarget = Math.round((eval(e.yExpr) * centerY) + centerY) + xScrollTop(p);xMoveTo(e, e.xTarget, e.yTarget);e.moving = true;}  else {e.moving = false;}  }function xSlideCornerTo(e, corner, targetX, targetY, totalTime){if (!(e=xGetElementById(e))) return;if (!e.timeout) e.timeout = 25;e.xT = targetX;e.yT = targetY;e.slideTime = totalTime;e.corner = corner.toLowerCase();e.stop = false;switch(e.corner) {case 'nw': e.xA = e.xT - xLeft(e); e.yA = e.yT - xTop(e); e.xD = xLeft(e); e.yD = xTop(e); break;case 'sw': e.xA = e.xT - xLeft(e); e.yA = e.yT - (xTop(e) + xHeight(e)); e.xD = xLeft(e); e.yD = xTop(e) + xHeight(e); break;case 'ne': e.xA = e.xT - (xLeft(e) + xWidth(e)); e.yA = e.yT - xTop(e); e.xD = xLeft(e) + xWidth(e); e.yD = xTop(e); break;case 'se': e.xA = e.xT - (xLeft(e) + xWidth(e)); e.yA = e.yT - (xTop(e) + xHeight(e)); e.xD = xLeft(e) + xWidth(e); e.yD = xTop(e) + xHeight(e); break;default: alert("xSlideCornerTo: Invalid corner"); return;}e.B = Math.PI / ( 2 * e.slideTime );var d = new Date();e.C = d.getTime();if (!e.moving) _xSlideCornerTo(e);}function _xSlideCornerTo(e){if (!(e=xGetElementById(e))) return;var now, seX, seY;now = new Date();t = now.getTime() - e.C;if (e.stop) { e.moving = false; e.stop = false; return; }else if (t < e.slideTime) {setTimeout("_xSlideCornerTo('"+e.id+"')", e.timeout);s = Math.sin( e.B * t );newX = Math.round(e.xA * s + e.xD);newY = Math.round(e.yA * s + e.yD);}else { newX = e.xT; newY = e.yT; }  seX = xLeft(e) + xWidth(e);seY = xTop(e) + xHeight(e);switch(e.corner) {case 'nw': xMoveTo(e, newX, newY); xResizeTo(e, seX - xLeft(e), seY - xTop(e)); break;case 'sw': if (e.xT != xLeft(e)) { xLeft(e, newX); xWidth(e, seX - xLeft(e)); } xHeight(e, newY - xTop(e)); break;case 'ne': xWidth(e, newX - xLeft(e)); if (e.yT != xTop(e)) { xTop(e, newY); xHeight(e, seY - xTop(e)); } break;case 'se': xWidth(e, newX - xLeft(e)); xHeight(e, newY - xTop(e)); break;default: e.stop = true;}e.moving = true;if (t >= e.slideTime) {e.moving = false;}}