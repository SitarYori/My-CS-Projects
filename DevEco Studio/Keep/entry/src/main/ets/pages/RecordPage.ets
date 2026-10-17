import router from '@ohos.router';

@Entry
@Component
export struct RecordPage {
  build() {
    Column() {
      Row() {
        Text("< 返回")
          .fontSize(16)
          .onClick(() => {
            router.back();
          })
        Text("运动记录")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
        Blank()
      }
      .width('100%')
      .padding(16)

      Row() {
        Text("数据概览 AI Beta")
          .fontSize(18)
          .fontColor("#999")
        Text("全部数据")
          .fontSize(18)
          .fontColor("#999")
        Text("运动记录")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .padding({bottom:6})
          .border({width:{bottom:3}, color:"#000"})
      }
      .width("100%")
      .padding({ left:16, right:16 })

      Row() {
        Text("⟳ 运动数据同步")
          .fontSize(16)
          .fontColor("#7B61FF")
        Blank()
        Text(">")
          .fontColor("#999")
      }
      .width("92%")
      .margin({ left:"4%", top:15 })
      .padding({top:12, bottom:12, left:12, right:12})
      .backgroundColor("#F8F8FF")
      .borderRadius(10)

      Blank().layoutWeight(1)

      Stack() {
        Rect().width(130).height(90).fill("#EAEAEA").translate({x:8,y:8})
        Rect().width(140).height(80).fill("#86E8B8")
        Rect().width(120).height(70).fill("#DDD").translate({x:-8,y:-8})
      }
      .width(140)
      .height(120)
      .margin({bottom:20})

      Text("最近一年没有活动了，现在就行动！")
        .fontSize(20)
        .fontColor("#666")
      Text("快来探索你的运动方式吧！")
        .fontSize(16)
        .fontColor("#999")
        .margin({top:8, bottom:30})

      Button("立即开始", {stateEffect:true})
        .width("50%")
        .height(52)
        .backgroundColor("#36C987")
        .fontSize(18)
        .fontColor(Color.White)
        .borderRadius(26)
        .onClick(()=>{
          router.replaceUrl({url:"pages/MainPage"})
        })

      Blank().height(40)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}