import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { CartUtil } from '../utils/CartUtil';


// ===================== 新品榜单行组件 =====================
@Component
struct NewProductCard {
  title: string = "";
  price: string = "";
  bgColor: string = "#FFF0F5";
  tag: string = "";
  imgName: string = "";
  goodsId: string = "";


  build() {
    Column() {

      // 商品图片
      Image($r(`app.media.${this.imgName}`))
        .width('100%')
        .height(80)
        .borderRadius(6)
        .objectFit(ImageFit.Cover)
        .backgroundColor(this.bgColor)

      // 标题
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: 4 })

      // 价格
      Row() {
        Text('上新价')
          .fontSize(10)
          .fontColor('#999999')
        Text(this.price)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF6B4A')
          .margin({ left: 4 })
      }
      .width('100%')
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(8)
    .padding(8)
    .onClick(() => {
      router.pushUrl({
        url: "pages/GoodsDetailPage",
        params: {
          goodsId: this.goodsId,
          title: "新人商品",
          price: this.price,
          imgName: this.imgName
        }
      })
    })
  }
}

// ===================== 搭配推荐卡片组件 =====================
@Component
struct ComboCard {
  title: string = "";
  price: string = "";
  bgColor: string = "#E6E6FA";
  tag: string = "";
  imgName: string = "";
  goodsId: string = "";

  build() {
    Column() {
      // 商品图片
      Image($r(`app.media.${this.imgName}`))
        .width('100%')
        .height(80)
        .borderRadius(6)
        .objectFit(ImageFit.Cover)
        .backgroundColor(this.bgColor)

      // 标题
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: 4 })

      // 价格
      Row() {
        Text('上新价')
          .fontSize(10)
          .fontColor('#999999')
        Text(this.price)
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF6B4A')
          .margin({ left: 4 })
      }
      .width('100%')
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(8)
    .padding(8)
    .onClick(() => {
      router.pushUrl({
        url: "pages/GoodsDetailPage",
        params: {
          goodsId: this.goodsId,
          title: "新人商品",
          price: this.price,
          imgName: this.imgName
        }
      })
    })
  }
}

// ===================== 跑步系列卡片 =====================
@Component
struct RunningCard {
  title: string = "";
  price: string = "";
  bgColor: string = "#E0FFFF";
  tag: string = "";
  imgName: string = "";
  goodsId: string = "";

  build() {
    Column() {

      // 商品图片
      Image($r(`app.media.${this.imgName}`))
        .width('100%')
        .height(80)
        .borderRadius(6)
        .objectFit(ImageFit.Cover)
        .backgroundColor(this.bgColor)

      // 标签
      if (this.tag) {
        Text(this.tag)
          .fontSize(10)
          .backgroundColor('#FF6B4A')
          .fontColor(Color.White)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .borderRadius(4)
          .margin({ bottom: 6 })
      }

      // 标题
      Text(this.title)
        .fontSize(13)
        .fontWeight(FontWeight.Medium)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: 4 })

      // 价格
      Row() {
        Text('上新价')
          .fontSize(10)
          .fontColor('#999999')
        Text(this.price)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF6B4A')
          .margin({ left: 4 })
      }
      .width('100%')
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(8)
    .padding(8)
    .onClick(() => {
      router.pushUrl({
        url: "pages/GoodsDetailPage",
        params: {
          goodsId: this.goodsId,
          title: "新人商品",
          price: this.price,
          imgName: this.imgName
        }
      })
    })
  }
}

// ===================== 营养食品卡片 =====================
@Component
struct NutritionCard {
  title: string = "";
  price: string = "";
  bgColor: string = "#FFF8DC";
  tag: string = "";
  imgName: string = "";
  goodsId: string = "";

  build() {
    Column() {

      // 商品图片
      Image($r(`app.media.${this.imgName}`))
        .width('100%')
        .height(80)
        .borderRadius(6)
        .objectFit(ImageFit.Cover)
        .backgroundColor(this.bgColor)

      // 标题
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: 4 })

