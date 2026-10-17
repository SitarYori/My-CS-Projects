// pages/MainPage.ets
import { UserInfo, getUser } from '../utils/StorageUtil';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// ===================== 类型定义 =====================
interface CourseImageSet {
  back: string;
  baduanjin: string;
  dance: string;
  leg: string;
  hip: string;
  abs: string;
}

interface PlanImageSet {
  fat: string;
  student: string;
  waist: string;
}

// 用户基础信息接口
interface UserProfile {
  gender: string;
  birthday: string;
  height: number;
  weight: number;
  injuries: string[];
}

// 计划课程项接口
interface PlanCourseItem {
  title: string;
  duration: string;
}

// ===================== 功能入口图标 =====================
@Component
struct FunctionIcon {
  title: string = '';
  icon: string = '';

  build() {
    Column({ space: 8 }) {
      Column() {
        Text(this.icon)
          .fontSize(28)
      }
      .width('100%')
      .height(70)
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Text(this.title)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('18%')
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      promptAction.showToast({
        message: `你点击了：${this.title}`,
        duration: 1000
      })
    })
  }
}

// ===================== 大家都在练 - 单列课程卡片 =====================
@Component
struct HotCourseItem {
  title: string = '';
  tag: string = '';
  level: string = '';
  duration: string = '';
  imageUrl: string = '';
  calories: string = '92-138';

