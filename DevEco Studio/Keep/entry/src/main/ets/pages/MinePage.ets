import { UserInfo, getUser, clearUser } from '../utils/StorageUtil';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// 功能列表子组件
@Component
struct FunctionItem {
  icon: string = ""
  title: string = ""
  desc: string = ""
  clickEvent: () => void = () => {}
  build() {
    Row() {
      Text(this.icon)
        .fontSize(24)
        .margin({ right: 12 })
      Column({ space: 2 }) {
        Text(this.title)
          .fontSize(15)
          .fontColor('#333')
        if (this.desc) {
          Text(this.desc)
            .fontSize(11)
            .fontColor('#888')
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Text('>')
        .fontSize(16)
        .fontColor('#CCC')
    }
    .width('100%')
    .padding({ left: 15, right: 15, top: 12, bottom: 12 })
    .backgroundColor(Color.White)
    .borderRadius(12)
    .onClick(() => {
      this.clickEvent()
    })
  }
}

// 运动数据统计项
@Component
struct DataStatItem {
  value: string = ""
  label: string = ""
  build() {
    Column({ space: 4 }) {
      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333')
      Text(this.label)
        .fontSize(12)
        .fontColor('#888')
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }
}

@Entry
@Component
export struct MinePage {
  // 统一变量：页面全部使用 this.user，删除不存在的 userInfo
  @State user: UserInfo = {
    nickname: '',
    email: '',
    password: '',
    _id: "",
    avatar: "",
    gender: "",
    registerDate: "",
    weight: 0,
    totalMinutes: 0
  };
  @State loginUser: UserInfo | null = null;
  @State totalDays: number = 0
  @State totalMin: number = 0
  @State weekTimes: number = 0
  @State medalNum: number = 0

  async aboutToAppear() {
    this.loadUserInfo();
  }

  // 读取登录用户
  async loadUserInfo() {
    try {
      const userData = await getUser();
      this.user = userData;
      this.loginUser = userData;
    } catch (e) {
      console.error('加载登录用户信息失败', JSON.stringify(e));
    }
  }

  // 跳转个人主页，全部改用 this.user 传参
  goProfile() {
    router.pushUrl({
      url: "pages/UserPersonalPage",
      params: {
        name: this.user.nickname,
        avatar: this.user.avatar,
        followers: "0",
        following: "0",
        likes: "0",
        totalMinutes: String(this.user.totalMinutes),
        weight: this.user.weight,
        registerDate: this.user.registerDate
      }
    })
  }

  // 跳转关注
  goFollow() {
    if (!this.loginUser) return;
    router.pushUrl({
      url: "pages/FollowFansPage",
      params: {
        subTab: 0,
        uid: this.loginUser._id
      }
    })
  }

  // 跳转粉丝
  goFans() {
    if (!this.loginUser) return;
    router.pushUrl({
      url: "pages/FollowFansPage",
      params: {
        subTab: 1,
        uid: this.loginUser._id
      }
    })
  }

  build() {
    Column() {
      Scroll() {
        Column({ space: 15 }) {
          // 用户头部卡片 头像修正：this.user.avatar，删除userInfo
          Column() {
            Row() {
              Stack({ alignContent: Alignment.Center }) {
                Image(this.user.avatar ? $r(`app.media.${this.user.avatar}`) : $r("app.media.avatar"))
                  .width(88)
                  .height(88)
                  .borderRadius(44)
                // 无头像显示昵称首字母
                Text(this.user.nickname?.length > 0 ? this.user.nickname.substring(0, 1).toUpperCase() : "U")
                  .fontSize(30)
                  .fontColor(Color.White)
              }
              .width(80)
              .height(80)
              .margin({ right: 15 })
              .onClick(() => this.goProfile())

              Column({ space: 6 }) {
                Text(this.user.nickname || "律动Stick")
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .onClick(() => this.goProfile())
                Text(this.user.email)
                  .fontSize(13)
                  .fontColor('#888')
                Row({ space: 6 }) {
                  Text("普通会员")
                    .fontSize(11)
                    .backgroundColor('#F0F0F0')
                    .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                    .borderRadius(8)
                  Text("开通VIP >")
                    .fontSize(11)
                    .fontColor('#FF6B4A')
                }
                Row({ space: 30 }) {
                  Text("关注")
                    .fontSize(14)
                    .fontColor('#333')
                    .onClick(() => this.goFollow())
                  Text("粉丝")
                    .fontSize(14)
                    .fontColor('#333')
                    .onClick(() => this.goFans())
                }
                .margin({ top: 6 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding(15)

            Divider()
              .color('#EEEEEE')
              .margin({ top: 8, bottom: 8 })

            Row() {
              DataStatItem({ value: `${this.totalDays}`, label: "运动天数" })
              DataStatItem({ value: `${this.totalMin}`, label: "累计分钟" })
              DataStatItem({ value: `${this.weekTimes}`, label: "本周训练" })
              DataStatItem({ value: `${this.medalNum}`, label: "获得奖牌" })
            }
            .width('100%')
          }
          .width('94%')
          .margin({ left: '3%', top: 20 })
          .backgroundColor(Color.White)
          .borderRadius(12)

          // 运动档案分组
          Column() {
            Text("运动档案")
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .width('94%')
              .margin({ left: '3%', bottom: 8 })

            Column() {
              FunctionItem({
                icon: "📚",
                title: "我的课程",
                desc: "暂无收藏课程",
                clickEvent: () => {
                  router.pushUrl({ url: "pages/CoursePage" })
                }
              })
              FunctionItem({
                icon: "📝",
                title: "运动记录",
                desc: "查看全部训练日志",
                clickEvent: () => {
                  router.pushUrl({ url: "pages/RecordPage" })
                }
              })
              FunctionItem({
                icon: "🏆",
                title: "我的奖牌",
                desc: `共获得${this.medalNum}枚奖牌`,
                clickEvent: () => {
                  router.pushUrl({ url: "pages/MedalPage" })
                }
              })
            }
            .width('94%')
            .margin({ left: '3%' })
            .borderRadius(12)
          }

          // 工具与设置分组
          Column() {
            Text("工具与设置")
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .width('94%')
              .margin({ left: '3%', bottom: 8 })

            Column() {
              FunctionItem({
                icon: "⚙️",
                title: "系统设置",
                desc: "账号、隐私、通用设置",
                clickEvent: () => {
                  router.pushUrl({ url: "pages/SettingPage" })
                }
              })
              FunctionItem({
                icon: "❓",
                title: "帮助与反馈",
                desc: "问题咨询、意见反馈",
                clickEvent: () => {
                  router.pushUrl({ url: "pages/FeedbackPage" })
                }
              })
              FunctionItem({
                icon: "ℹ️",
                title: "关于我们",
                desc: "版本 1.0.0",
                clickEvent: () => {
                  router.pushUrl({ url: "pages/AboutPage" })
                }
              })
            }
            .width('94%')
            .margin({ left: '3%' })
            .borderRadius(12)
          }

          // 退出登录
          Button('退出登录')
            .width('94%')
            .height(48)
            .margin({ left: '3%', top: 10 })
            .backgroundColor('#FF4D4F')
            .fontColor(Color.White)
            .borderRadius(12)
            .onClick(async () => {
              await clearUser();
              promptAction.showToast({ message: "已退出登录", duration: 1000 })
              setTimeout(() => {
                router.replaceUrl({ url: 'pages/Index' });
              }, 1000)
            })

          Blank()
            .height(30)
        }
      }
      .layoutWeight(1)

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
            .fontColor('#888888')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          router.replaceUrl({ url: 'pages/DiscoverPage' })
        })
        Column({ space: 4 }) {
          Text('我的')
            .fontSize(14)
            .fontColor('#1677FF')
            .fontWeight(FontWeight.Bold)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
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