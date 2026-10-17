// pages/ProfilePage.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct ProfilePage {
  @State userInfo: UserProfileInfo = {
    name: '',
    avatar: '',
    bio: '',
    location: '',
    followers: 0,
    following: 0,
    likes: 0,
    monthlyWorkouts: 0,
    totalMinutes: 0,
    totalDays: 0
  };

  aboutToAppear() {
    // 获取MinePage跳转携带的登录用户名参数
    const params = router.getParams() as Record<string, string>;
    if (params) {
      this.userInfo = {
        name: params.name || '健身小夏',
        avatar: params.avatar || '',
        bio: params.bio || '助力千万女性摆脱身材焦虑，获得自由人生。',
        location: params.location || '女·重庆·渝北区·IP重庆',
        followers: Number(params.followers) || 0,
        following: Number(params.following) || 0,
        likes: Number(params.likes) || 0,
        monthlyWorkouts: Number(params.monthlyWorkouts) || 0,
        totalMinutes: Number(params.totalMinutes) || 0,
        totalDays: Number(params.totalDays) || 0
      };
    }
  }

  build() {
    Column() {
      // 顶部导航栏（替换返回为Text，兼容低版本）
      Row() {
        Text('<')
          .fontSize(24)
          .fontColor('#333333')
          .onClick(() => {
            router.back();
          })

        Text('个人主页')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('···')
          .fontSize(20)
          .fontColor('#333333')
          .onClick(() => {
            promptAction.showToast({ message: '更多功能', duration: 1000 });
          })
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 0, bottom: 12 })
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column() {
          this.UserHeader()
          this.StatsRow()
          this.CertificationInfo()
          this.BioSection()
          this.TotalWorkoutData()
          this.TabBar()
          this.CourseList()
          this.HotPosts()
        }
        .width('100%')
        .padding({ bottom: 20 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  @Builder
  UserHeader() {
    Column() {
      Row() {
        Image(this.userInfo.avatar || 'https://ts1.tc.mm.bing.net/th/id/R-C.1ed2f6f12237b105787f2cb8a1fef2c7?rik=9dyYcxBeIqCdhw&riu=http%3a%2f%2fimg.touxiangkong.com%2fuploads%2fallimg%2f20220526%2f1653554400242699.jpg&ehk=GuL1mWXfbvONlJcOdd2Uzlzf%2fE%2fzzaWWwdpOUsHwcg0%3d&risl=&pid=ImgRaw&r=0')
          .width(80)
          .height(80)
          .borderRadius(40)
          .objectFit(ImageFit.Cover)
          .margin({ right: 16 })

        Column({ space: 8 }) {
          Row() {
            Text(this.userInfo.name)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
            Text('已关注')
              .fontSize(12)
              .fontColor('#FF6B4A')
              .backgroundColor('#FFF0ED')
              .padding({ left: 8, right: 8, top: 2, bottom: 2 })
              .borderRadius(10)
              .margin({ left: 8 })
          }
          Button('编辑资料')
            .fontSize(14)
            .height(32)
            .backgroundColor('#F0F0F0')
            .fontColor('#333333')
            .borderRadius(16)
            .width(100)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('94%')
      .margin({ left: '3%', top: 16 })
    }
  }

  @Builder
  StatsRow() {
    Row() {
      this.StatItem('关注', this.formatNumber(this.userInfo.following))
      this.StatItem('粉丝', this.formatNumber(this.userInfo.followers))
      this.StatItem('收获加油', this.formatNumber(this.userInfo.likes))
      this.StatItem('月跟练人次', this.formatNumber(this.userInfo.monthlyWorkouts))
    }
    .width('94%')
    .margin({ left: '3%', top: 16, bottom: 16 })
    .padding({ top: 12, bottom: 12 })
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .justifyContent(FlexAlign.SpaceAround)
  }

  @Builder
  StatItem(label: string, value: string) {
    Column({ space: 4 }) {
      Text(value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
      Text(label)
        .fontSize(12)
        .fontColor('#999999')
    }
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
  }

  @Builder
  CertificationInfo() {
    Column() {
      Row({ space: 8 }) {
        this.CertTag('成就0个', '#6A5ACD', '#F0EDFF')
        this.CertTag(`累计运动天数${this.userInfo.totalDays}`, '#6A5ACD', '#F0EDFF')
      }
      .width('100%')
      .margin({ bottom: 8 })
      Row({ space: 8 }) {
        this.CertTag('ACE认证教练', '#52C41A', '#F6FFED')
        this.CertTag('健身领域达人', '#52C41A', '#F6FFED')
      }
      .width('100%')
      .margin({ bottom: 8 })
      Row({ space: 8 }) {
        this.CertTag('跟练合伙人', '#FF9800', '#FFF8E1')
        this.CertTag('百万跟练合伙人', '#FF9800', '#FFF8E1')
      }
      .width('100%')
    }
    .width('94%')
    .margin({ left: '3%', bottom: 12 })
  }

  @Builder
  CertTag(text: string, color: string, bgColor: string) {
    Text(text)
      .fontSize(11)
      .fontColor(color)
      .backgroundColor(bgColor)
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      .borderRadius(12)
  }

  @Builder
  BioSection() {
    Column() {
      Text(this.userInfo.bio)
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')
        .margin({ bottom: 8 })
      Row() {
        Text('📍')
          .fontSize(12)
        Text(this.userInfo.location)
          .fontSize(12)
          .fontColor('#999999')
          .margin({ left: 4 })
      }
      .width('100%')
    }
    .width('94%')
    .margin({ left: '3%', bottom: 16 })
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  TotalWorkoutData() {
    Column() {
      Row() {
        Text('总运动数据')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text(`${this.userInfo.totalMinutes}分钟`)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF6B4A')
        Text(' >')
          .fontSize(14)
          .fontColor('#CCCCCC')
      }
      .width('100%')
      .margin({ bottom: 8 })
      Text('近12个月')
        .fontSize(12)
        .fontColor('#999999')
        .width('100%')
        .margin({ bottom: 12 })
      Row({ space: 4 }) {
        ForEach([0,0,0,0,0,0,0,0,0,0,0,0], (height: number) => {
          Column()
            .width('7%')
            .height(height)
            .backgroundColor('#6A5ACD')
            .borderRadius(4)
        })
      }
      .width('100%')
      .height(80)
      .alignItems(VerticalAlign.Bottom)
    }
    .width('94%')
    .margin({ left: '3%', bottom: 16 })
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  TabBar() {
    Row() {
      this.TabItem('主页', true)
      this.TabItem('动态', false)
      this.TabItem('课程', false)
      this.TabItem('装备', false)
    }
    .width('94%')
    .margin({ left: '3%', bottom: 12 })
    .justifyContent(FlexAlign.SpaceAround)
  }

  @Builder
  TabItem(title: string, isSelected: boolean) {
    Column() {
      Text(title)
        .fontSize(15)
        .fontColor(isSelected ? '#6A5ACD' : '#666666')
        .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal)
      if (isSelected) {
        Column()
          .width(24)
          .height(3)
          .backgroundColor('#6A5ACD')
          .borderRadius(2)
          .margin({ top: 4 })
      }
    }
    .onClick(() => {
      promptAction.showToast({ message: title, duration: 1000 });
    })
  }

  @Builder
  CourseList() {
    Column() {
      Row() {
        Text('达人课程')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text('查看更多 >')
          .fontSize(12)
          .fontColor('#6A5ACD')
      }
      .width('100%')
      .margin({ bottom: 12 })
      this.CourseCard('改善圆肩驼背头前引', 'K1零基础·4分钟·评分7.5', '#FFE4E1')
      this.CourseCard('徒手高效燃脂', 'K2初学·11分钟·评分8.5', '#E0FFFF')
      this.CourseCard('减掉小肚腩', 'K2初学·13分钟·评分8.4', '#FFF0F5')
    }
    .width('94%')
    .margin({ left: '3%', bottom: 16 })
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  CourseCard(title: string, info: string, bgColor: string) {
    Row() {
      Column()
        .width(60)
        .height(60)
        .backgroundColor(bgColor)
        .borderRadius(8)
        .margin({ right: 12 })
      Column({ space: 4 }) {
        Text(title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        Text(info)
          .fontSize(11)
          .fontColor('#999999')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      Button('跟练')
        .fontSize(12)
        .height(30)
        .backgroundColor('#6A5ACD')
        .fontColor(Color.White)
        .borderRadius(15)
        .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .margin({ bottom: 12 })
  }

  @Builder
  HotPosts() {
    Column() {
      Row() {
        Text('热门动态')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text('查看更多 >')
          .fontSize(12)
          .fontColor('#6A5ACD')
      }
      .width('100%')
      .margin({ bottom: 12 })
      Text('动态内容开发中...')
        .fontSize(14)
        .fontColor('#999999')
        .padding(20)
    }
    .width('94%')
    .margin({ left: '3%', bottom: 16 })
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  formatNumber(num: number): string {
    if (num >= 10000) {
      return (num / 10000).toFixed(1) + 'w';
    }
    return num.toString();
  }
}

interface UserProfileInfo {
  name: string;
  avatar: string;
  bio: string;
  location: string;
  followers: number;
  following: number;
  likes: number;
  monthlyWorkouts: number;
  totalMinutes: number;
  totalDays: number;
}