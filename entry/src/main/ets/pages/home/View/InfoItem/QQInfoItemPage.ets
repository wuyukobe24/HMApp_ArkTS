import { QQInfoListBody, QQInfoListFooter } from '../../Model/QQInfoListModel'

@Entry
@Component
export struct QQInfoItemPage {
  @State body: QQInfoListBody = new QQInfoListBody()
  @State footer: QQInfoListFooter = new QQInfoListFooter()

  build() {
    RelativeContainer() {
      Row() {
        Column() {
          Text(this.body.title)
            .width('100%')
            .fontSize(16)
            .fontColor('#1e1e1e')
            .lineHeight(20)
            .maxLines(2)
            .textOverflow({overflow:TextOverflow.Ellipsis})
          Row({space:10}) {
            Text(this.footer.zoneName)
              .fontColor('#65b8c3')
              .fontSize(12)
              .fontWeight(500)
              .backgroundColor('#ecf6f8')
              .borderRadius(4)
              .padding(4)
            Text(this.footer.source)
              .fontColor('#a2acb4')
              .fontSize(14)
            Row() {
              Image('Images/home/home_message_icon.png')
                .width(20)
                .height(15)
              Text(this.footer.commentCount?.toString())
                .fontColor('#a8b1b9')
                .fontSize(12)
            }
            .opacity(this.footer.commentCount ? 1 : 0)
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
        }
        .width('60%')
        .height('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding(10)
        Image(this.body.imgUrl)
          .width('40%')
          .height(80)
      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .height('100%')
    .width('100%')
  }
}