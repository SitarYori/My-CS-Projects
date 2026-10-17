// pages/NewPage.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { CartUtil } from '../utils/CartUtil';

// ===================== 新人首单礼商品卡片 =====================
@Component
struct NewUserGoodsCard {
  price: string = "¥0";
  originPrice: string = "¥0";
  tag: string = "";
  bgColor: string = "#FFF8DC";
  imgName: string = "";
  goodsId: string = "";
  title: string = ""; // 新增商品标题

  build() {
    Column({ space: 8 }) {

      // 商品图片
      Image($r(`app.media.${this.imgName}`))
        .width('100%')
        .height(80)
        .borderRadius(6)
        .objectFit(ImageFit.Cover)
        .backgroundColor(this.bgColor)

      Row() {
        Text(this.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF6B4A')
        if (this.originPrice) {
          Text(this.originPrice)
            .fontSize(12)
            .fontColor('#999999')
            .margin({ left: 6 })
            .decoration({ type: TextDecorationType.LineThrough })
        }
        Blank()
        // Stack 单独承载加号，点击独立，不穿透到外层卡片
        Stack() {
          Text("+")
            .width(28)
            .height(28)
            .textAlign(TextAlign.Center)
            .fontSize(18)
            .fontColor(Color.White)
            .backgroundColor('#FF6B4A')
            .borderRadius(14)
        }
        .width(28)
        .height(28)
        .onClick(() => {
          promptAction.showToast({ message: `${this.title} 已加入购物车`, duration: 1000 });
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(this.tag)
        .fontSize(10)
        .backgroundColor('#FF6B4A')
        .fontColor(Color.White)
        .padding({ left: 6, right: 6, top: 2, bottom: 2 })
        .borderRadius(4)
    }
    .width('23%')
    .backgroundColor(Color.White)
    .borderRadius(8)
    .padding({ top: 8, bottom: 8 })
    .onClick(() => {
      router.pushUrl({
        url: "pages/GoodsDetailPage",
        params: {
          goodsId: this.goodsId,
          title: "新人商品",
          price: this.price,
          originPrice: this.originPrice,
          imgName: this.imgName
        }
      })
    })
  }
}
// ===================== 分类入口组件 =====================
@Component
struct CategoryIcon {
  icon: string = "🏋️";
  title: string = "";
  hasTag: boolean = false;
  tagText: string = "";

  build() {
    Column({ space: 6 }) {
      Stack() {
        Column() {
          Text(this.icon)
            .fontSize(28)
        }
        .width(50)
        .height(50)
        .backgroundColor('#F5F5F5')
        .borderRadius(25)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        if (this.hasTag) {
          Text(this.tagText)
            .fontSize(10)
            .backgroundColor('#FF6B4A')
            .fontColor(Color.White)
            .padding({ left: 4, right: 4, top: 2, bottom: 2 })
            .borderRadius(8)
            .position({ x: 32, y: -5 })
        }
      }

      Text(this.title)
        .fontSize(11)
        .fontColor('#666666')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width(60)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      promptAction.showToast({ message: `进入${this.title}`, duration: 1000 });
    })
  }
}

// ===================== 热销商品卡片（横向滚动） =====================
@Component
struct HotGoodsCard {
  title: string = "";
  price: string = "";
  originPrice: string = "";
  tag: string = "";
  bgColor: string = "#F0EDFF";
  imgName: string = "";
  goodsId: string = "";

  build() {
    Column() {
      Image($r(`app.media.${this.imgName}`))
        .width('100%')
        .height(80)
        .borderRadius(6)
        .objectFit(ImageFit.Cover)
        .backgroundColor(this.bgColor)

      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: 4 })

      Row() {
        Text(this.price)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF6B4A')
        Text(this.originPrice)
          .fontSize(11)
          .fontColor('#999999')
          .margin({ left: 4 })
          .decoration({ type: TextDecorationType.LineThrough })
        Blank()
        Text("+")
          .width(24)
          .height(24)
          .textAlign(TextAlign.Center)
          .fontSize(16)
          .fontColor(Color.White)
          .backgroundColor('#FF6B4A')
          .borderRadius(12)
          .onClick((event: ClickEvent) => {
            promptAction.showToast({ message: `${this.title} 加入购物车`, duration: 1000 });
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      if (this.tag) {
        Text(this.tag)
          .fontSize(10)
          .backgroundColor('#FFF0ED')
          .fontColor('#FF6B4A')
          .padding({ left: 4, right: 4, top: 2, bottom: 2 })
          .borderRadius(4)
          .margin({ top: 4 })
      }
    }
    .width(140)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .padding(8)
    .margin({ right: 10 })
    .onClick(() => {
      router.pushUrl({
        url: "pages/GoodsDetailPage",
        params: {
          goodsId: this.goodsId,
          title: this.title,
          price: this.price,
          originPrice: this.originPrice,
          imgName: this.imgName
        }
      })
    })
  }
}

// ===================== 瀑布流商品卡片（双列布局） =====================
@Component
struct WaterfallGoodsCard {
  title: string = "";
  price: string = "";
  originPrice: string = "";
  desc: string = "";
  bgColor: string = "#E6E6FA";
  imgName: string = "";
  goodsId: string = ""; // 新增商品ID

  // 购物车工具实例
  private cartUtil: CartUtil = CartUtil.getInstance();

  // 加入购物车方法
  async addToCart() {
    const result = await this.cartUtil.addToCart({
      goodsId: this.goodsId,
      title: this.title,
      price: this.price,
      originPrice: this.originPrice,
      imgName: this.imgName,
      spec: '默认规格',  // 如果详情页有规格选择，可传递
      quantity: 1,
      selected: true
    });

    if (result) {
      promptAction.showToast({ message: `${this.title} 已加入购物车`, duration: 1000 });
    } else {
      promptAction.showToast({ message: '添加失败，请重试', duration: 1000 });
    }
  }

  build() {
    Column({ space: 8 }) {
      // 本地商品图片
      Image($r(`app.media.${this.imgName}`))
        .width('100%')
        .height(80)
        .borderRadius(6)
        .objectFit(ImageFit.Cover)
        .backgroundColor(this.bgColor)

      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')

      if (this.desc) {
        Text(this.desc)
          .fontSize(11)
          .fontColor('#999999')
          .width('100%')
      }

      // 价格行 + 右侧加号购物车按钮
      Row() {
        Text(this.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF6B4A')
        if (this.originPrice) {
          Text(this.originPrice)
            .fontSize(12)
            .fontColor('#999999')
            .margin({ left: 6 })
            .decoration({ type: TextDecorationType.LineThrough })
        }
        Blank()
        // 加号按钮，阻止冒泡，只加购物车不跳转
        Text("+")
          .width(28)
          .height(28)
          .textAlign(TextAlign.Center)
          .fontSize(18)
          .fontColor(Color.White)
          .backgroundColor('#FF6B4A')
          .borderRadius(14)
          .onClick((event: ClickEvent) => {
            this.addToCart();  // 调用加入购物车方法
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding(10)
    .onClick(() => {
      // 点击卡片跳商品详情
      router.pushUrl({
        url: "pages/GoodsDetailPage",
        params: {
          goodsId: this.goodsId,
          title: this.title,
          price: this.price,
          originPrice: this.originPrice,
          imgName: this.imgName
        }
      })
    })
  }
}
// ===================== 限时直降商品卡片 =====================
@Component
struct FlashSaleCard {
  title: string = "";
  price: string = "";
  originalPrice: string = "";
  bgColor: string = "#FFF0F0";
  imgName: string = "";
  goodsId: string = "";

  build() {
    Row() {
      Image($r(`app.media.${this.imgName}`))
        .width(80)
        .height(80)
        .borderRadius(6)
        .objectFit(ImageFit.Cover)
        .backgroundColor(this.bgColor)

      Column({ space: 6 }) {
        Text(this.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text(this.price)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF6B4A')
          Text(this.originalPrice)
            .fontSize(12)
            .fontColor('#999999')
            .margin({ left: 6 })
            .decoration({ type: TextDecorationType.LineThrough })
          Blank()
          Text("+")
            .width(26)
            .height(26)
            .textAlign(TextAlign.Center)
            .fontSize(16)
            .fontColor(Color.White)
            .backgroundColor('#FF6B4A')
            .borderRadius(13)
            .onClick((event: ClickEvent) => {
              promptAction.showToast({ message: `${this.title} 加入购物车`, duration: 1000 });
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding(12)
    .margin({ bottom: 10 })
    .onClick(() => {
      router.pushUrl({
        url: "pages/GoodsDetailPage",
        params: {
          goodsId: this.goodsId,
          title: this.title,
          price: this.price,
          originPrice: this.originalPrice,
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
  @State selectTab: number = 4;

  private tabs: string[] = ['关注', '社区', '奖牌', '比赛', '商城', '上新', '更多'];

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {                    // ← 改成 Column，不再整体滚动
        // ==================== 顶部搜索栏（固定） ====================
        Row() {
          TextInput({ placeholder: "韩小四瘦腿" })
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

        // ==================== 可滑动标签栏（固定） ====================
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

        // ==================== 可上下滑动的内容区域（从新人首单礼开始） ====================
        Scroll() {
          Column() {
            // 新人首单礼
            if (this.showNewUserGift) {
              this.NewUserGiftSection()
            }

            // 分类入口
            this.CategorySection()

            // 政府补贴横幅
            this.GovernmentSubsidyBanner()

            // 618福利横幅
            this.WelfareBanner()

            // 限时直降专区
            this.FlashSaleSection()

            // 热销爆款（横向滚动）
            this.HotSaleSection()

            // 必买精选瀑布流
            this.MustBuySection()

            // 底部优惠券栏
            if (this.showCouponBar) {
              this.CouponBar()
            }

            // 底部占位
            Blank()
              .height(20)
          }
          .width('100%')
          .padding({ bottom: 20 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)    // ← 关键：占据剩余空间
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8F8F8')

      // ==================== 底部导航栏（固定） ====================
      this.BottomNavBar()

      // ==================== 悬浮购物车按钮（固定） ====================
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

  // ==================== 新人首单礼 ====================
  @Builder
  NewUserGiftSection() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Column() {
        Row() {
          Text('新人首单礼')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
          Text('NEW')
            .fontSize(12)
            .backgroundColor(Color.White)
            .fontColor('#FF6B4A')
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .borderRadius(10)
            .margin({ left: 10 })
        }
        .width('100%')
        .padding({ left: 16, top: 16 })

        Row() {
          Text('领¥100券包 >')
            .fontSize(14)
            .backgroundColor('rgba(0,0,0,0.7)')
            .fontColor(Color.White)
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .borderRadius(16)
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
        .padding({ right: 16, bottom: 8 })

        Row() {
          NewUserGoodsCard({
            price: '¥170',
            originPrice: '¥299',
            tag: '限时直降', bgColor: '#FFE4E1' ,imgName:"shoubiao",goodsId:"goods_002" })
          NewUserGoodsCard({ price: '¥89', originPrice: '¥121', tag: '热销爆款', bgColor: '#FFF0F5', imgName:"tizhongcheng",goodsId:"goods_007" })
          NewUserGoodsCard({ price: '¥85', originPrice: '¥85', tag: '必买精选', bgColor: '#E0FFFF' ,imgName:"yujiadian",goodsId:"goods_003"})
          NewUserGoodsCard({ price: '¥55', originPrice: '¥55', tag: '必买精选', bgColor: '#F0FFF0' ,imgName:"tiaosheng",goodsId:"goods_011"})
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
        .padding({ left: 10, right: 10, bottom: 16 })
      }
      .width('100%')
      .backgroundColor('#FF6B4A')
      .borderRadius(12)
      .margin({ top: 8 })

      Text('✕')
        .fontSize(20)
        .fontColor(Color.White)
        .margin({ top: 16, right: 16 })
        .onClick(() => {
          this.showNewUserGift = false;
        })
    }
    .width('94%')
    .margin({ left: '3%', top: 12, bottom: 8 })
  }

  // ==================== 分类入口 ====================
  @Builder
  CategorySection() {
    Column() {
      Row() {
        CategoryIcon({ icon: '🎁', title: '618福利', hasTag: true, tagText: '12%' })
        CategoryIcon({ icon: '📊', title: '身体数据', hasTag: true, tagText: '首发' })
        CategoryIcon({ icon: '👟', title: '运动装备' })
        CategoryIcon({ icon: '🏠', title: '家用智能' })
        CategoryIcon({ icon: '👕', title: '运动服饰' })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .margin({ bottom: 16 })

      Row() {
        CategoryIcon({ icon: '🛡️', title: '护具包配' })
        CategoryIcon({ icon: '🥗', title: '减脂食品' })
        CategoryIcon({ icon: '⌚', title: '智能装备' })
        CategoryIcon({ icon: '🧘', title: '瑜伽运动' })
        CategoryIcon({ icon: '📱', title: '全部分类' })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('94%')
    .margin({ left: '3%', top: 12, bottom: 8 })
    .padding({ top: 12, bottom: 12 })
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  // ==================== 政府补贴横幅 ====================
  @Builder
  GovernmentSubsidyBanner() {
    Stack({ alignContent: Alignment.End }) {
      Row() {
        Text('政府补贴 单单立减12%')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .layoutWeight(1)

        Column() {
          Text('补')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .width(56)
        .height(56)
        .backgroundColor('#2E8B57')
        .borderRadius(8)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
    }
    .width('94%')
    .height(70)
    .backgroundColor('#32CD32')
    .borderRadius(12)
    .margin({ left: '3%', top: 8, bottom: 8 })
    .onClick(() => {
      promptAction.showToast({ message: '查看政府补贴活动', duration: 1000 });
    })
  }

  // ==================== 618福利横幅 ====================
  @Builder
  WelfareBanner() {
    Row() {
      Column() {
        Text('热力全开')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
        Text('618')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ top: 8 })
      }
      .layoutWeight(1)
      .height(130)
      .backgroundColor('#FF4500')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text('国补再叠券')
          .fontSize(16)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)
        Text('6折起')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF6B4A')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .height(130)
      .backgroundColor('#FFF8DC')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('94%')
    .borderRadius(12)
    .margin({ left: '3%', top: 8, bottom: 8 })
    .onClick(() => {
      promptAction.showToast({ message: '进入618大促会场', duration: 1000 });
    })
  }

  // ==================== 限时直降专区 ====================
  @Builder
  FlashSaleSection() {
    Column() {
      Row() {
        Text('⚡ 限时直降')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF4500')
        Blank()
        Text('查看更多 >')
          .fontSize(12)
          .fontColor('#999999')
          .onClick(() => {
            promptAction.showToast({ message: '查看更多', duration: 1000 });
          })
      }
      .width('100%')
      .margin({ bottom: 12 })

      FlashSaleCard({
        title: '运动手环B6 全网首发',
        price: '¥249',
        originalPrice: '¥304',
        bgColor: '#E6E6FA',
        imgName:"shoubiao",
        goodsId:"goods_002"
      })

      FlashSaleCard({
        title: 'Stick智能体脂秤',
        price: '¥99',
        originalPrice: '¥159',
        bgColor: '#FFF0F5',
        imgName: "tizhongcheng",
        goodsId:"goods_007"
      })
    }
    .width('94%')
    .margin({ left: '3%', top: 12, bottom: 8 })
  }

  // ==================== 热销爆款（横向滚动） ====================
  @Builder
  HotSaleSection() {
    Column() {
      Row() {
        Text('🔥 热销爆款')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text('查看更多 >')
          .fontSize(12)
          .fontColor('#999999')
          .onClick(() => {
            promptAction.showToast({ message: '查看更多', duration: 1000 });
          })
      }
      .width('100%')
      .margin({ bottom: 12 })

      Scroll() {
        Row() {
          HotGoodsCard({
            title: 'Stick运动防晒衣',
            price: '¥159',
            originPrice: '¥231',
            tag: '爆款',
            bgColor: '#FFE4E1',
            imgName:"fangshaiyi",
            goodsId:"goods_008"
          })
          HotGoodsCard({
            title: '健身瑜伽垫',
            price: '¥79',
            originPrice: '¥159',
            tag: '限时5折',
            bgColor: '#E0FFFF',
            imgName:"yujiadian",
            goodsId:"goods_004"
          })
          HotGoodsCard({
            title: '动感单车',
            price: '¥1429',
            originPrice: '¥1659',
            tag: '新人专享',
            bgColor: '#F0FFF0',
            imgName:"danche",
            goodsId:"goods_009"

          })
          HotGoodsCard({
            title: '跑步腰包',
            price: '¥39',
            originPrice: '¥79',
            tag: '',
            bgColor: '#FFF0F5',
            imgName:"tizhongcheng",
            goodsId:"goods_0010"
          })
        }
        .padding({ right: 16 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .width('94%')
    .margin({ left: '3%', top: 12, bottom: 8 })
  }

  // ==================== 必买精选瀑布流 ====================
  @Builder
  MustBuySection() {
    Column() {
      Row() {
        Text('🎯 必买精选')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text('查看更多 >')
          .fontSize(12)
          .fontColor('#999999')
          .onClick(() => {
            promptAction.showToast({ message: '查看更多', duration: 1000 });
          })
      }
      .width('100%')
      .margin({ bottom: 12 })

      Row({ space: 10 }) {
        Column({ space: 10 }) {
          WaterfallGoodsCard({
            title: 'Stick智能运动手环B6',
            price: '¥249',
            originPrice: '¥304',
            desc: '从睡眠到训练 全天候陪伴',
            bgColor: '#E6E6FA',
            imgName:"shoubiao",
            goodsId:"goods_002"
          })
          WaterfallGoodsCard({
            title: 'Stick哑铃套装',
            price: '¥59',
            originPrice: '¥99',
            desc: '家用塑形 一对装',
            bgColor: '#FFF0F5',
            imgName:"yaling",
            goodsId:"goods_001"
          })
          WaterfallGoodsCard({
            title: '运动发带',
            price: '¥15',
            originPrice: '¥29',
            desc: '吸汗速干',
            bgColor: '#E0FFFF',
            imgName:"fadai",
            goodsId:"goods_003"
          })
        }
        .layoutWeight(1)

        Column({ space: 10 }) {
          WaterfallGoodsCard({
            title: 'Stick新款瑜伽垫',
            price: '¥89',
            originPrice: '¥129',
            desc: '防滑耐磨 家用首选',
            bgColor: '#FFF8DC',
            imgName:"yujiadian",
            goodsId:"goods_004"
          })
          WaterfallGoodsCard({
            title: '运动电解水',
            price: '¥35',
            originPrice: '¥69',
            desc: '便携户外',
            bgColor: '#F0FFF0',
            imgName:"dianjieshui",
            goodsId:"goods_005"

          })
          WaterfallGoodsCard({
            title: '弹力带套装',
            price: '¥25',
            originPrice: '¥49',
            desc: '塑形美体',
            bgColor: '#FFE4E1',
            imgName:"tanlisheng",
            goodsId:"goods_006"
          })
        }
        .layoutWeight(1)
      }
      .width('100%')
    }
    .width('94%')
    .margin({ left: '3%', top: 12, bottom: 8 })
  }

  // ==================== 优惠券栏 ====================
  @Builder
  CouponBar() {
    Row() {
      Text('💰')
        .fontSize(20)
        .margin({ right: 10 })

      Text('37元优惠券待使用，仅剩1天07:23:45')
        .fontSize(13)
        .fontColor('#333333')
        .layoutWeight(1)

      Button('去使用')
        .fontSize(12)
        .height(32)
        .backgroundColor('#FF6B4A')
        .fontColor(Color.White)
        .borderRadius(16)
        .padding({ left: 16, right: 16 })

      Text('✕')
        .fontSize(18)
        .fontColor('#999999')
        .margin({ left: 10 })
        .onClick(() => {
          this.showCouponBar = false;
        })
    }
    .width('94%')
    .backgroundColor('#FFF0ED')
    .borderRadius(12)
    .padding(12)
    .margin({ left: '3%', top: 8, bottom: 8 })
  }

  // ==================== 底部导航栏 ====================
  @Builder
  BottomNavBar() {
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



  }
}