import router from '@ohos.router';

@Entry
@Component
export struct AboutPage {
  build() {
    Column() {
      Row() {
        Text("< 返回")
          .fontSize(16)
          .onClick(() => {
            router.back();
          })
        Text("关于我们")
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Blank()
      }
      .width('100%')
      .padding(15)

      Column() {
        Text("Stick 大学生健身助手")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text("版本号：1.0.0")
          .fontSize(16)
          .fontColor('#666')
          .margin({ top: 20 })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}