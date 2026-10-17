// pages/DiscoverPage.ets
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';

// 频道图标组件
@Component
struct ChannelIcon {
  icon: string = ''
  title: string = ''

  build() {
    Column({ space: 5 }) {
      Text(this.icon)
        .fontSize(28)
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor('#f0f0f0')
        .textAlign(TextAlign.Center)
      Text(this.title)
        .fontSize(12)
        .fontColor('#333')
    }
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      promptAction.showToast({ message: `进入${this.title}频道`, duration: 1000 })
    })
  }
}


// 动态帖子组件（带网络图片）
@Component
struct PostItem {
  userName: string = ''
  publishInfo: string = ''
  postTitle: string = ''
  postDesc: string = ''
  avatarUrl: string = ''      // 新增：头像URL
  imageUrl: string = ''       // 新增：作品图片URL
  title: string = "";
  desc: string = "";
  timeAgo: string = "";

  // 跳转到博主主页
  navigateToProfile() {
    router.pushUrl({
      url: 'pages/ProfilePage',
      params: {
        name: this.userName,
        avatar: this.avatarUrl,
        bio: '助力千万女性摆脱身材焦虑，获得自由人生。',
        location: '女·重庆·渝北区·IP重庆',
        followers: '102500',
        following: '553000',
        likes: '13000',
        monthlyWorkouts: '260',
        totalMinutes: '2521',
        totalDays: '1163'
      }
    });
  }

  // 跳转到帖子详情页
  navigateToPostDetail() {
    router.pushUrl({
      url: 'pages/PostDetailPage',
      params: {
        userName: this.userName,
        avatarUrl: this.avatarUrl,
        title: this.title,
        content: this.desc,
        imageUrl: this.imageUrl,
        publishTime: this.timeAgo,
        location: '河南',
        likeCount: '28',
        commentCount: '5',
        collectCount: '12',
        distance: '5.07',
        duration: '00:31:37',
        pace: "06'13\"",
        calories: '330',
        userId: "user_001",
        isSelf: "false"
      }
    });
  }

