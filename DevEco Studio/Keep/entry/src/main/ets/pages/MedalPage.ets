// pages/MedalPage.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';


// 功能入口图标组件
@Component
struct MedalIcon {
  bgColor: string = "#6A5ACD"
  icon: string = ""
  title: string = ""
  hasNew: boolean = false
  tagText: string = ""

  build() {
    Column({ space: 10 }) {
      Stack() {
        Text(this.icon)
          .fontSize(32)
          .width(80)
          .height(80)
          .borderRadius(40)
          .backgroundColor(this.bgColor)
          .textAlign(TextAlign.Center)
          .fontColor(Color.White)

        if (this.hasNew) {
          Text("NEW")
            .fontSize(12)
            .backgroundColor(Color.Yellow)
            .padding({ left: 5, right: 5 })
            .borderRadius(5)
            .position({ x: 0, y: 0 })
        }

        if (this.tagText) {
          Text(this.tagText)
            .fontSize(12)
            .backgroundColor(Color.Green)
            .fontColor(Color.White)
            .padding({ left: 5, right: 5 })
            .borderRadius(5)
            .position({ x: "60%", y: 0 })
        }
      }

      Text(this.title)
        .fontSize(16)
        .fontColor('#333')
    }
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      promptAction.showToast({ message: `进入${this.title}`, duration: 1000 })
    })
  }
}

// 奖牌活动卡片组件
// 奖牌活动卡片组件（带网络图片）
@Component
struct MedalCard {
  title: string = ""
  desc: string = ""
  peopleCount: string = ""
  dateRange: string = ""
  bgColor: string = "#FFE4E1"
  imageUrl: string = ""      // 新增：活动图片URL

  build() {
    Column({ space: 10 }) {
      // 卡片主图 - 使用网络图片
      if (this.imageUrl) {
        Image(this.imageUrl)
          .width('100%')
          .height(180)
          .borderRadius(12)
          .objectFit(ImageFit.Cover)
          .onError(() => {
            console.error('图片加载失败');
          })
      } else {
        // 默认占位图（没有URL时显示）
        Column()
          .width('100%')
          .height(180)
          .backgroundColor(this.bgColor)
          .borderRadius(12)
      }

      // 标题
      Text(this.title)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 描述（如果有）
      if (this.desc) {
        Text(this.desc)
          .fontSize(12)
          .fontColor('#666')
          .width('100%')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }

      // 人气
      if (this.peopleCount) {
        Row() {
          Text("人气")
            .fontSize(12)
            .fontColor('#888')
            .backgroundColor('#F0F0F0')
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .borderRadius(4)
          Text(this.peopleCount)
            .fontSize(12)
            .fontColor('#888')
            .margin({ left: 5 })
        }
        .width('100%')
      }

      // 日期
      if (this.dateRange) {
        Text(this.dateRange)
          .fontSize(12)
          .fontColor('#888')
          .width('100%')
      }
    }
    .width('48%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .onClick(() => {
      promptAction.showToast({ message: `查看活动：${this.title}`, duration: 1000 });
    })
  }
}

@Entry
@Component
export struct MedalPage {
  @State selectTab: number = 2
  @State currentSubTab: number = 0;  // 0:新赛首发, 1:祝福礼赠, 2:奖牌榜单
  tabList: string[] = ["关注", "社区", "奖牌", "比赛", "商城", "上新", "更多"]

