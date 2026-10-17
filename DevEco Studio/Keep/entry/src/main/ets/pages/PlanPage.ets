import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { UserInfo, getUser } from '../utils/StorageUtil';

// 日程单项组件
@Component
struct ScheduleItem {
  title: string = "";
  time: string = "";
  tag: string = "";
  tagColor: ResourceColor = "#1677FF";
  build() {
    Row() {
      Column({ space: 4 }) {
        Text(this.title)
          .fontSize(15)
          .fontWeight(FontWeight.Medium);
        Text(this.time)
          .fontSize(12)
          .fontColor('#888');
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start);
      if (this.tag) {
        Text(this.tag)
          .fontSize(11)
          .fontColor(Color.White)
          .backgroundColor(this.tagColor)
          .padding({ left: 8, right: 8, top: 2, bottom: 2 })
          .borderRadius(10);
      }
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 8 });
  }
}

// 日历格子组件
@Component
struct CalendarDay {
  day: number = 0;
  isToday: boolean = false;
  hasRecord: boolean = false;
  clickEvent: () => void = () => {};
  build() {
    Column() {
      Text(this.day.toString())
        .fontSize(14)
        .fontColor(this.isToday ? Color.White : '#333');
      if (this.hasRecord) {
        Circle()
          .width(6)
          .height(6)
          .backgroundColor('#1677FF')
          .margin({ top: 4 });
      }
    }
    .width('100%')
    .height(40)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.isToday ? '#1677FF' : Color.Transparent)
    .borderRadius(20)
    .onClick(() => {
      this.clickEvent();
    });
  }
}

@Entry
@Component
export struct PlanPage {
  @State user: UserInfo = {
    _id: "",
    nickname: "",
    email: "",
    password: "",
    avatar: "",
    gender: "",
    registerDate: "",
    weight: 0,
    totalMinutes: 0
  } as UserInfo;

  @State currentYear: number = new Date().getFullYear();
  @State currentMonth: number = new Date().getMonth() + 1;
  @State selectDay: number = new Date().getDate();
  @State recordDays: number[] = [2, 5, 8, 12, 15, 18, 22, 25];

  // 页面加载时预计算日期数据，不在build里写变量
  @State nowYear: number = 0;
  @State nowMonth: number = 0;
  @State nowDay: number = 0;
  @State firstDayOfMonth: number = 0;
  @State totalMonthDays: number = 0;

  aboutToAppear() {
    this.loadUserInfo();
    // 所有日期计算放到这里，不占用build
    const nowDate = new Date();
    this.nowYear = nowDate.getFullYear();
    this.nowMonth = nowDate.getMonth() + 1;
    this.nowDay = nowDate.getDate();
    this.firstDayOfMonth = new Date(this.currentYear, this.currentMonth - 1, 1).getDay();
    this.totalMonthDays = this.getDaysOfMonth(this.currentYear, this.currentMonth);
  }

  async loadUserInfo() {
    try {
      this.user = await getUser();
    } catch (e) {
      console.error("加载用户信息失败");
    }
  }

  getDaysOfMonth(year: number, month: number): number {
    let dateObj = new Date(year, month, 0);
    return dateObj.getDate();
  }

