// pages/FeedbackPage.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
export struct FeedbackPage {
  build() {
    Column() {
      // 顶部导航
      Row() {
        Text("<")
          .fontSize(22)
          .onClick(()=>router.back())
        Blank().layoutWeight(1)
        Text("帮助中心")
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
        Blank().layoutWeight(1)
        Text("反馈记录")
          .fontSize(18)
          .fontColor("#333")
          .onClick(()=>promptAction.showToast({message:"反馈记录",duration:800}))
      }
      .width("100%")
      .padding({left:16, right:16, top:12, bottom:16})
      .backgroundColor(Color.White)

      Scroll() {
        Column() {
          // 公告栏
          Row() {
            Text("📢")
              .fontSize(16)
              .fontColor("#E64340")
            Text("服务公告 | 关于谨防诈骗的公告")
              .fontSize(16)
              .fontColor("#333")
          }
          .width("100%")
          .padding({left:16, right:16, top:10, bottom:10})
          .backgroundColor("#FFF9D8")

          // 自助工具标题
          Text("自助工具")
            .fontSize(20)
            .fontColor("#333")
            .width("100%")
            .padding({left:16, top:20, bottom:12})
          // 工具网格 3行4列 修复Grid列配置
          Grid(){
            this.ToolItem("🔒","帐号管理")
            this.ToolItem("👤","信息修改")
            this.ToolItem("✅","达人认证")
            this.ToolItem("📎","硬件售后")

            this.ToolItem("⚧","教练性别")
            this.ToolItem("💎","会员记录")
            this.ToolItem("⚠️","申诉管理")
            this.ToolItem("🔔","催发货")

            this.ToolItem("🧾","申请发票")
            this.ToolItem("💱","会员续费管理")
            this.ToolItem("🎁","联合会员赠礼")
            this.ToolItem("🎁","会员福利社")
          }
          .columnsTemplate("1fr 1fr 1fr 1fr") // 标准4等分网格配置，替换错误.columns(4)
          .width("100%")
          .padding({left:10, right:10})

          Blank().height(30)
          // 常见问题标题
          Row() {
            Text("常见问题")
              .fontSize(20)
              .fontColor("#333")
              .layoutWeight(1)
            Text("全部问题")
              .fontSize(18)
              .fontColor("#999")
          }
          .width("100%")
          .padding({left:16, right:16})
          Divider().width(80).margin({top:6, bottom:16})

          // 问题列表
          this.QuestionItem("付费赛报名后，可以更换组别及套餐么？")
          this.QuestionItem("报名后，可以取消报名并退款吗？")
          this.QuestionItem("未完成比赛还能获得奖牌吗？")
          this.QuestionItem("AI教练")
          this.QuestionItem("如何关闭会员自动续费")
          this.QuestionItem("会员兑换码如何使用")
          this.QuestionItem("活动奖品发货时间及进度查询")

          Blank().layoutWeight(1)
          Blank().height(40)
          // 底部双按钮
          Row() {
            Column({space:6}) {
              Text("🎧").fontSize(28)
              Text("联系客服").fontSize(16)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .onClick(()=>promptAction.showToast({message:"联系客服",duration:800}))

            Column({space:6}) {
              Text("✉️").fontSize(28)
              Text("意见反馈").fontSize(16)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .onClick(()=>promptAction.showToast({message:"意见反馈",duration:800}))
          }
          .width("100%")
          .padding({top:20, bottom:30})
          .backgroundColor(Color.White)
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

  // 自助工具格子
  @Builder
  ToolItem(icon:string, title:string) {
    Column({space:8}) {
      Text(icon).fontSize(32).fontColor("#36C987")
      Text(title).fontSize(14).fontColor("#333")
    }
    .width("100%")
    .alignItems(HorizontalAlign.Center)
    .padding({top:8, bottom:8})
    .onClick(()=>promptAction.showToast({message:title,duration:600}))
  }

  // 问题条目
  @Builder
  QuestionItem(text:string) {
    Row() {
      Text(text)
        .fontSize(18)
        .fontColor("#333")
        .layoutWeight(1)
      Text(">").fontSize(20).fontColor("#CCC")
    }
    .width("100%")
    .padding({left:16, right:16, top:14, bottom:14})
    .onClick(()=>promptAction.showToast({message:text,duration:600}))
  }
}