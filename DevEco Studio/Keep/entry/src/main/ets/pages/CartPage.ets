// pages/CartPage.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { CartUtil, CartItem } from '../utils/CartUtil';

@Entry
@Component
struct CartPage {
  @State cartList: CartItem[] = [];
  @State totalPrice: number = 0;
  @State totalCount: number = 0;
  @State totalOriginPrice: number = 0;
  @State isAllSelected: boolean = false;
  private cartUtil: CartUtil = CartUtil.getInstance();

  aboutToAppear() {
    // 确保 preferences 能够正确拿到 Context 初始化
    let context = getContext(this);
    this.cartUtil.init(context).then(() => {
      this.loadCartData();
    });
  }

  async loadCartData() {
    this.cartList = await this.cartUtil.getCartList();
    this.calculateTotal();
  }

  calculateTotal() {
    let total = 0;
    let count = 0;
    let originTotal = 0;
    let allSelected = true;

    if (this.cartList.length === 0) {
      this.totalPrice = 0;
      this.totalCount = 0;
      this.totalOriginPrice = 0;
      this.isAllSelected = false;
      return;
    }

    this.cartList.forEach(item => {
      if (item.selected) {
        let priceStr = item.price.replace('¥', '').replace('起', '').trim();
        let priceNum = parseFloat(priceStr);
        if (!isNaN(priceNum)) {
          total += priceNum * item.quantity;
          count += item.quantity;
        }

        let originPriceStr = item.originPrice.replace('¥', '').replace('起', '').trim();
        let originPriceNum = parseFloat(originPriceStr);
        if (!isNaN(originPriceNum)) {
          originTotal += originPriceNum * item.quantity;
        }
      } else {
        allSelected = false;
      }
    });

    this.totalPrice = Math.round(total * 100) / 100;
    this.totalCount = count;
    this.totalOriginPrice = Math.round(originTotal * 100) / 100;
    this.isAllSelected = allSelected && this.cartList.length > 0;
  }

  getDiscountAmount(): number {
    return Math.round((this.totalOriginPrice - this.totalPrice) * 100) / 100;
  }

  // 处理数量变化（整合弹窗确认与状态同步）
  async handleQuantityChange(item: CartItem, delta: number) {
    const newQuantity = item.quantity + delta;

    if (newQuantity <= 0) {
      // ⚠️ 触碰边界：当数量从 1 准备变为 0 时，触发删除确认弹窗
      try {
        const result = await promptAction.showDialog({
          title: '提示',
          message: `确定要从购物车删除「${item.title}」吗？`,
          buttons: [
            { text: '取消', color: '#999999' },
            { text: '确定删除', color: '#FF6B4A' }
          ]
        });

        if (result.index === 1) {
          // 用户点击了 "确定删除"
          // 1. 立即在内存中移除该项，让页面 UI 瞬间刷新
          this.cartList = this.cartList.filter(i => !(i.goodsId === item.goodsId && i.spec === item.spec));
          this.calculateTotal();

          // 2. 异步同步到本地 Preferences
          await this.cartUtil.removeFromCart(item.goodsId, item.spec);
          promptAction.showToast({ message: '已删除', duration: 1000 });
        }
        // 如果点击 "取消" (index === 0)，不改变任何状态，保持数量为 1
      } catch (error) {
        console.error('删除弹窗异常：' + error);
      }
    } else {
      // 📈 正常加减：数量大于 0，直接更新
      // 1. 立即在内存数组中修改数量，UI 瞬间给予反馈
      this.cartList = this.cartList.map(i => {
        if (i.goodsId === item.goodsId && i.spec === item.spec) {
          i.quantity = newQuantity;
        }
        return i;
      });
      this.calculateTotal();

      // 2. 异步同步到本地 Preferences 存储
      await this.cartUtil.updateQuantity(item.goodsId, item.spec, newQuantity);
    }
  }

  async handleToggleSelected(item: CartItem) {
    await this.cartUtil.toggleSelected(item.goodsId, item.spec);
    await this.loadCartData();
  }