  // build内部只允许UI组件，无任何const/let变量声明
  build() {
    // 唯一根容器
    Column() {
      // 顶部标题栏
      Row() {
        Text("我的运动日程")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1);
        Text("➕ 添加计划")
          .fontSize(14)
          .fontColor('#1677FF')
          .onClick(() => {
            promptAction.showToast({ message: "新建运动计划", duration: 1000 });
          });
      }
      .width('94%')
      .margin({ left: '3%', top: 15, bottom: 15 });

      Scroll() {
        Column({ space: 15 }) {
          // 年月切换
          Row() {
            Text("<")
              .fontSize(18)
              .onClick(() => {
                if (this.currentMonth === 1) {
                  this.currentMonth = 12;
                  this.currentYear -= 1;
                } else {
                  this.currentMonth -= 1;
                }
                // 切换月份后重新计算日历
                this.firstDayOfMonth = new Date(this.currentYear, this.currentMonth - 1, 1).getDay();
                this.totalMonthDays = this.getDaysOfMonth(this.currentYear, this.currentMonth);
              });
            Text(`${this.currentYear}年${this.currentMonth}月`)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .layoutWeight(1)
              .textAlign(TextAlign.Center);
            Text(">")
              .fontSize(18)
              .onClick(() => {
                if (this.currentMonth === 12) {
                  this.currentMonth = 1;
                  this.currentYear += 1;
                } else {
                  this.currentMonth += 1;
                }
                this.firstDayOfMonth = new Date(this.currentYear, this.currentMonth - 1, 1).getDay();
                this.totalMonthDays = this.getDaysOfMonth(this.currentYear, this.currentMonth);
              });
          }
          .width('94%')
          .margin({ left: '3%' });

          // 星期头部
          Row() {
            ForEach(["日", "一", "二", "三", "四", "五", "六"], (item: string) => {
              Text(item)
                .fontSize(13)
                .fontColor('#888')
                .layoutWeight(1)
                .textAlign(TextAlign.Center);
            })
          }
          .width('94%')
          .margin({ left: '3%' });

          // 日历网格，循环内仅简单计算，无批量const声明
          Column({ space: 8 }) {
            ForEach([0, 1, 2, 3, 4, 5], (rowIndex: number) => {
              Row() {
                ForEach([0, 1, 2, 3, 4, 5, 6], (colIndex: number) => {
                  if (rowIndex * 7 + colIndex + 1 - this.firstDayOfMonth > 0 && rowIndex * 7 + colIndex + 1 - this.firstDayOfMonth <= this.totalMonthDays) {
                    CalendarDay({
                      day: rowIndex * 7 + colIndex + 1 - this.firstDayOfMonth,
                      isToday: (rowIndex * 7 + colIndex + 1 - this.firstDayOfMonth) === this.nowDay && this.currentYear === this.nowYear && this.currentMonth === this.nowMonth,
                      hasRecord: this.recordDays.includes(rowIndex * 7 + colIndex + 1 - this.firstDayOfMonth),
                      clickEvent: () => {
                        const dayNum = rowIndex * 7 + colIndex + 1 - this.firstDayOfMonth;
                        this.selectDay = dayNum;
                        promptAction.showToast({ message: `选择${this.currentMonth}月${dayNum}日`, duration: 800 });
                      }
                    })
                      .layoutWeight(1);
                  } else {
                    Column()
                      .layoutWeight(1)
                      .height(40);
                  }
                })
              }
            })
          }
          .width('94%')
          .margin({ left: '3%' })
          .backgroundColor(Color.White)
          .padding(12)
          .borderRadius(12);

          // 今日运动数据
          Row() {
            Column({ space: 4 }) {
              Text("0")
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1677FF');
              Text("步数")
                .fontSize(12)
                .fontColor('#888');
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center);
            Column({ space: 4 }) {
              Text("0")
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FF6B4A');
              Text("千卡")
                .fontSize(12)
                .fontColor('#888');
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center);
            Column({ space: 4 }) {
              Text("0")
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor('#52C41A');
              Text("分钟")
                .fontSize(12)
                .fontColor('#888');
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center);
            Column({ space: 4 }) {
              Text("0")
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor('#6A5ACD');
              Text("公里")
                .fontSize(12)
                .fontColor('#888');
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center);
          }
          .width('94%')
          .margin({ left: '3%' })
          .backgroundColor(Color.White)
          .padding(15)
          .borderRadius(12);

          // 本周训练计划
          Column() {
            Row() {
              Text("本周训练计划")
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1);
              Text("查看全部 >")
                .fontSize(12)
                .fontColor('#1677FF')
                .onClick(() => {
                  promptAction.showToast({ message: "查看全部计划", duration: 1000 });
                });
            }
            .width('100%')
            .margin({ bottom: 12 });

            ScheduleItem({ title: "帕梅拉瘦腿训练", time: "07:00 - 07:15", tag: "每日", tagColor: '#1677FF' });
            ScheduleItem({ title: "有氧燃脂操", time: "19:30 - 20:00", tag: "已完成", tagColor: '#52C41A' });
            ScheduleItem({ title: "核心腹肌训练", time: "20:10 - 20:25", tag: "待完成", tagColor: '#FF9800' });
          }
          .width('94%')
          .margin({ left: '3%' });

          Blank()
            .height(20);
        }
      }
      .layoutWeight(1);

      // 底部导航栏
      Row() {
        Column({ space: 4 }) {
          Text('课程')
            .fontSize(14)
            .fontColor('#888888');
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          router.replaceUrl({ url: 'pages/MainPage' });
        });
        Column({ space: 4 }) {
          Text('日程')
            .fontSize(14)
            .fontColor('#1677FF')
            .fontWeight(FontWeight.Bold);
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center);
        Column({ space: 4 }) {
          Text('发现')
            .fontSize(14)
            .fontColor('#888888');
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          router.replaceUrl({ url: 'pages/DiscoverPage' });
        });
        Column({ space: 4 }) {
          Text('我的')
            .fontSize(14)
            .fontColor('#888888');
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          router.replaceUrl({ url: 'pages/MinePage' });
        });
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.White)
      .shadow({ radius: 5, color: '#00000010', offsetY: -2 });
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8');
  }
}