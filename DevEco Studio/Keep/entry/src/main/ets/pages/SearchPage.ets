import router from '@ohos.router';

@Entry
@Component
export struct SearchPage {
  build() {
    Column() {
      Row() {
        Text("< 返回")
          .fontSize(16)
          .onClick(() => {
            router.back();
          })
        Text("搜索课程")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Blank()
          .width(30)
      }
      .width("100%")
      .padding(16)

      // 构造参数传入占位提示，兼容极低版本SDK
      TextInput({ text: "", placeholder: "输入课程名称搜索" })
        .width("90%")
        .height(44)
        .margin({ bottom: 30 })

      Blank()
        .layoutWeight(1)
    }
    .width("100%")
    .height("100%")
    .backgroundColor(Color.White)
  }
}