  build() {
    Row({ space: 14 }) {
      Image(this.imageUrl)
        .width(140)
        .height(100)
        .borderRadius(8)
        .objectFit(ImageFit.Cover)
        .onError(() => {
          console.info('课程封面加载失败');
        })

      Column({ space: 8 }) {
        Text(this.title)
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')

        Row({ space: 8 }) {
          if (this.tag) {
            Text(this.tag)
              .fontSize(12)
              .fontColor('#22C55E')
              .backgroundColor('#F0FFF0')
              .padding({ left: 8, right: 8, top: 3, bottom: 3 })
              .borderRadius(4)
          }

          Text(`${this.level}  ${this.duration}`)
            .fontSize(13)
            .fontColor('#999999')
        }
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .onClick(() => {
      router.pushUrl({
        url: 'pages/MoreCourse',
        params: {
          title: this.title,
          level: this.level,
          duration: this.duration,
          calories: this.calories,
          imageUrl: this.imageUrl,
          tag: this.tag
        }
      });
    })
  }
}

// ===================== 探索推荐课程卡片 =====================
@Component
struct ExploreCourseCard {
  title: string = '';
  tag: string = '';
  level: string = '';
  duration: string = '';
  imageUrl: string = '';

  build() {
    Column({ space: 8 }) {
      Image(this.imageUrl)
        .width(160)
        .height(120)
        .borderRadius(8)
        .objectFit(ImageFit.Cover)
        .onError(() => {
          console.info('课程封面加载失败');
        })

      Text(this.title)
        .fontSize(14)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width(160)

      Row({ space: 6 }) {
        if (this.tag) {
          Text(this.tag)
            .fontSize(11)
            .fontColor('#22C55E')
            .backgroundColor('#F0FFF0')
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .borderRadius(4)
        }
        Text(`${this.level}  ${this.duration}`)
          .fontSize(12)
          .fontColor('#999')
      }
      .width(160)
    }
    .onClick(() => {
      router.pushUrl({
        url: 'pages/MoreCourse',
        params: {
          title: this.title,
          level: this.level,
          duration: this.duration,
          calories: '80-120',
          imageUrl: this.imageUrl,
          tag: this.tag
        }
      });
    })
  }
}

// ===================== 个性定制计划大卡片（修复按钮遮挡） =====================
@Component
struct CustomPlanCard {
  @Prop userName: string = '';
  @Prop userProfile: UserProfile | null = null;
  private bgImage: string = 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=1200&q=80';

  private getDayPlans(): PlanCourseItem[][] {
    return [
      [
        { title: '18分钟小腹燃脂', duration: '训练 · 18分钟' },
        { title: '14分钟站立瘦腿', duration: '训练 · 14分钟' }
      ],
      [
        { title: '20分钟臀部塑形', duration: '训练 · 15分钟' },
        { title: '20分钟全身燃脂', duration: '训练 · 20分钟' }
      ]
    ];
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      // 背景 + 蒙层
      Stack() {
        Image(this.bgImage)
          .width('100%')
          .height('100%')
          .objectFit(ImageFit.Cover)
          .borderRadius(12)
          .onError(() => {
            console.info('计划页背景图加载失败');
          })

        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(0,0,0,0.65)')
          .borderRadius(12)
      }
      .width('100%')
      .height('100%')

      // 专属标签
      Text(`专为 ${this.userName} 打造`)
        .fontSize(14)
        .fontColor(Color.White)
        .backgroundColor('#6366F1')
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .borderRadius({ topLeft: 0, topRight: 12, bottomLeft: 12, bottomRight: 0 })

      // 内容区：调整边距，避免底部按钮被遮挡
      Column({ space: 12 }) {
        Column({ space: 6 }) {
          Text('个性定制训练计划')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .width('100%')

          Text('1分钟问卷评估')
            .fontSize(14)
            .fontColor('rgba(255,255,255,0.7)')
            .width('100%')
        }

        if (!this.userProfile || this.userProfile.gender === '') {
          Button('✎ 评估身体现状，为你定制训练方案')
            .fontSize(16)
            .width('100%')
            .height(48)
            .backgroundColor('rgba(255,255,255,0.2)')
            .fontColor(Color.White)
            .borderRadius(24)
            .margin({ top: 10 })
        } else {
          // 已填写：两天训练计划
          Row({ space: 12 }) {
            ForEach(this.getDayPlans(), (dayCourses: PlanCourseItem[], index: number) => {
              Column({ space: 8 }) {
                Text(`第${index + 1}天`)
                  .fontSize(14)
                  .fontColor('rgba(255,255,255,0.7)')
                  .width('100%')

                Row({ space: 8 }) {
                  ForEach(dayCourses, (course: PlanCourseItem) => {
                    Column({ space: 4 }) {
                      Text(course.title)
                        .fontSize(15)
                        .fontColor(Color.White)
                        .fontWeight(FontWeight.Medium)
                        .maxLines(1)
                        .textOverflow({ overflow: TextOverflow.Ellipsis })
                        .width('100%')
                      Text(course.duration)
                        .fontSize(12)
                        .fontColor('rgba(255,255,255,0.7)')
                        .width('100%')
                    }
                    .layoutWeight(1)
                    .padding(12)
                    .backgroundColor('rgba(255,255,255,0.1)')
                    .borderRadius(8)
                  })
                }
                .width('100%')
              }
              .layoutWeight(1)
            })
          }
          .width('100%')
          .margin({ top: 4 })

          Button('☰ 查看更多')
            .fontSize(16)
            .width('100%')
            .height(48)
            .backgroundColor('rgba(255,255,255,0.2)')
            .fontColor(Color.White)
            .borderRadius(24)
            .margin({ top: 6 })
        }
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .margin({ top: 28 })
    }
    .width('100%')
    // 卡片高度微调，确保底部按钮完整展示
    .height(this.userProfile && this.userProfile.gender ? 290 : 240)
    .onClick(() => {
      router.pushUrl({
        url: 'pages/PersonalInformation'
      });
    })
  }
}

// ===================== 智能计划卡片 =====================
@Component
struct PlanItemCard {
  title: string = '';
  desc: string = '';
  tag: string = '';
  tagColor: string = '#FF4D4F';
  imageUrl: string = '';

  build() {
    Column({ space: 8 }) {
      Stack({ alignContent: Alignment.TopStart }) {
        Image(this.imageUrl)
          .width('100%')
          .height(120)
          .borderRadius({ topLeft: 8, topRight: 8, bottomLeft: 0, bottomRight: 0 })
          .objectFit(ImageFit.Cover)
          .onError(() => {
            console.info('计划封面加载失败');
          })

        if (this.tag) {
          Text(this.tag)
            .fontSize(12)
            .fontColor(Color.White)
            .backgroundColor(this.tagColor)
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius({ topLeft: 8, topRight: 0, bottomLeft: 0, bottomRight: 8 })
        }
      }
      .width('100%')

      Column({ space: 4 }) {
        Text(this.title)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')

        Text(this.desc)
          .fontSize(12)
          .fontColor('#888')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
      }
      .padding({ left: 8, right: 8, bottom: 10 })
    }
    .width(160)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .onClick(() => {
      promptAction.showToast({ message: `查看${this.title}`, duration: 1000 });
    })
  }
}

// ===================== 筛选下拉项 =====================
@Component
struct FilterItem {
  title: string = '';

  build() {
    Row() {
      Text(this.title)
        .fontSize(14)
        .fontColor('#666')
      Text('▼')
        .fontSize(10)
        .fontColor('#999')
        .margin({ left: 4 })
    }
    .onClick(() => {
      promptAction.showToast({ message: `筛选${this.title}`, duration: 800 });
    })
  }
}

// ===================== 每日限免大卡片 =====================
@Component
struct DailyFreeCard {
  private bgImage: string = 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?auto=format&fit=crop&w=1200&q=80';

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Stack() {
        Image(this.bgImage)
          .width('100%')
          .height('100%')
          .objectFit(ImageFit.Cover)
          .borderRadius(12)
          .onError(() => {
            console.info('限免课程背景图加载失败');
          })

        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(0,0,0,0.3)')
          .borderRadius(12)
      }
      .width('100%')
      .height('100%')

      Text('每日限免 14:54:58')
        .fontSize(16)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Medium)
        .backgroundColor('#FF4D4F')
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .borderRadius({ topLeft: 12, topRight: 0, bottomLeft: 0, bottomRight: 12 })
        .position({ x: 0, y: 0 })

      Column({ space: 8 }) {
        Row() {
          Column({ space: 6 }) {
            Text('20分钟HIIT全身燃脂·爆发训练')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            Text('K3 · 21分钟 · 评分 9.2')
              .fontSize(14)
              .fontColor('rgba(255,255,255,0.9)')
          }
          .layoutWeight(1)

          Text('免费练')
            .fontSize(16)
            .fontColor('#333')
            .backgroundColor('#E6C27A')
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .borderRadius(20)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              promptAction.showToast({ message: '开始免费训练', duration: 1000 });
            })
        }
        .width('100%')

