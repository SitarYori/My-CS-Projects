// pages/PostDetailPage.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct PostDetailPage {
  @State postData: PostDetailInfo = {
    id: '',
    userName: '',
    avatarUrl: '',
    title: '',
    content: '',
    imageUrl: '',
    publishTime: '',
    location: '',
    likeCount: 0,
    commentCount: 0,
    collectCount: 0,
    distance: '',
    duration: '',
    pace: '',
    calories: ''
  };

  aboutToAppear() {
    const params = router.getParams() as Record<string, string>;
    if (params) {
      this.postData = {
        id: params.id || '',
        userName: params.userName || '用户',
        avatarUrl: params.avatarUrl || '',
        title: params.title || '',
        content: params.content || '',
        imageUrl: params.imageUrl || '',
        publishTime: params.publishTime || '',
        location: params.location || '',
        likeCount: parseInt(params.likeCount) || 0,
        commentCount: parseInt(params.commentCount) || 0,
        collectCount: parseInt(params.collectCount) || 0,
        distance: params.distance || '5.07',
        duration: params.duration || '00:31:37',
        pace: params.pace || "06'13\"",
        calories: params.calories || '330'
      };
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Button('<')
          .fontSize(24)
          .backgroundColor(Color.Transparent)
          .fontColor('#333333')
          .onClick(() => {
            router.back();
          })

        Text('帖子详情')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('···')
          .fontSize(20)
          .fontColor('#333333')
          .onClick(() => {
            promptAction.showToast({ message: '更多', duration: 1000 });
          })
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 12, bottom: 12 })
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column() {
          // 用户信息行
          this.UserInfoRow()

          // 帖子标题
          if (this.postData.title) {
            Text(this.postData.title)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .width('100%')
              .margin({ top: 12, bottom: 12 })
          }

          // 帖子内容
          Text(this.postData.content)
            .fontSize(15)
            .fontColor('#333333')
            .lineHeight(22)
            .width('100%')
            .margin({ bottom: 16 })

          // 运动数据卡片（户外跑步）
          this.WorkoutDataCard()

          // 帖子图片
          if (this.postData.imageUrl) {
            Image(this.postData.imageUrl)
              .width('100%')
              .height(280)
              .borderRadius(12)
              .objectFit(ImageFit.Cover)
              .margin({ bottom: 16 })
          }

          // 地点和时间
          Row() {
            Text('📍')
              .fontSize(12)
            Text(this.postData.location || '河南')
              .fontSize(12)
              .fontColor('#666')
              .margin({ left: 4 })
            Text(this.postData.publishTime || '2026/03/31 10:19')
              .fontSize(12)
              .fontColor('#999')
              .margin({ left: 12 })
          }
          .width('100%')
          .margin({ bottom: 16 })

          // 作者推荐
          this.AuthorRecommendCard()

          // 互动按钮栏
          this.ActionBar()

          // 评论标题
          Row() {
            Text(`评论 ${this.postData.commentCount}`)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
            Blank()
            Text('按推荐')
              .fontSize(13)
              .fontColor('#888')
              .margin({ right: 12 })
            Text('按时间')
              .fontSize(13)
              .fontColor('#888')
          }
          .width('100%')
          .margin({ top: 16, bottom: 16 })

          // 评论输入框
          this.CommentInput()

          // 评论列表
          this.CommentList()
        }
        .width('94%')
        .margin({ left: '3%' })
        .padding({ bottom: 30 })
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
  UserInfoRow() {
    Row() {
      // 头像
      if (this.postData.avatarUrl) {
        Image(this.postData.avatarUrl)
          .width(45)
          .height(45)
          .borderRadius(22.5)
          .objectFit(ImageFit.Cover)
          .margin({ right: 12 })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ProfilePage',
              params: {
                name: this.postData.userName,
                avatar: this.postData.avatarUrl
              }
            });
          })
      } else {
        Circle()
          .width(45)
          .height(45)
          .fill('#E6E6FA')
          .margin({ right: 12 })
      }

      Column({ space: 4 }) {
        Row() {
          Text(this.postData.userName)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ProfilePage',
                params: {
                  name: this.postData.userName,
                  avatar: this.postData.avatarUrl
                }
              });
            })

          Text('已关注')
            .fontSize(10)
            .fontColor('#FF6B4A')
            .backgroundColor('#FFF0ED')
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .borderRadius(8)
            .margin({ left: 8 })
        }

        Text('跑步🏃')
          .fontSize(11)
          .fontColor('#999')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('关注')
        .fontSize(12)
        .height(30)
        .backgroundColor('#FF6B4A')
        .fontColor(Color.White)
        .borderRadius(15)
        .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .margin({ top: 8, bottom: 8 })
  }

  @Builder
  WorkoutDataCard() {
    Column() {
      Row() {
        Text('🏃 户外跑步')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333')
        Blank()
        Text('查看详情 >')
          .fontSize(12)
          .fontColor('#1677FF')
          .onClick(() => {
            promptAction.showToast({ message: '查看详情', duration: 1000 });
          })
      }
      .width('100%')
      .margin({ bottom: 12 })

      Row() {
        this.WorkoutStatItem(this.postData.distance + '公里', '训练时长', this.postData.duration)
        this.WorkoutStatItem(this.postData.pace, '平均配速', this.postData.calories + '千卡')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
    .margin({ bottom: 16 })
  }

  @Builder
  WorkoutStatItem(value: string, label: string, extra: string) {
    Column() {
      Text(value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333')
      Text(label)
        .fontSize(12)
        .fontColor('#999')
        .margin({ top: 4 })
      Text(extra)
        .fontSize(12)
        .fontColor('#999')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
  }

  @Builder
  AuthorRecommendCard() {
    Column() {
      Row() {
        Text('作者推荐')
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text('Keep B5 智能运动手环')
          .fontSize(13)
          .fontColor('#333')
      }
      .width('100%')
      .margin({ bottom: 8 })

      Row() {
        Row() {
          Circle()
            .width(20)
            .height(20)
            .fill('#E6E6FA')
          Text('Keep 作者使用')
            .fontSize(11)
            .fontColor('#999')
            .margin({ left: 6 })
        }

        Blank()

        Button('去看看')
          .fontSize(11)
          .height(28)
          .backgroundColor('#F0F0F0')
          .fontColor('#333')
          .borderRadius(14)
          .padding({ left: 12, right: 12 })
      }
      .width('100%')
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ bottom: 16 })
  }

  @Builder
  ActionBar() {
    Row() {
      this.ActionButton('❤️', this.postData.likeCount, () => {
        this.postData.likeCount++;
        promptAction.showToast({ message: '加油', duration: 800 });
      })
      this.ActionButton('💬', this.postData.commentCount, () => {
        promptAction.showToast({ message: '评论', duration: 800 });
      })
      this.ActionButton('⭐', this.postData.collectCount, () => {
        this.postData.collectCount++;
        promptAction.showToast({ message: '收藏', duration: 800 });
      })
      this.ActionButton('↗️', 0, () => {
        promptAction.showToast({ message: '分享', duration: 800 });
      })
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .justifyContent(FlexAlign.SpaceAround)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  ActionButton(icon: string, count: number, onClick: () => void) {
    Row() {
      Text(icon)
        .fontSize(20)
      Text(count > 0 ? count.toString() : '')
        .fontSize(13)
        .fontColor('#666')
        .margin({ left: 4 })
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .borderRadius(20)
    .onClick(onClick)
  }

  @Builder
  CommentInput() {
    Row() {
      Circle()
        .width(32)
        .height(32)
        .fill('#E6E6FA')
        .margin({ right: 10 })

      TextInput({ placeholder: '说点什么吧...' })
        .layoutWeight(1)
        .height(40)
        .backgroundColor('#F5F5F5')
        .borderRadius(20)
        .padding({ left: 16 })
    }
    .width('100%')
    .margin({ bottom: 16 })
  }

  @Builder
  CommentList() {
    Column({ space: 16 }) {
      this.CommentItem('包仔来了 - 高心率', '厉害啊', '2026/04/10 20:02', '广东', '782')
      this.CommentItem('自信的_Keeperah3r', '35岁以内问题不大。要是不到30岁，这心率没啥问题', '2026/04/22 16:44', '山东', '')
      this.CommentItem('率真的_Keepermw5z', '姐妹，你这是在桂林路跑的吗', '2026/04/14 11:37', '江苏', '')
      this.CommentItem('安静的_Keeperdtp7', '不是，上面标了', '2026/04/15 19:14', '广东', '')
      this.CommentItem('皇华皇使', '手环好用不', '2026/05/18 18:56', '重庆', '')
    }
    .width('100%')
    .margin({ bottom: 20 })
  }

  @Builder
  CommentItem(name: string, content: string, time: string, location: string, likeCount: string) {
    Column() {
      Row() {
        Circle()
          .width(35)
          .height(35)
          .fill('#E6E6FA')
          .margin({ right: 10 })

        Column({ space: 4 }) {
          Row() {
            Text(name)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
            Text(`· ${location}`)
              .fontSize(11)
              .fontColor('#999')
              .margin({ left: 6 })
          }
          .width('100%')

          Text(content)
            .fontSize(13)
            .fontColor('#333')
            .width('100%')

          Text(time)
            .fontSize(11)
            .fontColor('#999')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        if (likeCount) {
          Row() {
            Text('❤️')
              .fontSize(12)
            Text(likeCount)
              .fontSize(11)
              .fontColor('#999')
              .margin({ left: 2 })
          }
        }
      }
      .width('100%')

      Divider()
        .color('#EEEEEE')
        .height(0.5)
        .margin({ top: 8 })
    }
  }
}

interface PostDetailInfo {
  id: string;
  userName: string;
  avatarUrl: string;
  title: string;
  content: string;
  imageUrl: string;
  publishTime: string;
  location: string;
  likeCount: number;
  commentCount: number;
  collectCount: number;
  distance: string;
  duration: string;
  pace: string;
  calories: string;
}

export default PostDetailPage;