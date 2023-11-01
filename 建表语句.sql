/*
 Navicat Premium Data Transfer

 Source Server         : 科协招新服务器
 Source Server Type    : MySQL
 Source Server Version : 80100
 Source Host           : 47.122.26.218:3306
 Source Schema         : sacc_recruit

 Target Server Type    : MySQL
 Target Server Version : 80100
 File Encoding         : 65001

 Date: 01/11/2023 21:19:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`  (
  `uid` bigint(0) NOT NULL COMMENT '账号uid，主键，雪花算法自动生成',
  `stu_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生学号',
  `stu_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生姓名',
  `md5password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '账户密码(加密版)',
  `role` int(0) NULL DEFAULT NULL COMMENT '用户权限\r\n0：普通用户\r\n1：阅卷人\r\n2：管理员',
  `grouped` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '阅卷人组别',
  `front_end_score` int(0) NULL DEFAULT NULL COMMENT '前端组得分',
  `back_end_score` int(0) NULL DEFAULT NULL COMMENT '后端组得分',
  `python_score` int(0) NULL DEFAULT NULL COMMENT 'python组得分',
  `algorithm_score` int(0) NULL DEFAULT NULL COMMENT '算法组得分',
  `security_score` int(0) NULL DEFAULT NULL COMMENT '安全组得分',
  PRIMARY KEY (`uid`) USING BTREE,
  INDEX `stu_id`(`stu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '答案ID，主键,雪花算法自动生成',
  `unit_id` bigint(0) NOT NULL COMMENT '比赛ID',
  `stu_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生学号',
  `problem_id` bigint(0) NOT NULL COMMENT '题目ID',
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '答案内容',
  `correct_score` int(0) NULL DEFAULT NULL COMMENT '阅卷人批改的分数',
  `judger_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '阅卷人ID，用阅卷人的stu_id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `stu_id`(`stu_id`) USING BTREE,
  INDEX `unit_id`(`unit_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for problem
-- ----------------------------
DROP TABLE IF EXISTS `problem`;
CREATE TABLE `problem`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '问题ID，主键，雪花算法自动生成',
  `unit_id` bigint(0) NOT NULL COMMENT '比赛ID',
  `problem_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '题目描述',
  `problem_type` int(0) NOT NULL COMMENT '题目类型\r\n0：单选\r\n1：多选\r\n2：简答',
  `problem_group` int(0) NOT NULL COMMENT '问题来自的组别\r\n1：前端组\r\n2：后端组\r\n3：python组\r\n4：算法组\r\n5：安全组',
  `problem_score` int(0) NOT NULL COMMENT '题目分数',
  `A` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '选项A',
  `B` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '选项B',
  `C` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '选项C',
  `D` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '选项D',
  `picture_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片url',
  `answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标准答案',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for unit
-- ----------------------------
DROP TABLE IF EXISTS `unit`;
CREATE TABLE `unit`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '比赛ID，主键，雪花算法自动生成',
  `unit_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '比赛名字',
  `unit_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '比赛描述',
  `start_time` datetime(0) NOT NULL COMMENT '开始时间',
  `end_time` datetime(0) NOT NULL COMMENT '结束时间',
  `total_score` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
