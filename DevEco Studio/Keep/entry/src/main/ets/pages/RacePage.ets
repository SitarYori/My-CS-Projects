// pages/RacePage.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// 功能入口卡片
@Component
struct RaceEntryCard {

  title: string = ""
  desc: string = ""


  build() {
    Column({ space: 5 }) {
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding({ left: 15, top: 15 })

      if (this.desc) {
        Text(this.desc)
          .fontSize(14)
          .fontColor('#666')
          .width('100%')
          .padding({ left: 15 })
      }

      Column()
        .width('100%')
        .height(80)

        .borderRadius(8)
    }
    .width('31%')
    .height(50)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .onClick(() => {
      promptAction.showToast({ message: `进入${this.title}`, duration: 1000 })
    })
  }
}

// 比赛活动卡片（带网络图片和报名按钮）
@Component
struct RaceCard {
  title: string = ""
  dateInfo: string = ""
  bgColor: string = "#F0F8FF"
  imageUrl: string = ""
  location: string = ""   // 地点参数
  status: string = ""     // 状态参数
  jumpUrl?: string; // 新增满屏跳转页面地址


  build() {
    Column({ space: 10 }) {
      // 卡片主图 - 使用网络图片
      if (this.imageUrl && this.imageUrl.length > 0 ) {
        Image(this.imageUrl)
          .width('100%')
          .height(160)
          .borderRadius(8)
          .objectFit(ImageFit.Cover)
          .onError(() => {
            console.error('图片加载失败');
          })
      } else {
        // 默认占位图（没有URL时显示背景色）
        Column()
          .width('100%')
          .height(160)
          .backgroundColor(this.bgColor)
          .borderRadius(8)
      }

      // 标题
      Text(this.title)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 地点信息（如果有）
      if (this.location) {
        Row() {
          Text("📍")
            .fontSize(12)
          Text(this.location)
            .fontSize(12)
            .fontColor('#666')
            .margin({ left: 4 })
            .layoutWeight(1)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .width('100%')
      }

      // 日期信息
      Text(this.dateInfo)
        .fontSize(12)
        .fontColor('#888')
        .width('100%')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 状态和按钮行
      Row() {
        // 状态标签
        if (this.status) {
          Text(this.status)
            .fontSize(11)
            .fontColor('#FF6B4A')
            .backgroundColor('#FFF0ED')
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(4)
        }

        Blank()

        // 报名按钮
        Button('去报名')
          .fontSize(12)
          .height(32)
          .backgroundColor('#FF6B4A')
          .fontColor(Color.White)
          .borderRadius(16)
          .padding({ left: 16, right: 16 })

          .onClick(() => {
            if(this.jumpUrl){
              router.pushUrl({url: this.jumpUrl})
            }else{
              promptAction.showToast({ message: "查看活动: "+this.title, duration: 1000 });
            }
          })

          /*
          .onClick(() => {
            promptAction.showToast({ message: `报名：${this.title}`, duration: 1000 });
          })
          * */
      }
      .width('100%')
      .margin({ top: 4 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .margin({ bottom: 10 })
    .onClick(() => {
      // 点击卡片其他区域也查看详情
      promptAction.showToast({ message: `查看活动：${this.title}`, duration: 1000 });
    })
  }
}

@Entry
@Component
export struct RacePage {
  @State selectTab: number = 3
  @State currentSubTab: number = 0;  // 0:品牌赛, 1:比赛报名, 2:瑞航送机票
  @State showFullScreenImage: boolean = false  // 控制全屏图片显示
  @State fullScreenImage: Resource | string = $r('app.media.pgbl1')  // 全屏图片资源
  tabList: string[] = ["关注", "社区", "奖牌", "比赛", "商城","上新","更多"]

  build() {
    Column() {
      // 1. 顶部搜索栏
      Row() {
        TextInput({ placeholder: "韩小四瘦腿" })
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

      // 2. 顶部标签栏（可互相跳转）
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

      Scroll() {
        Column() {
          // 3. 轮播横幅（使用Swiper组件，3秒自动切换）
          Swiper() {
            // 图片1
            Image("https://ts4.tc.mm.bing.net/th/id/OIP-C.8osCKddfur08KkVN3w1W2wHaFj?r=0&rs=1&pid=ImgDetMain&o=7&rm=3")
              .width('100%')
              .height(200)
              .objectFit(ImageFit.Cover)
              .borderRadius(8)

            // 图片2
            Image("https://imgslim.geekpark.net/uploads/image/file/c3/c3/c3c34ae1a9579fcc6ebc81756d920deb.png")
              .width('100%')
              .height(200)
              .objectFit(ImageFit.Cover)
              .borderRadius(8)

            // 图片3
            Image("https://tse3-mm.cn.bing.net/th/id/OIP-C.1t0yv-De_uGnDqMkGD7nOgHaDq?r=0&o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3")
              .width('100%')
              .height(200)
              .objectFit(ImageFit.Cover)
              .borderRadius(8)
          }
          .autoPlay(true)          // 开启自动轮播
          .interval(3000)          // 设置切换间隔为3000毫秒（3秒）
          .loop(true)              // 开启无限循环
          .indicator(true)         // 显示底部指示点（小圆点）
          .width('94%')
          .height(200)
          .margin({ left: '3%', bottom: 15 })
          .borderRadius(8)



          // 4. 功能入口：赛事报名/端午野练/城市K马
          Row() {
            RaceEntryCard({
              title: "赛事报名"
            })
            RaceEntryCard({
              title: "端午野练",
              desc: "明星陪跑共赴端午"
            })
            RaceEntryCard({
              title: "城市K马"
            })
          }
          .width('94%')
          .margin({top:8,bottom:8})
          .justifyContent(FlexAlign.SpaceBetween)


          // 5. 子标签：品牌赛/比赛报名/瑞航送机票（可切换）
          Row() {
            // 品牌赛按钮
            Button("品牌赛")
              .fontSize(14)
              .backgroundColor(this.currentSubTab === 0 ? '#333333' : Color.White)
              .fontColor(this.currentSubTab === 0 ? Color.White : '#333333')
              .borderRadius(20)
              .border({ width: this.currentSubTab === 0 ? 0 : 1, color: '#E0E0E0' })
              .width('30%')
              .height(40)
              .onClick(() => {
                this.currentSubTab = 0;
                promptAction.showToast({ message: '品牌赛', duration: 800 });
              })

            // 比赛报名按钮
            Button("比赛报名")
              .fontSize(14)
              .backgroundColor(this.currentSubTab === 1 ? '#333333' : Color.White)
              .fontColor(this.currentSubTab === 1 ? Color.White : '#333333')
              .borderRadius(20)
              .border({ width: this.currentSubTab === 1 ? 0 : 1, color: '#E0E0E0' })
              .width('30%')
              .height(40)
              .onClick(() => {
                this.currentSubTab = 1;
                promptAction.showToast({ message: '比赛报名', duration: 800 });
              })

            // 跑个菠萝
            Button("跑个菠萝")
              .fontSize(14)
              .backgroundColor(this.currentSubTab === 2 ? '#333333' : Color.White)
              .fontColor(this.currentSubTab === 2 ? Color.White : '#333333')
              .borderRadius(20)
              .border({ width: this.currentSubTab === 2 ? 0 : 1, color: '#E0E0E0' })
              .width('30%')
              .height(40)
              .onClick(() => {
                this.currentSubTab = 2;
                this.showFullScreenImage = true;  // 显示全屏图片
              })
          }
          .width('94%')
          .margin({ left: '3%', bottom: 15 })
          .justifyContent(FlexAlign.SpaceBetween)

          // 6. 比赛卡片列表（现在在 Scroll 内部，可以上下滑动）
          // 根据选中的子标签显示不同的内容
          if (this.currentSubTab === 0) {
            // 品牌赛内容
            Column() {
              RaceCard({
                title: "2026'黄河旋风杯'塔城半程马拉松",
                dateInfo: "报名: 2026.06.03~06.14 比赛: 2026.06.21",
                location: "中国·新疆·塔城",
                status: "报名中",
                imageUrl:"https://bkimg.cdn.bcebos.com/pic/aa64034f78f0f736afc3af590208a419ebc4b745b56c?x-bce-process=image/format,f_auto/quality,Q_70/resize,m_lfit,limit_1,w_536"
              })
              RaceCard({
                title: "传承中国体育文化 2026体育文化全国行",
                dateInfo: "报名: 2026.06.01~06.12 比赛: 2026.06.13",
                location: "河南·信阳站",
                status: "报名中",
                imageUrl:"https://ts3.tc.mm.bing.net/th/id/OIP-C.GLVyqRCj2-IdNmukO_QZvgHaE5?r=0&rs=1&pid=ImgDetMain&o=7&rm=3"
              })
              RaceCard({
                title: "瑞航送机票·线上跑活动",
                dateInfo: "报名: 2026.06.10~07.10 比赛: 2026.06.20~07.20",
                location: "线上跑·全球参与",
                status: "热门"
              })

            }
            .width('100%')
          } else if (this.currentSubTab === 1) {
            // 比赛报名内容
            Column() {
              RaceCard({
                title: "美丽中国·全民健身跑（陕西·西安站）",
                dateInfo: "报名: 2025.06.01~06.12 比赛: 2025.08.30",
                location: "周至秦岭国家植物园",
                status: "报名中",
                imageUrl: "https://ts1.tc.mm.bing.net/th/id/OIP-C.xOrWnHVJ3jmlA3UA-MpDtAHaE7?r=0&rs=1&pid=ImgDetMain&o=7&rm=3"
              })
              RaceCard({
                title: "城市马拉松挑战赛",
                dateInfo: "报名: 2026.07.01~07.31 比赛: 2026.08.01",
                location: "北京市奥林匹克森林公园",
                status: "即将开始",
                imageUrl: "https://ts1.tc.mm.bing.net/th/id/R-C.6d060657e11f55d3d33cffb157f6db3e?rik=XMgfwPYjFOxDDw&riu=http%3a%2f%2fwenhui.whb.cn%2fu%2fcms%2fwww%2f202104%2f182051102a1n.jpg&ehk=h%2b%2bLcwCLIAHtP4SUh8C2Nh3mAbo%2bJ5MKEKVSRRcWgDI%3d&risl=&pid=ImgRaw&r=0"
              })
              RaceCard({
                title: "夏日马拉松挑战赛",
                dateInfo: "报名: 2026.07.01~07.31 比赛: 2026.07.01~07.31",
                bgColor: "#90EE90",
                status: "报名中",
                imageUrl: "https://ts1.tc.mm.bing.net/th/id/R-C.6d060657e11f55d3d33cffb157f6db3e?rik=XMgfwPYjFOxDDw&riu=http%3a%2f%2fwenhui.whb.cn%2fu%2fcms%2fwww%2f202104%2f182051102a1n.jpg&ehk=h%2b%2bLcwCLIAHtP4SUh8C2Nh3mAbo%2bJ5MKEKVSRRcWgDI%3d&risl=&pid=ImgRaw&r=0"
              })

            }
            .width('100%')
          } else if (this.currentSubTab === 2) {
            // 跑个菠萝
            Column() {
              RaceCard({
                title: "跑个菠萝 | Keep送2000斤黑钻菠萝",
                dateInfo: "报名: 2026.06.10~06.28 比赛: 2026.06.10~06.28",
                bgColor: "#87CEEB",
                status: "即将开始",
                jumpUrl: "pages/fullpicture"
              })

            }
            /*
            // 新增点击跳转
            .onClick(() => {
                router.replaceUrl({
                  url: "pages/fullpicture"
              })
            })
            */
            .width('100%')

          }

        }
        .width('100%')
        .padding({ bottom: 20 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')
      .padding({ left: 10, right: 10 })

      // 底部导航（当前：发现高亮）

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
    .backgroundColor('#F5F5F5')
  }
}