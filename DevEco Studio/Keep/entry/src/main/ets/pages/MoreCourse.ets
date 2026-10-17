// pages/MoreCourse.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// 课程详情参数接口
interface CourseDetailParams {
  title: string;
  level: string;
  duration: string;
  calories: string;
  imageUrl: string;
  tag: string;
}

@Entry
@Component
export struct MoreCourse {
  @State courseInfo: CourseDetailParams = {
    title: '11分钟女生无跑跳瘦肚子·进阶',
    level: 'K3 进阶',
    duration: '11',
    calories: '92-138',
    imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?auto=format&fit=crop&w=1200&q=80',
    tag: ''
  };

  aboutToAppear(): void {
    const params = router.getParams() as Record<string, string>;
    if (params) {
      if (params['title']) this.courseInfo.title = params['title'];
      if (params['level']) this.courseInfo.level = params['level'];
      if (params['duration']) {
        this.courseInfo.duration = params['duration'].replace('分钟', '');
      }
      if (params['calories']) this.courseInfo.calories = params['calories'];
      if (params['imageUrl']) this.courseInfo.imageUrl = params['imageUrl'];
      if (params['tag']) this.courseInfo.tag = params['tag'];
    }
  }

  build() {
    Column() {
      // ========== 顶部导航栏 ==========
      Row() {
        Text('〈')
          .fontSize(26)
          .fontColor('#333')
          .onClick(() => {
            router.back();
          })

        Blank()

        Text('👥')
          .fontSize(22)
          .margin({ right: 20 })
          .onClick(() => {
            promptAction.showToast({ message: '好友都在练', duration: 1000 });
          })
        Text('↗')
          .fontSize(22)
          .margin({ right: 20 })
          .onClick(() => {
            promptAction.showToast({ message: '分享课程', duration: 1000 });
          })
        Text('⋯')
          .fontSize(22)
          .onClick(() => {
            promptAction.showToast({ message: '更多选项', duration: 1000 });
          })
      }
      .width('100%')
      .height(56)
      .padding({ left: 15, right: 15 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Color.White)

      // ========== 可滚动内容区 ==========
      Scroll() {
        Column({ space: 18 }) {
          // 课程封面 + 播放按钮 + 底部按钮
          Stack({ alignContent: Alignment.Center }) {
            Image(this.courseInfo.imageUrl)
              .width('100%')
              .height(280)
              .objectFit(ImageFit.Cover)
              .borderRadius(8)
              .onError(() => {
                console.info('课程封面加载失败');
              })

            // 中间播放按钮【修复：Stack叠加，Circle不嵌套Text】
            Stack({ alignContent: Alignment.Center }) {
              Circle()
                .width(72)
                .height(72)
                .fill('rgba(120, 120, 120, 0.7)')
              Text('▶')
                .fontSize(32)
                .fontColor(Color.White)
                .margin({ left: 6 })
            }
            .onClick(() => {
              promptAction.showToast({ message: '开始播放课程', duration: 1000 });
            })

            // 底部悬浮按钮
            Row() {
              Row({ space: 6 }) {
                Text('💎')
                  .fontSize(18)
                Text('开通会员参加训练')
                  .fontSize(14)
                  .fontColor(Color.White)
                Text('〉')
                  .fontSize(14)
                  .fontColor(Color.White)
              }
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .backgroundColor('rgba(0, 0, 0, 0.65)')
              .borderRadius(20)
              .onClick(() => {
                promptAction.showToast({ message: '开通会员', duration: 1000 });
              })

              Blank()

              Text('课程分段')
                .fontSize(14)
                .fontColor('#333333')
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                .backgroundColor('rgba(255, 255, 255, 0.85)')
                .borderRadius(20)
                .onClick(() => {
                  promptAction.showToast({ message: '查看课程分段', duration: 1000 });
                })
            }
            .width('100%')
            .padding({ left: 16, right: 16, bottom: 16 })
            .position({ x: 0, y: 216 })
          }
          .width('100%')
          .height(280)

          // 评分 + 系列标签
          Row({ space: 12 }) {
            Row({ space: 4 }) {
              Text('⭐')
                .fontSize(16)
              Text('9.5分')
                .fontSize(14)
                .fontColor('#333333')
                .fontWeight(FontWeight.Medium)
            }

            Row({ space: 4 }) {
              Text('🎬')
                .fontSize(14)
              Text('系列 2/4 女生无跑跳瘦肚子系列')
                .fontSize(14)
                .fontColor('#6366F1')
              Text('▽')
                .fontSize(12)
                .fontColor('#6366F1')
            }
            .backgroundColor('#F0F0FF')
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(4)
          }
          .width('100%')

          // 课程大标题
          Text(this.courseInfo.title)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111111')
            .width('100%')
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          // 难度/时长/消耗 + 智能互联标签
          Row({ space: 30 }) {
            Column({ space: 4 }) {
              Text(this.courseInfo.level.split(' ')[0])
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333')
              Text(this.courseInfo.level.split(' ')[1] || '进阶')
                .fontSize(14)
                .fontColor('#999999')
            }

            Column({ space: 4 }) {
              Text(this.courseInfo.duration)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333')
              Text('分钟')
                .fontSize(14)
                .fontColor('#999999')
            }

            Column({ space: 4 }) {
              Text(this.courseInfo.calories)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333')
              Text('千卡')
                .fontSize(14)
                .fontColor('#999999')
            }

            Blank()

            Column({ space: 2 }) {
              Row({ space: 4 }) {
                Text('⌚')
                  .fontSize(16)
                Text('Keep智能互联')
                  .fontSize(13)
                  .fontColor('#22C55E')
              }
              Text('精准测量消耗')
                .fontSize(15)
                .fontColor('#22C55E')
                .fontWeight(FontWeight.Medium)
            }
            .backgroundColor('#F0FFF0')
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .borderRadius(8)
          }
          .width('100%')

          // 发布者信息
          Row({ space: 10 }) {
            Circle()
              .width(40)
              .height(40)
              .fill('#6366F1')
            Text('减脂塑形中的Keep君')
              .fontSize(16)
              .fontColor('#333')
              .layoutWeight(1)
          }
          .width('100%')

          // 课程简介
          Text(`会员专属「${this.courseInfo.title}系列」，专为女生设计，无跑跳不伤膝，居家即可练习，有效燃脂塑形。`)
            .fontSize(14)
            .fontColor('#666666')
            .width('100%')
            .lineHeight(22)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text('更多')
            .fontSize(14)
            .fontColor('#333333')
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              promptAction.showToast({ message: '展开完整简介', duration: 1000 });
            })

          // 功能图标栏：想练/加日历/投屏/评论/练过
          Row() {
            Column({ space: 6 }) {
              Text('☰+')
                .fontSize(28)
              Text('想练')
                .fontSize(13)
                .fontColor('#666666')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              promptAction.showToast({ message: '已加入想练列表', duration: 1000 });
            })

            Column({ space: 6 }) {
              Text('📅')
                .fontSize(28)
              Text('加日历')
                .fontSize(13)
                .fontColor('#666666')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              promptAction.showToast({ message: '已添加到日历', duration: 1000 });
            })

            Column({ space: 6 }) {
              Text('📺')
                .fontSize(28)
              Text('投屏')
                .fontSize(13)
                .fontColor('#666666')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              promptAction.showToast({ message: '投屏功能开发中', duration: 1000 });
            })

            Column({ space: 6 }) {
              Text('💬')
                .fontSize(28)
              Text('评论 57')
                .fontSize(13)
                .fontColor('#666666')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              promptAction.showToast({ message: '查看评论区', duration: 1000 });
            })