      // 价格
      Row() {
        Text(this.price)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF6B4A')
      }
      .width('100%')
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(8)
    .padding(8)
    .onClick(() => {
      router.pushUrl({
        url: "pages/GoodsDetailPage",
        params: {
          goodsId: this.goodsId,
          title: "新人商品",
          price: this.price,
          imgName: this.imgName
        }
      })
    })
  }
}

// ===================== 主页面 =====================
@Entry
@Component
export struct NewPage {
  @State showCouponBar: boolean = true;
  @State showNewUserGift: boolean = true;
  @State selectTab: number = 5;

  private tabs: string[] = ['关注', '社区', '奖牌', '比赛', '商城', '上新', '更多'];

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column() {
          // ==================== 顶部搜索栏====================
          Row() {
            TextInput({ placeholder: "肉类大礼包" })
              .layoutWeight(1)
              .height(44)
              .borderRadius(22)
              .backgroundColor('#F0F0F0')
              .margin({ right: 12 })
            Text("🏆")
              .fontSize(22)
              .margin({ right: 15 })
            Text("⚙️")
              .fontSize(22)
          }
          .width('100%')
          .padding({ left: 15, right: 15, top: 10, bottom: 10 })

          // ==================== 可滑动标签栏 ====================
          Scroll() {
            Row() {
              ForEach(this.tabs, (item: string, index: number) => {
                Column({ space: 4 }) {
                  Text(item)
                    .fontSize(18)
                    .fontColor(this.selectTab === index ? '#1677FF' : '#888')
                    .fontWeight(this.selectTab === index ? FontWeight.Bold : FontWeight.Normal)

                  if (this.selectTab === index) {
                    Column()
                      .width(24)
                      .height(2)
                      .backgroundColor('#1677FF')
                  }
                }
                .width(80)
                .alignItems(HorizontalAlign.Center)
                .onClick(() => {
                  if (index === 0) {
                    router.replaceUrl({ url: "pages/DiscoverPage" })
                  } else if (index === 1) {
                    router.replaceUrl({ url: "pages/CommunityPage" })
                  } else if (index === 2) {
                    router.replaceUrl({ url: "pages/MedalPage" })
                  } else if (index === 3) {
                    router.replaceUrl({ url: "pages/RacePage" })
                  } else if (index === 4) {
                    router.replaceUrl({ url: "pages/ShopPage" });
                  } else if (index === 5) {
                    router.replaceUrl({ url: "pages/NewPage" });
                  } else if (index === 6) {
                    router.replaceUrl({ url: "pages/MorePage" });
                  } else {
                    this.selectTab = index
                  }
                })
              })
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .padding({ top: 10, bottom: 15 })

          // ==================== 奖牌/比赛入口横幅 ====================
          Row() {
            this.EntryCard('🏅', '线上马拉松', '立即报名 >')
            this.EntryCard('🏆', '热门比赛', '查看详情 >')
            this.EntryCard('🎖️', '完赛奖牌', '荣誉榜 >')
          }
          .width('94%')
          .margin({ left: '3%', bottom: 12 })
          .justifyContent(FlexAlign.SpaceBetween)

          // ==================== 新品榜标题 ====================
          Row() {
            Text('NEW')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FF6B4A')
              .margin({ right: 8
              })
            Text('Stick新品榜')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
            Blank()
            Text('近期上新 >')
              .fontSize(12)
              .fontColor('#999999')
              .onClick(() => {
                promptAction.showToast({ message: '查看更多新品', duration: 1000 });
              })
          }
          .width('94%')
          .margin({ left: '3%', top: 8, bottom: 12 })

          // ==================== 新品榜网格（4列） ====================
          Column() {
            // 第一行
            Row({ space: 8 }) {
              NewProductCard({
                title: '女吸湿速干圆领运动短袖',
                price: '¥89',
                bgColor: '#FFE4E1',
                imgName:"yldx",
                goodsId:"goods_012"
              })
                .layoutWeight(1)

              NewProductCard({
                title: '人体工学拉筋板',
                price: '¥79.9',
                bgColor: '#FFF0F5',
                imgName:"ljb",
                goodsId:"goods_010"
              })
                .layoutWeight(1)

              NewProductCard({
                title: '动感单车 C5',
                price: '¥2199',
                bgColor: '#E0FFFF',
                imgName:"danche",
                goodsId:"goods_009"
              })
                .layoutWeight(1)
            }
            .width('100%')
            .margin({ bottom: 8 })

            // 第二行
            Row({ space: 8 }) {
              NewProductCard({
                title: '三合一多功能瑜伽挎包',
                price: '¥139.9',
                bgColor: '#F0FFF0',
                imgName:"yjkb",
                goodsId:"goods_010"
              })
                .layoutWeight(1)

              NewProductCard({
                title: 'RB01运动风镜',
                price: '¥139.9',
                bgColor: '#FFF8DC',
                imgName:"ydfj",
                goodsId:"goods_013"
              })
                .layoutWeight(1)

              NewProductCard({
                title: '女高强速干美背运动内衣',
                price: '¥99',
                bgColor: '#FFE4E1',
                imgName:"yundongneiyi",
                goodsId:"goods_012"

              })
                .layoutWeight(1)
            }
            .width('100%')
          }
          .width('94%')
          .margin({ left: '3%' })

          // ==================== 促销活动横幅 ====================
          Row() {
            Text('mini小巧随身携带')
              .fontSize(14)
              .fontColor(Color.White)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)
          }
          .width('94%')
          .height(40)
          .backgroundColor('#32CD32')
          .borderRadius(20)
          .margin({ left: '3%', top: 12, bottom: 8 })
          .onClick(() => {
            promptAction.showToast({ message: '查看活动详情', duration: 1000 });
          })

          // ==================== 促销标签行 ====================
          Row() {
            this.PromotionTag('品牌政府双补贴', '#FFF0ED', '#FF6B4A')
            this.PromotionTag('新品专享', '#E6F7FF', '#1890FF')
            this.PromotionTag('会员专享新品88折', '#F6FFED', '#52C41A')
            this.PromotionTag('新品体验', '#FFF0F6', '#EB2F96')
            this.PromotionTag('好评晒单返红包', '#FFF8E1', '#FF9800')
          }
          .width('94%')
          .margin({ left: '3%', top: 8, bottom: 12 })
          .justifyContent(FlexAlign.SpaceBetween)

          // ==================== 搭配推荐标题 ====================
          Row() {
            Text('搭配推荐')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
            Text('RECOMMENDED COMBINATIONS')
              .fontSize(11)
              .fontColor('#999999')
              .margin({ left: 8 })
          }
          .width('94%')
          .margin({ left: '3%', bottom: 12 })

          // ==================== 居家塑形管理 ====================
          Column() {
            Row() {
              Text('居家塑形管理')
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
              Blank()
              Text('有氧 / 减脂 / 健身搭配')
                .fontSize(11)
                .fontColor('#999999')
            }
            .width('100%')
            .margin({ bottom: 8 })

            Row() {
              Text('防滑减震')
                .fontSize(11)
                .fontColor('#FF6B4A')
                .backgroundColor('#FFF0ED')
                .padding({ left: 8, right: 8, top: 3, bottom: 3 })
                .borderRadius(10)
              Text('减脂有氧搭配使用')
                .fontSize(11)
                .fontColor('#999999')
                .margin({ left: 8 })
            }
            .width('100%')
            .margin({ bottom: 12 })

            // 商品网格（2列）
            Row({ space: 8 }) {
              ComboCard({
                title: '健身垫',
                price: '¥79.9',
                bgColor: '#E6E6FA',
                imgName:"yujiadian",
                goodsId:"goods_003"
              })
                .layoutWeight(1)

              ComboCard({
                title: '专业平衡波速球',
                price: '¥199.9',
                bgColor: '#FFF0F5',
                imgName:"bsq",
                goodsId:"goods_010"
              })
                .layoutWeight(1)
            }
            .width('100%')
            .margin({ bottom: 8 })

            Row({ space: 8 }) {
              ComboCard({
                title: '负重环增肌辅助',
                price: '¥59.9',
                bgColor: '#E0FFFF',
                imgName:"fzh",
                goodsId:"goods_010"
              })
                .layoutWeight(1)

              ComboCard({
                title: '泡沫轴舒缓放松',
                price: '¥59.9',
                bgColor: '#FFF8DC',
                imgName:"pmz",
                goodsId:"goods_010"
              })
                .layoutWeight(1)
            }
            .width('100%')
          }
          .width('94%')
          .margin({ left: '3%', top: 8, bottom: 16 })
          .padding(12)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)

          // ==================== 健康家庭管理 ====================
          Column() {
            Row() {
              Text('健康家庭管理')
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
              Blank()
              Text('按摩 / 舒缓 / 运动搭配')
                .fontSize(11)
                .fontColor('#999999')
            }
            .width('100%')
            .margin({ bottom: 8 })

            Row() {
              Text('按摩舒缓')
                .fontSize(11)
                .fontColor('#FF6B4A')
                .backgroundColor('#FFF0ED')
                .padding({ left: 8, right: 8, top: 3, bottom: 3 })
                .borderRadius(10)
              Text('练后搭配推荐使用')
                .fontSize(11)
                .fontColor('#999999')
                .margin({ left: 8 })
            }
            .width('100%')
            .margin({ bottom: 12 })

            // 商品网格（2列）
            Row({ space: 8 }) {
              ComboCard({
                title: 'G3筋膜枪',
                price: '¥329.9',
                bgColor: '#FFE4E1',
                imgName:"jmq",
                goodsId:"goods_010"
              })
                .layoutWeight(1)

              ComboCard({
                title: 'Keep律动甩脂机',
                price: '¥2239',
                bgColor: '#F0FFF0',
                imgName:"szj",
                goodsId:"goods_010"

              })
                .layoutWeight(1)
            }
            .width('100%')
            .margin({ bottom: 8 })

            Row({ space: 8 }) {
              ComboCard({
                title: '磨砂柔感普拉提球',
                price: '¥49.9',
                bgColor: '#FFF0F6',
                imgName:"pltq",
                goodsId:"goods_010"
              })
                .layoutWeight(1)

              ComboCard({
                title: 'S3体脂秤',
                price: '¥159',
                bgColor: '#E0FFFF',
                imgName:"tizhongcheng",
                goodsId:"goods_007"
              })
                .layoutWeight(1)
            }
            .width('100%')
          }
          .width('94%')
          .margin({ left: '3%', top: 8, bottom: 16 })
          .padding(12)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)

