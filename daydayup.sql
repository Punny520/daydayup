/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50742 (5.7.42)
 Source Host           : localhost:3306
 Source Schema         : daydayup

 Target Server Type    : MySQL
 Target Server Version : 50742 (5.7.42)
 File Encoding         : 65001

 Date: 26/10/2023 21:45:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for document
-- ----------------------------
DROP TABLE IF EXISTS `document`;
CREATE TABLE `document`  (
  `DocumentID` int(11) NOT NULL AUTO_INCREMENT,
  `DocumentTitle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DocumentTypeID` int(11) NULL DEFAULT NULL,
  `DocumentContent` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `FavoritesCount` int(11) NULL DEFAULT NULL,
  `LikesCount` int(11) NULL DEFAULT NULL,
  `CommentCount` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`DocumentID`) USING BTREE,
  INDEX `DocumentTypeID`(`DocumentTypeID`) USING BTREE,
  CONSTRAINT `document_ibfk_1` FOREIGN KEY (`DocumentTypeID`) REFERENCES `documenttype` (`DocumentTypeID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of document
-- ----------------------------
INSERT INTO `document` VALUES (1, '标题', 1, '内容', 0, 0, 0);
INSERT INTO `document` VALUES (2, '标题', 1, '内容', 0, 0, 0);

-- ----------------------------
-- Table structure for documenttype
-- ----------------------------
DROP TABLE IF EXISTS `documenttype`;
CREATE TABLE `documenttype`  (
  `DocumentTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DocumentCount` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`DocumentTypeID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of documenttype
-- ----------------------------
INSERT INTO `documenttype` VALUES (1, '软件工程', 2);

-- ----------------------------
-- Table structure for options
-- ----------------------------
DROP TABLE IF EXISTS `options`;
CREATE TABLE `options`  (
  `OptionID` int(11) NOT NULL AUTO_INCREMENT,
  `OptionContent` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `QuestionID` int(11) NULL DEFAULT NULL,
  `IsAnswer` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`OptionID`) USING BTREE,
  INDEX `QuestionID`(`QuestionID`) USING BTREE,
  CONSTRAINT `options_ibfk_1` FOREIGN KEY (`QuestionID`) REFERENCES `question` (`QuestionID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of options
-- ----------------------------
INSERT INTO `options` VALUES (1, '1', 1, 0);
INSERT INTO `options` VALUES (2, '2', 1, 1);
INSERT INTO `options` VALUES (3, '3', 1, 0);
INSERT INTO `options` VALUES (4, '4', 1, 0);
INSERT INTO `options` VALUES (5, '4', 2, 1);
INSERT INTO `options` VALUES (6, '8', 2, 0);

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `QuestionID` int(11) NOT NULL AUTO_INCREMENT,
  `QuestionTypeID` int(11) NULL DEFAULT NULL,
  `QuestionContent` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`QuestionID`) USING BTREE,
  INDEX `QuestionTypeID`(`QuestionTypeID`) USING BTREE,
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`QuestionTypeID`) REFERENCES `questiontype` (`QuestionTypeID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES (1, 1, '1+1=？');
INSERT INTO `question` VALUES (2, 1, '2+2=?');

-- ----------------------------
-- Table structure for questiontype
-- ----------------------------
DROP TABLE IF EXISTS `questiontype`;
CREATE TABLE `questiontype`  (
  `QuestionTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `QuestionCount` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`QuestionTypeID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of questiontype
-- ----------------------------
INSERT INTO `questiontype` VALUES (1, 'math', 2);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, NULL, NULL);
INSERT INTO `users` VALUES (2, NULL, NULL);
INSERT INTO `users` VALUES (3, 'punny', '123456');
INSERT INTO `users` VALUES (4, 'admin', '12345');
INSERT INTO `users` VALUES (5, 'admin123', '123');
INSERT INTO `users` VALUES (6, '111111', '111111');
INSERT INTO `users` VALUES (7, '555555', '555555');

-- ----------------------------
-- Triggers structure for table document
-- ----------------------------
DROP TRIGGER IF EXISTS `UpdateDocumentCount`;
delimiter ;;
CREATE TRIGGER `UpdateDocumentCount` AFTER INSERT ON `document` FOR EACH ROW BEGIN
    UPDATE DocumentType
    SET DocumentCount = DocumentCount + 1
    WHERE DocumentTypeID = NEW.DocumentTypeID;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table document
-- ----------------------------
DROP TRIGGER IF EXISTS `UpdateDocumentCountOnUpdate`;
delimiter ;;
CREATE TRIGGER `UpdateDocumentCountOnUpdate` AFTER UPDATE ON `document` FOR EACH ROW BEGIN
    IF OLD.DocumentTypeID != NEW.DocumentTypeID THEN
        UPDATE DocumentType
        SET DocumentCount = DocumentCount - 1
        WHERE DocumentTypeID = OLD.DocumentTypeID;
        
        UPDATE DocumentType
        SET DocumentCount = DocumentCount + 1
        WHERE DocumentTypeID = NEW.DocumentTypeID;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table document
-- ----------------------------
DROP TRIGGER IF EXISTS `UpdateDocumentCountOnDelete`;
delimiter ;;
CREATE TRIGGER `UpdateDocumentCountOnDelete` AFTER DELETE ON `document` FOR EACH ROW BEGIN
    UPDATE DocumentType
    SET DocumentCount = DocumentCount - 1
    WHERE DocumentTypeID = OLD.DocumentTypeID;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table question
-- ----------------------------
DROP TRIGGER IF EXISTS `UpdateQuestionCount`;
delimiter ;;
CREATE TRIGGER `UpdateQuestionCount` AFTER INSERT ON `question` FOR EACH ROW BEGIN
    UPDATE QuestionType
    SET QuestionCount = QuestionCount + 1
    WHERE QuestionTypeID = NEW.QuestionTypeID;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table question
-- ----------------------------
DROP TRIGGER IF EXISTS `UpdateQuestionCountOnUpdate`;
delimiter ;;
CREATE TRIGGER `UpdateQuestionCountOnUpdate` AFTER UPDATE ON `question` FOR EACH ROW BEGIN
    IF OLD.QuestionTypeID != NEW.QuestionTypeID THEN
        UPDATE QuestionType
        SET QuestionCount = QuestionCount - 1
        WHERE QuestionTypeID = OLD.QuestionTypeID;
        
        UPDATE QuestionType
        SET QuestionCount = QuestionCount + 1
        WHERE QuestionTypeID = NEW.QuestionTypeID;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table question
-- ----------------------------
DROP TRIGGER IF EXISTS `UpdateQuestionCountOnDelete`;
delimiter ;;
CREATE TRIGGER `UpdateQuestionCountOnDelete` AFTER DELETE ON `question` FOR EACH ROW BEGIN
    UPDATE QuestionType
    SET QuestionCount = QuestionCount - 1
    WHERE QuestionTypeID = OLD.QuestionTypeID;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
