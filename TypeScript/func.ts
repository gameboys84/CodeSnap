
// 过滤队列中不符合条件的元素
let lstKeyDown : Array<number> = [1,2,3,2,2,1,2,2];
let ret = lstKeyDown.filter((value: number, index: number, array: number[]) => {return (value != 2);});
console.log("lstKeyDown:" + lstKeyDown.toString());
console.log("ret:" + ret.toString());

