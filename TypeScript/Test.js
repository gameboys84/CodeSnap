"use strict";
// // 过滤队列中不符合条件的元素
// let lstKeyDown : Array<number> = [1,2,3,2,2,1,2,2];
// let ret = lstKeyDown.filter((value: number, index: number, array: number[]) => {return (value != 2);});
// console.log("lstKeyDown:" + lstKeyDown.toString());
// console.log("ret:" + ret.toString());
// // let str="The rain in SPAIN stays mainly in the plain"; 
// let n = str.match(/ain/g);  // ain,ain,ain
// console.log(n);
var roomUserInfoList = "[{\"userId\":4024796,\"userID\":4024796,\"userProfile\":\"玩家kBMoZrom进入了房间, {\"modelID\":1,\"userName\":\"玩家kBMoZrom\"}\"}]";
var userProfile = "玩家kBMoZrom进入了房间, {\"modelID\":1,\"userName\":\"玩家kBMoZrom\"}";
// let matchReg = /\"userProfile\":.*({[^}]*}\")/;
//let matchString: RegExp = new RegExp();
// let ret = roomUserInfoList.replace(matchReg, "$1");
// let ret2 = roomUserInfoList.match(matchReg);
var matchReg = /{.*}/;
var ret = userProfile.match(matchReg);
console.log(ret);
if (ret) {
    var obj = JSON.parse(ret[0]);
    console.log("obj:" + JSON.stringify(obj));
}
var ret2 = userProfile.replace(matchReg, "$1");
console.log(ret2);
// var reg = /.*uid\=([^\=\&]*).*/;
// var str = "=123&uid=12123&t=4";
// let n = str.match(reg); // Array(2) ["=123&uid=12123&t=4", "12123"]
// console.log(n);
// let s2 = str.replace(reg, "$1");
// console.log(s2);
