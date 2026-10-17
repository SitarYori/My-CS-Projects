@Component
export struct LoginPage {



  @State email: string = ''
  @State password: string = ''

  build() {
    Column({ space: 20 }) {

      Text('Keep')
        .fontSize(36)
        .fontWeight(FontWeight.Bold)

      Text('大学生健身助手')
        .fontSize(16)
        .fontColor('#888888')

      TextInput({
        placeholder: '请输入邮箱'
      })
        .width('85%')
        .height(50)
        .onChange((value) => {
          this.email = value
        })

      TextInput({
        placeholder: '请输入密码'
      })
        .width('85%')
        .height(50)
        .type(InputType.Password)
        .onChange((value) => {
          this.password = value
        })

      Button('登录')
        .width('85%')
        .height(50)

      Text('没有账号？立即注册')
        .fontColor('#6A5ACD')

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#E6E6FA')
    .justifyContent(FlexAlign.Center)
  }
}