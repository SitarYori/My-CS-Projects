// pages/PersonalInformation.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// 用户基础信息接口（供外部使用）
export interface UserProfile {
  gender: string;
  birthday: string;
  height: number;
  weight: number;
  injuries: string[];
}

@Entry
@Component
struct PersonalInformation {
  @State currentStep: number = 1;
  @State gender: string = '';

  // 生日选择器数据
  private yearList: string[] = this.generateYearList();
  private monthList: string[] = this.generateMonthList();
  private dayList: string[] = this.generateDayList();

  @State selectYearIndex: number = 30;
  @State selectMonthIndex: number = 5;
  @State selectDayIndex: number = 0;

  // 重命名避免与组件内置属性冲突
  @State userHeight: number = 160.0;
  @State userWeight: number = 41.5;

  @State injuryList: string[] = [];

  private generateYearList(): string[] {
    const list: string[] = [];
    for (let i = 0; i < 51; i++) {
      list.push(`${1960 + i}年`);
    }
    return list;
  }

  private generateMonthList(): string[] {
    const list: string[] = [];
    for (let i = 1; i <= 12; i++) {
      list.push(`${i}月`);
    }
    return list;
  }

  private generateDayList(): string[] {
    const list: string[] = [];
    for (let i = 1; i <= 31; i++) {
      list.push(`${i}日`);
    }
    return list;
  }

  // 提交用户信息并返回
  private submitProfile(): void {
    const birthdayStr: string = `${this.yearList[this.selectYearIndex]}${this.monthList[this.selectMonthIndex]}${this.dayList[this.selectDayIndex]}`;
    const profile: UserProfile = {
      gender: this.gender,
      birthday: birthdayStr,
      height: this.userHeight,
      weight: this.userWeight,
      injuries: this.injuryList
    };
    AppStorage.setOrCreate<UserProfile>('userProfile', profile);
    promptAction.showToast({ message: '专属计划已生成', duration: 1000 });
    router.back();
  }

  nextStep(): void {
    if (this.currentStep === 1 && !this.gender) {
      promptAction.showToast({ message: '请选择性别', duration: 1000 });
      return;
    }
    this.currentStep++;
  }

  prevStep(): void {
    if (this.currentStep === 1) {
      router.back();
    } else {
      this.currentStep--;
    }
  }

  toggleInjury(item: string): void {
    const index: number = this.injuryList.indexOf(item);
    if (index > -1) {
      this.injuryList.splice(index, 1);
    } else {
      this.injuryList.push(item);
    }
  }

