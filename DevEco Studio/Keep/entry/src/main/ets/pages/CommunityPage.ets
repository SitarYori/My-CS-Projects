import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// 帖子卡片组件（带网络图片）
@Component
struct PostCard {
  title: string = "";
  desc: string = "";
  bgColor: string = "#E8E8E8";
  avatarUrl: string = "";
  imageUrl: string = "";
  userName: string = "";
  timeAgo: string = "";

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
      // 作品图片 - 点击跳转帖子详情
      if (this.imageUrl) {
        Image(this.imageUrl)
          .width('100%')
          .height(180)
          .borderRadius(8)
          .objectFit(ImageFit.Cover)
          .onClick(() => {
            this.navigateToPostDetail();
          })
      } else {
        Column()
          .width('100%')
          .height(180)
          .backgroundColor(this.bgColor)
          .borderRadius(8)
          .onClick(() => {
            this.navigateToPostDetail();
          })
      }

      // 标题 - 点击跳转帖子详情
      Text(this.title)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .onClick(() => {
          this.navigateToPostDetail();
        })

      // 描述 - 点击跳转帖子详情
      Text(this.desc)
        .fontSize(14)
        .fontColor('#888')
        .width('100%')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .onClick(() => {
          this.navigateToPostDetail();
        })

      // 用户信息行
      Row() {
        Row() {
          // 头像 - 点击跳转博主主页
          if (this.avatarUrl) {
            Image(this.avatarUrl)
              .width(30)
              .height(30)
              .borderRadius(15)
              .objectFit(ImageFit.Cover)
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/ProfilePage',
                  params: {
                    name: this.userName,
                    avatar: this.avatarUrl,
                    userId: "user_001", // 后期替换为数据库真实用户ID
                    isSelf: "false" // 他人主页固定false
                  }
                });
              })
          } else {
            Circle()
              .width(30)
              .height(30)
              .fill('#E6E6FA')
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/ProfilePage',
                  params: {
                    name: this.userName,
                    avatar: this.avatarUrl
                  }
                });
              })
          }

          // 用户名 - 点击跳转博主主页
          Text(this.userName)
            .fontSize(14)
            .fontColor('#666')
            .margin({ left: 8 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ProfilePage',
                params: {
                  name: this.userName,
                  avatar: this.avatarUrl
                }
              });
            })
        }

        // 时间 - 固定在右侧
        Text(this.timeAgo)
          .fontSize(12)
          .fontColor('#AAA')
          .margin({ right: 4 })
          .layoutWeight(1)
      }
      .width('100%')
    }
    .width('48%')
    .padding(10)
    .backgroundColor(Color.White)
    .borderRadius(8)
  }
}

@Entry
@Component
export struct CommunityPage {
  @State selectTab: number = 1
  private tabList: string[] = ["关注", "社区", "奖牌", "比赛", "商城", "上新", "更多"];

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

