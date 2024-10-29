// 使用系统网络框架 @ohos.net.http 进行网络请求，对获取的json需要手动解析后使用。

import http from '@ohos.net.http'
import { JSON } from '@kit.ArkTS';

let header:Record<string, string> = {
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

// post
export function postRequest(url:string, param:Object, success:(str:string)=>void, fail:(error:Error)=>void) {
  let httpRequest = http.createHttp()
  let reponseResult = httpRequest.request(url, {
    method: http.RequestMethod.POST,
    readTimeout:60000,
    connectTimeout:60000,
    header: header,
    extraData: param,
    expectDataType:http.HttpDataType.STRING
  }, (error, data) => {
    if (!error) {
      success(data.result.toString())
      // data.result为HTTP响应内容，可根据业务需要进行解析
      console.info('Networking ====================================');
      console.info('Networking Url:' + url);
      console.info('Networking Result 类型:' + typeof data.result);
      // console.info('Result 类型:' + typeof JSON.stringify(data.result));
      console.info('Networking Result:' + data.result);
      console.info('Networking code:' + data.responseCode);
      // data.header为HTTP响应头，可根据业务需要进行解析
      console.info('Networking header:' + JSON.stringify(data.header));
      console.info('Networking cookies:' + data.cookies); // 8+
      console.info('Networking ====================================');
    } else {
      fail(error)
      console.info('Networking error:' + JSON.stringify(error));
      // 当该请求使用完毕时，调用destroy方法主动销毁。
      httpRequest.destroy();
    }
  })
}

// get
export function getRequest(url:string, param:Object, success:(str:string)=>void, fail:(error:Error)=>void) {
  let httpRequest = http.createHttp()
  let reponseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    readTimeout:60000,
    connectTimeout:60000,
    header: header,
    extraData: param,
    expectDataType:http.HttpDataType.STRING
  }, (error, data) => {
    if (!error) {
      success(data.result.toString())
      // data.result为HTTP响应内容，可根据业务需要进行解析
      console.info('Networking ====================================');
      console.info('Networking Url:' + url);
      console.info('Networking Result 类型:' + typeof data.result);
      // console.info('Result 类型:' + typeof JSON.stringify(data.result));
      console.info('Networking Result:' + data.result);
      console.info('Networking code:' + data.responseCode);
      // data.header为HTTP响应头，可根据业务需要进行解析
      console.info('Networking header:' + JSON.stringify(data.header));
      console.info('Networking cookies:' + data.cookies); // 8+
      console.info('Networking ====================================');
    } else {
      fail(error)
      console.info('error:' + JSON.stringify(error));
      // 当该请求使用完毕时，调用destroy方法主动销毁。
      httpRequest.destroy();
    }
  })
}

export function getFullUrl(url: string): string {
  return "https://mlol.qt.qq.com" + url
}

