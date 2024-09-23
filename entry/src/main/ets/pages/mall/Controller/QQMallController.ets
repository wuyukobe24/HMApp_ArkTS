@Entry
@Component
export struct QQMallController {
  @State message: string = '商城';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('QQMallControllerHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}