        Row({ space: 12 }) {
          Row({ space: 10 }) {
            Column()
              .width(50)
              .height(50)
              .backgroundColor('rgba(255,255,255,0.2)')
              .borderRadius(6)
            Column({ space: 2 }) {
              Text('01')
                .fontSize(14)
                .fontColor(Color.White)
              Text('身体唤醒')
                .fontSize(13)
                .fontColor(Color.White)
            }
          }
          .layoutWeight(1)

          Row({ space: 10 }) {
            Column()
              .width(50)
              .height(50)
              .backgroundColor('rgba(255,255,255,0.2)')
              .borderRadius(6)
            Column({ space: 2 }) {
              Text('02')
                .fontSize(14)
                .fontColor(Color.White)
              Text('激活热身')
                .fontSize(13)
                .fontColor(Color.White)
            }
          }
          .layoutWeight(1)
        }
        .width('100%')
        .margin({ top: 8 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 16 })
      .position({ x: 0, y: 160 })
    }
    .width('100%')
    .height(280)
    .onClick(() => {
      promptAction.showToast({ message: '查看课程详情', duration: 1000 });
    })
  }
}

// ===================== 主页面：课程/计划/会员专区 =====================
@Component
struct CoursePage {
  @State currentTab: number = 0;
  @State currentFilterTab: number = 0;
  @State userInfo: UserInfo = {
    _id: "",
    nickname: "",
    email: "",
    password: "",
    avatar: "",
    gender: "",
    registerDate: "",
    weight: 0,
    totalMinutes: 0
  };
  tabs: string[] = ['课程', '计划', '会员专区'];
  filterTabs: string[] = ['全部', '智能定制计划'];

  @StorageLink('userProfile') userProfile: UserProfile = {
    gender: '',
    birthday: '',
    height: 0,
    weight: 0,
    injuries: []
  };

