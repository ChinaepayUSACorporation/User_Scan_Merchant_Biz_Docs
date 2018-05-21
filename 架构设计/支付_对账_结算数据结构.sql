CREATE TABLE `tbl_bill_order_proc_result` (
  `processer_id` varchar(32) NOT NULL COMMENT '处理进程ID',
  `mch_id` varchar(32) DEFAULT NULL COMMENT '商户ID，此处指NOB',
  `bill_order_type` varchar(32) DEFAULT NULL COMMENT '对账单类型，支付单：bill_payment   退款单：bill_refund',
  `belong_date` varchar(32) DEFAULT NULL COMMENT '对账单所属日期，即：交易所发生的日期，格式：yyyyMMdd',
  `proc_start_time` varchar(32) DEFAULT NULL COMMENT '进程处理开始时间。',
  `proc_finish_time` varchar(32) DEFAULT NULL COMMENT '进程处理结束时间。',
  `proc_status` varchar(32) DEFAULT NULL COMMENT '处理状态。0：处理中   1：处理成功    2：处理失败',
  PRIMARY KEY (`processer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='对账单下载控制表';

CREATE TABLE `tbl_merch_submch` (
  `sub_mch_id` varchar(32) NOT NULL COMMENT '子商户ID，对应t_merchant(商户表)中的id字段。',
  `mch_id` varchar(32) DEFAULT NULL COMMENT '商户ID，此处为NOB银行在腾讯侧申请支付时的商户ID号。',
  PRIMARY KEY (`sub_mch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_pay_order_recon_result` (
  `out_trade_no` varchar(32) NOT NULL COMMENT '商户订单号',
  `sub_mch_id` varchar(32) DEFAULT NULL COMMENT '子商户号（终端商户号）',
  `agent_id` varchar(32) DEFAULT NULL COMMENT '代理ID',
  `pound_fee_temp_id` varchar(32) DEFAULT NULL COMMENT '分佣模板ID',
  `trans_time_end` varchar(32) DEFAULT NULL COMMENT '支付结束时间，格式：yyyyMMddHHmmss',
  `total_fee` varchar(32) DEFAULT NULL COMMENT '总金额，单位：分',
  `discount_fee` varchar(32) DEFAULT NULL COMMENT '代金券或立减优惠金额，单位：分',
  `service_pound_fee` varchar(32) DEFAULT NULL COMMENT '手续费，单位：分',
  `pound_rate` varchar(32) DEFAULT NULL COMMENT '费率，两位小数',
  `rec_nob_exist` varchar(1) DEFAULT NULL COMMENT '在NOB(实际是Harvest)的支付系统是否存在该记录 1：存在；0：不存在',
  `rec_nob_act_fee` varchar(32) DEFAULT NULL COMMENT '在NOB(实际是Harvest)的支付系统记录的实际支付的金额（扣除腾讯侧的服务费后），单位为：分',
  `rec_wx_exist` varchar(1) DEFAULT NULL COMMENT '在腾讯侧是否存在该记录 1：存在  0：不存在',
  `rec_wx_act_fee` varchar(32) DEFAULT NULL COMMENT '在腾讯侧的支付系统记录的实际支付金额（扣除腾讯侧的服务费后），单位为：分',
  `rec_nob_less_wx_fee` varchar(32) DEFAULT NULL COMMENT '该笔支付单，在NOB(实际是Harvest)的实际支付金额比腾讯侧少多少钱，单位为：分。计算时，双方均扣除腾讯侧的服务费。',
  `rec_result` varchar(1) NOT NULL DEFAULT '0' COMMENT '对账结果，1：成功；0：失败',
  `is_transf_settle` varchar(1) NOT NULL DEFAULT '0' COMMENT '是否已经流转到结算单, 1: 是  0：否',
  PRIMARY KEY (`out_trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='支付单对账结果表。';

CREATE TABLE `tbl_pay_settle_detail_order` (
  `out_trade_no` varchar(32) NOT NULL COMMENT '商户交易单号',
  `sub_mch_id` varchar(32) DEFAULT NULL COMMENT '子商户号\n',
  `agent_id` varchar(32) DEFAULT NULL COMMENT '代理ID',
  `trans_time_end` varchar(32) DEFAULT NULL COMMENT '交易结束时间，格式：yyyyMMddHHmmss\n',
  `pound_fee_temp_id` varchar(32) DEFAULT NULL COMMENT '费率扣除模板',
  `total_fee` varchar(32) DEFAULT NULL COMMENT '总交易金额，单位：分',
  `discount_fee` varchar(32) DEFAULT NULL COMMENT '优惠券立减金额，单位：分',
  `wx_pound_fee` varchar(32) DEFAULT NULL COMMENT '腾讯手续费，单位：分',
  `nob_pound_fee` varchar(32) DEFAULT NULL COMMENT 'NOB手续费，单位：分',
  `nob_settle_status` varchar(32) DEFAULT NULL COMMENT 'NOB结算状态，0：待结算  1：结算中  2：已结算  3：结算失败',
  `har_pound_fee` varchar(32) DEFAULT NULL COMMENT 'Harvest手续费，单位：分',
  `har_settle_status` varchar(32) DEFAULT NULL COMMENT 'Harvest结算状态，0：待结算  1：结算中  2：已结算  3：结算失败',
  `agen_pound_fee` varchar(32) DEFAULT NULL COMMENT '代理手续费，单位：分',
  `agen_settle_status` varchar(32) DEFAULT NULL COMMENT 'Agent结算状态，0：待结算  1：结算中  2：已结算  3：结算失败',
  `submch_settle_fee` varchar(32) DEFAULT NULL COMMENT '终端商户结算金额，单位：分',
  `submch_settle_status` varchar(32) DEFAULT NULL COMMENT 'SubMerch结算状态，0：待结算  1：结算中  2：已结算  3：结算失败',
  `settlementfee_type` varchar(32) DEFAULT NULL COMMENT '资金结算类型，默认：USD',
  `settle_order_id` varchar(32) DEFAULT NULL COMMENT '最终结算单ID。',
  PRIMARY KEY (`out_trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_qrcode_info` (
  `sub_mch_id` varchar(32) NOT NULL COMMENT '子商户ID，即：t_merchant表中的ID字段。',
  `qr_code_content` varchar(250) DEFAULT NULL COMMENT '二维码内的内容信息。如：扫描二维码的URL地址、参数（子商户号）等。',
  `qr_png_folder` varchar(250) DEFAULT NULL COMMENT '二维码图片存储的目录。',
  `qr_png_name` varchar(64) DEFAULT NULL COMMENT '二维码图片名称，默认为：sub_mch_id.png',
  `gen_time` varchar(14) DEFAULT NULL COMMENT '二维码创建时间。',
  PRIMARY KEY (`sub_mch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_refund_order` (
  `out_refund_no` varchar(32) NOT NULL COMMENT '商户退款单号',
  `assistant_id` varchar(32) DEFAULT NULL COMMENT '店员ID',
  `transaction_id` varchar(32) DEFAULT NULL COMMENT '微信端交易ID',
  `total_fee` varchar(32) DEFAULT NULL COMMENT '标价金额',
  `refund_fee` varchar(32) DEFAULT NULL COMMENT '退款金额',
  `refund_fee_type` varchar(32) DEFAULT NULL COMMENT '退款币种',
  `refund_desc` varchar(256) DEFAULT NULL COMMENT '退款原因',
  `refund_account` varchar(32) DEFAULT NULL COMMENT '退款资金来源',
  `refund_trans_time` varchar(14) DEFAULT NULL COMMENT '退款交易时间',
  `refund_id` varchar(32) DEFAULT NULL COMMENT '微信端退款单号',
  `fee_type` varchar(32) DEFAULT NULL COMMENT '标价币种',
  `cash_fee` varchar(32) DEFAULT NULL COMMENT '现金支付金额',
  `cash_fee_type` varchar(32) DEFAULT NULL COMMENT '现金支付币种',
  `cash_refund_fee` varchar(32) DEFAULT NULL COMMENT '现金退款金额',
  `cash_refund_fee_type` varchar(32) DEFAULT NULL COMMENT '现金退款币种',
  `refund_count` varchar(32) DEFAULT NULL COMMENT '退款笔数',
  `refund_channel` varchar(32) DEFAULT NULL COMMENT '退款渠道',
  `refund_status` varchar(32) DEFAULT NULL COMMENT '退款状态',
  `refund_recv_accout` varchar(32) DEFAULT NULL COMMENT '退款入账账户',
  `refund_success_time` varchar(32) DEFAULT NULL COMMENT '退款成功时间',
  `rate` varchar(32) DEFAULT NULL COMMENT '汇率',
  PRIMARY KEY (`out_refund_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_refund_order_recon_result` (
  `out_refund_no` varchar(32) NOT NULL COMMENT '商户退款单号',
  `sub_mch_id` varchar(32) DEFAULT NULL COMMENT '子商户ID（终端商户ID）',
  `agent_id` varchar(32) DEFAULT NULL COMMENT '代理ID',
  `pound_fee_temp_id` varchar(32) DEFAULT NULL COMMENT '分佣模板',
  `refund_success_time` varchar(32) DEFAULT NULL COMMENT '退款成功时间，格式：yyyyMMddHHmmss',
  `refund_fee` varchar(32) DEFAULT NULL COMMENT '退款金额,单位：分',
  `discount_refund_fee` varchar(32) DEFAULT NULL COMMENT '代金券或立减优惠退款金额，单位：分',
  `service_pound_fee` varchar(32) DEFAULT NULL COMMENT '手续费,单位：分',
  `pound_rate` varchar(32) DEFAULT NULL COMMENT '费率，两位小数。',
  `rec_nob_exist` varchar(1) DEFAULT NULL COMMENT '在NOB(实际是Harvest)的支付系统是否存在该记录 1：存在；0：不存在',
  `rec_nob_act_fee` varchar(32) DEFAULT NULL COMMENT '在NOB(实际是Harvest)的支付系统记录的实际支付的金额（扣除腾讯侧的服务费后），单位为：分',
  `rec_wx_exist` varchar(1) DEFAULT NULL COMMENT '在腾讯侧是否存在该记录 1：存在  0：不存在',
  `rec_wx_act_fee` varchar(32) DEFAULT NULL COMMENT '在腾讯侧的支付系统记录的实际退款金额（扣除腾讯侧的服务费后），单位为：分',
  `rec_nob_less_wx_fee` varchar(32) DEFAULT NULL COMMENT '该笔支付单，在NOB(实际是Harvest)的实际退款金额比腾讯侧少多少钱，单位为：分。计算时，双方均扣除腾讯侧的服务费。',
  `rec_result` varchar(1) DEFAULT '0' COMMENT '对账结果，1：成功；0：失败',
  `is_transf_settle` varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否已经流转到结算单。 1: 是  0：否',
  PRIMARY KEY (`out_refund_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退款单对账结果表。';

CREATE TABLE `tbl_refund_settle_detail_order` (
  `out_refund_no` varchar(32) NOT NULL COMMENT '商户退款单号',
  `sub_mch_id` varchar(32) DEFAULT NULL COMMENT '子商户号\n',
  `agent_id` varchar(32) DEFAULT NULL COMMENT '代理ID',
  `refund_success_time` varchar(32) DEFAULT NULL COMMENT '退款完成时间，格式：yyyyMMddHHmmss\n',
  `pound_fee_temp_id` varchar(32) DEFAULT NULL COMMENT '费率扣除模板',
  `refund_fee` varchar(32) DEFAULT NULL COMMENT '退款金额，单位：分',
  `discount_refund_fee` varchar(32) DEFAULT NULL COMMENT '优惠券立减金额，单位：分',
  `wx_pound_fee` varchar(32) DEFAULT NULL COMMENT '腾讯手续费，单位：分',
  `nob_pound_fee` varchar(32) DEFAULT NULL COMMENT 'NOB手续费，单位：分',
  `nob_settle_status` varchar(32) DEFAULT NULL COMMENT 'NOB结算状态，0：待结算  1：结算中  2：已结算  3：结算失败',
  `har_pound_fee` varchar(32) DEFAULT NULL COMMENT 'Harvest手续费，单位：分',
  `har_settle_status` varchar(32) DEFAULT NULL COMMENT 'Harvest结算状态，0：待结算  1：结算中  2：已结算  3：结算失败',
  `agen_pound_fee` varchar(32) DEFAULT NULL COMMENT '代理手续费，单位：分',
  `agen_settle_status` varchar(32) DEFAULT NULL COMMENT 'Agent结算状态，0：待结算  1：结算中  2：已结算  3：结算失败',
  `submch_settle_fee` varchar(32) DEFAULT NULL COMMENT '终端商户结算金额，单位：分',
  `submch_settle_status` varchar(32) DEFAULT NULL COMMENT 'SubMerch结算状态，0：待结算  1：结算中  2：已结算  3：结算失败',
  `settlementfee_type` varchar(32) DEFAULT NULL COMMENT '资金结算类型，默认：USD',
  `settle_order_id` varchar(32) DEFAULT NULL COMMENT '最终结算单ID。',
  PRIMARY KEY (`out_refund_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_settle_order_proc_result` (
  `processer_id` varchar(32) NOT NULL COMMENT '处理进程ID',
  `mch_id` varchar(32) DEFAULT NULL COMMENT '商户号，此处指：NOB',
  `sett_start_date` varchar(32) DEFAULT NULL COMMENT '结算单时间段（开始时间），格式：yyyyMMdd',
  `sett_end_date` varchar(32) DEFAULT NULL COMMENT '结算单时间段（结束时间），格式：yyyyMMdd',
  `proc_start_time` varchar(32) DEFAULT NULL COMMENT '进程处理开始时间，格式：yyyyMMddHHmmss',
  `proc_finish_time` varchar(32) DEFAULT NULL COMMENT '进程处理结束时间，格式：yyyyMMddHHmmss',
  `proc_status` varchar(32) DEFAULT NULL COMMENT '处理状态。0：处理中   1：处理成功    2：处理失败',
  PRIMARY KEY (`processer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_settlement_sum_order` (
  `settle_order_id` varchar(32) NOT NULL COMMENT '最终结算单的ID',
  `org_id` varchar(32) DEFAULT NULL COMMENT '组织机构ID，包含：子商户ID、代理ID、Harvest的ID、NOB银行ID',
  `org_type` varchar(32) DEFAULT NULL COMMENT '组织类型，sub_mch: 子商户  agent：代理   harvest：易付通美国  nob：NOB银行',
  `settle_belong_date` varchar(32) DEFAULT NULL COMMENT '结算单所属日期,此处与交易结束时间(支付结束时间、退款完成时间)相同，格式：yyyyMMdd',
  `settle_batch_no` varchar(32) DEFAULT NULL COMMENT '结算批次号，格式：yyyyMMdd_xxxx, 其中: xxxx为四位数字，如：20180403_0001',
  `settle_start_time` varchar(32) DEFAULT NULL COMMENT '结算开始时间，默认结算单生成时，即为结算开始时间。格式：yyyyMMddHHmmss',
  `settle_end_time` varchar(32) DEFAULT NULL COMMENT '结算结束时间，即NOB侧返回的结算单回执时间。格式：yyyyMMddHHmmss',
  `settle_fee_amount` varchar(32) DEFAULT NULL COMMENT '结算总金额，单位：分',
  `settle_fee_type` varchar(32) DEFAULT NULL COMMENT '结算币种，默认：USD',
  `settle_status` varchar(32) DEFAULT NULL COMMENT '结算状态，1：结算中  2：已结算  3：结算失败',
  PRIMARY KEY (`settle_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_submch_trans_order` (
  `out_trade_no` varchar(32) NOT NULL COMMENT '商户订单号，在用户扫描商户二维码时，由易付通平台生成。',
  `sub_mch_id` varchar(32) DEFAULT NULL COMMENT '子商户号，即：t_merchant表中的ID字段。',
  `assistant_id` varchar(32) DEFAULT NULL COMMENT '创建订单时，当时处于在线状态的店员ID。',
  PRIMARY KEY (`out_trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_temp_settle_order` (
  `org_id` varchar(32) NOT NULL COMMENT '组织机构ID',
  `out_order_no` varchar(32) NOT NULL COMMENT '支付单或退款单订单号',
  `org_type` varchar(32) DEFAULT NULL COMMENT '组织类型，sub_mch: 子商户  agent：代理   harvest：易付通美国  nob：NOB银行',
  `order_type` varchar(32) DEFAULT NULL COMMENT '订单类型，payment ： 支付单   refund ：退款单',
  `settle_belong_date` varchar(32) DEFAULT NULL COMMENT '结算单所属日期,此处与交易结束时间(支付结束时间、退款完成时间)相同，格式：yyyyMMdd',
  `settle_fee_amount` varchar(32) DEFAULT NULL COMMENT '结算总金额，单位：分',
  `settle_order_id` varchar(32) DEFAULT NULL COMMENT '最终结算单的ID。',
  PRIMARY KEY (`org_id`,`out_order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_trans_order` (
  `out_trade_no` varchar(32) NOT NULL COMMENT '商户订单号，在用户扫描商户二维码时，由易付通平台生成。',
  `transaction_id` varchar(32) DEFAULT NULL COMMENT '微信侧的交易ID。',
  `body` varchar(128) DEFAULT NULL COMMENT '商品描述。',
  `fee_type` varchar(16) DEFAULT NULL COMMENT '标价币种。',
  `total_fee` varchar(32) DEFAULT NULL COMMENT '标价金额，即：订单总金额，只能为整数；单位为“分”。',
  `spbill_create_ip` varchar(16) DEFAULT NULL COMMENT '终端IP。',
  `time_start` varchar(14) DEFAULT NULL COMMENT '交易超始时间，格式为：yyyyMMddHHmmss',
  `time_end` varchar(14) DEFAULT NULL COMMENT '支付完成时间，格式：yyyyMMddHHmmss',
  `time_expire` varchar(14) DEFAULT NULL COMMENT '订单失效时间，格式：yyyyMMddHHmmss',
  `notify_url` varchar(256) DEFAULT NULL COMMENT '接收微信支付异步通知回调地址。',
  `notify_proc_rst` varchar(1) DEFAULT 'N' COMMENT '是否已经接收到正确的回调通知并被处理？Y：已经处理；N：未曾处理；',
  `trade_type` varchar(16) DEFAULT NULL COMMENT '交易类型，取值如下：JSAPI，NATIVE，APP',
  `prepay_id` varchar(64) DEFAULT NULL COMMENT '预支付交易会话标识',
  `openid` varchar(128) DEFAULT NULL COMMENT '用户标识，用户在主商户appid下的唯一标识。',
  `sub_is_subscribe` varchar(1) DEFAULT NULL COMMENT '是否关注子公众账号，用户是否关注子公众账号，Y-关注，N-未关注，仅在公众账号类型支付有效。',
  `trade_state` varchar(32) DEFAULT NULL COMMENT '交易状态，取值为：\nSUCCESS—支付成功\nREFUND—转入退款\nNOTPAY—未支付\nCLOSED—已关闭\nREVOKED—已撤销(刷卡支付)\nUSERPAYING--用户支付中\nPAYERROR--支付失败(其他原因，如银行返回失败)',
  `trade_state_desc` varchar(256) DEFAULT NULL COMMENT '交易状态描述信息。',
  `bank_type` varchar(16) DEFAULT NULL COMMENT '付款银行。',
  `cash_fee` varchar(32) DEFAULT NULL COMMENT '现金支付金额',
  `cash_fee_type` varchar(16) DEFAULT NULL COMMENT '现金支付货币类型，如：USD代表美元。',
  `rate` varchar(16) DEFAULT NULL COMMENT '汇率，外币兑换RMB的比例乘以10的8次方即为此值，例如美元兑换人民币的比例为6.5，则rate=650000000。',
  `user_pay_type` varchar(1) DEFAULT NULL COMMENT '用户支付类型, 1：扫码支付； 2： 公众号支付；3：刷卡支付；4：APP支付；5: H5支付；6：小程序支付。',
  PRIMARY KEY (`out_trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_trans_order_refund_order` (
  `out_trade_no` varchar(32) NOT NULL COMMENT '商户订单号',
  `out_refund_no` varchar(32) NOT NULL COMMENT '商户退款单号',
  PRIMARY KEY (`out_trade_no`,`out_refund_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_wx_calculated_settle_fee` (
  `mch_id` varchar(32) NOT NULL COMMENT '商户ID，此处指：NOB',
  `fbatchno` varchar(32) NOT NULL COMMENT '结算批次号',
  `date_settlement` varchar(32) DEFAULT NULL COMMENT '结算日期，格式：yyyy-MM-dd',
  `date_start` varchar(32) DEFAULT NULL COMMENT '交易开始日期，格式：yyyy-MM-dd',
  `date_end` varchar(32) DEFAULT NULL COMMENT '交易结束日期，格式：yyyy-MM-dd',
  `settlement_fee` varchar(32) DEFAULT NULL COMMENT '划账金额，单位：分',
  `unsettlement_fee` varchar(32) DEFAULT NULL COMMENT '未划账金额，单位：分',
  `settlementfee_type` varchar(32) DEFAULT NULL COMMENT '结算币种：USD',
  `pay_fee` varchar(32) DEFAULT NULL COMMENT '支付金额，单位：分',
  `refund_fee` varchar(32) DEFAULT NULL COMMENT '退款金额，单位：分',
  `pay_net_fee` varchar(32) DEFAULT NULL COMMENT '支付净额，单位：分',
  `poundage_fee` varchar(32) DEFAULT NULL COMMENT '手续费金额，单位：分',
  PRIMARY KEY (`mch_id`,`fbatchno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_wx_pay_bill_info` (
  `trans_time` varchar(32) DEFAULT NULL COMMENT '支付结束时间，格式： yyyy-MM-dd HH:mm:ss',
  `appid` varchar(32) DEFAULT NULL COMMENT '公众号ID',
  `mch_id` varchar(32) DEFAULT NULL COMMENT '商户ID',
  `sub_mch_id` varchar(32) DEFAULT NULL COMMENT '子商户ID',
  `device_info` varchar(32) DEFAULT NULL COMMENT '设备号',
  `transaction_id` varchar(32) DEFAULT NULL COMMENT '微信端交易单号',
  `out_trade_no` varchar(32) NOT NULL COMMENT '商户订单号',
  `openid` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `trade_type` varchar(32) DEFAULT NULL COMMENT '交易类型',
  `trade_state` varchar(32) DEFAULT NULL COMMENT '交易状态, SUCCESS—支付成功\nREFUND—转入退款\nNOTPAY—未支付\nCLOSED—已关闭\nREVOKED—已撤销(刷卡支付)\nUSERPAYING--用户支付中\nPAYERROR--支付失败(其他原因，如银行返回失败)',
  `bank_type` varchar(32) DEFAULT NULL COMMENT '付款银行',
  `fee_type` varchar(32) DEFAULT NULL COMMENT '货币种类,USD',
  `total_fee` varchar(32) DEFAULT NULL COMMENT '总金额，单位：元',
  `discount_fee` varchar(32) DEFAULT NULL COMMENT '代金券或立减优惠金额，单位：元',
  `goods_name` varchar(64) DEFAULT NULL COMMENT '商品名称',
  `mch_data_info` varchar(256) DEFAULT NULL COMMENT '商户数据包',
  `service_pound_fee` varchar(32) DEFAULT NULL COMMENT '手续费，单位：元',
  `pound_rate` varchar(32) DEFAULT NULL COMMENT '费率，两位小数。',
  `cash_fee_type` varchar(32) DEFAULT NULL,
  `cash_fee` varchar(32) DEFAULT NULL,
  `settl_currency_type` varchar(32) DEFAULT NULL,
  `settl_currency_amount` varchar(32) DEFAULT NULL,
  `exchange_rate` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`out_trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信端支付单对应的对账单信息。';

CREATE TABLE `tbl_wx_refund_bill_info` (
  `trans_time` varchar(32) DEFAULT NULL COMMENT '支付结束时间，格式： yyyy-MM-dd HH:mm:ss',
  `appid` varchar(32) DEFAULT NULL COMMENT '公众号ID',
  `mch_id` varchar(32) DEFAULT NULL COMMENT '商户ID',
  `sub_mch_id` varchar(32) DEFAULT NULL COMMENT '子商户ID',
  `device_info` varchar(32) DEFAULT NULL COMMENT '设备号',
  `transaction_id` varchar(32) DEFAULT NULL COMMENT '微信端交易单号',
  `out_trade_no` varchar(32) DEFAULT NULL COMMENT '商户订单号',
  `openid` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `trade_type` varchar(32) DEFAULT NULL COMMENT '交易类型',
  `trade_state` varchar(32) DEFAULT NULL COMMENT '交易状态， SUCCESS—支付成功\nREFUND—转入退款\nNOTPAY—未支付\nCLOSED—已关闭\nREVOKED—已撤销(刷卡支付)\nUSERPAYING--用户支付中\nPAYERROR--支付失败(其他原因，如银行返回失败)',
  `bank_type` varchar(32) DEFAULT NULL COMMENT '付款银行',
  `fee_type` varchar(32) DEFAULT NULL COMMENT '货币种类，USD',
  `total_fee` varchar(32) DEFAULT NULL COMMENT '总金额，单位：元',
  `discount_fee` varchar(32) DEFAULT NULL COMMENT '代金券或立减优惠金额，单位：元',
  `refund_trans_time` varchar(32) DEFAULT NULL COMMENT '退款发起时间',
  `refund_success_time` varchar(32) DEFAULT NULL COMMENT '退款成功时间',
  `refund_id` varchar(32) DEFAULT NULL COMMENT '微信侧退款单号',
  `out_refund_no` varchar(32) NOT NULL COMMENT '商户退款单号',
  `refund_fee` varchar(32) DEFAULT NULL COMMENT '退款金额，单位：元',
  `discount_refund_fee` varchar(32) DEFAULT NULL COMMENT '代金券或立减优惠退款金额，单位：元',
  `refund_type` varchar(32) DEFAULT NULL COMMENT '退款类型',
  `refund_status` varchar(32) DEFAULT NULL COMMENT '退款状态，SUCCESS—退款成功\nREFUNDCLOSE—退款关闭。\nPROCESSING—退款处理中',
  `goods_name` varchar(64) DEFAULT NULL COMMENT '商品名称',
  `mch_data_info` varchar(256) DEFAULT NULL COMMENT '商户数据包',
  `service_pound_fee` varchar(32) DEFAULT NULL COMMENT '手续费，单位：元',
  `pound_rate` varchar(32) DEFAULT NULL COMMENT '费率，两位小数',
  `cash_fee_type` varchar(32) DEFAULT NULL,
  `cash_fee` varchar(32) DEFAULT NULL,
  `settl_currency_type` varchar(32) DEFAULT NULL,
  `settl_currency_amount` varchar(32) DEFAULT NULL,
  `exchange_rate` varchar(32) DEFAULT NULL,
  `refund_exchange_rate` varchar(32) DEFAULT NULL,
  `payer_refund_amount` varchar(32) DEFAULT NULL,
  `payer_refund_currency_type` varchar(32) DEFAULT NULL,
  `refund_currency_type` varchar(32) DEFAULT NULL,
  `refund_settl_currency_type` varchar(32) DEFAULT NULL,
  `refund_settl_amount` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`out_refund_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信端退款单对应的对账单信息。';
