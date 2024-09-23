
import { QQHomeViewModel } from "../ViewModel/QQHomeViewModel"
import { QQChannelDataModel, QQChannelModel } from '../Model/QQChannelModel'
import { QQBannerBody, QQBannerData, QQBannerFeedsInfo, QQBannerModel } from '../Model/QQBannerModel'
import { QQIconBody, QQIconData, QQIconFeedsInfo, QQIconModel } from '../Model/QQIconModel'
import { QQInfoListBody,
  QQInfoListData,
  QQInfoListFeedNews, QQInfoListFeedsInfo, QQInfoListModel } from '../Model/QQInfoListModel'
import { router } from '@kit.ArkUI'
import { TabSegmentPage } from '../View/Segment/TabSegmentPage'
import { QQInfoItemPage } from '../View/InfoItem/QQInfoItemPage'

@Entry
@Component
export struct QQHomeController {

  viewModel:QQHomeViewModel = new QQHomeViewModel()
  // 顶部segment数据
  @State channelArray:Array<QQChannelModel> = Array<QQChannelModel>()
  // banner数据
  @State bannerListArray:Array<QQBannerBody> = Array<QQBannerBody>()
  // 金刚区数据
  @State iconListArray:Array<QQIconBody> = Array<QQIconBody>()
  // 列表数据
  @State infoListArray:Array<QQInfoListFeedsInfo> = Array<QQInfoListFeedsInfo>()

  // 生命周期
  aboutToAppear() {
    console.log('1 aboutToAppear')
    // 请求首页segment列表数据
    this.loadHomeRequestSegmentListData()
    // 请求banner数据
    this.loadHomeRequestBannerData()
    // 请求金刚区数据
    this.loadHomeRequestIconData()
    // 请求首页资讯列表数据
    this.loadHomeRequestInfoListData()
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

  // header
  @Builder
  CustomHeader() {
    Column() {
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
      // 金刚区
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
    }
  }

  // 页面入口
  build() {
    RelativeContainer() {
      Stack({
        alignContent:Alignment.TopStart
      }) {
        // 顶部导航
        Row() {
          Button({type:ButtonType.Normal})
            .width(30)
            .height(30)
            .backgroundImage('Images/home/slide_menu_black_icon.png')
            .backgroundImageSize(ImageSize.Contain)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              router.pushUrl({
                url:'common/webview/QQWebviewController',
                params:{
                  url:'https://www.baidu.com'
                }
              })
            })
          Row() {
            // segment
            if (this.channelArray.length > 0) {
              TabSegmentPage({
                channelArray:this.channelArray
              })
                .width(240)
                .height(44)
                .backgroundColor(Color.White)
            }
            Row() {
              Button({type:ButtonType.Normal})
                .width(25)
                .height(25)
                .backgroundImage('Images/home/home_search_icon.png')
                .backgroundImageSize(ImageSize.Contain)
                .backgroundColor(Color.Transparent)
                .onClick(() => {
                  AlertDialog.show({
                    message:'去搜索吧'
                  })
                })
              Button({type:ButtonType.Normal})
                .width(25)
                .height(25)
                .backgroundImage('Images/home/home_forcus_icon.png')
                .backgroundImageSize(ImageSize.Contain)
                .backgroundColor(Color.Transparent)
                .onClick(() => {
                  AlertDialog.show({
                    message:'喜欢就关注哦'
                  })
                })
            }
          }
          // .width('100%')
          .height('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .height(54)
        .backgroundColor(Color.White)
        .justifyContent(FlexAlign.Start)
        .padding({
          left:10,
          right:10
        })
        // 中间内容
        Column() {
          // 课程列表
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
        }
        .margin({
          top:54
        })
      }
    }
    .backgroundColor('#F5F6F7')
    .height('100%')
    .width('100%')
  }

  // 请求首页segment列表数据
  loadHomeRequestSegmentListData() {
    this.viewModel.loadHomeRequestSegmentListData((str) => {
      console.log('home segment 数据',str)
      let dataModel:QQChannelDataModel = JSON.parse(str)
      this.channelArray = dataModel.data as Array<QQChannelModel>
      console.log('home segment 数据 .data ',JSON.parse(str))
    }, (error) => {
      console.log('home segment 数据 error ',error)
    })
  }

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

  // 请求金刚区数据
  loadHomeRequestIconData() {
    this.viewModel.loadHomeRequestIconData((str) => {
      console.log('home Icon 数据',str)
      let model:QQIconModel = JSON.parse(str)
      // 刷新数据
      let dataModel:QQIconData = model.data as QQIconData
      let feedsInfoArray = dataModel.feedsInfo as Array<QQIconFeedsInfo>
      if (feedsInfoArray.length > 0) {
        let feedsInfo = feedsInfoArray[0]
        let feedNews = feedsInfo.feedNews
        this.iconListArray = feedNews?.body as Array<QQIconBody>
      }
      console.log('home Icon 数据 .data ',JSON.parse(str))
    }, (error) => {
      console.log('home Icon 数据 error ',error)
    })
  }

  // 请求首页资讯列表数据
  loadHomeRequestInfoListData() {
    this.viewModel.loadHomeRequestInfoListData((str) => {
      console.log('home InfoList 数据',str)
      let model:QQInfoListModel = JSON.parse(str)
      // 刷新数据
      let dataModel:QQInfoListData = model.data as QQInfoListData
      this.infoListArray = dataModel.feedsInfo as Array<QQInfoListFeedsInfo>
      console.log('home InfoList 数据 .data ',JSON.parse(str))
    }, (error) => {
      console.log('home InfoList 数据 error ',error)
    })
  }

}