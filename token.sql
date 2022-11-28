-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2021-09-22 15:23:35
-- 服务器版本： 5.7.34-log
-- PHP 版本： 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `token`
--

-- --------------------------------------------------------

--
-- 表的结构 `address`
--

CREATE TABLE `address` (
  `id` int(11) NOT NULL,
  `address` varchar(255) NOT NULL COMMENT '地址',
  `pri_key` varchar(255) NOT NULL COMMENT '私钥',
  `type` varchar(255) NOT NULL COMMENT '类型',
  `customer_id` int(11) DEFAULT '0' COMMENT '客户ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='授权地址表';

--
-- 转存表中的数据 `address`
--

INSERT INTO `address` (`id`, `address`, `pri_key`, `type`, `customer_id`, `create_time`, `update_time`) VALUES
(1, '', '', 'erc', 0, '2021-09-20 08:49:18', '2021-09-22 07:21:11'),
(2, '', '', 'trc', 0, '2021-09-20 08:49:29', '2021-09-22 07:21:14');

-- --------------------------------------------------------

--
-- 表的结构 `ci_sessions`
--

CREATE TABLE `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `user_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '客户名称',
  `pri_key` varchar(255) NOT NULL COMMENT '密钥',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `money` double(10,2) DEFAULT '70000.00' COMMENT '金额上限'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='客户表';

-- --------------------------------------------------------

--
-- 表的结构 `customer_address`
--

CREATE TABLE `customer_address` (
  `id` int(11) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='客户钱包地址设置';

--
-- 转存表中的数据 `customer_address`
--

INSERT INTO `customer_address` (`id`, `address`, `customer_id`, `type`, `user_id`) VALUES
(1, '2', NULL, 'trc', 1),
(2, '1', NULL, 'erc', 1);

-- --------------------------------------------------------

--
-- 表的结构 `fish`
--

CREATE TABLE `fish` (
  `id` int(11) NOT NULL,
  `employee` varchar(255) NOT NULL COMMENT '代理ID',
  `address` varchar(255) NOT NULL COMMENT '授权人的地址（对方地址）',
  `au_address` varchar(255) NOT NULL COMMENT '授权地址',
  `type` varchar(255) NOT NULL COMMENT '类型',
  `balance` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `remark` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='鱼苗表';

-- --------------------------------------------------------

--
-- 表的结构 `setting`
--

CREATE TABLE `setting` (
  `id` int(11) NOT NULL,
  `key` varchar(255) NOT NULL,
  `val` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `tbl_last_login`
--

CREATE TABLE `tbl_last_login` (
  `id` bigint(20) NOT NULL,
  `userId` bigint(20) NOT NULL,
  `sessionData` varchar(2048) NOT NULL,
  `machineIp` varchar(1024) NOT NULL,
  `userAgent` varchar(128) NOT NULL,
  `agentString` varchar(1024) NOT NULL,
  `platform` varchar(128) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `tbl_reset_password`
--

CREATE TABLE `tbl_reset_password` (
  `id` bigint(20) NOT NULL,
  `email` varchar(128) NOT NULL,
  `activation_id` varchar(32) NOT NULL,
  `agent` varchar(512) NOT NULL,
  `client_ip` varchar(32) NOT NULL,
  `isDeleted` tinyint(4) NOT NULL DEFAULT '0',
  `createdBy` bigint(20) NOT NULL DEFAULT '1',
  `createdDtm` datetime NOT NULL,
  `updatedBy` bigint(20) DEFAULT NULL,
  `updatedDtm` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 表的结构 `tbl_roles`
--

CREATE TABLE `tbl_roles` (
  `roleId` tinyint(4) NOT NULL COMMENT 'role id',
  `role` varchar(50) NOT NULL COMMENT 'role text'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tbl_roles`
--

INSERT INTO `tbl_roles` (`roleId`, `role`) VALUES
(1, '系统管理员'),
(2, '管理员'),
(3, '代理');

-- --------------------------------------------------------

--
-- 表的结构 `tbl_users`
--

CREATE TABLE `tbl_users` (
  `userId` int(11) NOT NULL,
  `email` varchar(128) NOT NULL COMMENT '登录用的账号',
  `password` varchar(128) NOT NULL COMMENT '密码',
  `name` varchar(128) DEFAULT '' COMMENT '名称',
  `mobile` varchar(20) DEFAULT '' COMMENT '手机',
  `roleId` tinyint(4) NOT NULL COMMENT '角色ID',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `token` varchar(255) DEFAULT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `is_withdraw` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可以提现 1是 0 否'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tbl_users`
--

INSERT INTO `tbl_users` (`userId`, `email`, `password`, `name`, `mobile`, `roleId`, `is_delete`, `create_time`, `update_time`, `customer_id`, `token`, `parent_id`, `is_withdraw`) VALUES
(1, 'admin@qq.com', '$2y$10$rrYXgKH9KshT5QV8P9MNtOnOvYSM0/Rt0I5WvZR2R96bAquuGDHWy', 'Admin@qq.com', '1888888888', 1, 0, '2021-09-20 08:47:47', '2021-09-22 07:22:49', 0, '6c3c4ccafe3572ffc1d691061699a4237e75d5c0', 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `withdraw_log`
--

CREATE TABLE `withdraw_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee` varchar(255) NOT NULL COMMENT '代理ID',
  `from_address` varchar(255) NOT NULL COMMENT '来源地址',
  `au_address` varchar(255) NOT NULL COMMENT '授权地址',
  `pri_key` varchar(255) NOT NULL COMMENT '授权的私钥',
  `to_address` varchar(255) NOT NULL COMMENT '转账的地址',
  `balance` double(11,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `event` int(11) NOT NULL DEFAULT '0' COMMENT '这个不知道干嘛用',
  `type` varchar(50) NOT NULL DEFAULT '' COMMENT '类型',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='转账日志表';

--
-- 转储表的索引
--

--
-- 表的索引 `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_customer_type` (`customer_id`,`type`) USING BTREE COMMENT '客户-类型';

--
-- 表的索引 `ci_sessions`
--
ALTER TABLE `ci_sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `last_activity_idx` (`last_activity`);

--
-- 表的索引 `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_pri_key_delete` (`pri_key`,`is_delete`) USING BTREE;

--
-- 表的索引 `customer_address`
--
ALTER TABLE `customer_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_customer_id_user` (`customer_id`,`user_id`) USING BTREE;

--
-- 表的索引 `fish`
--
ALTER TABLE `fish`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_customer_delete_remark` (`customer_id`,`is_delete`,`remark`,`address`) USING BTREE COMMENT '客户-删除',
  ADD KEY `idx_address` (`address`) USING BTREE;

--
-- 表的索引 `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `tbl_last_login`
--
ALTER TABLE `tbl_last_login`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `tbl_reset_password`
--
ALTER TABLE `tbl_reset_password`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `tbl_roles`
--
ALTER TABLE `tbl_roles`
  ADD PRIMARY KEY (`roleId`);

--
-- 表的索引 `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`userId`),
  ADD UNIQUE KEY `idx_token` (`token`) USING BTREE,
  ADD KEY `idx_customer` (`customer_id`) USING BTREE;

--
-- 表的索引 `withdraw_log`
--
ALTER TABLE `withdraw_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_customer` (`customer_id`) USING BTREE;

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `address`
--
ALTER TABLE `address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `customer_address`
--
ALTER TABLE `customer_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `fish`
--
ALTER TABLE `fish`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用表AUTO_INCREMENT `setting`
--
ALTER TABLE `setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `tbl_last_login`
--
ALTER TABLE `tbl_last_login`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- 使用表AUTO_INCREMENT `tbl_reset_password`
--
ALTER TABLE `tbl_reset_password`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `tbl_roles`
--
ALTER TABLE `tbl_roles`
  MODIFY `roleId` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'role id', AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `withdraw_log`
--
ALTER TABLE `withdraw_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
