// pages/SettingPage.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
export struct SettingPage {
  build() {
    Column() {
      // 顶部导航
      Row() {
        Text("<")
          .fontSize(22)
          .onClick(() => router.back())
        Blank().layoutWeight(1)
        Text("设置")
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
        Blank().layoutWeight(1)
        Blank().width(22)
      }
      .width('100%')
      .padding({ left:16, right:16, top:12, bottom:20 })
      .backgroundColor(Color.White)

      Scroll() {
        Column() {
          // 账号分组
          Text("账号")
            .fontSize(18)
            .fontColor("#999")
            .width("100%")
            .padding({ left:16, top:12, bottom:10 })
            .backgroundColor("#F7F7F7")
          this.SetItem("运动名片", "👤", "")
          this.SetItem("个人基本信息", "", "")
          this.SetItem("账号与安全", "", "")
          this.SetItem("未成年人模式", "", "未开启")
          this.SetItem("隐私设置", "", "")
          this.SetItem("收货地址", "", "")

          // 通用分组
          Text("通用")
            .fontSize(18)
            .fontColor("#999")
            .width("100%")
            .padding({ left:16, top:12, bottom:10 })
            .backgroundColor("#F7F7F7")
          this.SetItem("运动设置", "", "")
          this.SetItem("消息与提醒", "", "")
          this.SetItem("通用设置", "", "")
          this.SetItem("网络诊断", "", "")
          this.SetItem("律动Stick实验室", "", "")
          this.SetItem("App个性化", "", "")

          // 关于分组
          Text("关于")
            .fontSize(18)
            .fontColor("#999")
            .width("100%")
            .padding({ left:16, top:12, bottom:10 })
            .backgroundColor("#F7F7F7")
          this.SetItem("个人信息收集清单", "", "")
          this.SetItem("第三方信息共享清单", "", "")
          this.SetItem("隐私政策摘要", "", "")
          this.SetItem("协议与条款", "", "")
          this.SetItem("运动风险须知", "", "")
          this.SetItem("关于律动Stick", "", "")

          Blank().height(30)
          // 退出登录
          Text("退出登录")
            .fontSize(20)
            .fontColor("#E64340")
            .width("100%")
            .textAlign(TextAlign.Center)
            .padding({ top:16, bottom:16 })
            .backgroundColor(Color.White)
            .onClick(()=>{
              promptAction.showToast({message:"已退出登录",duration:1000})
              setTimeout(()=>router.replaceUrl({url:"pages/Index"}),1000)
            })
          Blank().height(20)
          // 底部隐私政策文字
          Text("《律动Stick隐私政策》")
            .fontSize(16)
            .fontColor("#36C987")
            .width("100%")
            .textAlign(TextAlign.Center)
            .onClick(()=>promptAction.showToast({message:"查看隐私政策",duration:800}))
          Blank().height(40)
        }
        .width("100%")
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
    }
    .width("100%")
    .height("100%")
    .backgroundColor(Color.White)
  }

  // 设置条目公共组件
  @Builder
  SetItem(title:string, icon:string, tip:string) {
    Row() {
      if(icon.length>0){
        Text(icon).fontSize(22).margin({right:12})
      }
      Text(title).fontSize(20).layoutWeight(1)
      if(tip.length>0){
        Text(tip).fontSize(18).fontColor("#999").margin({right:8})
      }
      Text(">").fontSize(22).fontColor("#CCC")
    }
    .width("100%")
    .padding({left:16, right:16, top:14, bottom:14})
    .backgroundColor(Color.White)
    .onClick(()=>promptAction.showToast({message:title,duration:600}))
  }
}