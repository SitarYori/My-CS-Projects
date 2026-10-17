// pages/UserPersonalPage.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { getFollowTotal } from '../utils/HttpUtil';
import { getUser } from '../utils/StorageUtil';

@Entry
@Component
struct UserPersonalPage {
  @State userInfo: UserPersonalInfo = {
    name: '',
    avatar: '',
    gender: '女',
    location: '银河，地球',
    ip: '广西桂林',
    registerDate: '2026.06.16',
    weight: 0,
    newChallengeCount: 0,
    followers: 0,
    following: 0,
    likes: 0,
    totalMinutes: 0
  };

  aboutToAppear() {
    const params = router.getParams() as Record<string, string>;
    if (params) {
      this.userInfo.name = params.name || "律动Stick";
      this.userInfo.followers = Number(params.followers) || 0;
      this.userInfo.following = Number(params.following) || 0;
      this.userInfo.likes = Number(params.likes) || 0;
      this.userInfo.totalMinutes = Number(params.totalMinutes) || 0;
    }
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          this.CoverHeader()
          this.UserStatArea()
          this.NameEditRow()
          this.InfoTagRow()
          this.LocationText()
          this.TotalSportCard()
          this.MainTabBar()
          this.SubTabBar()
          Blank().layoutWeight(1)
          this.EmptyIcon()
          Blank().height(40)
        }
        .width('100%')
        .backgroundColor(Color.White)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  CoverHeader() {
    Column() {
      Row() {
        Text('<')
          .fontSize(26)
          .fontColor(Color.White)
          .onClick(() => router.back())
        Blank()
        Text('⎙')
          .fontSize(26)
          .fontColor(Color.White)
          .onClick(() => promptAction.showToast({ message: "分享", duration: 1000 }))
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 10 })

      Row() {
        Blank()
        Text("👆 点击更换封面图")
          .fontSize(14)
          .fontColor(Color.White)
          .backgroundColor('#2DB880')
          .padding({ left: 12, right: 12, top: 4, bottom: 4 })
          .borderRadius(16)
      }
      .width('100%')
      .padding({ right: 16, top: 12, bottom: 24 })
    }
    .width('100%')
    .backgroundColor('#36C987')
  }

  @Builder
  UserStatArea() {
    Row() {
      Image(this.userInfo.avatar ? $r(`app.media.${this.userInfo.avatar}`) : $r("app.media.avatar"))
        .width(88)
        .height(88)
        .borderRadius(44) // 圆形裁剪
        .margin({ right: 20 })

      Row({ space: 40 }) {
        this.StatText(`${this.userInfo.following}`, "关注")
        this.StatText(`${this.userInfo.followers}`, "粉丝")
        this.StatText(`${this.userInfo.likes}`, "收获加油")
      }
      .layoutWeight(1)
    }
    .width('100%')
    .padding({ left: 16, right: 16 })
    .margin({ top: -44 })
  }

  @Builder
  StatText(num: string, label: string) {
    Column({ space: 4 }) {
      Text(num)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333')
      Text(label)
        .fontSize(14)
        .fontColor('#888')
    }
  }

  @Builder
  NameEditRow() {
    Row() {
      Text(this.userInfo.name)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111')
      Blank()
      Row({ space: 16 }) {
        Text("编辑主页")
          .fontSize(16)
          .backgroundColor('#F5F5F5')
          .padding({ left: 16, right: 16, top: 6, bottom: 6 })
          .borderRadius(20)
        Text("▦")
          .fontSize(24)
      }
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12 })
  }

  @Builder
  InfoTagRow() {
    Row({ space: 16 }) {
      Text(`Kg ${this.userInfo.weight} ——`)
        .fontSize(14)
        .fontColor('#666')
      Text(`${this.userInfo.newChallengeCount} 新挑战`)
        .fontSize(14)
        .fontColor('#36C987')
      Text(`📅 ${this.userInfo.registerDate} 加入律动Stick`)
        .fontSize(14)
        .fontColor('#888')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8 })
  }

  @Builder
  LocationText() {
    Text(`${this.userInfo.gender} · ${this.userInfo.location} · ${this.userInfo.ip}`)
      .fontSize(16)
      .fontColor('#999')
      .width('100%')
      .padding({ left: 16, right: 16, top: 6, bottom: 20 })
  }

  @Builder
  TotalSportCard() {
    Column() {
      Row() {
        Text("总运动数据")
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text(" >")
          .fontSize(16)
          .fontColor('#CCC')
      }
      .width('100%')

      Row() {
        Text(`${this.userInfo.totalMinutes} 分钟`)
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#222')
        Blank()
        Row({ space: 6 }) {
          ForEach([0,0,0,0,0,0,0,0,0,0,0,0], () => {
            Circle()
              .width(8)
              .height(8)
              .fill('#36C987')
          })
        }
      }
      .width('100%')
      .margin({ top: 8 })

      Text("近 12 个月")
        .fontSize(14)
        .fontColor('#999')
        .width('100%')
    }
    .width('92%')
    .margin({ left: '4%' })
    .padding(16)
    .backgroundColor('#F8F8F8')
    .borderRadius(8)
  }

  @Builder
  MainTabBar() {
    Row() {
      this.MainTabItem("动态", true)
      this.MainTabItem("装备", false)
      this.MainTabItem("运动圈", false)
    }
    .width('100%')
    .margin({ top: 24 })
  }

  @Builder
  MainTabItem(title: string, active: boolean) {
    Column() {
      Text(title)
        .fontSize(22)
        .fontColor(active ? '#111' : '#999')
        .fontWeight(active ? FontWeight.Bold : FontWeight.Normal)
      if (active) {
        Column()
          .width(32)
          .height(4)
          .backgroundColor('#36C987')
          .borderRadius(2)
          .margin({ top: 6 })
      }
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => promptAction.showToast({ message: title, duration: 800 }))
  }

  @Builder
  SubTabBar() {
    Row({ space: 12 }) {
      this.SubTabItem("动态 0", true)
      this.SubTabItem("视频", false)
      this.SubTabItem("相册", false)
      this.SubTabItem("可跟练", false)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 16 })
  }

  @Builder
  SubTabItem(text: string, active: boolean) {
    Text(text)
      .fontSize(18)
      .fontColor(active ? Color.White : '#333')
      .backgroundColor(active ? '#222' : '#F0F0F0')
      .padding({ left: 18, right: 18, top: 8, bottom: 8 })
      .borderRadius(22)
      .onClick(() => promptAction.showToast({ message: text, duration: 800 }))
  }

  @Builder
  EmptyIcon() {
    Stack() {
      Rect()
        .width(140)
        .height(95)
        .fill('#EAEAEA')
        .translate({ x: 10, y: -10 })
      Rect()
        .width(152)
        .height(85)
        .fill('#86E8B8')
      Rect()
        .width(132)
        .height(75)
        .fill('#DDDDDD')
        .translate({ x: -10, y: 10 })
    }
    .width(152)
    .height(95)
    .margin({ top: 80 })
  }
}

interface UserPersonalInfo {
  name: string;
  avatar: string;
  gender: string;
  location: string;
  ip: string;
  registerDate: string;
  weight: number;
  newChallengeCount: number;
  followers: number;
  following: number;
  likes: number;
  totalMinutes: number;
}