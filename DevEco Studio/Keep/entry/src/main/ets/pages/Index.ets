// pages/Index.ets
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import { HttpUtil } from '../utils/HttpUtil';

export interface UserData {
  _id?: string;
  name: string;
  email: string;
  pass: string;
  gender?: string;
  age?: number;
  job?: string;
  avatar?: string;
  createdAt?: string;
}

export interface RegisterParams {
  name: string;
  email: string;
  pass: string;
  gender?: string;
  age?: number;
  job?: string;
  avatar?: string;
}

export interface LoginParams {
  email: string;
  pass: string;
}

@Entry
@Component
struct Index {
  @State currentPage: number = 0

  // ===== 登录表单 =====
  @State email: string = ''
  @State pass: string = ''

  // ===== 注册表单 =====
  @State registerName: string = ''
  @State registerEmail: string = ''
  @State registerPass: string = ''
  @State registerGender: string = '保密'
  @State registerAge: string = ''
  @State registerJob: string = ''
  @State registerAvatar: string = ''

  @State isLoading: boolean = false;

  private genderOptions: string[] = ['保密', '男', '女'];

  build() {
    Column() {
      if (this.currentPage === 0) {
        this.LoginPage()
      }
      if (this.currentPage === 1) {
        this.RegisterPage()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#E6E6FA')
    .justifyContent(FlexAlign.Center)
  }


  //登录
  @Builder
  LoginPage() {
    Column({ space: 20 }) {
      Text('🏃')
        .fontSize(48)
      Text('律动Stick')
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor('#6A5ACD')
      Text('大学生健身助手')
        .fontSize(16)
        .fontColor('#888888')

      TextInput({ placeholder: '请输入邮箱', text: this.email })
        .width('85%')
        .height(50)
        .backgroundColor('#FFFFFF')
        .borderRadius(25)
        .padding({ left: 20 })
        .onChange((value: string) => {
          this.email = value
        })

      TextInput({ placeholder: '请输入密码', text: this.pass })
        .width('85%')
        .height(50)
        .backgroundColor('#FFFFFF')
        .borderRadius(25)
        .padding({ left: 20 })
        .type(InputType.Password)
        .onChange((value: string) => {
          this.pass = value
        })

      Button('登 录')
        .width('85%')
        .height(50)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .backgroundColor('#6A5ACD')
        .fontColor(Color.White)
        .borderRadius(25)
        .enabled(!this.isLoading)
        .onClick(() => {
          this.doLogin()
        })

      Row() {
        Text('还没有账号？')
          .fontSize(14)
          .fontColor('#888888')
        Text('立即注册')
          .fontSize(14)
          .fontColor('#6A5ACD')
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.currentPage = 1
            this.clearRegisterForm()
          })
      }
      .margin({ top: 8 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }

  //注册
  @Builder
  RegisterPage() {
    Scroll() {
      Column({ space: 16 }) {
        Text('📝 用户注册')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#6A5ACD')
          .margin({ top: 10 })

        // 昵称
        Column({ space: 4 }) {
          Text('昵称 *')
            .fontSize(14)
            .fontColor('#666')
            .width('85%')
          TextInput({ placeholder: '请输入昵称', text: this.registerName })
            .width('85%')
            .height(48)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .padding({ left: 20 })
            .onChange((value: string) => {
              this.registerName = value
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        // 邮箱
        Column({ space: 4 }) {
          Text('邮箱 *')
            .fontSize(14)
            .fontColor('#666')
            .width('85%')
          TextInput({ placeholder: '请输入邮箱', text: this.registerEmail })
            .width('85%')
            .height(48)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .padding({ left: 20 })
            .onChange((value: string) => {
              this.registerEmail = value
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        // 密码
        Column({ space: 4 }) {
          Text('密码 *')
            .fontSize(14)
            .fontColor('#666')
            .width('85%')
          TextInput({ placeholder: '请输入密码（至少6位）', text: this.registerPass })
            .width('85%')
            .height(48)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .padding({ left: 20 })
            .type(InputType.Password)
            .onChange((value: string) => {
              this.registerPass = value
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        // 性别
        Column({ space: 4 }) {
          Text('性别')
            .fontSize(14)
            .fontColor('#666')
            .width('85%')
          Row({ space: 12 }) {
            ForEach(this.genderOptions, (item: string) => {
              Button(item)
                .fontSize(14)
                .height(36)
                .backgroundColor(this.registerGender === item ? '#6A5ACD' : '#F0F0F0')
                .fontColor(this.registerGender === item ? Color.White : '#666')
                .borderRadius(18)
                .padding({ left: 20, right: 20 })
                .onClick(() => {
                  this.registerGender = item
                })
            })
          }
          .width('85%')
          .justifyContent(FlexAlign.Start)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        // 年龄
        Column({ space: 4 }) {
          Text('年龄')
            .fontSize(14)
            .fontColor('#666')
            .width('85%')
          TextInput({ placeholder: '请输入年龄', text: this.registerAge })
            .width('85%')
            .height(48)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .padding({ left: 20 })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.registerAge = value
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        // 职业
        Column({ space: 4 }) {
          Text('职业')
            .fontSize(14)
            .fontColor('#666')
            .width('85%')
          TextInput({ placeholder: '请输入职业', text: this.registerJob })
            .width('85%')
            .height(48)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .padding({ left: 20 })
            .onChange((value: string) => {
              this.registerJob = value
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        Button('注 册')
          .width('85%')
          .height(50)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .backgroundColor('#6A5ACD')
          .fontColor(Color.White)
          .borderRadius(25)
          .margin({ top: 8 })
          .enabled(!this.isLoading)
          .onClick(() => {
            this.doRegister()
          })

        Row() {
          Text('已有账号？')
            .fontSize(14)
            .fontColor('#888888')
          Text('去登录')
            .fontSize(14)
            .fontColor('#6A5ACD')
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.currentPage = 0
              this.clearLoginForm()
            })
        }
        .margin({ top: 8, bottom: 20 })
      }
      .width('100%')
      .padding({ top: 20, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }

  // ========== 登录逻辑 ==========
  async doLogin(): Promise<void> {
    if (!this.email || !this.pass) {
      promptAction.showToast({ message: '请输入邮箱和密码！', duration: 1500 })
      return
    }

    this.isLoading = true

    try {
      const loginData: LoginParams = {
        email: this.email,
        pass: this.pass
      }

      const res = await HttpUtil.post<UserData>('/user/login', loginData)

      console.log('📥 登录响应：', JSON.stringify(res))

      if (res.code === 200 && res.data) {
        promptAction.showToast({
          message: `🎉 登录成功！欢迎 ${res.data.name || '用户'}`,
          duration: 1500
        })
        setTimeout(() => {
          router.replaceUrl({ url: 'pages/MainPage' })
        }, 500)
      } else {
        promptAction.showToast({
          message: res.msg || '邮箱或密码错误，请先注册！',
          duration: 1500
        })
      }
    } catch (error) {
      console.error('❌ 登录异常：', JSON.stringify(error))
      // ✅ 改为友好提示
      promptAction.showToast({
        message: '连接服务器失败，请检查网络！',
        duration: 1500
      })
    } finally {
      this.isLoading = false
    }
  }

  // ========== 注册逻辑 ==========
  async doRegister(): Promise<void> {
    if (!this.registerName || !this.registerEmail || !this.registerPass) {
      promptAction.showToast({
        message: '昵称、邮箱、密码不能为空！',
        duration: 1500
      })
      return
    }

    if (this.registerPass.length < 6) {
      promptAction.showToast({
        message: '密码长度不能少于6位！',
        duration: 1500
      })
      return
    }

    this.isLoading = true

    try {
      const registerData: RegisterParams = {
        name: this.registerName,
        email: this.registerEmail,
        pass: this.registerPass,
        gender: this.registerGender || '保密',
        age: this.registerAge ? parseInt(this.registerAge) : undefined,
        job: this.registerJob || '',
        avatar: this.registerAvatar || ''
      }

      console.log('📤 注册数据：', JSON.stringify(registerData))

      const res = await HttpUtil.post<UserData>('/user/register', registerData)

      console.log('📥 注册响应：', JSON.stringify(res))

      if (res.code === 200) {
        promptAction.showToast({
          message: `✅ 注册成功！请登录`,
          duration: 1500
        })
        this.currentPage = 0
        this.email = this.registerEmail
        this.clearRegisterForm()
      } else {
        promptAction.showToast({
          message: res.msg || '注册失败，请稍后重试',
          duration: 1500
        })
      }
    } catch (error) {
      console.error('❌ 注册异常：', JSON.stringify(error))
      // ✅ 改为友好提示
      promptAction.showToast({
        message: '连接服务器失败，请检查网络！',
        duration: 1500
      })
    } finally {
      this.isLoading = false
    }
  }

  clearLoginForm(): void {
    this.email = ''
    this.pass = ''
  }

  clearRegisterForm(): void {
    this.registerName = ''
    this.registerEmail = ''
    this.registerPass = ''
    this.registerGender = '保密'
    this.registerAge = ''
    this.registerJob = ''
    this.registerAvatar = ''
  }
}