### 目录：
#### 一、项目结构
#### 二、UI页面
#### 三、网络请求
#### 四、数据封装
#### 五、路由跳转
#### 六、webview加载
#### 七、华为模拟器的使用
------------------------------------
#### 本文主要介绍一个华为鸿蒙系统（HarmonyOS）使用ArkTS语言开发的实战项目，需要有一定的ArkTS基础。
> 声明：项目中展示数据皆为抓包获取，仅用于项目练手，无商业行为。

![华为模拟器截图-掌盟项目](https://upload-images.jianshu.io/upload_images/4037795-eede58c95b42b83a.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/200)


### 一、项目结构
![项目结构](https://upload-images.jianshu.io/upload_images/4037795-84018dd4522a3aa7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/200)

#### 1、图中1是项目源码
* common中是通用代码，包括网络请求networking、webview；
* entryability里面EntryAbility.ets 可以设置项目入口。比如将原入口 pages/index 改为自定义入口 pages/Tabbar/TabsPage：
```
    windowStage.loadContent('pages/Tabbar/TabsPage', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
```
* Images 是项目要用到的本地图片，是自定义的目录。引用方式：
```
Image('Images/home/home_search@3x.png')
```
也可以放在系统图片目录下 src/main/resources/base/media/home_search.png，引用方式：
```
 Image($r('app.media.home_search'))
```
* pages下是项目页面代码，其中home、mall和mine是三个tabbar的控制器。tabbar下的TabsPage.ets是项目自定义的入口。
* 项目默认的入口页面是Index.ets，即入口为pages/index，如果要使用华为模拟器运行项目，一定要在EntryAbility.ets中修改入口配置为 pages/tabbar/TabsPage。
#### 2、图中2是项目配置
* entry/src/main/resources/base/element/string.json 中可以设置项目名称（包括中文名和英文名）
* entry/src/main/resources/base/media 中可以设置项目图标、启动图

### 二、UI页面
#### 1、tabbar/TabsPage.ets
一般tabbar都会作为项目的启动页面，TabsPage中使用的是Tabs控件，里面只可以使用子组件TabContent，并且子组件TabContent可以自定义每个tabBar，即 TabBuilder。
##### TabsPage页面源码：
```
import {QQHomeController} from "../home/Controller/QQHomeController"
import {QQMallController} from  "../mall/Controller/QQMallController"
import {QQMineController} from "../mine/Controller/QQMineController"

@Entry
@Component
struct TabsPage {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController()

  @Builder TabBuilder(title:string, targetIndex:number, normalImg:string, selectedImg:string) {
    Column() {
      Image(this.currentIndex == targetIndex ? selectedImg : normalImg)
        .width(24)
        .height(24)
      Text(title)
        .fontSize(10)
        .margin({top:5})
        .fontColor(this.currentIndex == targetIndex ? '#0F1114' : '#565D66')
    }
    .backgroundColor('#ffffff')
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.Center)
    .onClick(()=>{
      this.currentIndex = targetIndex
      this.tabsController.changeIndex(this.currentIndex)
    })
  }

  build() {
    RelativeContainer() {
      Column() {
        Tabs({barPosition:BarPosition.End, controller:this.tabsController, index:0}) {
          TabContent() {
            QQHomeController()
          }.tabBar(this.TabBuilder('首页', 0, 'Images/tabbar/tabbar_home_normal.png','Images/tabbar/tabbar_home_select.png'))
          TabContent() {
            QQMallController()
          }.tabBar(this.TabBuilder('商城', 1, 'Images/tabbar/tabbar_mall_normal.png','Images/tabbar/tabbar_mall_select.png'))
          TabContent() {
            QQMineController()
          }.tabBar(this.TabBuilder('我的', 2, 'Images/tabbar/tabbar_mine_normal.png','Images/tabbar/tabbar_mine_select.png'))
        }
      }
    }
    .height('100%')
    .width('100%')
  }
}
```
#### 2、QQHomeController
QQHomeController 作为首页，里面使用了一些常用的控件，比如：
* TabSegmentPage 是自定义的 Segment 控制器，里面使用了控件Tabs（Tabs可以通过设置位置`barPosition: BarPosition.Start`放在顶部，底部和侧边栏来实现不同的效果）来实现的；

##### TabSegmentPage.tes 源码：
```
import { QQChannelModel } from '../../Model/QQChannelModel'

@Entry
@Component
export struct TabSegmentPage {
  @State itemWidth: number = 50
  @State currentIndex: number = 0
  @State channelArray:Array<QQChannelModel> = Array<QQChannelModel>()

  @Builder TabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? '#161616' : '#868c8d')
        .fontSize(this.currentIndex === index ? 18 : 16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .lineHeight(18)
        .margin({top: 10, bottom:5})
      Divider()
        .width(16)
        .strokeWidth(2)
        .color('#202020')
        .opacity(this.currentIndex === index ? 1 : 0)
    }
    // .width('100%')
    .width(this.itemWidth)
    .height('100%')
  }

  build() {
    RelativeContainer() {
      Column() {
        Tabs({ barPosition: BarPosition.Start}) {
          if (this.channelArray.length > 0) {
            ForEach(this.channelArray, (item:QQChannelModel, index) => {
              TabContent() {

              }
              .tabBar(this.TabBuilder(index, item.name ?? ''))
              .margin(0)
            })
          }
        }
        // .width('100%')
        .height('100%')
        // .barWidth('100%')
        .barWidth(this.itemWidth*this.channelArray.length)
        .align(Alignment.Start)
        .vertical(false)
        .scrollable(false)
        .barPosition(BarPosition.Start)
        .barMode(BarMode.Fixed)
        .animationDuration(300)
        .onChange((index:number) => {
          this.currentIndex = index
          console.log('TabSegmentPage index = ',index)
        })
      }
    }
    .height('100%')
    .width('100%')
  }
}
```
QQHomeController 中使用方式：
```
  TabSegmentPage({
    channelArray:this.channelArray
  })
  .width(240)
  .height(44)
  .backgroundColor(Color.White)
```

* Swiper 轮播器，使用起来极其方便，因为实现了第一张和最后一张的轮播效果；
```
      Swiper() {
        ForEach(this.bannerListArray, (item:QQBannerBody, index) => {
          Image(item.imgUrl)
            .onClick(() => {
              router.pushUrl({
                url:'common/webview/QQWebviewController',
                params:{
                  url:item.intent
                }
              })
            })
        })
      }
      .width('100%')
      .height(150)
      .loop(true)
      .autoPlay(true)
      .interval(3000)
      .indicator(Indicator.dot()
        .itemWidth(10)
        .itemHeight(2)
        .selectedItemWidth(15)
        .selectedItemHeight(2)
        .color('#918c8e')
        .selectedColor(Color.White))
```
* Grid 和 GridItem 来实现金刚区效果；
```
      Grid() {
        ForEach(this.iconListArray, (item:QQIconBody, index) => {
          GridItem() {
            Column({space:10}) {
              Image(item.iconUrl)
                .width(55)
                .width(55)
              Text(item.name)
                .fontSize(10)
                .fontColor('#939999')
            }
            .onClick(() => {
              router.pushUrl({
                url:'common/webview/QQWebviewController',
                params:{
                  url:item.intent
                }
              })
            })
          }
          .width('20%')
          .height(80)
        })
      }
      .width('100%')
      .backgroundColor(Color.White)
```
* List 和 ListItem 来实现列表，还可以通过加入ListItemGroup来实现分组效果。
```
          List() {
            ListItemGroup({
              header:this.CustomHeader
            })
            ForEach(this.infoListArray, (item:QQInfoListFeedsInfo, index) => {
              ListItem() {
                // 列表item
                QQInfoItemPage({
                  body:item.feedNews?.body,
                  footer:item.feedNews?.footer
                })
                  .backgroundColor(Color.White)
              }
              .width('100%')
              .height(100)
              .onClick(() => {
                router.pushUrl({
                  url:'common/webview/QQWebviewController',
                  params:{
                    url:''
                  }
                })
              })
            })
          }
          .width('100%')
          .height('100%')
```
在 ListItemGroup 中还可以添加 header 和 footer 。【友情提示：可以通过将顶部内容比如轮播器和金刚区加入到ListItemGroup的header中来实现整体的滑动效果】
```
ListItemGroup({
  header:this.CustomHeader()
})
```
* 页面的生命周期
```
  // 生命周期
  aboutToAppear() {
    console.log('1 aboutToAppear')
  }

  aboutToDisappear() {
    console.log('2 aboutToDisappear')
  }

  aboutToReuse() {
    console.log('3 aboutToReuse')
  }

  onPageShow() {
    console.log('4 onPageShow')
  }

  onPageHide() {
    console.log('5 onPageHide')
  }

  onDidBuild() {
    console.log('6 onDidBuild')
  }
```
### 三、网络请求
导入头文件  import http from '@ohos.net.http'，
通过http封装post和get请求。

##### 里面需要注意的几点：
* 请求header的类型为 Record<string, string>
```
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
```
* 预计请求生成数据可以设置三种STRING、OBJECT、ARRAY_BUFFER，默认为STRING
```
// STRING
expectDataType:http.HttpDataType.STRING
// OBJECT
expectDataType:http.HttpDataType.OBJECT
// ARRAY_BUFFER
expectDataType:http.HttpDataType.ARRAY_BUFFER
```

##### QQNetworkRequest.ets 中通过http封装post和get请求的源码为：
```
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
```
### 四、数据封装
对于网络请求获取的json数据，可以通过方法 JSON.parse(jsonStr) 来转换成对应的数据模型进行使用。
##### 比如网络获取首页banner的json数据为：
```
{"code":0,"data":{"result":0,"next":"0","feedsInfo":[{"feedBase":{"layoutType":"300","contentType":"300","contentId":"plat_banner_plat","intent":"","position":0,"priority":10},"feedNews":{"body":[{"enableWholeBannerClick":true,"isAmsAd":false,"imgUrl":"https://mlol-75948.qpic.cn/common/90376f2042fa865cb6a08a3e4cb43c28.jpg","bigImgUrl":"","intent":"https://lol.qq.com/act/a20240926t1orianna/index.html?exchangeType=1\u0026autoRefreshCookie=1\u0026page=1\u0026qd=true\u0026zmGameId=tft\u0026e_code=508034","title":"全球总决赛限定T1小小奥莉安娜","taskName":"全球总决赛限定T1小小奥莉安娜","contentId":"mlol-46","isVideo":false,"vid":"","reservedDesc":"","packageName":"","universalLink":"","algorithmInfo":{"adid":"4518","actionID":"4518","fname":"全球总决赛限定T1小小奥莉安娜","bannerId":"9","ecode":"508034","from":"mlol","clickEventId":"61505","expoEventId":"61504","gamecode":"tft","url":"https://lol.qq.com/act/a20240926t1orianna/index.html?exchangeType=1\u0026autoRefreshCookie=1\u0026page=1\u0026qd=true\u0026zmGameId=tft"},"extend":{"roomid":""},"commonInfo":{"cover":"https://mlol-75948.qpic.cn/common/90376f2042fa865cb6a08a3e4cb43c28.jpg","type":"image"}},{"enableWholeBannerClick":true,"isAmsAd":false,"imgUrl":"https://mlol-75948.qpic.cn/common/5a111a691f58c17451ef00df16f9fd0c.jpg","bigImgUrl":"","intent":"https://jcc.qq.com/cp/a20240913eo8xcf/index.html?zmGameId=jgame\u0026exchangeType=1\u0026autoRefreshCookie=1\u0026e_code=508035","title":"符文大陆焕新回归 体验抽阿狸雕塑","taskName":"符文大陆焕新回归 体验抽阿狸雕塑","contentId":"mlol-45","isVideo":false,"vid":"","reservedDesc":"","packageName":"","universalLink":"","algorithmInfo":{"adid":"4519","actionID":"4519","fname":"符文大陆焕新回归 体验抽阿狸雕塑","bannerId":"9","ecode":"508035","from":"mlol","clickEventId":"61505","expoEventId":"61504","gamecode":"jgame","url":"https://jcc.qq.com/cp/a20240913eo8xcf/index.html?zmGameId=jgame\u0026exchangeType=1\u0026autoRefreshCookie=1"},"extend":{"roomid":""},"commonInfo":{"cover":"https://mlol-75948.qpic.cn/common/5a111a691f58c17451ef00df16f9fd0c.jpg","type":"image"}},{"enableWholeBannerClick":true,"isAmsAd":false,"imgUrl":"https://mlol-75948.qpic.cn/common/2caa90261d7336313157de60dbf5d9d8.jpg","bigImgUrl":"","intent":"https://lol.qq.com/act/a20240926worldspass/index.html?exchangeType=1\u0026autoRefreshCookie=1\u0026page=1\u0026qd=true\u0026zmGameId=lol\u0026e_code=508036","title":"全球总决赛2024通行证上线","taskName":"全球总决赛2024通行证上线","contentId":"mlol-44","isVideo":false,"vid":"","reservedDesc":"","packageName":"","universalLink":"","memo":"解锁通行证赢取至臻 魔域梦魇 泽丽","algorithmInfo":{"adid":"4520","actionID":"4520","fname":"全球总决赛2024通行证上线","bannerId":"9","ecode":"508036","from":"mlol","clickEventId":"61505","expoEventId":"61504","gamecode":"lol","url":"https://lol.qq.com/act/a20240926worldspass/index.html?exchangeType=1\u0026autoRefreshCookie=1\u0026page=1\u0026qd=true\u0026zmGameId=lol"},"extend":{"roomid":""},"commonInfo":{"cover":"https://mlol-75948.qpic.cn/common/2caa90261d7336313157de60dbf5d9d8.jpg","type":"image"}},{"enableWholeBannerClick":true,"isAmsAd":false,"imgUrl":"https://mlol-75948.qpic.cn/common/8af1b425eeb5c79dbd95558e3595c2b3.png","bigImgUrl":"","intent":"https://mlol.qt.qq.com/go/mlol_news/varcache_article?docid=8961997516292572552\u0026gameid=166\u0026webview=cc\u0026e_code=508037","title":"lolm英雄决斗场","taskName":"lolm英雄决斗场","contentId":"mlol-43","isVideo":false,"vid":"","reservedDesc":"","packageName":"","universalLink":"","algorithmInfo":{"adid":"4516","actionID":"4516","fname":"lolm英雄决斗场","bannerId":"9","ecode":"508037","from":"mlol","clickEventId":"61505","expoEventId":"61504","gamecode":"lgame","url":"https://mlol.qt.qq.com/go/mlol_news/varcache_article?docid=8961997516292572552\u0026gameid=166\u0026webview=cc"},"extend":{"roomid":""},"commonInfo":{"cover":"https://mlol-75948.qpic.cn/common/8af1b425eeb5c79dbd955
```
##### 我们创建对应的数据模型类 QQBannerModel.ets
```

export class QQBannerModel {
  code?: number
  data?: QQBannerData
  msg?: string
  result?: number
}

export class QQBannerData {
  result?: number
  next?: string
  feedsInfo?: Array<QQBannerFeedsInfo>
  attach?: object
  scope?: string
  distance?: number
}

export class QQBannerFeedsInfo {
  feedBase?: QQBannerFeedBase
  feedNews?: QQBannerFeedNews
}

export class QQBannerFeedNews {
  body?: Array<QQBannerBody>
}

export class QQBannerBody {
  enableWholeBannerClick?: boolean
  isAmsAd?: boolean
  imgUrl?: string
  bigImgUrl?: string
  intent?: string
  title?: string
  taskName?: string
  contentId?: string
  isVideo?: boolean
  vid?: string
  reservedDesc?: string
  packageName?: string
  universalLink?: string
  algorithmInfo?: QQBannerAlgorithmInfo
  extend?: QQBannerExtend
  commonInfo?: QQBannerCommonInfo
}

export class QQBannerCommonInfo {
  cover?: string
  type?: string
}

export class QQBannerExtend {
  roomid?: string
}

export class QQBannerAlgorithmInfo {
  adid?: string
  actionID?: string
  fname?: string
  bannerId?: string
  ecode?: string
  from?: string
  clickEventId?: string
  expoEventId?: string
  gamecode?: string
  url?: string
}

export class QQBannerFeedBase {
  layoutType?: string
  contentType?: string
  contentId?: string
  intent?: string
  position?: number
  priority?: number
}
```
##### 推荐一个ArkTS的json转model的一个在线工具，将json放在左边，一键转换。
可以将其中生成的数组类型修改下形式，比如 string[] 修改成 Array<sring>，使用起来更加方便。
[鸿蒙json转对象](https://abnerming888.github.io/vip/json/json.html)

##### 在网络请求获取json的方法中写入以下代码，就可以获取到具体的数据进行渲染了。
```
let model:QQBannerModel = JSON.parse(str)
```
网络请求示例：
```
  // 请求banner数据
  loadHomeRequestBannerData() {
    this.viewModel.loadHomeRequestBannerData((str) => {
      console.log('home Banner 数据',str)
      let model:QQBannerModel = JSON.parse(str)
      // 刷新数据
      let dataModel:QQBannerData = model.data as QQBannerData
      let feedsInfoArray = dataModel.feedsInfo as Array<QQBannerFeedsInfo>
      if (feedsInfoArray.length > 0) {
        let feedsInfo = feedsInfoArray[0]
        let feedNews = feedsInfo.feedNews
        this.bannerListArray = feedNews?.body as Array<QQBannerBody>
      }
      console.log('home Banner 数据 .data ',JSON.parse(str))
    }, (error) => {
      console.log('home Banner 数据 error ',error)
    })
  }
```

### 五、路由跳转
路由跳转就是一个页面跳转另一个页面了，并可以携带参数。
##### 比如首页 QQHomeController 跳转 webview页面QQWebviewController，并携带参数url：
QQHomeController 中点击响应方法中写入路由跳转：
```
router.pushUrl({
  url:'common/webview/QQWebviewController',
  params:{
    url:'https://www.baidu.com'
  }
})
```
QQWebviewController 中返回按钮方法中写入路由返回方法：
```
router.back()
```
对于跳转携带的参数url，可以在QQWebviewController中的生命周期方法中，用以下方式进行接收：
```
  aboutToAppear(): void {
    const param = router.getParams() as Map<string, string>
    this.url = param['url']
  }
```

### 六、webview加载
使用Web控件进行加载url，并与对应的控制器WebviewController进行绑定。
##### 具体QQWebviewController.ets源码：
```
import { webview } from '@kit.ArkWeb'
import { router } from '@kit.ArkUI'
import { JSON } from '@kit.ArkTS'

@Entry
@Component
struct QQWebviewController {
  @State url:string = ''
  controller:WebviewController = new webview.WebviewController()

  aboutToAppear(): void {
    console.log(JSON.stringify(router.getParams()))
    const param = router.getParams() as Map<string, string>
    console.log('wxqtodo url =', param['url'])
    this.url = param['url']
  }

  build() {
    RelativeContainer() {
      Column() {
        Row() {
          Button({type:ButtonType.Normal})
            .width(36)
            .height(36)
            .backgroundImage('Images/common/common_back_icon@3x.png')
            .backgroundColor(Color.Transparent)
            .backgroundImageSize(ImageSize.Contain)
            .margin({
              left:20
            })
            .onClick(() => {
              router.back()
            })
        }
        .width('100%')
        .height(44)
        .justifyContent(FlexAlign.Start)
        Web({
          src: this.url,
          controller: this.controller
        })
      }
    }
    .height('100%')
    .width('100%')
  }
}
```
### 七、华为模拟器的使用

正常在开发中运行某个页面，我们都是使用预览器，可以实时看某一个页面的效果，比较方便。但是预览器只能在pages页面进行使用。使用华为模拟器就可以一键运行整个项目，效果就比较好。

##### 注意：使用模拟器需要提前进行申请并下载

具体的模拟器申请可以参考：[https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ide-emulator-create-V5](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ide-emulator-create-V5)

模拟器使用中遇见问题可以参考：

-----------------------------------------------------
【未完待续】

项目实现效果参考：[华为模拟器录屏](https://www.bilibili.com/video/BV1vUsbeFE39/?vd_source=8ffc4448c0e5ecf3de9bed56d14d0b3f)

项目源码：[HMApp_ArkTS](https://github.com/wuyukobe24/HMApp_ArkTS)