  async handleSelectAll() {
    await this.cartUtil.selectAll(!this.isAllSelected);
    await this.loadCartData();
  }

  async handleClearCart() {
    promptAction.showDialog({
      title: '提示',
      message: '确定要清空购物车吗？',
      buttons: [
        { text: '取消', color: '#999999' },
        { text: '确定', color: '#FF6B4A' }
      ]
    }).then(async (result) => {
      if (result.index === 1) {
        await this.cartUtil.clearCart();
        await this.loadCartData();
        promptAction.showToast({ message: '已清空', duration: 1000 });
      }
    });
  }

  navigateToGoodsDetail(item: CartItem) {
    router.pushUrl({
      url: 'pages/GoodsDetailPage',
      params: {
        goodsId: item.goodsId,
        title: item.title,
        price: item.price,
        originPrice: item.originPrice,
        imgName: item.imgName
      }
    });
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Button('<')
          .fontSize(24)
          .backgroundColor(Color.Transparent)
          .fontColor('#333333')
          .onClick(() => {
            router.back();
          })

        Text('购物车')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('清空')
          .fontSize(14)
          .fontColor('#FF6B4A')
          .onClick(() => {
            this.handleClearCart();
          })
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 12, bottom: 12 })
      .backgroundColor('#FFFFFF')

      if (this.cartList.length === 0) {
        // 空购物车状态
        Column() {
          Text('🛒')
            .fontSize(80)
            .margin({ top: 100 })
          Text('购物车是空的')
            .fontSize(18)
            .fontColor('#333333')
            .margin({ top: 20 })
          Text('快去逛逛吧～')
            .fontSize(14)
            .fontColor('#999999')
            .margin({ top: 8 })
          Button('去逛逛')
            .fontSize(14)
            .height(44)
            .backgroundColor('#FF6B4A')
            .fontColor(Color.White)
            .borderRadius(22)
            .width(120)
            .margin({ top: 30 })
            .onClick(() => {
              router.replaceUrl({ url: 'pages/ShopPage' });
            })
        }
        .width('100%')
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#F8F8F8')
      } else {
        // 全选按钮行
        Row() {
          Row() {
            Text(this.isAllSelected ? '✅' : '⬜')
              .fontSize(20)
              .margin({ right: 8 })
            Text('全选')
              .fontSize(14)
              .fontColor('#333333')
          }
          .onClick(() => {
            this.handleSelectAll();
          })

          Blank()

          Text(`共 ${this.cartList.length} 件商品`)
            .fontSize(12)
            .fontColor('#999999')
        }
        .width('94%')
        .margin({ left: '3%', bottom: 8, top: 8 })

        // 商品列表
        List({ space: 10 }) {
          ForEach(this.cartList, (item: CartItem, index: number) => {
            ListItem() {
              this.CartItemCard(item, index)
            }
          }, (item: CartItem, index: number) => {
            // ⭐ 核心修改：将 quantity 和 selected 加入 key，数量变了 UI 才会刷新
            return `${item.goodsId}_${item.spec}_${item.quantity}_${item.selected}_${index}`;
          })
        }
        .width('100%')
        .padding({ left: 10, right: 10, top: 4, bottom: 80 })
        .layoutWeight(1)
        .backgroundColor('#F8F8F8')

        // 底部结算栏
        // CartPage.ets - 底部结算栏
        Row() {
          Row() {
            Text(this.isAllSelected ? '✅' : '⬜')
              .fontSize(20)
              .margin({ right: 8 })
            Text('全选')
              .fontSize(14)
              .fontColor('#333333')
          }
          .onClick(() => {
            this.handleSelectAll();
          })

          Blank()

          Column() {
            Row() {
              Text('总计：')
                .fontSize(14)
                .fontColor('#333333')
              Text(`¥${this.totalPrice.toFixed(2)}`)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FF6B4A')
            }
            Row() {
              Text(`共优惠 ¥${this.getDiscountAmount().toFixed(2)}`)
                .fontSize(11)
                .fontColor('#999999')
            }
          }

          // 底部结算栏
          Button(`结算(${this.totalCount})`)
            .fontSize(14)
            .height(40)
            .backgroundColor('#FF6B4A')
            .fontColor(Color.White)
            .borderRadius(20)
            .padding({ left: 20, right: 20 })
            .enabled(this.totalCount > 0)
            .onClick(() => {
              if (this.totalCount > 0) {
                // ✅ 跳转到结算页面
                router.pushUrl({
                  url: 'pages/CheckoutPage',
                  params: {
                    cartList: this.cartList,
                    totalPrice: this.totalPrice,
                    originTotalPrice: this.totalOriginPrice,
                    discountAmount: this.getDiscountAmount(),
                    shippingFee: 0
                  }
                });
              }
            })
        }
        .width('100%')
        .height(60)
        .backgroundColor(Color.White)
        .padding({ left: 12, right: 12 })
        .shadow({ radius: 5, color: '#00000010', offsetY: -2 })
        .position({ x: 0, y: '100%' })
        .translate({ x: 0, y: -60 })
        .width('100%')
        .height(60)
        .backgroundColor(Color.White)
        .padding({ left: 12, right: 12 })
        .shadow({ radius: 5, color: '#00000010', offsetY: -2 })
        .position({ x: 0, y: '100%' })
        .translate({ x: 0, y: -60 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  @Builder
  CartItemCard(item: CartItem, index: number) {
    Row() {
      // 勾选框
      Text(item.selected ? '✅' : '⬜')
        .fontSize(20)
        .margin({ right: 10 })
        .onClick(() => {
          this.handleToggleSelected(item);
        })

      // 商品图片
      if (item.imgName) {
        Image($r(`app.media.${item.imgName}`))
          .width(80)
          .height(80)
          .borderRadius(8)
          .objectFit(ImageFit.Cover)
          .margin({ right: 10 })
          .onClick(() => {
            this.navigateToGoodsDetail(item);
          })
      } else {
        Column()
          .width(80)
          .height(80)
          .borderRadius(8)
          .backgroundColor('#F5F5F5')
          .margin({ right: 10 })
      }

      // 商品信息
      Column({ space: 4 }) {
        Text(item.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')

        Text(item.spec)
          .fontSize(11)
          .fontColor('#999999')
          .width('100%')

        Row() {
          Text(item.price)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF6B4A')
          Text(item.originPrice)
            .fontSize(12)
            .fontColor('#999999')
            .decoration({ type: TextDecorationType.LineThrough })
            .margin({ left: 6 })
        }
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // ===== 数量控制器（使用 Text 组件，确保可点击） =====
      // ===== 数量控制器 =====
      Row() {
        // 减号
        Text('-')
          .width(28)
          .height(28)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          // 视觉提示：如果数量是1，减号变成红色或浅灰（这里用你的逻辑，数量为1时红底白字提示删除）
          .backgroundColor(item.quantity <= 1 ? '#FFEAEA' : '#F0F0F0')
          .fontColor(item.quantity <= 1 ? '#FF4D4F' : '#333333')
          .borderRadius(14)
          .lineHeight(28)
          .onClick(() => {
            console.log('点击减号:', item.title, '当前数量:', item.quantity);
            this.handleQuantityChange(item, -1);
          })

        // 数量显示
        Text(item.quantity.toString())
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .width(30)
          .textAlign(TextAlign.Center)

        // 加号
        Text('+')
          .width(28)
          .height(28)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .backgroundColor('#FF6B4A')
          .fontColor(Color.White)
          .borderRadius(14)
          .lineHeight(28)
          .onClick(() => {
            console.log('点击加号:', item.title, '当前数量:', item.quantity);
            this.handleQuantityChange(item, 1);
          })
      }
      .alignItems(VerticalAlign.Center)
      // ⭐ 重点：不要用 HitTestMode.Block，改用 Default 确保子 Text 能被点到
      .hitTestBehavior(HitTestMode.Default)

    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(12)
  }
}

export default CartPage;