  build() {
    Column() {
      // 顶部导航 + 进度条
      Row() {
        Text('〈')
          .fontSize(26)
          .fontColor('#333333')
          .onClick(() => {
            this.prevStep();
          })

        Stack({ alignContent: Alignment.Start }) {
          Rect()
            .width('100%')
            .height(6)
            .fill('#EEEEEE')
            .borderRadius(3)
          Rect()
            .width(`${this.currentStep * 25}%`)
            .height(6)
            .fill('#22C55E')
            .borderRadius(3)
        }
        .layoutWeight(1)
        .margin({ left: 16, right: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)

      // 标题区域
      Column({ space: 8 }) {
        Text('基础信息')
          .fontSize(14)
          .fontColor('#999999')
          .backgroundColor('#F0F0F0')
          .padding({ left: 10, right: 10, top: 4, bottom: 4 })
          .borderRadius(4)

        Text(this.getStepTitle())
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
          .width('100%')

        Text(this.getStepSubtitle())
          .fontSize(16)
          .fontColor('#999999')
          .width('100%')
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12, bottom: 32 })

      // 步骤内容区
      Scroll() {
        Column() {
          if (this.currentStep === 1) {
            this.GenderStepBuilder();
          } else if (this.currentStep === 2) {
            this.BirthdayStepBuilder();
          } else if (this.currentStep === 3) {
            this.HeightWeightStepBuilder();
          } else if (this.currentStep === 4) {
            this.InjuryStepBuilder();
          }
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)

      // 底部操作区
      Column({ space: 12 }) {
        if (this.currentStep === 4) {
          // 原有按钮：不存在伤病困扰
          Button('不存在伤病困扰')
            .fontSize(18)
            .width('90%')
            .height(56)
            .backgroundColor('#22C55E')
            .borderRadius(28)
            .onClick(() => {
              // 选择不存在则清空伤病记录
              this.injuryList = [];
              this.submitProfile();
            })

          // 新增按钮：存在伤病困扰（位于原按钮下方）
          Button('存在伤病困扰')
            .fontSize(18)
            .width('90%')
            .height(56)
            .backgroundColor('#22C55E')
            .borderRadius(28)
            .onClick(() => {
              // 保留已勾选的伤病记录，直接提交
              this.submitProfile();
            })
        } else {
          Button('下一步')
            .fontSize(18)
            .width('90%')
            .height(56)
            .backgroundColor('#22C55E')
            .borderRadius(28)
            .onClick(() => {
              this.nextStep();
            })
        }

        Text('信息将同步到「个人资料」')
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')
      .padding({ bottom: 32 })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  // 步骤1：选择性别
  @Builder GenderStepBuilder() {
    Row({ space: 20 }) {
      Column({ space: 16 }) {
        Text('👤')
          .fontSize(120)
          .fontColor(this.gender === '男' ? '#22C55E' : '#CCCCCC')
        Row({ space: 8 }) {
          Text('♂')
            .fontSize(24)
            .fontColor(this.gender === '男' ? '#22C55E' : '#333333')
          Text('男')
            .fontSize(20)
            .fontColor(this.gender === '男' ? '#22C55E' : '#333333')
            .fontWeight(this.gender === '男' ? FontWeight.Bold : FontWeight.Normal)
        }
      }
      .layoutWeight(1)
      .height(320)
      .backgroundColor(this.gender === '男' ? '#F0FFF0' : '#F8F8F8')
      .border({ width: 2, color: this.gender === '男' ? '#22C55E' : 'transparent' })
      .borderRadius(12)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.gender = '男';
      })

      Column({ space: 16 }) {
        Text('👤')
          .fontSize(120)
          .fontColor(this.gender === '女' ? '#22C55E' : '#CCCCCC')
        Row({ space: 8 }) {
          Text('♀')
            .fontSize(24)
            .fontColor(this.gender === '女' ? '#22C55E' : '#333333')
          Text('女')
            .fontSize(20)
            .fontColor(this.gender === '女' ? '#22C55E' : '#333333')
            .fontWeight(this.gender === '女' ? FontWeight.Bold : FontWeight.Normal)
        }
      }
      .layoutWeight(1)
      .height(320)
      .backgroundColor(this.gender === '女' ? '#F0FFF0' : '#F8F8F8')
      .border({ width: 2, color: this.gender === '女' ? '#22C55E' : 'transparent' })
      .borderRadius(12)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.gender = '女';
      })
    }
    .width('90%')
    .margin({ left: '5%' })
  }

  // 步骤2：选择生日
  @Builder BirthdayStepBuilder() {
    Row() {
      TextPicker({ range: this.yearList, selected: this.selectYearIndex })
        .layoutWeight(1)
        .selectedTextStyle({
          color: '#111111',
          font: { size: 28, weight: FontWeight.Bold }
        })
        .disappearTextStyle({
          color: '#CCCCCC',
          font: { size: 18, weight: FontWeight.Normal }
        })
        .textStyle({
          color: '#999999',
          font: { size: 20, weight: FontWeight.Normal }
        })
        .onChange((_: string | string[], index: number | number[]) => {
          this.selectYearIndex = index as number;
        })

      TextPicker({ range: this.monthList, selected: this.selectMonthIndex })
        .layoutWeight(1)
        .selectedTextStyle({
          color: '#111111',
          font: { size: 28, weight: FontWeight.Bold }
        })
        .disappearTextStyle({
          color: '#CCCCCC',
          font: { size: 18, weight: FontWeight.Normal }
        })
        .textStyle({
          color: '#999999',
          font: { size: 20, weight: FontWeight.Normal }
        })
        .onChange((_: string | string[], index: number | number[]) => {
          this.selectMonthIndex = index as number;
        })

      TextPicker({ range: this.dayList, selected: this.selectDayIndex })
        .layoutWeight(1)
        .selectedTextStyle({
          color: '#111111',
          font: { size: 28, weight: FontWeight.Bold }
        })
        .disappearTextStyle({
          color: '#CCCCCC',
          font: { size: 18, weight: FontWeight.Normal }
        })
        .textStyle({
          color: '#999999',
          font: { size: 20, weight: FontWeight.Normal }
        })
        .onChange((_: string | string[], index: number | number[]) => {
          this.selectDayIndex = index as number;
        })
    }
    .width('100%')
    .height(300)
  }

  // 步骤3：身高体重
  @Builder HeightWeightStepBuilder() {
    Column({ space: 48 }) {
      Column({ space: 12 }) {
        Row() {
          Text(this.userHeight.toFixed(1))
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111111')
          Text('厘米')
            .fontSize(18)
            .fontColor('#666666')
            .margin({ top: 20 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Slider({
          value: this.userHeight,
          min: 140,
          max: 190,
          step: 0.1,
          style: SliderStyle.OutSet
        })
          .width('80%')
          .trackColor('#EEEEEE')
          .selectedColor('#22C55E')
          .blockColor('#22C55E')
          .onChange((value: number) => {
            this.userHeight = value;
          })
      }
      .width('100%')

      Column({ space: 12 }) {
        Row() {
          Text(this.userWeight.toFixed(1))
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111111')
          Text('公斤')
            .fontSize(18)
            .fontColor('#666666')
            .margin({ top: 20 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Slider({
          value: this.userWeight,
          min: 30,
          max: 100,
          step: 0.1,
          style: SliderStyle.OutSet
        })
          .width('80%')
          .trackColor('#EEEEEE')
          .selectedColor('#22C55E')
          .blockColor('#22C55E')
          .onChange((value: number) => {
            this.userWeight = value;
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding({ top: 20 })
  }

  // 步骤4：伤病困扰
  @Builder InjuryStepBuilder() {
    Row({ space: 20 }) {
      Column({ space: 14 }) {
        Text('🦵')
          .fontSize(80)
          .fontColor('#BBBBBB')
        Text('膝盖')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
        Text('关节疼痛、卡顿或不适')
          .fontSize(14)
          .fontColor('#999999')

        Checkbox({ name: 'knee' })
          .select(this.injuryList.includes('膝盖'))
          .selectedColor('#22C55E')
          .onChange((_: boolean) => {
            this.toggleInjury('膝盖');
          })
          .margin({ top: 8 })
      }
      .layoutWeight(1)
      .padding(20)
      .backgroundColor('#F8F8F8')
      .borderRadius(12)
      .alignItems(HorizontalAlign.Center)

      Column({ space: 14 }) {
        Text('🩻')
          .fontSize(80)
          .fontColor('#BBBBBB')
        Text('腰部')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
        Text('疼痛或下肢麻木')
          .fontSize(14)
          .fontColor('#999999')

        Checkbox({ name: 'waist' })
          .select(this.injuryList.includes('腰部'))
          .selectedColor('#22C55E')
          .onChange((_: boolean) => {
            this.toggleInjury('腰部');
          })
          .margin({ top: 8 })
      }
      .layoutWeight(1)
      .padding(20)
      .backgroundColor('#F8F8F8')
      .borderRadius(12)
      .alignItems(HorizontalAlign.Center)
    }
    .width('90%')
    .margin({ left: '5%', top: 30 })
  }

  getStepTitle(): string {
    switch (this.currentStep) {
      case 1: return '选择性别';
      case 2: return '选择生日';
      case 3: return '选择身高体重';
      case 4: return '你是否存在伤病困扰';
      default: return '';
    }
  }

  getStepSubtitle(): string {
    switch (this.currentStep) {
      case 1:
      case 2:
      case 3:
        return '填写真实信息，生成合适的计划';
      case 4:
        return '选择伤病部位后，将为你去除不适合的动作及器械类动作';
      default: return '';
    }
  }
}