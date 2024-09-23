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