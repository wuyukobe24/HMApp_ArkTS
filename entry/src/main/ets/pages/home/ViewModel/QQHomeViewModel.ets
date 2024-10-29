// import {postRequest, getRequest, getFullUrl} from "../../../common/networking/QQNetworkRequest"
import {postRequest, getRequest, header} from "../../../common/networking/QQNetworkRequestNET"
import { Net, NetError } from '@abner/net'
import { JSON } from '@kit.ArkTS'
import { QQBannerModel } from '../Model/QQBannerModel'

export class QQHomeViewModel {


  // 获取首页Segment数据
  loadHomeRequestSegmentListData(success:(str:string)=>void, fail:(error:NetError)=>void) {
    let param:Record<string, string> = {

    }
    let url:string = '/go/zone/v3/channel?zone=plat'
    getRequest(url, param, (jsonStr:string) => {
      success(jsonStr)
    }, (error:NetError) => {
      console.error(`viewmodel Segment error:${JSON.stringify(error)}`)
      fail(error)
    })
  }

  // 获取首页banner数据
  loadHomeRequestBannerData(success:(str:string)=>void, fail:(error:NetError)=>void) {
    let param:Record<string, string> = {
      // "zone":"plat",
      // "subch":"66",
      // "refreshInterval":"10",
      // "resourceId":"4",
      // "favzone":"",
      // "subChannel":"1",
      // "slidetype":"0",
      // "next":"0",
    }
    // let url:string = getFullUrl('/go/recommend/platbanner')
    let url:string = '/go/recommend/platbanner?refresh_type=insert&zone=plat&favzone=&resourceId=1&subChannel=1&slidetype=0&next=0'
    getRequest(url, param, (jsonStr:string) => {
      success(jsonStr)
    }, (error:NetError) => {
      console.error(`viewmodel banner error:${JSON.stringify(error)}`)
      fail(error)
    })
  }

  // 获取首页金刚区数据【使用三方库Net进行网络请求，使用requestString对获取的json数据自己进行数据解析】
  loadHomeRequestIconData(success:(str:string)=>void, fail:(error:NetError)=>void) {
    let param:Record<string, string> = {
      "game":"game_zone",
      "priority":"5",
      "favzone":"",
      "subChannel":"1",
      "slidetype":"0",
      "next":"0",
    }
    let url:string = '/go/zone/icon_card'
    getRequest(url, param, (jsonStr:string) => {
      success(jsonStr)
    }, (error:NetError) => {
      console.error(`viewmodel Segment error:${JSON.stringify(error)}`)
      fail(error)
    })
  }

  // 获取首页金刚区数据2【使用三方库Net进行网络请求，使用requestObject获取封装好的数据】
  loadHomeRequestIconDataNew(success:(model:QQBannerModel)=>void, fail:(error:NetError)=>void) {
    let param:Record<string, string> = {
      "game":"game_zone",
      "priority":"5",
      "favzone":"",
      "subChannel":"1",
      "slidetype":"0",
      "next":"0",
    }
    let url:string = '/go/zone/icon_card'
    Net.get(url).setParams(param).setHeaders(header).requestObject<QQBannerModel>((data) => {
      success(data)
    }, (error) => {
      fail(error)
    })
  }

  // 请求首页资讯列表数据
  loadHomeRequestInfoListData(success:(str:string)=>void, fail:(error:NetError)=>void) {
    let param:Record<string, string> = {
      "main_feeds":"1",
      "plat":"iOS",
      "ip":"0.0.0.0",
      "network":"wifi",
      "favzone":"",
      "zone":"plat",
      "channel":"1",
      "transport":"docids%3D6004640787272757818%252C1642662437979068205%26end_index%3D2",
      "disableAlgo":"1",
      "pic_size":"384x204",
      "waterflow":"$WaterFlow$",
      "subChannel":"1",
      "slidetype":"0",
      "next":"0",
    }
    // https://mlol.qt.qq.com/go/mlol_news/recommend_feeds?main_feeds=1&plat=iOS&ip=0.0.0.0&network=wifi&favzone=&zone=plat&channel=1&transport=docids%3D6004640787272757818%252C1642662437979068205%26end_index%3D2&disableAlgo=1&pic_size=384x204&waterflow=$WaterFlow$&subChannel=1&slidetype=0&next=0
    let url:string = '/go/mlol_news/recommend_feeds'
    getRequest(url, param, (jsonStr:string) => {
      success(jsonStr)
    }, (error:NetError) => {
      console.error(`viewmodel Segment error:${JSON.stringify(error)}`)
      fail(error)
    })
  }
}
