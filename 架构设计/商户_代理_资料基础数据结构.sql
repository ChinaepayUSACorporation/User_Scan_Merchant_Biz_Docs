DROP TABLE IF EXISTS `t_merchant`;
CREATE TABLE IF NOT EXISTS `t_merchant` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `merchant_name` varchar(255) NOT NULL  COMMENT '商户名称',
  `merchant_tax_no` varchar(255) DEFAULT NULL  COMMENT '商户税号',
  `merchant_license_url` varchar(255) DEFAULT NULL  COMMENT '商户营业执照',
  `contact_name` varchar(255) DEFAULT NULL  COMMENT '商户联系人',
  `contact_phone` varchar(50) DEFAULT NULL  COMMENT '商户联系人电话',
  `industry_id` varchar(32) DEFAULT NULL  COMMENT '行业ID',
  `industry_name` varchar(250) DEFAULT NULL  COMMENT '行业名称',
  `merchant_bank_id` varchar(50) DEFAULT NULL  COMMENT '商户银行ID',
  `merchant_bank_name` varchar(255) DEFAULT NULL  COMMENT '商户银行名称',
  `merchant_account` varchar(255) DEFAULT NULL  COMMENT '商户账号',
  `user_id` varchar(255) NOT NULL  COMMENT 'User表ID',
  `agent_id` varchar(50) NOT NULL  COMMENT '商户代理ID',
  `open_id` varchar(50) DEFAULT NULL  COMMENT '商户openId',
  `signing_date` datetime DEFAULT NULL COMMENT '签约日期',
  `status` int(2) NOT NULL COMMENT '商户状态 1 启用 2禁用',
  `account_status` int(2) NOT NULL COMMENT '账户状态  1正常 2 冻结',
   `audit_status` int(2) NOT NULL COMMENT '审核状态  1 待审核 2审核通过 3审核不通过',
   `settlement_Cycle` int(2) DEFAULT NULL COMMENT '结算分期',
  `servant_id` int(2) DEFAULT NULL COMMENT '分佣模板ID',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间' ,
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记 ''1'':已删除 ''0''：未删除',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商户信息管理';

DROP TABLE IF EXISTS `t_agent`;
CREATE TABLE IF NOT EXISTS `t_agent` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `agent_name` varchar(255)  NOT NULL  COMMENT '代理商名称',
  `agent_tax_no` varchar(255)  NOT NULL  COMMENT '代理商税号',
  `contact_name` varchar(255)  NOT NULL  COMMENT '代理商联系人',
  `contact_phone` varchar(50) DEFAULT NULL  COMMENT '代理商联系人电话',
  `agent_bank_id` varchar(50) DEFAULT NULL  COMMENT '代理商银行ID',
  `agent_account` varchar(255) DEFAULT NULL  COMMENT '代理商账号',
  `settlement_id` varchar(255) DEFAULT NULL  COMMENT '结算ID',
  `signing_date` datetime DEFAULT NULL COMMENT '签约日期',
  `open_id` varchar(50) DEFAULT NULL  COMMENT '代理商openId',
  `status` int(2) DEFAULT NULL COMMENT '代理商状态',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间' ,
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记 ''1'':已删除 ''0''：未删除',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='代理商信息管理';

DROP TABLE IF EXISTS `t_assistant`;
CREATE TABLE IF NOT EXISTS `t_assistant` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `assistant_name` varchar(255)  NOT NULL COMMENT '店员名称',
  `assistant_code` varchar(255)  NOT NULL COMMENT '店员编号',
   `user_id` varchar(255) NOT NULL  COMMENT 'User表ID',
   `merchant_id` varchar(32) NOT NULL  COMMENT '商户ID',
   `last_login` datetime DEFAULT NULL COMMENT '最后登录时间' ,
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间' ,
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记 ''1'':已删除 ''0''：未删除',	
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='店员管理';

DROP TABLE IF EXISTS `t_assistant_sign`;
CREATE TABLE IF NOT EXISTS `t_assistant_sign` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `assistant_id` varchar(32)  NOT NULL COMMENT '店员ID',	
  `merchant_id` varchar(32)  NOT NULL COMMENT '商户ID',
  `assistant_name` varchar(255)  NOT NULL COMMENT '店员名称',
  `assistant_code` varchar(255)  NOT NULL COMMENT '店员编号',
  `status` int(2) DEFAULT NULL COMMENT '店员状态 1.在线 2离线',
  `sign_in` datetime  NOT NULL COMMENT '签到时间',
  `sign_out` datetime  NOT NULL COMMENT '签退时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间' ,
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记 ''1'':已删除 ''0''：未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='店员签到签退表';


DROP TABLE IF EXISTS `t_servant`;
CREATE TABLE IF NOT EXISTS `t_servant` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `servant_code` varchar(255) DEFAULT NULL  COMMENT '编号',
  `all_rate` varchar(255) DEFAULT NULL  COMMENT '总比例',
  `wechat_rate` varchar(255) DEFAULT NULL  COMMENT '微信比例',
  `bank_rate` varchar(255) DEFAULT NULL  COMMENT '银行比例',
  `meiwei_rate` varchar(50) DEFAULT NULL  COMMENT '美唯比例',
  `agent_rate` varchar(50) DEFAULT NULL  COMMENT '代理商比例',
  `status` int(2) DEFAULT NULL COMMENT '状态',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间' ,
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记 ''1'':已删除 ''0''：未删除',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='分佣管理';

DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE IF NOT EXISTS `t_notice` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `title` varchar(255) DEFAULT NULL  COMMENT '通知标题',
  `notice_content` varchar(255) DEFAULT NULL  COMMENT '通知内容',
  `notice_type` varchar(255) DEFAULT NULL  COMMENT '通知内型：1 商户  2代理',
  `isTop` char(1) DEFAULT NULL  COMMENT '是否置顶： 1 是  0 否',
   `publish_date` datetime DEFAULT NULL COMMENT '发布时间' ,
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间' ,
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记 ''1'':已删除 ''0''：未删除',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='通知管理';

DROP TABLE IF EXISTS `t_wechat_user`;
CREATE TABLE IF NOT EXISTS `t_wechat_user`(
	`id` varchar(32) NOT NULL COMMENT '主键ID',
	`open_id` varchar(255) NOT NULL  COMMENT '微信openId',
	`user_id` varchar(32) NOT NULL COMMENT '用户Id',
	`relation_id` varchar(32) NOT NULL COMMENT '关系ID，商户 代理 店员',
	`user_type` varchar(32) NOT NULL COMMENT '1代理 2 商户 3 店员',
	`nick_name` varchar(255) DEFAULT NULL COMMENT '微信昵称',
	`remarks` varchar(255) DEFAULT NULL COMMENT '备注',
	`create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
	 `create_date` datetime DEFAULT NULL COMMENT '创建时间',
	 `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
	 `update_date` datetime DEFAULT NULL COMMENT '修改时间' ,
	 `del_flag` char(1) DEFAULT '0' COMMENT '删除标记 ''1'':已删除 ''0''：未删除',
	 PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='微信用户';





