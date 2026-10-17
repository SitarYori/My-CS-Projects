// pages/fullpicture.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
export struct FullPicturePage {
  build() {
    Column() {
      // 顶部返回行
      Row() {
        Text("← 返回")
          .fontSize(18)
          .fontColor('#000')
          .onClick(() => {
            // 返回上一页（比赛页面）
            router.back();
          })
        Blank()
      }
      .width('100%')
      .padding({ left: 16, top: 12, bottom: 12 })

      // 纵向滚动长活动图
      Scroll() {
        // 你的完整活动长图，放入 media 文件夹，命名 full_pineapple.png
        Image($r('app.media.pgbl1'))
          .width('100%')
          .objectFit(ImageFit.Contain)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}