import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { getMyFollowList, getMyFansList } from '../utils/HttpUtil';
import { UserInfo } from '../utils/StorageUtil';

// 后端通用返回类型
interface ApiRes {
  code: number;
  msg: string;
  data?: UserInfo[];
}

@Entry
@Component
export struct FollowFansPage {
  // 顶部切换Tab 0=用户列表 1=话题（当前只做用户）
  @State currentTab: number = 0;
  // 子Tab 0=我的关注 1=我的粉丝
  @State subTab: number = 0;
  // 接收MinePage传递的登录用户MongoDB ID
  @State loginUid: string = "";
  // 列表用户数组
  @State userList: UserInfo[] = [];
  // 加载状态
  @State isLoading: boolean = true;

  aboutToAppear() {
    // 接收跳转参数
    const params = router.getParams() as Record<string, string | number>;
    if (params.subTab !== undefined) {
      this.subTab = Number(params.subTab);
    }
    if (params.uid) {
      this.loginUid = params.uid as string;
    }
    // 页面加载自动请求数据库接口
    this.loadUserData();
  }

  /**
   * 根据subTab调用对应后端接口
   * subTab=0 → getMyFollowList 我的关注
   * subTab=1 → getMyFansList 我的粉丝
   */
  async loadUserData() {
    this.isLoading = true;
    let res: ApiRes;
    if (this.subTab === 0) {
      res = await getMyFollowList(this.loginUid);
    } else {
      res = await getMyFansList(this.loginUid);
    }
    this.isLoading = false;
    if (res.code === 200 && res.data) {
      this.userList = res.data;
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text("< 返回")
          .fontSize(16)
          .onClick(() => {
            router.back();
          })
        Text(this.subTab === 0 ? "我的关注" : "我的粉丝")
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Blank().width(30)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 16 })

      // 用户/话题 Tab切换
      Row() {
        Text("用户")
          .fontSize(20)
          .fontColor(this.currentTab === 0 ? "#000" : "#999")
          .padding({ bottom: 8 })
          .border({ width: { bottom: this.currentTab === 0 ? 3 : 0 }, color: "#000" })
          .onClick(() => this.currentTab = 0)
        Blank().layoutWeight(1)
        Text("话题")
          .fontSize(20)
          .fontColor(this.currentTab === 1 ? "#000" : "#999")
          .padding({ bottom: 8 })
          .border({ width: { bottom: this.currentTab === 1 ? 3 : 0 }, color: "#000" })
          .onClick(() => this.currentTab = 1)
      }
      .width("100%")
      .padding({ left: 16, right: 16 })

      Divider()

      Blank().layoutWeight(1)

      // 主体内容区分 用户Tab / 话题Tab
      if (this.currentTab === 0) {
        // 用户列表模块
        if (this.isLoading) {
          Text("加载中...")
            .fontSize(18)
            .fontColor("#999")
        } else if (this.userList.length === 0) {
          // 数据库无数据 空白占位UI
          Column({ space: 20 }) {
            Stack() {
              Rect().width(100).height(140).fill("#EEEEEE")
              Rect().width(32).height(52).fill("#90E0BE")
                .translate({ x: -38, y: 45 })
            }
            .width(130)
            .height(150)
            Text(this.subTab === 0 ? "暂无关注用户" : "暂无粉丝")
              .fontSize(20)
              .fontColor("#999")
            Button("去发现用户", { stateEffect: true })
              .width("50%")
              .height(50)
              .backgroundColor("#36C987")
              .fontSize(18)
              .fontColor(Color.White)
              .borderRadius(25)
              .onClick(() => promptAction.showToast({ message: "跳转发现页", duration: 800 }))
          }
        } else {
          // 数据库存在数据，循环渲染用户列表
          Scroll() {
            Column({ space: 12 }) {
              ForEach(this.userList, (item: UserInfo) => {
                Row() {
                  // 用户头像
                  Circle()
                    .width(60)
                    .height(60)
                    .fill("#E6E6FA")
                  // 用户昵称
                  Text(item.nickname)
                    .fontSize(18)
                    .layoutWeight(1)
                    .margin({ left: 12 })
                  Text("已关注")
                    .fontSize(14)
                    .fontColor("#36C987")
                }
                .width("94%")
                .padding(12)
                .backgroundColor(Color.White)
                .borderRadius(10)
                .margin({ left: "3%" })
              })
            }
            .width("100%")
          }
          .layoutWeight(1)
        }
      } else {
        // 话题Tab 静态空白页面（暂未对接接口）
        Column({ space: 20 }) {
          Stack() {
            Rect().width(130).height(90).fill("#EAEAEA")
              .translate({ x: 8, y: 8 })
            Rect().width(140).height(80).fill("#86E8B8")
            Rect().width(120).height(70).fill("#DDD")
              .translate({ x: -8, y: -8 })
          }
          .width(140)
          .height(120)
          Text("暂无关注话题")
            .fontSize(20)
            .fontColor("#999")
        }
      }

      Blank().height(40)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}