  build() {
    Column({ space: 10 }) {
      // 用户信息行（带头像图片）
      Row() {
        // 头像 - 点击跳转到博主主页
        Image(this.avatarUrl)
          .width(40)
          .height(40)
          .borderRadius(20)
          .objectFit(ImageFit.Cover)
          .margin({ right: 10 })
          .onClick(() => {
            this.navigateToProfile();
          })

        Column({ space: 3 }) {
          // 用户名 - 点击跳转到博主主页
          Text(this.userName)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .onClick(() => {
              this.navigateToProfile();
            })
          Text(this.publishInfo)
            .fontSize(12)
            .fontColor('#888')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text("···")
          .fontSize(18)
          .fontColor('#888')
          .onClick(() => {
            promptAction.showToast({ message: "更多选项", duration: 1000 });
          })
      }
      .width('100%')

      // 作品图片 - 使用网络图片
      Image(this.imageUrl)
        .width('100%')
        .height(180)
        .borderRadius(8)
        .objectFit(ImageFit.Cover)

      Text(this.postTitle)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .width('100%')
      Text(this.postDesc)
        .fontSize(14)
        .fontColor('#666')
        .width('100%')

      Row({ space: 30 }) {
        Text("加油 28")
          .fontSize(14)
          .fontColor('#888')
          .onClick(() => {
            promptAction.showToast({ message: "加油", duration: 1000 });
          })
        Text("评论 5")
          .fontSize(14)
          .fontColor('#888')
          .onClick(() => {
            promptAction.showToast({ message: "评论", duration: 1000 });
          })
        Text("收藏 12")
          .fontSize(14)
          .fontColor('#888')
          .onClick(() => {
            promptAction.showToast({ message: "收藏", duration: 1000 });
          })
      }
      .width('100%')
      .margin({ top: 5 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .onClick(() => {
      this.navigateToPostDetail();
    })
  }
}

// 好友运动排行组件
@Component
struct FriendRankPage {
  // 新增：用 @Link 绑定父页面的 showRankPage
  @Link showRankPage: boolean;

  build() {
    Column() {
      // 1. 返回按钮（现在可以直接用 this.showRankPage 修改状态）
      Row() {
        Text("← 返回")
          .fontSize(16)
          .onClick(() => {
            // 点击后直接修改父页面的变量，关闭排行页
            this.showRankPage = false;
          })
      }
      .width('100%')
      .padding({ left: 15, top: 10, bottom: 10 })

      // 2. 顶部标签栏（运动类型）
      Row() {
        // 总运动（选中态）
        Stack({ alignContent: Alignment.Bottom }) {
          Text("总运动")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1677FF')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Column()
            .width(24)
            .height(2)
            .backgroundColor('#1677FF')
        }
        .layoutWeight(1)

        Text("跑步")
          .fontSize(18)
          .fontColor('#888')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text("行走")
          .fontSize(18)
          .fontColor('#888')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text("骑行")
          .fontSize(18)
          .fontColor('#888')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text("步数")
          .fontSize(18)
          .fontColor('#888')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ top: 10, bottom: 15 })

      // 筛选栏
      Row() {
        Button("运动时长")
          .fontSize(14)
          .backgroundColor('#F0F0F0')
          .fontColor('#333')
          .borderRadius(20)
          .width('30%')

        Button("本周")
          .fontSize(14)
          .backgroundColor('#F0F0F0')
          .fontColor('#333')
          .borderRadius(20)
          .width('30%')

        Button("关注好友")
          .fontSize(14)
          .backgroundColor('#F0F0F0')
          .fontColor('#333')
          .borderRadius(20)
          .width('30%')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 15, right: 15, bottom: 20 })

      // 紫色标题栏
      Column() {
        Text("本周排行")
          .fontSize(16)
          .fontColor(Color.White)
          .width('100%')
          .padding({ top: 15, left: 15 })

        Text("好友运动排行")
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .width('100%')
          .padding({ left: 15, top: 10, bottom: 30 })
      }
      .width('100%')
      .backgroundColor('#6A5ACD') // 紫色背景
      .alignItems(HorizontalAlign.Start)

      // 空状态提示
      Column() {
        // 空状态图标（用三层方块模拟）
        Stack() {
          Column()
            .width(120)
            .height(40)
            .backgroundColor('#E0E0E0')
            .rotate({ x: 45, y: 0, z: 0, angle: 0 })
          Column()
            .width(120)
            .height(40)
            .backgroundColor('#90EE90')
            .rotate({ x: 45, y: 0, z: 0, angle: 0 })
            .margin({ top: 15 })
          Column()
            .width(120)
            .height(40)
            .backgroundColor('#E0E0E0')
            .rotate({ x: 45, y: 0, z: 0, angle: 0 })
            .margin({ top: 30 })
        }
        .width(120)
        .height(100)
        .margin({ top: 40 })

        Text("当前榜单暂无运动数据，快去运动吧")
          .fontSize(16)
          .fontColor('#888')
          .margin({ top: 30 })
      }
      .layoutWeight(1)
      .width('100%')
      .justifyContent(FlexAlign.Center)

      // 底部用户信息栏
      Row() {
        Text("--")
          .fontSize(16)
          .fontColor('#888')
          .width('10%')
          .textAlign(TextAlign.Center)

        Circle()
          .width(50)
          .height(50)
          .margin({ left: 10 })

        Column({ space: 5 }) {
          Text("用户fz6ob016h")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
          Text("未上榜")
            .fontSize(14)
            .fontColor('#888')
        }
        .layoutWeight(1)
        .margin({ left: 15 })

        Image('common/voice.png') // 这里可以换成你的图标，没有的话用Text代替
          .width(24)
          .height(24)
      }
      .width('100%')
      .padding(15)
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}

// ===================== 主页面 =====================
@Entry
@Component
export struct DiscoverPage {
  // 标签状态 & 列表
  @State selectTab: number = 0;
  @State showRankPage: boolean = false;

  private tabList: string[] = ["关注", "社区", "奖牌", "比赛", "商城", "上新", "更多"];

  build() {
    Column() {
      // 主体内容区
      if (this.showRankPage) {
        // 显示好友运动排行
        FriendRankPage({ showRankPage: $showRankPage })
      } else {
        // ==================== 固定区域：顶部搜索栏 ====================
        Row() {
          TextInput({ placeholder: "瘦腿段落床上练" })
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
                // 关注/社区 跳转对应页面，其他标签只切换样式
                if (index === 0) {
                  router.replaceUrl({ url: "pages/DiscoverPage" })
                } else if (index === 1) {
                  router.replaceUrl({ url: "pages/CommunityPage" })
                } else if (index === 2) {
                  //奖牌
                  router.replaceUrl({ url: "pages/MedalPage" })
                }else if (index === 3) {
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

        // ==================== 可上下滑动的内容区域 ====================
        Scroll() {
          Column() {
            // 频道入口
            Row() {
              ChannelIcon({ icon: "📍", title: "同城" })
              ChannelIcon({ icon: "👥", title: "运动圈" })
              ChannelIcon({ icon: "🎁", title: "会员权益" })
              ChannelIcon({ icon: "🏃", title: "跑步专区" })
            }
            .width('94%')
            .margin({ left: '3%', bottom: 15 })
            .justifyContent(FlexAlign.SpaceAround)

            // 好友排行入口卡片
            Row() {
              Text("🏆")
                .fontSize(28)
                .margin({ right: 10 })
              Column({ space: 4 }) {
                Text("好友运动排行")
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                Text("每周一0点更新榜单")
                  .fontSize(12)
                  .fontColor('#888')
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
              Text(">")
                .fontSize(18)
                .fontColor('#888')
            }
            .width('94%')
            .margin({ left: '3%', bottom: 15 })
            .padding(12)
            .backgroundColor(Color.White)
            .borderRadius(8)
            .onClick(() => {
              this.showRankPage = true;
            })

            // 推荐帖子标题
            Row() {
              Text('🔥 推荐动态')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
              Blank()
              Text('查看更多 >')
                .fontSize(12)
                .fontColor('#1677FF')
            }
            .width('94%')
            .margin({ left: '3%', bottom: 10 })

            // 帖子列表
            Column({ space: 12 }) {
              PostItem({
                userName: "健身小夏",
                publishInfo: "今天 09:20 成都",
                postTitle: "每日减脂打卡，坚持第30天",
                postDesc: "跟着律动Stick一起运动，慢慢遇见更好的自己～",
                avatarUrl: "https://ts1.tc.mm.bing.net/th/id/R-C.1ed2f6f12237b105787f2cb8a1fef2c7?rik=9dyYcxBeIqCdhw&riu=http%3a%2f%2fimg.touxiangkong.com%2fuploads%2fallimg%2f20220526%2f1653554400242699.jpg&ehk=GuL1mWXfbvONlJcOdd2Uzlzf%2fE%2fzzaWWwdpOUsHwcg0%3d&risl=&pid=ImgRaw&r=0",
                imageUrl: "https://ts3.tc.mm.bing.net/th/id/OIP-C.dJjl2hMNa67ByS9k7NYU7gHaEJ?r=0&rs=1&pid=ImgDetMain&o=7&rm=3"
              })


              PostItem({
                userName: "运动达人阿凯",
                publishInfo: "昨天 18:10",
                postTitle: "居家无跳跃燃脂训练分享",
                postDesc: "新手也能轻松完成，全程不伤膝盖！",
                avatarUrl:"https://ts1.tc.mm.bing.net/th/id/OIP-C.KcvMuVGTKhiuVayhV_ziPQHaLH?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
                imageUrl:"https://ts1.tc.mm.bing.net/th/id/OIP-C.MmayOd1OzDHYtQgeE-ofXwHaEK?r=0&rs=1&pid=ImgDetMain&o=7&rm=3"


              })

              PostItem({
                userName: "瑜伽爱好者",
                publishInfo: "昨天 10:30",
                postTitle: "晨间瑜伽拉伸打卡",
                postDesc: "每天15分钟，唤醒身体，改善体态✨",
                avatarUrl:"https://ts1.tc.mm.bing.net/th/id/R-C.0d1ed8ff42858e5dff943f5990b3773f?rik=VF%2bqF%2bbQmJdn6A&riu=http%3a%2f%2fp2.itc.cn%2fq_70%2fimages03%2f20201215%2f12dc51369a4440a293af6305ea4168da.png&ehk=l3gywcuBjgSShibbfv9l6MPH1VXiXa6l4eL26dyPHiY%3d&risl=&pid=ImgRaw&r=0",
                imageUrl:"data:image/webp;base64,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"


              })
            }
            .width('94%')
            .margin({ left: '3%', bottom: 20 })
          }
          .width('100%')
          .padding({ bottom: 20 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .backgroundColor('#F8F8F8')
      }

      // 底部导航（固定，放在 if-else 外面）
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

