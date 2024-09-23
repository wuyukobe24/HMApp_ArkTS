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
    console.log('Webview url =', param['url'])
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