  build() {
    Column() {
      // 1. 顶部搜索栏（固定）
      Row() {
        TextInput({ placeholder: "帕梅拉瘦腿" })
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

      // 2. 顶部标签栏
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
                promptAction.showToast({ message: '更多功能开发中', duration: 800 });
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

      // ==================== 可上下滑动的内容区域 ====================
      Scroll() {
        Column() {
          // 3. 功能入口
          Row() {
            MedalIcon({
              bgColor: "#6A5ACD",
              icon: "📅",
              title: "上新预告",
              hasNew: true
            })
            MedalIcon({
              bgColor: "#3CB371",
              icon: "⊞",
              title: "IP合集"
            })
            MedalIcon({
              bgColor: "#FF8C00",
              icon: "🛡️",
              title: "限时活动"
            })
            MedalIcon({
              bgColor: "#FFA500",
              icon: "👕",
              title: "周边集市",
              tagText: "周边88折"
            })
          }
          .width('94%')
          .margin({ left: '3%', bottom: 15 })
          .justifyContent(FlexAlign.SpaceAround)

          // 4. 子标签
          Row() {
            Button("新赛首发")
              .backgroundColor(this.currentSubTab === 0 ? '#333333' : Color.White)
              .fontColor(this.currentSubTab === 0 ? Color.White : '#333333')
              .borderRadius(20)
              .border({ width: this.currentSubTab === 0 ? 0 : 1, color: '#E0E0E0' })
              .width('30%')
              .height(40)
              .onClick(() => {
                this.currentSubTab = 0;
                promptAction.showToast({ message: '新赛首发', duration: 800 });
              })

            Button("🎁 祝福礼赠")
              .fontSize(14)
              .backgroundColor(this.currentSubTab === 1 ? '#333333' : Color.White)
              .fontColor(this.currentSubTab === 1 ? Color.White : '#333333')
              .borderRadius(20)
              .border({ width: this.currentSubTab === 1 ? 0 : 1, color: '#E0E0E0' })
              .width('30%')
              .height(40)
              .onClick(() => {
                this.currentSubTab = 1;
                promptAction.showToast({ message: '祝福礼赠', duration: 800 });
              })

            Button("🔥 奖牌榜单")
              .fontSize(14)
              .backgroundColor(this.currentSubTab === 2 ? '#333333' : Color.White)
              .fontColor(this.currentSubTab === 2 ? Color.White : '#333333')
              .borderRadius(20)
              .border({ width: this.currentSubTab === 2 ? 0 : 1, color: '#E0E0E0' })
              .width('30%')
              .height(40)
              .onClick(() => {
                this.currentSubTab = 2;
                promptAction.showToast({ message: '奖牌榜单', duration: 800 });
              })
          }
          .width('94%')
          .margin({ left: '3%', bottom: 15 })
          .justifyContent(FlexAlign.SpaceBetween)

          // 第一行卡片
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            MedalCard({
              title: "珍心爱神 | 恋恋倾心系列线上跑",
              desc: "跑步或开合跳",
              peopleCount: "38,457 人参赛",
              dateRange: "04.15 - 06.14",
              bgColor: "#FFE4E1",
              imageUrl: "https://n.sinaimg.cn/sinakd20220630s/268/w641h427/20220630/00ea-dc54efada7f400711a4aec7b50e6a6f4.jpg"
            })
            MedalCard({
              title: "派对甜心 | 三丽鸥家族系列Hello Kitty线上跑",
              desc: "跑步",
              peopleCount: "243,392 人参赛",
              dateRange: "04.24 - 06.24",
              bgColor: "#FFE4E1",
              imageUrl: "https://ts1.tc.mm.bing.net/th/id/R-C.0f709f99f4a1cd2ba4eee0dddc2dc8fd?rik=lKJ89TsRhm%2fgvw&riu=http%3a%2f%2fn.sinaimg.cn%2fsinakd20220903ac%2f400%2fw1280h720%2f20220903%2f7544-5abe0f4943092213d31f22c5b15bd720.jpg&ehk=jQErZBQss4Ct3lQ%2bHA%2bps514gVS1iSL43kvIfwLomrA%3d&risl=&pid=ImgRaw&r=0"
            })
          }
          .width('94%')
          .margin({ left: '3%', bottom: 10 })

          // 第二行卡片
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            MedalCard({
              title: "天官赐福联名系列跑",
              desc: "运动专享价 ¥49",
              peopleCount: "",
              dateRange: "",
              bgColor: "#E6E6FA",
              imageUrl: "https://img.36krcdn.com/hsossms/20230712/v2_e72187f4519b43308f271d51f8e4c738@000000_oswg273955oswg1080oswg1080_img_000"
            })
            MedalCard({
              title: "心动礼遇季活动",
              desc: "抽免单券！",
              peopleCount: "",
              dateRange: "",
              bgColor: "#FFB6C1",
              imageUrl: "https://ts4.tc.mm.bing.net/th/id/OIP-C.8_1L8Mj6UjisvGQUeG4fGwHaHK?r=0&rs=1&pid=ImgDetMain&o=7&rm=3"
            })
          }
          .width('94%')
          .margin({ left: '3%', bottom: 10 })

          // 第三行卡片
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            MedalCard({
              title: "夏日限定线上跑",
              desc: "跑步或骑行",
              peopleCount: "12,345 人参赛",
              dateRange: "05.01 - 07.31",
              bgColor: "#FFF8DC",
              imageUrl: "https://n.sinaimg.cn/sinakd20220630s/268/w641h427/20220630/00ea-dc54efada7f400711a4aec7b50e6a6f4.jpg"
            })
            MedalCard({
              title: "城市马拉松系列",
              desc: "跑步",
              peopleCount: "56,789 人参赛",
              dateRange: "全年有效",
              bgColor: "#E0FFFF",
              imageUrl: "https://ts2.tc.mm.bing.net/th/id/OIP-C.c4L_3vXj_Uy-c-6ITGju4gHaJ3?r=0&rs=1&pid=ImgDetMain&o=7&rm=3"
            })
          }
          .width('94%')
          .margin({ left: '3%', bottom: 20 })
        }
        .width('100%')
        .padding({ bottom: 20 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)  // ← 让 Scroll 占据剩余空间

      // ==================== 底部导航（固定） ====================
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
    .backgroundColor('#F8F8F8')
  }
}