  private courseImages: CourseImageSet = {
    back: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&w=800&q=80',
    baduanjin: 'https://images.unsplash.com/photo-1506629082955-511b1aa562c8?auto=format&fit=crop&w=800&q=80',
    dance: 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&w=800&q=80',
    leg: 'https://images.unsplash.com/photo-1434682881908-b43d0467b798?auto=format&fit=crop&w=800&q=80',
    hip: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?auto=format&fit=crop&w=800&q=80',
    abs: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?auto=format&fit=crop&w=800&q=80'
  };

  private planImages: PlanImageSet = {
    fat: 'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?auto=format&fit=crop&w=800&q=80',
    student: 'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&w=800&q=80',
    waist: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?auto=format&fit=crop&w=800&q=80'
  };

  aboutToAppear() {
    this.loadUserInfo();
  }

  async loadUserInfo(): Promise<void> {
    try {
      this.userInfo = await getUser();
    } catch (e) {
      console.error('加载用户信息失败', JSON.stringify(e));
    }
  }

  build() {
    Column() {
      TextInput({ placeholder: '帕梅拉瘦腿' })
        .width('90%')
        .height(45)
        .borderRadius(22)
        .backgroundColor(Color.White)
        .margin({ top: 10, bottom: 15 })

      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column({ space: 5 }) {
            Text(tab)
              .fontSize(22)
              .fontWeight(this.currentTab === index ? FontWeight.Bold : FontWeight.Normal)
              .fontColor(this.currentTab === index ? '#333' : '#888888')

            if (this.currentTab === index) {
              Rect()
                .width(30)
                .height(3)
                .fill('#22C55E')
                .borderRadius(2)
            }
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 15 })
          .onClick(() => {
            this.currentTab = index;
          })
        })
      }
      .width('100%')
      .margin({ bottom: 15 })

      if (this.currentTab === 0) {
        this.CourseTabContent();
      } else if (this.currentTab === 1) {
        this.PlanTabContent();
      } else if (this.currentTab === 2) {
        this.VipTabContent();
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder CourseTabContent() {
    Scroll() {
      Column({ space: 24 }) {
        Row() {
          FunctionIcon({ title: '全部课程', icon: '⊞' })
          FunctionIcon({ title: '免费课', icon: '▶' })
          FunctionIcon({ title: '直播课', icon: '📺' })
          FunctionIcon({ title: '动作库', icon: '📋' })
          FunctionIcon({ title: '找路线', icon: '📍' })
        }
        .width('94%')
        .margin({ left: '3%' })
        .justifyContent(FlexAlign.SpaceBetween)

        Column({ space: 14 }) {
          Row() {
            Text('大家都在练')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .layoutWeight(1)
            Text('〉')
              .fontSize(18)
              .fontColor('#999')
          }
          .width('94%')
          .margin({ left: '3%' })

          Column({ space: 18 }) {
            HotCourseItem({
              title: '周杰伦音乐版|吉尼12分钟超强瘦背部训练',
              tag: '无俯卧撑',
              level: 'K2 初学',
              duration: '13分钟',
              imageUrl: this.courseImages.back,
              calories: '80-120'
            })
            HotCourseItem({
              title: '八段锦镜像版-加呼吸口令',
              tag: '',
              level: 'K1 零基础',
              duration: '12分钟',
              imageUrl: this.courseImages.baduanjin,
              calories: '60-90'
            })
            HotCourseItem({
              title: '帕梅拉15分钟快乐舞蹈操·高效减脂',
              tag: '全程站立',
              level: 'K3 进阶',
              duration: '14分钟',
              imageUrl: this.courseImages.dance,
              calories: '100-140'
            })
          }
          .width('94%')
          .margin({ left: '3%' })
        }

        Column({ space: 14 }) {
          Row() {
            Text('从练过的「自重塑形」课开始探索')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .layoutWeight(1)
            Text('〉')
              .fontSize(18)
              .fontColor('#999')
          }
          .width('94%')
          .margin({ left: '3%' })

          Scroll() {
            Row({ space: 14 }) {
              ExploreCourseCard({
                title: '10分钟站立瘦大腿 紧致内外侧 无蹦跳',
                tag: '低噪音',
                level: 'K1 零基础',
                duration: '10分钟',
                imageUrl: this.courseImages.leg
              })
              ExploreCourseCard({
                title: '15分钟居家翘臀训练',
                tag: '无器械',
                level: 'K2 初学',
                duration: '15分钟',
                imageUrl: this.courseImages.hip
              })
              ExploreCourseCard({
                title: '7天马甲线养成计划',
                tag: '热门',
                level: 'K2 初学',
                duration: '12分钟',
                imageUrl: this.courseImages.abs
              })
            }
            .padding({ right: 15 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('94%')
          .margin({ left: '3%' })
        }
      }
      .width('100%')
      .padding({ bottom: 20 })
    }
    .scrollBar(BarState.Off)
    .layoutWeight(1)
  }

  @Builder PlanTabContent() {
    Scroll() {
      Column({ space: 20 }) {
        CustomPlanCard({
          userName: this.userInfo.nickname || '用户',
          userProfile: this.userProfile.gender ? this.userProfile : null
        })
          .width('94%')
          .margin({ left: '3%' })

        Column({ space: 12 }) {
          Text('会员专属 · 智能定制计划')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .width('94%')
            .margin({ left: '3%' })

          Scroll() {
            Row({ space: 12 }) {
              PlanItemCard({
                title: '大体重·全身燃脂',
                desc: '零基础 不伤膝盖 巨暴汗',
                tag: '近期热门',
                imageUrl: this.planImages.fat
              })
              PlanItemCard({
                title: '学生专属·瘦腿计划',
                desc: '学生党减肥必选',
                tag: '近期热门',
                imageUrl: this.planImages.student
              })
              PlanItemCard({
                title: '告别腰腹赘肉',
                desc: '消除腰腹脂肪',
                tag: '智能定制',
                tagColor: '#22C55E',
                imageUrl: this.planImages.waist
              })
            }
            .padding({ right: 15 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('94%')
          .margin({ left: '3%' })
        }

        Row({ space: 12 }) {
          ForEach(this.filterTabs, (item: string, index: number) => {
            Text(item)
              .fontSize(14)
              .fontColor(this.currentFilterTab === index ? Color.White : '#333')
              .backgroundColor(this.currentFilterTab === index ? '#333' : '#F5F5F5')
              .padding({ left: 18, right: 18, top: 8, bottom: 8 })
              .borderRadius(20)
              .onClick(() => {
                this.currentFilterTab = index;
              })
          })
        }
        .width('94%')
        .margin({ left: '3%' })

        Row() {
          FilterItem({ title: '目标' })
          FilterItem({ title: '部位' })
          FilterItem({ title: '难度' })
          FilterItem({ title: '适合人群' })
        }
        .width('94%')
        .margin({ left: '3%' })
        .justifyContent(FlexAlign.SpaceBetween)

        Column() {
          Text('计划课程列表')
            .fontSize(14)
            .fontColor('#999')
            .padding(30)
        }
        .width('94%')
        .margin({ left: '3%' })
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Color.White)
        .borderRadius(12)
      }
      .width('100%')
      .padding({ bottom: 20 })
    }
    .scrollBar(BarState.Off)
    .layoutWeight(1)
  }

  @Builder VipTabContent() {
    Scroll() {
      Column({ space: 24 }) {
        DailyFreeCard()
          .width('94%')
          .margin({ left: '3%' })

        Column({ space: 8 }) {
          Text('适合你的合集')
            .fontSize(16)
            .fontColor('#D4A76A')
            .width('94%')
            .margin({ left: '3%' })

          Text('为你精选')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333')
            .width('94%')
            .margin({ left: '3%' })

          Column({ space: 12 }) {
            Row() {
              Text('帕梅拉 HIIT · 刷脂天花板')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)
              Text('〉')
                .fontSize(20)
                .fontColor('#333')
            }
            .width('100%')

            Scroll() {
              Row({ space: 12 }) {
                ExploreCourseCard({
                  imageUrl: this.courseImages.dance,
                  title: '帕梅拉燃脂舞蹈',
                  tag: '高效燃脂',
                  level: 'K3 进阶',
                  duration: '20分钟'
                })
                ExploreCourseCard({
                  imageUrl: this.courseImages.abs,
                  title: '核心力量训练',
                  tag: '强化马甲线',
                  level: 'K2 初学',
                  duration: '15分钟'
                })
                ExploreCourseCard({
                  imageUrl: this.courseImages.leg,
                  title: '腿部塑形训练',
                  tag: '无器械',
                  level: 'K2 初学',
                  duration: '12分钟'
                })
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFF5F5')
          .borderRadius(12)
          .onClick(() => {
            promptAction.showToast({ message: '查看合集详情', duration: 1000 });
          })
        }
        .width('94%')
        .margin({ left: '3%' })
      }
      .width('100%')
      .padding({ bottom: 20 })
    }
    .scrollBar(BarState.Off)
    .layoutWeight(1)
  }
}

// ===================== 内嵌页面组件（保留，备用） =====================
@Component
struct PlanPage2 {
  build() {
    Column() {
      Text('日程/计划页')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
      Text('智能计划推荐：20天马甲线突击计划')
        .fontSize(14)
        .margin({ top: 20 })
        .fontColor('#888888')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#F5F5F5')
  }
}

@Component
struct DiscoverPage {
  build() {
    Column() {
      Text('发现/社区页')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
      Text('运动动态、好友排行、商城功能待扩展')
        .fontSize(14)
        .margin({ top: 20 })
        .fontColor('#888888')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#F5F5F5')
  }
}

@Component
struct FunctionItem {
  title: string = '';

  build() {
    Row() {
      Text(this.title)
        .fontSize(16)
        .layoutWeight(1)
      Text('〉')
        .fontSize(16)
        .fontColor('#888888')
    }
    .width('100%')
    .padding(15)
    .backgroundColor(Color.White)
  }
}

@Component
struct MinePage {
  @State userInfo: UserInfo = {
    _id: "",
    nickname: "",
    email: "",
    password: "",
    avatar: "",
    gender: "",
    registerDate: "",
    weight: 0,
    totalMinutes: 0
  };

  aboutToAppear() {
    this.loadUserInfo();
  }

  async loadUserInfo(): Promise<void> {
    try {
      this.userInfo = await getUser();
    } catch (e) {
      console.error('加载用户信息失败', JSON.stringify(e));
    }
  }

  build() {
    Column({ space: 20 }) {
      Column({ space: 10 }) {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(80)
            .height(80)
            .fill('#E6E6FA')
          Text(this.userInfo.nickname ? this.userInfo.nickname.substring(0, 1).toUpperCase() : 'U')
            .fontSize(30)
            .fontColor(Color.White)
        }
        .width(80)
        .height(80)

        Text(this.userInfo.nickname || '用户')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        Text(this.userInfo.email || '')
          .fontSize(14)
          .fontColor('#888888')
      }
      .width('100%')
      .padding(20)
      .backgroundColor(Color.White)
      .borderRadius(12)
      .margin({ top: 20 })

      List({ space: 1 }) {
        ListItem() {
          FunctionItem({ title: '我的课程' })
        }
        ListItem() {
          FunctionItem({ title: '运动记录' })
        }
        ListItem() {
          FunctionItem({ title: '设置' })
        }
        ListItem() {
          Button('退出登录')
            .width('100%')
            .height(50)
            .backgroundColor('#FF4D4F')
            .onClick(() => {
              router.replaceUrl({ url: 'pages/Index' });
            })
        }
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(15)
    .backgroundColor('#F5F5F5')
  }
}

// ===================== 主入口页面（已添加底部导航栏） =====================
@Entry
@Component
export struct MainPage {
  build() {
    Column() {
      // 主体内容区域，占满剩余高度
      Column() {
        CoursePage()
      }
      .layoutWeight(1)

      // 底部导航（固定，放在主体外面）
      Row() {
        Column({ space: 4 }) {
          Text('课程')
            .fontSize(14)
            .fontColor('#1677FF')
            .fontWeight(FontWeight.Bold)
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