            Column({ space: 6 }) {
              Text('♾')
                .fontSize(28)
              Text('练过 26万')
                .fontSize(13)
                .fontColor('#666666')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              promptAction.showToast({ message: '查看练过记录', duration: 1000 });
            })
          }
          .width('100%')
          .padding({ top: 20, bottom: 20 })

          Blank()
            .height(30)
        }
        .width('100%')
        .padding({ left: 15, right: 15 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')

      // ========== 底部固定操作栏 ==========
      Row() {
        Row({ space: 8 }) {
          Text('🥢')
            .fontSize(22)
          Text('训练模式')
            .fontSize(16)
            .fontColor('#333')
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          promptAction.showToast({ message: '切换训练模式', duration: 1000 });
        })

        // 中间GO大按钮【修复：Stack叠加，Circle不嵌套Text】
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(120)
            .height(120)
            .fill('#22C55E')
          Text('GO')
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .margin({ top: -50 })
        .onClick(() => {
          promptAction.showToast({ message: '开始训练', duration: 1000 });
        })

        Row({ space: 8 }) {
          Text('🎧')
            .fontSize(22)
          Text('装备')
            .fontSize(16)
            .fontColor('#333')
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          promptAction.showToast({ message: '查看推荐装备', duration: 1000 });
        })
      }
      .width('100%')
      .height(80)
      .backgroundColor(Color.White)
      .alignItems(VerticalAlign.Center)
      .shadow({ radius: 6, color: '#00000015', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}