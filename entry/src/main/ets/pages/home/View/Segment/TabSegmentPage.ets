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