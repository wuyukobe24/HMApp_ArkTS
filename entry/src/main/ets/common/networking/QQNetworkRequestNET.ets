// 使用三方网络框架Net进行网络请求，可以通过以下三只方式获取数据进行使用：
// 1、request：对获取的数据封装成需要的model类型，只返回需要的data对象，不会携带外层的code、message等其他参数。
// 2、requestObject：对获取的数据封装成需要的model类型，会返回的整个json对应的对象，也就是包含了code，message等字段。
// 3、requestString：就是普通的返回请求回来的json字符串。

import { Net, NetError } from '@abner/net'

export let header:Record<string, string> = {
  'Cookie': 'tgw_l7_route=0f7eb4ab2f1d32df0ff24f07ba0cf8db; clientType=10; accountType=255',
  'qimei': '4f1c8ff7-4677-4c0a-9ac3-831c9dd865df',
  'accept': '*/*',
  'accept-encoding': 'gzip, deflate, br',
  'Content-Type': 'application/json',
  'user-agent': 'QTL/9.2.5 (iPhone; IOS 18.0; Scale/3.00)',
  'connection': 'keep-alive',
  'gh-header': '1-2-105-925-0',
  'subchannel': '1',
  'accept-language': 'zh-Hans-CN;q=1, zh-Hant-MO;q=0.9, en-CN;q=0.8',
};

// requestString方法：获取请求返回的json字符串
// post
export function postRequest(url:string, param:Object, success:(str:string)=>void, fail:(error:NetError)=>void) {
  Net.post(url).setParams(param).setHeaders(header).requestString((data) => {
    success(data.toString())
  }, (error) => {
    fail(error)
  })
}

// get
export function getRequest(url:string, param:Object, success:(str:string)=>void, fail:(error:NetError)=>void) {
  Net.get(url).setParams(param).setHeaders(header).requestString((data) => {
    success(data.toString())
  }, (error) => {
    fail(error)
  })
}

// requestObject方法：获取请求返回的json对应的对象
// get
// export function getRequestObject<T>(url:string, param:Object, model:T, success:(str:string)=>void, fail:(error:NetError)=>void) {
//   Net.get(url).setParams(param).setHeaders(header).requestObject<l22>((data) => {
//     success(data.toString())
//   }, (error) => {
//     fail(error)
//   })
// }