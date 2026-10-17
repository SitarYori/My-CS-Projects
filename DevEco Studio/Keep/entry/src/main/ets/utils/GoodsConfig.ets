// utils/GoodsConfig.ets

// 定义规格选项接口
export interface SpecOption {
  label: string;      // 显示名称
  value: string;      // 实际值
  price?: string;     // 该规格对应的价格（可选）
}

// 商品规格配置映射
export const GoodsSpecConfig: Record<string, SpecOption[]> = {
  // 哑铃的规格
  'goods_001': [
    { label: '1kg*2【瘦手臂】(樱粉)', value: '1kg*2_樱粉' },
    { label: '1.5kg*2【新手入门】(薄荷绿)', value: '1.5kg*2_薄荷绿' },
    { label: '2kg*2【肩背塑形】(水蓝)', value: '2kg*2_水蓝' },
    { label: '3kg*2【全身塑形】(紫灰)', value: '3kg*2_紫灰' },
    { label: '4kg*2【女士进阶/男士入门】(岩石灰)', value: '4kg*2_岩石灰' },
    { label: '5kg*2【女士专业/男士初阶】(墨灰)', value: '5kg*2_墨灰' }
  ],

  // 运动手环的规格
  'goods_002': [
    { label: '标准版【黑色】', value: '标准版_黑色' },
    { label: '标准版【白色】', value: '标准版_白色' },
    { label: 'Pro版【黑色】', value: 'Pro版_黑色' },
    { label: 'Pro版【白色】', value: 'Pro版_白色' }
  ],

  // 瑜伽垫的规格
  'goods_003': [
    { label: '6mm【粉色】', value: '6mm_粉色' },
    { label: '6mm【蓝色】', value: '6mm_蓝色' },
    { label: '8mm【紫色】', value: '8mm_紫色' },
    { label: '10mm【灰色】', value: '10mm_灰色' }
  ],

  // 弹力带的规格
  'goods_004': [
    { label: '初级【黄色】', value: '初级_黄色' },
    { label: '中级【红色】', value: '中级_红色' },
    { label: '高级【蓝色】', value: '高级_蓝色' }
  ],

  // 运动电解水的规格
  'goods_005': [
    { label: '350ml【柠檬味】', value: '柠檬味' },
    { label: '500ml【薄荷味】', value: '薄荷味' },
    { label: '750ml【荔枝味】', value: '荔枝味' }
  ],

  //弹力带套装
  'goods_006': [
    { label: '1m【白色】', value: '1m_白色' },
    { label: '1m【黑色】', value: '1m_黑色' },
    { label: '1m【蓝色】', value: '1m_蓝色' }
  ],

  //体脂秤
  'goods_007': [
    { label: '【白色】', value: '_白色' },
    { label: '【黑色】', value: '_黑色' },
    { label: '【蓝色】', value: '_蓝色' }
  ],

  //防晒衣
  'goods_008': [
    { label: '【白色】', value: '_白色' },
    { label: '【黑色】', value: '_黑色' },
    { label: '【蓝色】', value: '_蓝色' }
  ],

  //动感单车
  'goods_009': [
    { label: '25kg【白色】', value: '25kg_白色' },
    { label: '25kg【黑色】', value: '25kg_黑色' },
    { label: '25kg【蓝色】', value: '25kg_蓝色' }
  ],

  //腰包
  'goods_0010': [
    { label: '【白色】', value: '_白色' },
    { label: '【黑色】', value: '_黑色' },
    { label: '【蓝色】', value: '_蓝色' }
  ],

  //跳绳
  'goods_011': [
    { label: '2m【白色】', value: '2m_白色' },
    { label: '2m【黑色】', value: '2m_黑色' },
    { label: '2m【蓝色】', value: '2m_蓝色' }
  ],

  //圆领短袖
  'goods_012': [
    { label: 'XL【白色】', value: 'XL_白色' },
    { label: 'L【黑色】', value: 'L_黑色' },
    { label: 'M【蓝色】', value: 'M_蓝色' }
  ],

  //运动风镜
  'goods_013': [
    { label: '【灰色】', value: '_灰色' },
    { label: '【黑框】镀膜冰蓝片', value: '黑框_镀膜冰蓝片' },
    { label: '【黑色水银】镀膜', value: '黑色水银_镀膜' }
  ],

  //鱼油
  'goods_014': [
    { label: '【60粒】', value: '_60粒' },
    { label: '【120粒】', value: '_120粒' },
    { label: '【2瓶装】', value: '_2瓶装' },
    { label: '【4瓶装】', value: '_4瓶装' }
  ],


  //运动恢复饮
  'goods_015': [
    { label: '【一盒装】', value: '_15ml*15' },
    { label: '【五盒装】', value: '_15ml*75' },
    { label: '【三盒装】', value: '_15ml*45' }
  ],

  //莓果粉
  'goods_016': [
    { label: '【一盒装】', value: '_3g*15' },
    { label: '【五盒装】', value: '_3gl*75' },
    { label: '【三盒装】', value: '_3g*45' }
  ],

  // 默认规格（当商品没有配置时使用）
  'default': [
    { label: '默认规格', value: 'default' }
  ]
};

// 获取商品规格列表
export function getGoodsSpecs(goodsId: string): SpecOption[] {
  if (GoodsSpecConfig[goodsId]) {
    return GoodsSpecConfig[goodsId];
  }
  return GoodsSpecConfig['default'];
}

// 获取规格显示名称
export function getSpecLabel(goodsId: string, specValue: string): string {
  const specs = getGoodsSpecs(goodsId);
  for (let i = 0; i < specs.length; i++) {
    if (specs[i].value === specValue) {
      return specs[i].label;
    }
  }
  return specValue;
}