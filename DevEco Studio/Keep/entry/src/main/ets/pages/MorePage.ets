// pages/MorePage.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// 顶部分类入口
@Component
struct TopCategoryIcon {
  icon: string = ""
  title: string = ""

  build() {
    Column({ space: 8 }) {
      Text(this.icon)
        .fontSize(32)
        .width(60)
        .height(60)
        .borderRadius(30)
        .backgroundColor('#F0F0F0')
        .textAlign(TextAlign.Center)
      Text(this.title)
        .fontSize(14)
        .fontColor('#333')
    }
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      promptAction.showToast({ message: `进入${this.title}分类`, duration: 1000 })
    })
  }
}

// 商品卡片组件
@Component
struct GoodsCard {
  title: string = ""
  desc: string = ""
  price: string = ""
  originPrice: string = ""
  imgName: string = ""
  goodsId: string = ""
  bgColor: string = "#FFF0F5"

  build() {
    Row({ space: 10 }) {

      // 商品图片
      Image($r(`app.media.${this.imgName}`))
        .width('100%')
        .height(80)
        .borderRadius(6)
        .objectFit(ImageFit.Cover)
        .backgroundColor(this.bgColor)

      Column({ space: 5 }) {
        Text(this.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .width('100%')

        Text(this.desc)
          .fontSize(14)
          .fontColor('#666')
          .width('100%')

        Row() {
          Text(this.price)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF6347')
          Text(`到手价 ${this.originPrice}`)
            .fontSize(14)
            .fontColor('#888')
            .margin({ left: 5, top: 3 })
        }
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(10)
    .backgroundColor(Color.White)
    .borderRadius(8)
  }
}

@Entry
@Component
export struct MorePage {
  @State selectTab: number = 6
  @State selectedLeftCategory: number = 0

  // 优惠券栏（带关闭按钮）
  @State showCouponBar: boolean = true // 控制优惠券栏显示/隐藏状态

  tabList: string[] = ["关注", "社区", "奖牌", "比赛", "商城","上新","更多"]
  leftCategoryList: string[] = ["智能穿戴", "体脂秤", "动感单车", "跑步机", "椭圆机", "划船机"]

  build() {
    Column() {
      // 1. 顶部搜索栏
      Row() {
        TextInput({ placeholder: "牛排脆" })
          .layoutWeight(1)
          .height(44)
          .borderRadius(22)
          .backgroundColor('#F0F0F0')
          .margin({ right: 12 })
        Text("🏆")
          .fontSize(22)
          .margin({ right: 15 })
        Text("⚙️")
          .fontSize(22)
      }
      .width('100%')
      .padding({ left: 15, right: 15, top: 10, bottom: 10 })

      // 2. 可滑动标签栏
      Scroll() {
        Row() {
          ForEach(this.tabList, (item: string, index: number) => {
            Column({ space: 4 }) {
              Text(item)
                .fontSize(18)
                .fontColor(this.selectTab === index ? '#1677FF' : '#888')
                .fontWeight(this.selectTab === index ? FontWeight.Bold : FontWeight.Normal)

              if (this.selectTab === index) {
                Column()
                  .width(24)
                  .height(2)
                  .backgroundColor('#1677FF')
              }
            }
            .width(80)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              if (index === 0) {
                router.replaceUrl({ url: "pages/DiscoverPage" })
              } else if (index === 1) {
                router.replaceUrl({ url: "pages/CommunityPage" })
              } else if (index === 2) {
                router.replaceUrl({ url: "pages/MedalPage" })
              } else if (index === 3) {
                router.replaceUrl({ url: "pages/RacePage" })
              } else if (index === 4) {
                router.replaceUrl({ url: "pages/ShopPage" });
              } else if (index === 5) {
                router.replaceUrl({ url: "pages/NewPage" });
              } else if (index === 6) {
                router.replaceUrl({ url: "pages/MorePage" });
              } else {
                this.selectTab = index
              }
            })
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .padding({ top: 10, bottom: 15 })

      // 3. 顶部横向分类
      Row() {
        TopCategoryIcon({ icon: "⌚", title: "智能装备" })
        TopCategoryIcon({ icon: "🏋️", title: "增肌塑形" })
        TopCategoryIcon({ icon: "👚", title: "女子穿搭" })
        TopCategoryIcon({ icon: "👕", title: "男子穿搭" })
        Column({ space: 8 }) {
          Text("全部")
            .fontSize(16)
            .width(60)
            .height(60)
            .textAlign(TextAlign.Center)
          Text("☰")
            .fontSize(20)
            .width(60)
            .textAlign(TextAlign.Center)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .margin({ bottom: 15, left: 10, right: 10 })

      // 4. 排序栏
      Row() {
        ForEach(["综合排序", "新品"], (item: string, index: number) => {
          Text(item)
            .fontSize(18)
            .fontColor(index === 0 ? '#1677FF' : '#888')
            .fontWeight(index === 0 ? FontWeight.Bold : FontWeight.Normal)
            .padding({ left: 20, right: 20, top: 5, bottom: 5 })
        })
        Text("⥁")
          .fontSize(20)
          .layoutWeight(1)
          .textAlign(TextAlign.End)
          .margin({ right: 15 })
      }
      .width('100%')
      .margin({ bottom: 15 })

      // 5. 左侧分类 + 右侧商品列表
      Row() {
        // 左侧竖向分类
        Column() {
          ForEach(this.leftCategoryList, (item: string, index: number) => {
            Text(item)
              .fontSize(16)
              .fontColor(this.selectedLeftCategory === index ? '#1677FF' : '#888')
              .width('100%')
              .textAlign(TextAlign.Center)
              .padding(15)
              .backgroundColor(this.selectedLeftCategory === index ? '#F0F8FF' : Color.White)
              .onClick(() => {
                this.selectedLeftCategory = index
              })
          })
        }
        .width('25%')
        .backgroundColor('#F5F5F5')

        // 右侧商品列表
        List() {
          ListItem() {
            GoodsCard({
              title: "Keep 智能运动手环",
              desc: "从睡眠到训练 全天候陪伴",
              price: "¥249",
              originPrice: "¥304",
              imgName:"shoubiao"
            })
          }
          ListItem() {
            GoodsCard({
              title: "Stick智能运动手环",
              desc: "升级第8代智能互联 数据监测",
              price: "¥259",
              originPrice: "¥279",
              imgName:"shoubiao"
            })
          }
          ListItem() {
            GoodsCard({
              title: "智能运动手环 B4",
              desc: "",
              price: "¥191",
              originPrice: "¥299",
              imgName:"shoubiao"
            })
          }
        }
        .layoutWeight(1)
        .width('100%')
        .backgroundColor('#F5F5F5')
      }
      .layoutWeight(1)
      .width('100%')

      // 优惠券栏（带关闭按钮）
      if (this.showCouponBar) {
        Row() {
          Text("37元 优惠券待使用，仅剩 1天14…")
            .fontSize(16)
            .fontColor('#333')
            .layoutWeight(1) // 让文字占满剩余空间

          Button("去使用")
            .fontSize(14)
            .backgroundColor('#FF6347')
            .fontColor(Color.White)
            .borderRadius(20)
            .width('30%')

          // 🔴 这一行就是关闭的 × 按钮
          Text("×")
            .fontSize(20)
            .fontColor('#888')
            .margin({ left: 10 }) // 和按钮拉开一点距离
            .onClick(() => {
              this.showCouponBar = false; // 点击后隐藏
            })
        }
        .width('100%')
        .backgroundColor('#FFE4E1')
        .padding(15)
        .borderRadius(8)
        .margin({ left: 10, right: 10 })
      }

      // 底部导航
      Row() {
        Column({ space: 4 }) {
          Text('课程')
            .fontSize(14)
            .fontColor('#888888')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          router.replaceUrl({ url: 'pages/MainPage' })
        })

        Column({ space: 4 }) {
          Text('日程')
            .fontSize(14)
            .fontColor('#888888')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          router.replaceUrl({ url: 'pages/PlanPage' })
        })
        

        Column({ space: 4 }) {
          Text('发现')
            .fontSize(14)
            .fontColor('#1677FF')
            .fontWeight(FontWeight.Bold)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Column({ space: 4 }) {
          Text('我的')
            .fontSize(14)
            .fontColor('#888888')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          router.replaceUrl({ url: 'pages/MinePage' })
        })
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.White)
      .shadow({ radius: 5, color: '#00000010', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
  }
}