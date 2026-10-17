@Component
export struct RegisterPage {



  @State nickname: string = ''
  @State email: string = ''
  @State password: string = ''

  build() {

    Column({ space: 20 }) {

      Text('用户注册')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)

      TextInput({
        placeholder: '请输入昵称'
      })
        .width('85%')
        .onChange((value) => {
          this.nickname = value
        })

      TextInput({
        placeholder: '请输入邮箱'
      })
        .width('85%')
        .onChange((value) => {
          this.email = value
        })

      TextInput({
        placeholder: '请输入密码'
      })
        .width('85%')
        .type(InputType.Password)
        .onChange((value) => {
          this.password = value
        })

      Button('注册')
        .width('85%')
        .height(50)

      Text('已有账号？返回登录')
        .fontColor('#6A5ACD')

    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}