          // ==================== 为刷新PB而生标题 ====================
          Row() {
            Text('为刷新PB而生')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FF6B4A')
          }
          .width('94%')
          .margin({ left: '3%', top: 8, bottom: 12 })

          // ==================== 跑步系列（单行横向滚动） ====================
          Scroll() {
            Row({ space: 10 }) {
              RunningCard({
                title: '跑步背心',
                price: '¥209',
                bgColor: '#FFE4E1',
                tag: '为刷新PB而生',
                imgName:"yundongneiyi",
                goodsId:"goods_010"
              })
                .width(140)

              RunningCard({
                title: '紧身短裤',
                price: '¥239',
                bgColor: '#E0FFFF',
                tag: '竞速PB',
                imgName:"jsk",
                goodsId:"goods_010"
              })
                .width(140)

              RunningCard({
                title: '凉感短袖',
                price: '¥169',
                bgColor: '#FFF0F5',
                tag: '超轻面料',
                imgName:"lgdx",
                goodsId:"goods_010"
              })
                .width(140)

              RunningCard({
                title: '二合一短裤',
                price: '¥219',
                bgColor: '#FFF8DC',
                tag: '赛训兼备',
                imgName:"erheyiduanku",
                goodsId:"goods_010"
              })
                .width(140)
            }
            .padding({ right: 16 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('94%')
          .margin({ left: '3%', bottom: 16 })

          // ==================== 好身材吃出来标题 ====================
          Row() {
            Text('好身材吃出来')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
            Text('营养补充')
              .fontSize(12)
              .fontColor('#999999')
              .margin({ left: 8 })
          }
          .width('94%')
          .margin({ left: '3%', top: 8, bottom: 12 })

          // ==================== 营养食品网格 ====================
          Row({ space: 8 }) {
            NutritionCard({
              title: '97%高纯度鱼油',
              price: '¥59.9',
              bgColor: '#FFF0F5',
              tag: '',
              imgName:"yuyou",
              goodsId:"goods_014"
            })
              .layoutWeight(1)


            NutritionCard({
              title: '运动恢复饮',
              price: '¥59.9',
              bgColor: '#FFE4E1',
              tag: '',
              imgName:"yundonghuifu",
              goodsId:"goods_015"
            })
              .layoutWeight(1)
          }
          .width('94%')
          .margin({ left: '3%', bottom: 8 })

          Row({ space: 8 }) {
            NutritionCard({
              title: '氨糖软骨素片',
              price: '¥99.9起',
              bgColor: '#FFF8DC',
              tag: '',
              imgName:"atrgsp",
              goodsId:"goods_014"
            })
              .layoutWeight(1)

            NutritionCard({
              title: '甜菜根莓果粉',
              price: '¥99',
              bgColor: '#F0FFF0',
              tag: '',
              imgName:"mgf",
              goodsId:"goods_016"
            })
              .layoutWeight(1)

            NutritionCard({
              title: '更多营养品',
              price: '¥29起',
              bgColor: '#FFF0F6',
              tag: '',
              imgName:"",
              goodsId:"goods_010"
            })
              .layoutWeight(1)
          }
          .width('94%')
          .margin({ left: '3%', bottom: 20 })

          // 底部占位
          Blank()
            .height(20)
        }
        .width('100%')
        .padding({ bottom: 60 })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')

      // ==================== 底部导航栏 ====================
      Row() {
        Column({ space: 4 }) {
          Text('课程')
            .fontSize(14)
            .fontColor('#888888')
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
            .fontColor('#1677FF')
            .fontWeight(FontWeight.Bold)
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

      // ==================== 悬浮购物车按钮 ====================
      Text('🛒')
        .fontSize(28)
        .width(56)
        .height(56)
        .backgroundColor('#6A5ACD')
        .borderRadius(28)
        .textAlign(TextAlign.Center)
        .fontColor(Color.White)
        .shadow({ radius: 8, color: '#6A5ACD50', offsetY: 4 })
        .margin({ right: 20, bottom: 80 })
        .onClick(() => {
          // 跳转购物车页面
          router.pushUrl({ url: "pages/CartPage" });
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // 入口卡片
  @Builder
  EntryCard(icon: string, title: string, action: string) {
    Row() {
      Text(icon)
        .fontSize(24)
        .margin({ right: 8 })
      Column({ space: 2 }) {
        Text(title)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
        Text(action)
          .fontSize(10)
          .fontColor('#FF6B4A')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('30%')
    .backgroundColor('#FFFFFF')
    .borderRadius(10)
    .padding(10)
    .onClick(() => {
      promptAction.showToast({ message: title, duration: 1000 });
    })
  }

  // 促销标签
  @Builder
  PromotionTag(text: string, bgColor: string, textColor: string) {
    Text(text)
      .fontSize(10)
      .backgroundColor(bgColor)
      .fontColor(textColor)
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      .borderRadius(4)
  }
}