      // 3. 横幅+帖子 整体滑动区域
      Scroll() {
        Column() {
          // 深色横幅广告
          Stack({ alignContent: Alignment.TopEnd }) {
            Column() {
              Text("腿型问题 全方位评估")
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .width('100%')
                .padding({ top: 20, left: 15 })

              Row() {
                Text("X型腿")
                  .fontSize(16)
                  .fontColor(Color.White)
                  .backgroundColor('rgba(0,0,0,0.3)')
                  .padding(5)
                  .borderRadius(5)
                Text("O型腿")
                  .fontSize(16)
                  .fontColor(Color.White)
                  .backgroundColor('rgba(0,0,0,0.3)')
                  .padding(5)
                  .borderRadius(5)
                  .margin({ left: 20 })
              }
              .width('100%')
              .padding({ left: 15, top: 20 })

              Text("小腿粗壮")
                .fontSize(16)
                .fontColor(Color.White)
                .backgroundColor('rgba(0,0,0,0.3)')
                .padding(5)
                .borderRadius(5)
                .margin({ left: 15, top: 10 })
            }
            .width('100%')
            .height(150)
            .backgroundColor('#3A3A5A')
            .alignItems(HorizontalAlign.Start)

            Text("×")
              .fontSize(24)
              .fontColor(Color.White)
              .padding({ top: 10, right: 15 })
              .onClick(() => {
                promptAction.showToast({ message: '关闭横幅', duration: 800 });
              })
          }
          .width('94%')
          .height(150)
          .borderRadius(12)
          .margin({ left: '3%', bottom: 12 })

          // 帖子行1
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            PostCard({
              title: "珍心爱神 | 恋恋倾心系列线上跑",
              desc: "人气 | 38,484人参赛",
              bgColor: '#FFE4E1',
              avatarUrl: "https://c-ssl.duitang.com/uploads/blog/202302/28/20230228214644_8e4b9.jpeg",
              imageUrl: "https://img.alicdn.com/i4/2214884075221/O1CN017XBANi1oRGi02uq8p_!!2214884075221.jpg",
              userName: "运动爱好者",
              timeAgo: "2小时前"
            })
            PostCard({
              title: "「身体少抵抗 减重轻松达」乒出减重破...",
              desc: "Keep_活动",
              bgColor: '#F08080',
              avatarUrl: "https://ts1.tc.mm.bing.net/th/id/R-C.91d55c1b10fafda8d5e0f68c521e042d?rik=lQsEgG5P%2bA0%2f5A&riu=http%3a%2f%2fimage.woshipm.com%2fwp-files%2f2018%2f09%2fzs1ofkbXZ6cGjeZxaTLd.jpg&ehk=roaOdaydqDJgZ82GQbBUKkGAx7Gz67kb7lrsUrL%2bSPU%3d&risl=&pid=ImgRaw&r=0",
              imageUrl: "https://ts2.tc.mm.bing.net/th/id/OIP-C.1V7Gmrjs8RCtGkXzmKQpHgHaEK?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
              userName: "Keep官方",
              timeAgo: "5小时前"
            })
          }
          .width('94%')
          .margin({ left: '3%', bottom: 10 })

          // 帖子行2
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            PostCard({
              title: "结果不会辜负汗水",
              bgColor: '#F5F5F5',
              avatarUrl: "https://preview.qiantucdn.com/58pic/20230810/00H58PICZU5f1rB2p56d1_PIC2018_PIC2018.jpg!w1024_new_0_1",
              imageUrl: "https://ts4.tc.mm.bing.net/th/id/OIP-C.Jxhecwc7QuDbx69FqtaA8QHaE7?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
              userName: "兔兔子",
              timeAgo: "     昨天"
            })
            PostCard({
              title: "今日跑步5公里完成√",
              bgColor: '#FFFFFF',
              avatarUrl: "https://img95.699pic.com/photo/60067/6642.jpg_wh860.jpg",
              imageUrl: "https://k.sinaimg.cn/n/sports/2_img/upload/cf0d0fdd/668/w1080h1188/20200415/dc81-isehnnk4714123.jpg/w640slw.jpg",
              userName: "菲菲爱跑步",
              timeAgo: " 昨天"
            })
          }
          .width('94%')
          .margin({ left: '3%', bottom: 10 })

          // 帖子行3
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            PostCard({
              title: "跑个菠萝 线上跑活动",
              desc: "2km赢菠萝周边",
              bgColor: '#90EE90',
              avatarUrl: "https://tu.tuhenmei.com/uploads/allimg/20240625/1d2swf12q54.jpg",
              imageUrl: "https://pic.nximg.cn/file/20230815/34599220_162758754104_2.jpg",
              userName: "菠萝君",
              timeAgo: "     3天前"
            })
            PostCard({
              title: "Keep奖牌上新",
              desc: "更多主题奖牌等你来拿",
              bgColor: '#E6E6FA',
              avatarUrl: "https://ts2.tc.mm.bing.net/th/id/OIP-C.e-xg5FC4fMCJoEtXv6XvKAHaE8?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
              imageUrl: "https://i.guancha.cn/bbs/2022/10/18/20221018224951245.image?imageView2/2/w/500/format/jpg",
              userName: "Keep运营",
              timeAgo: "3天前"
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