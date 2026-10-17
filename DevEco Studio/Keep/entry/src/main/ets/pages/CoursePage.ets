import router from '@ohos.router';

@Entry
@Component
export struct CoursePage {
  @State currentTabIndex: number = 0;
  // 二级子Tab下标
  @State createSubIdx: number = 0;
  @State wantSubIdx: number = 0;
  @State doneSubIdx: number = 0;

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text("< 返回")
          .fontSize(16)
          .onClick(() => {
            router.back();
          })
        Text("我的课程")
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Blank()
          .width(30)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 16 })

      // 一级分类Tab：我创建的、想练、练过、订阅（移除更多）
      Row() {
        Text("我创建的")
          .fontSize(17)
          .fontColor(this.currentTabIndex === 0 ? "#000000" : "#999999")
          .fontWeight(this.currentTabIndex === 0 ? FontWeight.Medium : FontWeight.Normal)
          .padding({ left: 10, right: 10, bottom: 8 })
          .border({ width: { bottom: this.currentTabIndex === 0 ? 3 : 0 }, color: "#000" })
          .onClick(() => {
            this.currentTabIndex = 0;
            this.createSubIdx = 0;
          })
        Text("想练")
          .fontSize(17)
          .fontColor(this.currentTabIndex === 1 ? "#000000" : "#999999")
          .fontWeight(this.currentTabIndex === 1 ? FontWeight.Medium : FontWeight.Normal)
          .padding({ left: 10, right: 10, bottom: 8 })
          .border({ width: { bottom: this.currentTabIndex === 1 ? 3 : 0 }, color: "#000" })
          .onClick(() => {
            this.currentTabIndex = 1;
            this.wantSubIdx = 0;
          })
        Text("练过")
          .fontSize(17)
          .fontColor(this.currentTabIndex === 2 ? "#000000" : "#999999")
          .fontWeight(this.currentTabIndex === 2 ? FontWeight.Medium : FontWeight.Normal)
          .padding({ left: 10, right: 10, bottom: 8 })
          .border({ width: { bottom: this.currentTabIndex === 2 ? 3 : 0 }, color: "#000" })
          .onClick(() => {
            this.currentTabIndex = 2;
            this.doneSubIdx = 0;
          })
        Text("订阅")
          .fontSize(17)
          .fontColor(this.currentTabIndex === 3 ? "#000000" : "#999999")
          .fontWeight(this.currentTabIndex === 3 ? FontWeight.Medium : FontWeight.Normal)
          .padding({ left: 10, right: 10, bottom: 8 })
          .border({ width: { bottom: this.currentTabIndex === 3 ? 3 : 0 }, color: "#000" })
          .onClick(() => {
            this.currentTabIndex = 3;
          })
      }
      .width('100%')
      .padding({ left: 12, right: 12 })
      .margin({ bottom: 12 })

      // ========== 二级标签区域 ==========
      // 我创建的 二级Tab：训练方案、训练计划、跟练视频
      if (this.currentTabIndex === 0) {
        Row({ space: 12 }) {
          Text("训练方案")
            .fontSize(16)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .borderRadius(20)
            .backgroundColor(this.createSubIdx === 0 ? "#333333" : "#FFFFFF")
            .fontColor(this.createSubIdx === 0 ? "#FFFFFF" : "#333333")
            .onClick(() => this.createSubIdx = 0)
          Text("训练计划")
            .fontSize(16)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .borderRadius(20)
            .backgroundColor(this.createSubIdx === 1 ? "#333333" : "#FFFFFF")
            .fontColor(this.createSubIdx === 1 ? "#FFFFFF" : "#333333")
            .onClick(() => this.createSubIdx = 1)
          Text("跟练视频")
            .fontSize(16)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .borderRadius(20)
            .backgroundColor(this.createSubIdx === 2 ? "#333333" : "#FFFFFF")
            .fontColor(this.createSubIdx === 2 ? "#FFFFFF" : "#333333")
            .onClick(() => this.createSubIdx = 2)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
        .margin({ bottom: 60 })
      }

      // 想练 二级Tab：课程、合集、训练计划
      if (this.currentTabIndex === 1) {
        Row({ space: 12 }) {
          Text("课程")
            .fontSize(16)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .borderRadius(20)
            .backgroundColor(this.wantSubIdx === 0 ? "#333333" : "#FFFFFF")
            .fontColor(this.wantSubIdx === 0 ? "#FFFFFF" : "#333333")
            .onClick(() => this.wantSubIdx = 0)
          Text("合集")
            .fontSize(16)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .borderRadius(20)
            .backgroundColor(this.wantSubIdx === 1 ? "#333333" : "#FFFFFF")
            .fontColor(this.wantSubIdx === 1 ? "#FFFFFF" : "#333333")
            .onClick(() => this.wantSubIdx = 1)
          Text("训练计划")
            .fontSize(16)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .borderRadius(20)
            .backgroundColor(this.wantSubIdx === 2 ? "#333333" : "#FFFFFF")
            .fontColor(this.wantSubIdx === 2 ? "#FFFFFF" : "#333333")
            .onClick(() => this.wantSubIdx = 2)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
        .margin({ bottom: 60 })
      }

      // 练过 二级Tab：课程、训练计划
      if (this.currentTabIndex === 2) {
        Row({ space: 12 }) {
          Text("课程")
            .fontSize(16)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .borderRadius(20)
            .backgroundColor(this.doneSubIdx === 0 ? "#333333" : "#FFFFFF")
            .fontColor(this.doneSubIdx === 0 ? "#FFFFFF" : "#333333")
            .onClick(() => this.doneSubIdx = 0)
          Text("训练计划")
            .fontSize(16)
            .padding({ left: 16, right: 16, top: 6, bottom: 6 })
            .borderRadius(20)
            .backgroundColor(this.doneSubIdx === 1 ? "#333333" : "#FFFFFF")
            .fontColor(this.doneSubIdx === 1 ? "#FFFFFF" : "#333333")
            .onClick(() => this.doneSubIdx = 1)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
        .margin({ bottom: 60 })
      }

      // ========== 中间空白占位区域 ==========
      Column() {
        // 练过-课程 专属书本水瓶占位
        if (this.currentTabIndex === 2 && this.doneSubIdx === 0) {
          Stack() {
            Rect()
              .width(100)
              .height(130)
              .fill("#EEEEEE")
            Rect()
              .width(30)
              .height(50)
              .fill("#90E0BE")
              .translate({ x: -35, y: 40 })
          }
          .width(130)
          .height(150)
          .margin({ bottom: 20 })
          Text("你还没有练过课程，快去运动吧")
            .fontSize(20)
            .fontColor("#999999")
        }
        // 其余全部三层卡片占位
        else {
          Stack() {
            Rect()
              .width(120)
              .height(90)
              .fill("#E0E0E0")
              .translate({ x: 10, y: 10 })
            Rect()
              .width(130)
              .height(80)
              .fill("#86E8B8")
            Rect()
              .width(110)
              .height(70)
              .fill("#DCDCDC")
              .translate({ x: -10, y: -10 })
          }
          .width(140)
          .height(120)
          .margin({ bottom: 20 })
          // 分场景空白文字
          if (this.currentTabIndex === 0) {
            if (this.createSubIdx === 0) Text("暂无训练方案")
            else if (this.createSubIdx === 1) Text("暂无训练计划")
            else Text("暂无跟练视频")
          } else if (this.currentTabIndex === 1) {
            if (this.wantSubIdx === 0) Text("暂无想练的课程")
            else if (this.wantSubIdx === 1) {
              Column({ space: 10 }) {
                Text("暂无创建的课程合集")
                  .fontSize(20)
                  .fontColor("#999999")
                Text("将心仪的课程分类归纳，打造你的专属训练清单，点击下方按钮即可")
                  .fontSize(16)
                  .fontColor("#999999")
                  .textAlign(TextAlign.Center)
                  .width("80%")
              }
            }
            else Text("暂无训练计划")
          } else if (this.currentTabIndex === 2 && this.doneSubIdx === 1) {
            Text("暂无练过的训练计划")
          } else if (this.currentTabIndex === 3) {
            Text("暂无订阅")
          }
        }
      }
      .layoutWeight(1)
      .width('100%')
      .justifyContent(FlexAlign.Center)

      // ========== 底部按钮区域 ==========
      // 我创建的全部子页面：创建训练按钮
      if (this.currentTabIndex === 0) {
        Button("➕ 创建训练", { stateEffect: true })
          .width("90%")
          .height(60)
          .margin({ left: "5%", right: "5%", bottom: 30 })
          .backgroundColor("#36C987")
          .fontSize(20)
          .fontColor(Color.White)
          .borderRadius(30)
      }

      // 想练-合集：创建合集按钮
      if (this.currentTabIndex === 1 && this.wantSubIdx === 1) {
        Button("创建合集", { stateEffect: true })
          .width("50%")
          .height(50)
          .margin({ bottom: 30 })
          .backgroundColor("#36C987")
          .fontSize(18)
          .fontColor(Color.White)
          .borderRadius(25)
      }

      // 练过页面底部：发现更多课程+搜索+标签
      if (this.currentTabIndex === 2) {
        Column() {
          Row() {
            Text("发现更多课程")
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .layoutWeight(1)
            Row() {
              Text("Q 去搜索")
                .fontSize(15)
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                .backgroundColor("#F2F2F2")
                .borderRadius(20)
                .onClick(() => router.pushUrl({ url: "pages/SearchPage" }))
            }
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 16 })

          Row({ space: 12 }) {
            Text("安娜全身燃脂")
              .fontSize(16)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .backgroundColor("#F2F2F2")
              .borderRadius(22)
            Text("赵露思")
              .fontSize(16)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .backgroundColor("#F2F2F2")
              .borderRadius(22)
            Text("食谱")
              .fontSize(16)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .backgroundColor("#F2F2F2")
              .borderRadius(22)
          }
          .width("100%")
          .padding({ left: 16, right: 16, bottom: 10 })
          Row({ space: 12 }) {
            Text("哈利波特")
              .fontSize(16)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .backgroundColor("#F2F2F2")
              .borderRadius(22)
            Text("哈尔滨马拉松")
              .fontSize(16)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .backgroundColor("#F2F2F2")
              .borderRadius(22)
            Text("魔卡少女樱")
              .fontSize(16)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .backgroundColor("#F2F2F2")
              .borderRadius(22)
          }
          .width("100%")
          .padding({ left: 16, right: 16, bottom: 40 })
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}