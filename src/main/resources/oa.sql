/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.7.11-log : Database - oa
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`oa` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `oa`;

/*Table structure for table `approve` */

DROP TABLE IF EXISTS `approve`;

CREATE TABLE `approve` (
  `aid` bigint(20) NOT NULL,
  `approvename` varchar(30) DEFAULT NULL,
  `approvetime` datetime DEFAULT NULL,
  `isapprove` varchar(30) DEFAULT NULL,
  `comment` longtext,
  `fid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`aid`),
  KEY `FKD0BB034D371CBCF` (`fid`),
  CONSTRAINT `FKD0BB034D371CBCF` FOREIGN KEY (`fid`) REFERENCES `form` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `approve` */

insert  into `approve`(`aid`,`approvename`,`approvetime`,`isapprove`,`comment`,`fid`) values (1,'jack','2016-07-15 09:41:31','','asdf',2),(2,'jack','2016-07-15 09:41:49','','去屎吧',3),(3,'jack','2016-07-15 09:41:58','','去屎吧',4),(4,'jack','2016-07-15 10:42:13','','按时发达',5),(5,'jack','2016-07-16 21:26:27','','hg\'',6),(6,'jack','2016-07-17 10:12:09','不同意','zjh',7),(7,'jack','2016-07-17 17:09:11','同意','tongyikeyi',10);

/*Table structure for table `department` */

DROP TABLE IF EXISTS `department`;

CREATE TABLE `department` (
  `did` bigint(20) NOT NULL,
  `dname` varchar(20) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `department` */

insert  into `department`(`did`,`dname`,`description`) values (2,'技术部','公司技术架构支持<br />'),(3,'人力资源部','招聘相关,公司制度'),(4,'策划部','项目规划'),(5,'后勤部','后勤资源支持'),(6,'aafadf','<img src=\"http://localhost:8080/fckeditor/editor/images/smiley/wangwang/8.gif\" alt=\"\" />');

/*Table structure for table `form` */

DROP TABLE IF EXISTS `form`;

CREATE TABLE `form` (
  `fid` bigint(20) NOT NULL,
  `applicatetime` datetime DEFAULT NULL,
  `applicator` varchar(20) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `ftid` bigint(20) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`fid`),
  KEY `FK300CC46F17E0D1` (`ftid`),
  CONSTRAINT `FK300CC46F17E0D1` FOREIGN KEY (`ftid`) REFERENCES `formtemplate` (`ftid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `form` */

insert  into `form`(`fid`,`applicatetime`,`applicator`,`state`,`title`,`ftid`,`url`) values (1,'2016-07-10 21:24:59','admin','申请中','请假模板_admin_Sun Jul 10 21:24:59 CST 2016',1,'F:/upload/2016/07/10/9486e96f-275b-44fe-9f38-87c7c42220ee.doc'),(2,'2016-07-10 21:26:23','admin','申请中','请假模板_admin_Sun Jul 10 21:26:23 CST 2016',1,'F:/upload/2016/07/10/77218296-7f18-4fdc-a315-2bcd1fdd45a6.doc'),(3,'2016-07-12 11:51:54','admin','申请中','请假模板_admin_Tue Jul 12 11:51:54 CST 2016',1,'F:/upload/2016/07/12/06a66eae-76b5-4219-890d-189a997cd84c.doc'),(4,'2016-07-12 14:55:53','admin','申请中','请假模板_admin_Tue Jul 12 14:55:53 CST 2016',1,'F:/upload/2016/07/12/c86c413f-8ff3-495e-bf2a-465adbfa5dbf.doc'),(5,'2016-07-12 15:21:07','admin','申请中','请假模板_admin_Tue Jul 12 15:21:07 CST 2016',1,'F:/upload/2016/07/12/58ee802e-b0f5-4e81-8f53-e8093d9913f0.doc'),(6,'2016-07-12 15:42:48','admin','申请中','请假模板_admin_Tue Jul 12 15:42:48 CST 2016',1,'F:/upload/2016/07/12/30e9eb24-1adb-44aa-8dc5-65f68e7f7b91.doc'),(7,'2016-07-12 15:52:11','admin','未通过','请假模板_admin_Tue Jul 12 15:52:11 CST 2016',1,'F:/upload/2016/07/12/d583bac8-83d6-4b8d-af0f-cc5459fc34e3.doc'),(8,'2016-07-15 11:10:27','admin','申请中','请假模板_admin_Fri Jul 15 11:10:27 CST 2016',1,'F:/upload/2016/07/15/e3243919-b480-4f84-bbfa-ae99d142049f.doc'),(9,'2016-07-15 11:14:37','admin','申请中','请假模板_admin_Fri Jul 15 11:14:37 CST 2016',1,'F:/upload/2016/07/15/8e832d97-2197-49eb-8ee4-0e8b2a0e8179.doc'),(10,'2016-07-17 17:08:23','jack','申请中','请假模板_jack_Sun Jul 17 17:08:23 CST 2016',1,'F:/upload/2016/07/17/b2ec4bb4-e707-40d8-a82b-eed145e56e04.doc');

/*Table structure for table `formtemplate` */

DROP TABLE IF EXISTS `formtemplate`;

CREATE TABLE `formtemplate` (
  `ftid` bigint(20) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `processKey` varchar(20) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ftid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `formtemplate` */

insert  into `formtemplate`(`ftid`,`name`,`processKey`,`url`) values (1,'请假模板','qingjia','F:/upload/2016/07/10/c4716a86-7e30-4d6c-b2d3-6b4cf563cfe0.doc'),(2,'审批流程','forkjoin','F:/upload/2016/07/10/cc60fe17-9836-4026-8c20-1752ea6008e3.doc');

/*Table structure for table `jbpm4_deployment` */

DROP TABLE IF EXISTS `jbpm4_deployment`;

CREATE TABLE `jbpm4_deployment` (
  `DBID_` bigint(20) NOT NULL,
  `NAME_` longtext,
  `TIMESTAMP_` bigint(20) DEFAULT NULL,
  `STATE_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_deployment` */

insert  into `jbpm4_deployment`(`DBID_`,`NAME_`,`TIMESTAMP_`,`STATE_`) values (10001,NULL,0,'active'),(10008,NULL,0,'active'),(10015,NULL,0,'active'),(20001,NULL,0,'active');

/*Table structure for table `jbpm4_deployprop` */

DROP TABLE IF EXISTS `jbpm4_deployprop`;

CREATE TABLE `jbpm4_deployprop` (
  `DBID_` bigint(20) NOT NULL,
  `DEPLOYMENT_` bigint(20) DEFAULT NULL,
  `OBJNAME_` varchar(255) DEFAULT NULL,
  `KEY_` varchar(255) DEFAULT NULL,
  `STRINGVAL_` varchar(255) DEFAULT NULL,
  `LONGVAL_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_DEPLPROP_DEPL` (`DEPLOYMENT_`),
  CONSTRAINT `FK_DEPLPROP_DEPL` FOREIGN KEY (`DEPLOYMENT_`) REFERENCES `jbpm4_deployment` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_deployprop` */

insert  into `jbpm4_deployprop`(`DBID_`,`DEPLOYMENT_`,`OBJNAME_`,`KEY_`,`STRINGVAL_`,`LONGVAL_`) values (10004,10001,'qingjia','langid','jpdl-4.4',NULL),(10005,10001,'qingjia','pdid','qingjia-1',NULL),(10006,10001,'qingjia','pdkey','qingjia',NULL),(10007,10001,'qingjia','pdversion',NULL,1),(10011,10008,'forkjoin','langid','jpdl-4.4',NULL),(10012,10008,'forkjoin','pdid','forkjoin-1',NULL),(10013,10008,'forkjoin','pdkey','forkjoin',NULL),(10014,10008,'forkjoin','pdversion',NULL,1),(10018,10015,'qingjia','langid','jpdl-4.4',NULL),(10019,10015,'qingjia','pdid','qingjia-2',NULL),(10020,10015,'qingjia','pdkey','qingjia',NULL),(10021,10015,'qingjia','pdversion',NULL,2),(20004,20001,'forkjoin','langid','jpdl-4.4',NULL),(20005,20001,'forkjoin','pdid','forkjoin-2',NULL),(20006,20001,'forkjoin','pdkey','forkjoin',NULL),(20007,20001,'forkjoin','pdversion',NULL,2);

/*Table structure for table `jbpm4_execution` */

DROP TABLE IF EXISTS `jbpm4_execution`;

CREATE TABLE `jbpm4_execution` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ACTIVITYNAME_` varchar(255) DEFAULT NULL,
  `PROCDEFID_` varchar(255) DEFAULT NULL,
  `HASVARS_` bit(1) DEFAULT NULL,
  `NAME_` varchar(255) DEFAULT NULL,
  `KEY_` varchar(255) DEFAULT NULL,
  `ID_` varchar(255) DEFAULT NULL,
  `STATE_` varchar(255) DEFAULT NULL,
  `SUSPHISTSTATE_` varchar(255) DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `HISACTINST_` bigint(20) DEFAULT NULL,
  `PARENT_` bigint(20) DEFAULT NULL,
  `INSTANCE_` bigint(20) DEFAULT NULL,
  `SUPEREXEC_` bigint(20) DEFAULT NULL,
  `SUBPROCINST_` bigint(20) DEFAULT NULL,
  `PARENT_IDX_` int(11) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  UNIQUE KEY `ID_` (`ID_`),
  KEY `FK_EXEC_INSTANCE` (`INSTANCE_`),
  KEY `FK_EXEC_PARENT` (`PARENT_`),
  KEY `FK_EXEC_SUBPI` (`SUBPROCINST_`),
  KEY `FK_EXEC_SUPEREXEC` (`SUPEREXEC_`),
  CONSTRAINT `FK_EXEC_INSTANCE` FOREIGN KEY (`INSTANCE_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_EXEC_PARENT` FOREIGN KEY (`PARENT_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_EXEC_SUBPI` FOREIGN KEY (`SUBPROCINST_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_EXEC_SUPEREXEC` FOREIGN KEY (`SUPEREXEC_`) REFERENCES `jbpm4_execution` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_execution` */

insert  into `jbpm4_execution`(`DBID_`,`CLASS_`,`DBVERSION_`,`ACTIVITYNAME_`,`PROCDEFID_`,`HASVARS_`,`NAME_`,`KEY_`,`ID_`,`STATE_`,`SUSPHISTSTATE_`,`PRIORITY_`,`HISACTINST_`,`PARENT_`,`INSTANCE_`,`SUPEREXEC_`,`SUBPROCINST_`,`PARENT_IDX_`) values (30001,'pvm',3,'总经理审批','qingjia-2','',NULL,NULL,'qingjia.30001','active-root',NULL,0,100002,NULL,30001,NULL,NULL,NULL),(30007,'pvm',3,'总经理审批','qingjia-2','',NULL,NULL,'qingjia.30007','active-root',NULL,0,110002,NULL,30007,NULL,NULL,NULL),(40001,'pvm',3,'总经理审批','qingjia-2','',NULL,NULL,'qingjia.40001','active-root',NULL,0,110004,NULL,40001,NULL,NULL,NULL),(60001,'pvm',3,'总经理审批','qingjia-2','',NULL,NULL,'qingjia.60001','active-root',NULL,0,110006,NULL,60001,NULL,NULL,NULL),(70001,'pvm',3,'总经理审批','qingjia-2','',NULL,NULL,'qingjia.70001','active-root',NULL,0,120002,NULL,70001,NULL,NULL,NULL),(80001,'pvm',3,'总经理审批','qingjia-2','',NULL,NULL,'qingjia.80001','active-root',NULL,0,170002,NULL,80001,NULL,NULL,NULL),(150001,'pvm',2,'部门经理审批','qingjia-2','',NULL,NULL,'qingjia.150001','active-root',NULL,0,150006,NULL,150001,NULL,NULL,NULL),(160001,'pvm',2,'部门经理审批','qingjia-2','',NULL,NULL,'qingjia.160001','active-root',NULL,0,160006,NULL,160001,NULL,NULL,NULL),(180001,'pvm',3,'总经理审批','qingjia-2','',NULL,NULL,'qingjia.180001','active-root',NULL,0,180008,NULL,180001,NULL,NULL,NULL);

/*Table structure for table `jbpm4_hist_actinst` */

DROP TABLE IF EXISTS `jbpm4_hist_actinst`;

CREATE TABLE `jbpm4_hist_actinst` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `HPROCI_` bigint(20) DEFAULT NULL,
  `TYPE_` varchar(255) DEFAULT NULL,
  `EXECUTION_` varchar(255) DEFAULT NULL,
  `ACTIVITY_NAME_` varchar(255) DEFAULT NULL,
  `START_` datetime DEFAULT NULL,
  `END_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TRANSITION_` varchar(255) DEFAULT NULL,
  `NEXTIDX_` int(11) DEFAULT NULL,
  `HTASK_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_HACTI_HPROCI` (`HPROCI_`),
  KEY `FK_HTI_HTASK` (`HTASK_`),
  CONSTRAINT `FK_HACTI_HPROCI` FOREIGN KEY (`HPROCI_`) REFERENCES `jbpm4_hist_procinst` (`DBID_`),
  CONSTRAINT `FK_HTI_HTASK` FOREIGN KEY (`HTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_hist_actinst` */

insert  into `jbpm4_hist_actinst`(`DBID_`,`CLASS_`,`DBVERSION_`,`HPROCI_`,`TYPE_`,`EXECUTION_`,`ACTIVITY_NAME_`,`START_`,`END_`,`DURATION_`,`TRANSITION_`,`NEXTIDX_`,`HTASK_`) values (30004,'task',1,30001,'task','qingjia.30001','申请请假','2016-07-10 21:25:00','2016-07-10 21:25:00',328,'jbpm_no_task_outcome_specified_jbpm',1,30003),(30006,'task',1,30001,'task','qingjia.30001','部门经理审批','2016-07-10 21:25:00','2016-07-15 09:39:38',389678309,'jbpm_no_task_outcome_specified_jbpm',1,30005),(30010,'task',1,30007,'task','qingjia.30007','申请请假','2016-07-10 21:26:23','2016-07-10 21:26:23',116,'jbpm_no_task_outcome_specified_jbpm',1,30009),(30012,'task',1,30007,'task','qingjia.30007','部门经理审批','2016-07-10 21:26:23','2016-07-15 09:41:31',389708365,'jbpm_no_task_outcome_specified_jbpm',1,30011),(40004,'task',1,40001,'task','qingjia.40001','申请请假','2016-07-12 11:51:55','2016-07-12 11:51:55',197,'jbpm_no_task_outcome_specified_jbpm',1,40003),(40006,'task',1,40001,'task','qingjia.40001','部门经理审批','2016-07-12 11:51:55','2016-07-15 09:41:49',251394915,'jbpm_no_task_outcome_specified_jbpm',1,40005),(60004,'task',1,60001,'task','qingjia.60001','申请请假','2016-07-12 14:55:54','2016-07-12 14:55:54',158,'jbpm_no_task_outcome_specified_jbpm',1,60003),(60006,'task',1,60001,'task','qingjia.60001','部门经理审批','2016-07-12 14:55:54','2016-07-15 09:41:58',240364498,'jbpm_no_task_outcome_specified_jbpm',1,60005),(70004,'task',1,70001,'task','qingjia.70001','申请请假','2016-07-12 15:21:08','2016-07-12 15:21:08',480,'jbpm_no_task_outcome_specified_jbpm',1,70003),(70006,'task',1,70001,'task','qingjia.70001','部门经理审批','2016-07-12 15:21:08','2016-07-15 10:42:13',242465304,'jbpm_no_task_outcome_specified_jbpm',1,70005),(80004,'task',1,80001,'task','qingjia.80001','申请请假','2016-07-12 15:42:48','2016-07-12 15:42:48',48,'jbpm_no_task_outcome_specified_jbpm',1,80003),(80006,'task',1,80001,'task','qingjia.80001','部门经理审批','2016-07-12 15:42:48','2016-07-16 21:26:27',366219214,'jbpm_no_task_outcome_specified_jbpm',1,80005),(90004,'task',1,90001,'task','qingjia.90001','申请请假','2016-07-12 15:52:11','2016-07-12 15:52:12',217,'jbpm_no_task_outcome_specified_jbpm',1,90003),(90006,'task',0,90001,'task','qingjia.90001','部门经理审批','2016-07-12 15:52:12',NULL,0,NULL,1,90005),(100002,'task',0,30001,'task','qingjia.30001','总经理审批','2016-07-15 09:39:38',NULL,0,NULL,1,100001),(110002,'task',0,30007,'task','qingjia.30007','总经理审批','2016-07-15 09:41:31',NULL,0,NULL,1,110001),(110004,'task',0,40001,'task','qingjia.40001','总经理审批','2016-07-15 09:41:49',NULL,0,NULL,1,110003),(110006,'task',0,60001,'task','qingjia.60001','总经理审批','2016-07-15 09:41:58',NULL,0,NULL,1,110005),(120002,'task',0,70001,'task','qingjia.70001','总经理审批','2016-07-15 10:42:13',NULL,0,NULL,1,120001),(150004,'task',1,150001,'task','qingjia.150001','申请请假','2016-07-15 11:10:28','2016-07-15 11:10:28',340,'jbpm_no_task_outcome_specified_jbpm',1,150003),(150006,'task',0,150001,'task','qingjia.150001','部门经理审批','2016-07-15 11:10:28',NULL,0,NULL,1,150005),(160004,'task',1,160001,'task','qingjia.160001','申请请假','2016-07-15 11:14:37','2016-07-15 11:14:37',127,'jbpm_no_task_outcome_specified_jbpm',1,160003),(160006,'task',0,160001,'task','qingjia.160001','部门经理审批','2016-07-15 11:14:37',NULL,0,NULL,1,160005),(170002,'task',0,80001,'task','qingjia.80001','总经理审批','2016-07-16 21:26:27',NULL,0,NULL,1,170001),(180004,'task',1,180001,'task','qingjia.180001','申请请假','2016-07-17 17:08:23','2016-07-17 17:08:24',50,'jbpm_no_task_outcome_specified_jbpm',1,180003),(180006,'task',1,180001,'task','qingjia.180001','部门经理审批','2016-07-17 17:08:24','2016-07-17 17:09:11',47628,'jbpm_no_task_outcome_specified_jbpm',1,180005),(180008,'task',0,180001,'task','qingjia.180001','总经理审批','2016-07-17 17:09:11',NULL,0,NULL,1,180007);

/*Table structure for table `jbpm4_hist_detail` */

DROP TABLE IF EXISTS `jbpm4_hist_detail`;

CREATE TABLE `jbpm4_hist_detail` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `USERID_` varchar(255) DEFAULT NULL,
  `TIME_` datetime DEFAULT NULL,
  `HPROCI_` bigint(20) DEFAULT NULL,
  `HPROCIIDX_` int(11) DEFAULT NULL,
  `HACTI_` bigint(20) DEFAULT NULL,
  `HACTIIDX_` int(11) DEFAULT NULL,
  `HTASK_` bigint(20) DEFAULT NULL,
  `HTASKIDX_` int(11) DEFAULT NULL,
  `HVAR_` bigint(20) DEFAULT NULL,
  `HVARIDX_` int(11) DEFAULT NULL,
  `MESSAGE_` longtext,
  `OLD_STR_` varchar(255) DEFAULT NULL,
  `NEW_STR_` varchar(255) DEFAULT NULL,
  `OLD_INT_` int(11) DEFAULT NULL,
  `NEW_INT_` int(11) DEFAULT NULL,
  `OLD_TIME_` datetime DEFAULT NULL,
  `NEW_TIME_` datetime DEFAULT NULL,
  `PARENT_` bigint(20) DEFAULT NULL,
  `PARENT_IDX_` int(11) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_HDETAIL_HVAR` (`HVAR_`),
  KEY `FK_HDETAIL_HPROCI` (`HPROCI_`),
  KEY `FK_HDETAIL_HTASK` (`HTASK_`),
  KEY `FK_HDETAIL_HACTI` (`HACTI_`),
  CONSTRAINT `FK_HDETAIL_HACTI` FOREIGN KEY (`HACTI_`) REFERENCES `jbpm4_hist_actinst` (`DBID_`),
  CONSTRAINT `FK_HDETAIL_HPROCI` FOREIGN KEY (`HPROCI_`) REFERENCES `jbpm4_hist_procinst` (`DBID_`),
  CONSTRAINT `FK_HDETAIL_HTASK` FOREIGN KEY (`HTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`),
  CONSTRAINT `FK_HDETAIL_HVAR` FOREIGN KEY (`HVAR_`) REFERENCES `jbpm4_hist_var` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_hist_detail` */

/*Table structure for table `jbpm4_hist_procinst` */

DROP TABLE IF EXISTS `jbpm4_hist_procinst`;

CREATE TABLE `jbpm4_hist_procinst` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ID_` varchar(255) DEFAULT NULL,
  `PROCDEFID_` varchar(255) DEFAULT NULL,
  `KEY_` varchar(255) DEFAULT NULL,
  `START_` datetime DEFAULT NULL,
  `END_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `STATE_` varchar(255) DEFAULT NULL,
  `ENDACTIVITY_` varchar(255) DEFAULT NULL,
  `NEXTIDX_` int(11) DEFAULT NULL,
  PRIMARY KEY (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_hist_procinst` */

insert  into `jbpm4_hist_procinst`(`DBID_`,`DBVERSION_`,`ID_`,`PROCDEFID_`,`KEY_`,`START_`,`END_`,`DURATION_`,`STATE_`,`ENDACTIVITY_`,`NEXTIDX_`) values (30001,0,'qingjia.30001','qingjia-2',NULL,'2016-07-10 21:25:00',NULL,NULL,'active',NULL,1),(30007,0,'qingjia.30007','qingjia-2',NULL,'2016-07-10 21:26:23',NULL,NULL,'active',NULL,1),(40001,0,'qingjia.40001','qingjia-2',NULL,'2016-07-12 11:51:55',NULL,NULL,'active',NULL,1),(60001,0,'qingjia.60001','qingjia-2',NULL,'2016-07-12 14:55:54',NULL,NULL,'active',NULL,1),(70001,0,'qingjia.70001','qingjia-2',NULL,'2016-07-12 15:21:08',NULL,NULL,'active',NULL,1),(80001,0,'qingjia.80001','qingjia-2',NULL,'2016-07-12 15:42:48',NULL,NULL,'active',NULL,1),(90001,1,'qingjia.90001','qingjia-2',NULL,'2016-07-12 15:52:11','2016-07-17 10:12:17',411606363,'ended','部门经理审批',1),(150001,0,'qingjia.150001','qingjia-2',NULL,'2016-07-15 11:10:28',NULL,NULL,'active',NULL,1),(160001,0,'qingjia.160001','qingjia-2',NULL,'2016-07-15 11:14:37',NULL,NULL,'active',NULL,1),(180001,0,'qingjia.180001','qingjia-2',NULL,'2016-07-17 17:08:23',NULL,NULL,'active',NULL,1);

/*Table structure for table `jbpm4_hist_task` */

DROP TABLE IF EXISTS `jbpm4_hist_task`;

CREATE TABLE `jbpm4_hist_task` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `EXECUTION_` varchar(255) DEFAULT NULL,
  `OUTCOME_` varchar(255) DEFAULT NULL,
  `ASSIGNEE_` varchar(255) DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `STATE_` varchar(255) DEFAULT NULL,
  `CREATE_` datetime DEFAULT NULL,
  `END_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `NEXTIDX_` int(11) DEFAULT NULL,
  `SUPERTASK_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_HSUPERT_SUB` (`SUPERTASK_`),
  CONSTRAINT `FK_HSUPERT_SUB` FOREIGN KEY (`SUPERTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_hist_task` */

insert  into `jbpm4_hist_task`(`DBID_`,`DBVERSION_`,`EXECUTION_`,`OUTCOME_`,`ASSIGNEE_`,`PRIORITY_`,`STATE_`,`CREATE_`,`END_`,`DURATION_`,`NEXTIDX_`,`SUPERTASK_`) values (30003,1,'qingjia.30001','jbpm_no_task_outcome_specified_jbpm','admin',0,'completed','2016-07-10 21:25:00','2016-07-10 21:25:00',324,1,NULL),(30005,1,'qingjia.30001','jbpm_no_task_outcome_specified_jbpm','jack',0,'completed','2016-07-10 21:25:00','2016-07-15 09:39:38',389678312,1,NULL),(30009,1,'qingjia.30007','jbpm_no_task_outcome_specified_jbpm','admin',0,'completed','2016-07-10 21:26:23','2016-07-10 21:26:23',115,1,NULL),(30011,1,'qingjia.30007','jbpm_no_task_outcome_specified_jbpm','jack',0,'completed','2016-07-10 21:26:23','2016-07-15 09:41:31',389708368,1,NULL),(40003,1,'qingjia.40001','jbpm_no_task_outcome_specified_jbpm','admin',0,'completed','2016-07-12 11:51:55','2016-07-12 11:51:55',196,1,NULL),(40005,1,'qingjia.40001','jbpm_no_task_outcome_specified_jbpm','jack',0,'completed','2016-07-12 11:51:55','2016-07-15 09:41:49',251394918,1,NULL),(60003,1,'qingjia.60001','jbpm_no_task_outcome_specified_jbpm','admin',0,'completed','2016-07-12 14:55:54','2016-07-12 14:55:54',152,1,NULL),(60005,1,'qingjia.60001','jbpm_no_task_outcome_specified_jbpm','jack',0,'completed','2016-07-12 14:55:54','2016-07-15 09:41:58',240364500,1,NULL),(70003,1,'qingjia.70001','jbpm_no_task_outcome_specified_jbpm','admin',0,'completed','2016-07-12 15:21:08','2016-07-12 15:21:08',477,1,NULL),(70005,1,'qingjia.70001','jbpm_no_task_outcome_specified_jbpm','jack',0,'completed','2016-07-12 15:21:08','2016-07-15 10:42:13',242465308,1,NULL),(80003,1,'qingjia.80001','jbpm_no_task_outcome_specified_jbpm','admin',0,'completed','2016-07-12 15:42:48','2016-07-12 15:42:48',45,1,NULL),(80005,1,'qingjia.80001','jbpm_no_task_outcome_specified_jbpm','jack',0,'completed','2016-07-12 15:42:48','2016-07-16 21:26:27',366219230,1,NULL),(90003,1,'qingjia.90001','jbpm_no_task_outcome_specified_jbpm','admin',0,'completed','2016-07-12 15:52:11','2016-07-12 15:52:12',216,1,NULL),(90005,0,'qingjia.90001',NULL,'jack',0,NULL,'2016-07-12 15:52:12',NULL,0,1,NULL),(100001,0,'qingjia.30001',NULL,'cocochen',0,NULL,'2016-07-15 09:39:39',NULL,0,1,NULL),(110001,0,'qingjia.30007',NULL,'cocochen',0,NULL,'2016-07-15 09:41:31',NULL,0,1,NULL),(110003,0,'qingjia.40001',NULL,'cocochen',0,NULL,'2016-07-15 09:41:49',NULL,0,1,NULL),(110005,0,'qingjia.60001',NULL,'cocochen',0,NULL,'2016-07-15 09:41:58',NULL,0,1,NULL),(120001,0,'qingjia.70001',NULL,'cocochen',0,NULL,'2016-07-15 10:42:13',NULL,0,1,NULL),(150003,1,'qingjia.150001','jbpm_no_task_outcome_specified_jbpm','admin',0,'completed','2016-07-15 11:10:28','2016-07-15 11:10:28',337,1,NULL),(150005,0,'qingjia.150001',NULL,'jack',0,NULL,'2016-07-15 11:10:28',NULL,0,1,NULL),(160003,1,'qingjia.160001','jbpm_no_task_outcome_specified_jbpm','admin',0,'completed','2016-07-15 11:14:37','2016-07-15 11:14:37',125,1,NULL),(160005,0,'qingjia.160001',NULL,'jack',0,NULL,'2016-07-15 11:14:37',NULL,0,1,NULL),(170001,0,'qingjia.80001',NULL,'cocochen',0,NULL,'2016-07-16 21:26:27',NULL,0,1,NULL),(180003,1,'qingjia.180001','jbpm_no_task_outcome_specified_jbpm','jack',0,'completed','2016-07-17 17:08:23','2016-07-17 17:08:24',49,1,NULL),(180005,1,'qingjia.180001','jbpm_no_task_outcome_specified_jbpm','jack',0,'completed','2016-07-17 17:08:24','2016-07-17 17:09:11',47632,1,NULL),(180007,0,'qingjia.180001',NULL,'cocochen',0,NULL,'2016-07-17 17:09:11',NULL,0,1,NULL);

/*Table structure for table `jbpm4_hist_var` */

DROP TABLE IF EXISTS `jbpm4_hist_var`;

CREATE TABLE `jbpm4_hist_var` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `PROCINSTID_` varchar(255) DEFAULT NULL,
  `EXECUTIONID_` varchar(255) DEFAULT NULL,
  `VARNAME_` varchar(255) DEFAULT NULL,
  `VALUE_` varchar(255) DEFAULT NULL,
  `HPROCI_` bigint(20) DEFAULT NULL,
  `HTASK_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_HVAR_HPROCI` (`HPROCI_`),
  KEY `FK_HVAR_HTASK` (`HTASK_`),
  CONSTRAINT `FK_HVAR_HPROCI` FOREIGN KEY (`HPROCI_`) REFERENCES `jbpm4_hist_procinst` (`DBID_`),
  CONSTRAINT `FK_HVAR_HTASK` FOREIGN KEY (`HTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_hist_var` */

/*Table structure for table `jbpm4_id_group` */

DROP TABLE IF EXISTS `jbpm4_id_group`;

CREATE TABLE `jbpm4_id_group` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ID_` varchar(255) DEFAULT NULL,
  `NAME_` varchar(255) DEFAULT NULL,
  `TYPE_` varchar(255) DEFAULT NULL,
  `PARENT_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_GROUP_PARENT` (`PARENT_`),
  CONSTRAINT `FK_GROUP_PARENT` FOREIGN KEY (`PARENT_`) REFERENCES `jbpm4_id_group` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_id_group` */

/*Table structure for table `jbpm4_id_membership` */

DROP TABLE IF EXISTS `jbpm4_id_membership`;

CREATE TABLE `jbpm4_id_membership` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `USER_` bigint(20) DEFAULT NULL,
  `GROUP_` bigint(20) DEFAULT NULL,
  `NAME_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_MEM_USER` (`USER_`),
  KEY `FK_MEM_GROUP` (`GROUP_`),
  CONSTRAINT `FK_MEM_GROUP` FOREIGN KEY (`GROUP_`) REFERENCES `jbpm4_id_group` (`DBID_`),
  CONSTRAINT `FK_MEM_USER` FOREIGN KEY (`USER_`) REFERENCES `jbpm4_id_user` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_id_membership` */

/*Table structure for table `jbpm4_id_user` */

DROP TABLE IF EXISTS `jbpm4_id_user`;

CREATE TABLE `jbpm4_id_user` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ID_` varchar(255) DEFAULT NULL,
  `PASSWORD_` varchar(255) DEFAULT NULL,
  `GIVENNAME_` varchar(255) DEFAULT NULL,
  `FAMILYNAME_` varchar(255) DEFAULT NULL,
  `BUSINESSEMAIL_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_id_user` */

/*Table structure for table `jbpm4_job` */

DROP TABLE IF EXISTS `jbpm4_job`;

CREATE TABLE `jbpm4_job` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `DUEDATE_` datetime DEFAULT NULL,
  `STATE_` varchar(255) DEFAULT NULL,
  `ISEXCLUSIVE_` bit(1) DEFAULT NULL,
  `LOCKOWNER_` varchar(255) DEFAULT NULL,
  `LOCKEXPTIME_` datetime DEFAULT NULL,
  `EXCEPTION_` longtext,
  `RETRIES_` int(11) DEFAULT NULL,
  `PROCESSINSTANCE_` bigint(20) DEFAULT NULL,
  `EXECUTION_` bigint(20) DEFAULT NULL,
  `CFG_` bigint(20) DEFAULT NULL,
  `SIGNAL_` varchar(255) DEFAULT NULL,
  `EVENT_` varchar(255) DEFAULT NULL,
  `REPEAT_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_JOB_CFG` (`CFG_`),
  CONSTRAINT `FK_JOB_CFG` FOREIGN KEY (`CFG_`) REFERENCES `jbpm4_lob` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_job` */

/*Table structure for table `jbpm4_lob` */

DROP TABLE IF EXISTS `jbpm4_lob`;

CREATE TABLE `jbpm4_lob` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `BLOB_VALUE_` longblob,
  `DEPLOYMENT_` bigint(20) DEFAULT NULL,
  `NAME_` longtext,
  PRIMARY KEY (`DBID_`),
  KEY `FK_LOB_DEPLOYMENT` (`DEPLOYMENT_`),
  CONSTRAINT `FK_LOB_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_`) REFERENCES `jbpm4_deployment` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_lob` */

insert  into `jbpm4_lob`(`DBID_`,`DBVERSION_`,`BLOB_VALUE_`,`DEPLOYMENT_`,`NAME_`) values (10002,0,'<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n<process key=\"qingjia\" name=\"qingjia\" xmlns=\"http://jbpm.org/4.4/jpdl\">\r\n   <start g=\"246,28,7,3\" name=\"start1\">\r\n      <transition g=\"-71,-17\" name=\"to 申请请假\" to=\"申请请假\"/>\r\n   </start>\r\n   <end g=\"226,320,48,48\" name=\"end1\"/>\r\n   <task assignee=\"#{form.applicator}\" g=\"88,99,92,52\" name=\"申请请假\">\r\n      <transition g=\"-138,5\" name=\"to 部门经理审批\" to=\"部门经理审批\"/>\r\n   </task>\r\n   <task assignee=\"jack\" g=\"233,156,92,52\" name=\"部门经理审批\">\r\n      <transition g=\"3,-26\" name=\"to 总经理审批\" to=\"总经理审批\"/>\r\n   </task>\r\n   <task assignee=\"cocochen\" g=\"380,226,92,52\" name=\"总经理审批\">\r\n      <transition g=\"-47,-17\" name=\"to end1\" to=\"end1\"/>\r\n   </task>\r\n</process>',10001,'qingjia.jpdl.xml'),(10003,0,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0�\0\0p\0\0\0���\0\05IDATx���op�}�����9������rә�{n��4cϴ7�47nf��I�Խ4N�H�֮�4��O6m:&m�6Q�H%�\"$�&b��P�DH%R�%JeBE�F�O	A	���\0�ş%����g���bw�@�|�̃��\0\0\0`�̾\0\0\0\0�x��\0\0\0�!r\0\0\00D.\0\0\0��e\0\0\0��\0\0\0\"�\0\0\0C�2\0\0\0`�\\\0\0\0��\0\0\0�!r\0\0\00D.\0\0\0��e\0\0\0��\0\0\0\"�\0\0\0C�2\0\0\0`�\\\0\0\0��\0\0\0�!r\0\0\00D.\0\0\0��e\0\0\0��\0\0\0\"�\0\0\0C�2\0\0\0`�\\\0\0\0��\0\0\0�!r\0\0\00D.\0\0\0��e\0\0\0��\0\0\0\"�\0\0\0C�2\0\0\0`�\\����~\Z7335 O�}dg��\0\0��Q�,5<55�D���7Bd�<%;�n�3�\0����@�ʷnݒ\Z������/��?��s������?#Cȟ�Q�z�x�����Ą�,��\0\0X��r����D]�c?x�Ͽ�nտU���o�ksg�i��Onxe��S6�S���&;�n8�f\0\0��\\FYS�<==}��M����U��g�z}����ǃ3���Av��吷T���LLL�I�T3\0\0VB.�|�V���\n��/��͇�y�c����9�9P\Z\Z�~���JNH1\0`�2ʔ�ʁ1�S��_��t����|[Y\r9P��|���B3\0\0�A.�i�,i+�����G>^\\+�!��I�TW�\\��\0�r�H�W��U��鱗�]b+k�,��J1������:f��+\0\0Xregvv6\Z�޼ysG�/����#�9a��_^�~]^B^�	f\0\0J\Z����駟޺u+���T�E������?9�﹡����	y!&�\0(i�2ʋ�Z�q�mϚ�>�ű�KcS�G�/���.����=�=�VC����Y�?���cۧ��/�i��>�oddD^�	f\0\0J\Z���Z����x����M�\'�!��՟��v�%���H�6����>ڟrZ9yoo�իW兘`\0����(#��򞎗�iݪ��&<���{E=��=P��Lz;L~���m��Jl���p%~H��}9y����~&�\0(u�2ʈ�y���D�\\��/];~q���\Zc�ո8&����؈o�?����x|{�O�Y��<5~\\N��<w�ܵk����M��~�\0\0`1�e�i�H$2>���s��>�\r���><��d�����~w�WmW���;�I>�;�Ciey�S�N��~y9yQr\0�E.����̄����ч����}?��A�������)�`P�(��*��<V��>�Q�-�����\\^�ĉ>�O^N^T^��w\0\0�\\FQ����|��v�z����-�/���s#�������zp<��]�9��zJ��Fb7mO�(\'��8v��ŋ����e��=\0\0XreD�5\n���g�/�������xЯ���s��O곲=�Emt�k��I��?�á�;�%\\.��땗�%�\0(Q�2ʈ>�{��7�xWr4������ǻ���R����6&�O>ۿK���������2\0\0��\\F�r��\'?��XM,s��ۯ\"X\nXusc2�ճ�q���}|$Y҉}���}�F^Br��2\0\0%�\\F�r����dc˿�u.���\"��B����ͭ��v��M��ݺ�����2\0\0@.��h������y�����=���[�߮rry	c\0\0`�2ʈ��������\\������)�^r��ks�O���Tl|�>����%��\0\0@.��h7�{�`�?����k��]G�\'H�����s�$�$�k&jK��QNް�n$\0���(#�ϔ�|��U�Y���7�{׉��N��_�O}6����b랒-rZ9������\0\0,�\\F�~�������#����ɏ�Lx�L~4 �Nx&>�=����geˤ\Z�-�c>Rg���#9�������\0��e�i֩�����k׮������wK�~r������$�/�g�O=H�З|�7����m��i������y��9y!y9yQr\0�E.����Ϊ��###����޷��~�H�ѩKcӗG�.�ɘ��w���z|)���ĳS�G�{�Q;�����t��.9���8p��ɓ��Bj᲼���\0\0,��lmmmU�?���[�n���W����>��돽t�p�������DN%\'ܷo_gg��\\^B^H^��e\0\0J�+����Q�E?����zzzֽ��?�x�b��W+�I�T---����əZ\0��eXS(jmm������O{JM0OLL\r\ry�^��v���^��ua�b散�r�.\'�����������%�Z\0�ԑ˰�h4���QWW��ݝu5�|����ׯ�?�����o���?��ͱ:�\\�C�@9��w�=p��JN(����K0�\0@�#�a)��f�I.G\"�yv���O��������ؕ+WΝ;\'�����T��w�����k.���e�Mv�C��{�������r9��PN+\'��`j\0�RG.����ʖ���cG[���mټ9uS.�$_���2)�q�+/3��___�t:C�Ђ;��Ϊ���Σ����ϟ���:�a�m���?�7׭���z��m�=����\r�y �FyJv��d��w����w��!9\\N\"���i���Z\0�ԑ��#{.\'��ͥm\nuH.����ZTG�_�蕗����hhh��/汱���A��������y�������}s�/�����g�ᇟ�!�O�(O����ʲ�\"��r9�\0����%e����Өo�&|�Z�\'5�9^h�dR�`.G\"������:I�E�s8�~���А�����=y�p{{����[[[���{�����S6�S���&;�!r�.\'�S��\0\0X	�\\R���(6�#�%��(�g�إ�3�ܹ�F].��fs��K9�*����7oNLL���\\�z����ܹs�N�:q�ıc��:u�O�(O����,�ȁr��D�W��\0�r����g�P���s9�)G���Ob��]�����koo���|9R�,�}�֭7n�Ai�k׮��~��w��Eo܅8�X6�S���&;�!r�.\'��\0�r���f�c�bM�C\'��rpl��-��ѣG�Rc�իW�n����$���gN�扉����������@�(O���\0����%e.�ӗeH�\Zܪb��������O���7�X�����V�b^��E���T$	��Rá�Q��d7B\0\0k#�KJ�sy���ɘ]�Rzi3�R�����>�\"�h333Q�ڇP\0����R����vY.(�7/en��v�l6��%���s\0\0\0,�\\Z������Ű��mγ�G��͛��e����M-{�^	嶶�e�>\0\0����c��)��3ǹ�zg�d(�h�}�94448�e�>\0\0@��e$͕��B9#qs�g	B�PSSS}}���_��\0\0,����D:::l6[oo���\0\00�\\��������$��>\0\0(6�2����/����\Z\n�̾\0\0�,�e�#��FGG;\0\0\0C�2VZ(jmm������7�Z\0\0\0@.c�D�ю�������n��\0\0 \'�2V����l����\0\0(!�2\n������;�N��\0\0J��\Zu8\r\r\r�@��k\0\0Xr�D������^���\0\0�x�2�Y4\Zu�\\6���v�}-\0\0\0KE.c9�����յ���}>\0\0`\r�2��իW�n����;\0\0�eC.c���������\0\0���e,^$ioo��|\0\0���e䤯�o�Ν��n��f��\\�h4j�\0\0������VUU���|����z%�����>\0\0�<r�&�����{�嗷l��p8�>\0\0(�2��F7m�T���s�mܸ��\0\0X9�2��p8*S���k����\0\0X!�2}����/��Bmm�]��o�n����_��ՙ}i\0\0\0+�\\�!�d��W_mhhp:������p\0\0�r\0\0\00D.\0\0\0��e\0\0\0��\0\0\0\"��6;{��3��8{*j[e���-E>�v�u>�p���O͘��\0\0�r9�7��n:y�\r��R�w��\rO��Y\0\0�r9W�.ߪuvU��T5�o�9�����37#��y���p�6~��۞q��Κ��\0\0=rya��O8�*4�}�g hz/zx�&z�z/�qp�Ɣٟ.\0\0@Q#��Z��Ƿml�`z�.�|�ZRRQ��3\0\0�<��ػ|��%1M��e���Z[�t�I�?c\0\0��E.�����j�-G.���>��\r�Ȼ;50f�\'\r\0\0P�����el:hz�h�o�QK2���\0\0��l(<5�&_K��}��3j���&�\0\0� �\r5��Wӣ��c��.y�������\0\0��ˆ��cY��1�h:�;=(o�K/4��y\0\0#rِ�Q��#s�S�6W����y\0\0#r��~�(��4�h=�m�?o\0\0�bD.R?}W��qM.\0\0�lH��b�����3c���v��-kW7�Ol�j+jj�+�Rw�u�Ꝛ�y\0\0#r�P!r9��k.mS�Cr��vgME���z�^_\"����L.\0\0,\r�l(�\\�N5V��m����B�$��\\\0\0($r��bry�SSf��3�);˖,T�氏t�<3��2\0\0�2!�\r-.\'��Si���O���]\0\0(8r�Pac�ZS�i�g|���iܻ˕�ci�\\\0\00B.*�b�x\n˃�{W���\Z��O���kty��2\0\0�2!�\r<�矁^`���e��]�Y�;H.\0\0,\n�l���1\n0�,�,Q�z�ڊ�7�#�\0\0�\\6T���]R���./�O�����eT�;�L.\0\0̃\\6T��)��3ǹ�zg�d(�hN�o�\0\0�8䲡���Bc.��v�Q�y��>�1�e\0\0\0#䲡��r1\rr\0\0��lh�:�D�wh��-�P����\0\0��ˆ�vJD�6=g=�m��d�ٟ7\0\0@1\"�\r}k�!��-G.���\'.��ۼ��=f�\0\0\0ň\\6���t�Co2�h:ַ���\\kw��y\0\0#r�Х�I��;��	����T5��|��ٟ7\0\0@1\"����%%���mz�h�<�7�j���Ԍ�6\0\0@1\"��sj`LM0��4fz�.���=16u\\0��\0\0(R�����a	�/���bK2�O�TԶ�[���9;k��\0\0P�����f���zv�g hz�.��T+�Zg�42i�g\0\0P�����\'�y�Yݜxc��cw�cO�_����s�ʘٟ.\0\0@Q#�s�5�P�6�j�y}KOɭf�Mn8pV�C��\0��\0\0\0\"�s5;{��̠���M5�4m���k~�gsY��t:��ۃ�`�?]\0\0�\"E.�G*�����U��w>������t�r�g������lv����D�т~�\0\0\0E�\\������Ngmmmkkk 0�r\0\0\0V��\\E\"���������:y �}E\0\0\0G.#o������555MMM���f_\0\0@��X���^��n���F \0\0�*rK�7\0����X6|#\0\0X��e�7\0����(�\0\0,�\\F��@\0\0P��e��\0\0J����7\0@	!�a�\0\0J���@\0\0P��e�y�x�ڵ��z�h\0\0���e���|��*++���(f\0\0���e)��۶m�L��\0�\n#�o��TV��%�;�YK���ئ��؎i6�;�v�쯡�Ҳ9�D���!sgO{F=���\\�����������?���(f\0\0���9���o�Q�<�Q\Z��Gu[��)����3j;�uo��ۼ�r��pd~���j^�<;{��3��8{*j[e���-E>�v�u>�p���O���\0\0�V.k����=�����%Eǲ��N��.���.�&��ѺC7=�q���[�f�o����\\�1�t��;�l0���2����ox��5\0\0Ȫ�s�v�a��83�\r^-���loʄt�b��f�3����K����E���-���[�ή����-=z?�q}r�f�v1u������x|�3Ξ�Y�?S\0\0ʏ�r9m�~7{�f�whi����h݅sy�<��o�O�j+(R.�������c�.\"�b��=ʞd��\n��_���^��ޡɇ�<���o�1e��\0@y�T.�g�Sfw�L�\Z�A[`�\\!��b��rNIs�K�0��_���]NY���b�	���x|������r�7�%%���1\0������+��g\"}.WHM��\rY^-�T�� 2V8g.y^hv9�|}�o�]>�ʒ��g�2�@P�-y��ٟ1\0\0e��s9e�qj�\Z�g1�쟥w3����і~�2�l���[�\\�VM���E�w�Ǒ�a��\0yw���#\0\0V�Us9�����/rr�8��ٞ���D&g�Y.�\r�v9v��V��1��MMO���-=jI�ٟ4\0\0��Z���f�ϊd���ch����)���}-ٮ\"k.�5��Mi[�Fry	Oͨ�ג�n����䌚>?}����\0`Y,��3�b�,�h���V�ٖYT�}��`��Y�3ź/�.�����E�)��y5=j:V�풷��oz���\0(e�˰���XGV�zL/ڂ��N�����f�\0\0�r֡~��b7������U��f�\0\0�r��5JGz�&M/�B�D���\0��@.�:�O��o\\��\0\0�r֡rY���55]�?/�]]���mڵ���%��+ҭnJ誝;I�g5kj��d�(�X9d�^_��u֬�uY]�v�jK�P����\0��@.�:t��%���NDjW�\\�f�Q_��d.k;��:�*Z}�j;\'_\"�ڙǦJ^�\0@�!�a)�˗��NN�&��r\"�;kԌ����s�U�u9�~�.���.�������M~�nܛ��)�L.\0�b�eXG�bU��R\n�˙=_.�&�S&�+�\\hv9��+�׳nvYY�:vBm��\0�J#�as��_O�M���J.w6��UӴ���yu[-�7�έ��/���k0�l0��`1F�v��2\0\0+�\\�ud~�/e\\֭]��hN�1���PN�⍇r\"ds�]֯���.�R\'^%�br\0\0s�˰}.�b�ȩS�s�{V�7�\\N_a4����9e��f���|�\0��B.�:�ry.��ze].�o��C��һZIg�9�\\k���a.��\'�\0Xa�2�#�\\N�9^��-�ȶ�#��{j��[}��.g��X+�^���� �\0Xy�2�#��6����N�eWmZ�\Z�r^��ڔ67�\0�L�2�#����<w��x��SX��&�9]�����\\���Fr*���S�YgNB��\0\0�rֱ��1,4�e\0\0V�� �\0��#�a���%\"�C���l��z�f�\0\0�r�qo�S\"�H߰�9[�!o��\'���\0(�2��[[IGn9r��-�8qiL��]��1��\0�,�˰�M�#z��E[б��G��Z����\0��@.�:.�LJG���6�H��-ܸ��Y���g���s�ײ��������?��-}�^���Ҳ�2]�rH�k�]���Y.\0�L�2,�7JJ�G���-��y�\'op�:�ͩ�?��5ij:�>)C8y��sZ�f�*���2\0`q�eXʩ�15�|�Ҙ�i��#�R����qa�?�X��3��\0��d	h�9e�X��Y�$�睠��u�n>z4#��f\0�|�eX�w�:,A���5ZlI��ə��Vyk�V;ggW�c]L.Ű:�n�wn��ˤ�����3��K���͉���\0�\r��	Oͨ;�����@���]�N�V^��~idr�?մ�a�L�Ak.��s�\'�o�O�j+(R^������f�u��m1F�\0\0dC.Â|Ó��ЬnN����鱻ı�ۯ�`��9uŤ��M¦�\0g��{b��ɤV園ݺ��0��_���]NY���b�\0���˰�𭙇�aV���[zJn5�whrÁ��>2�?\0L�WN�������Xp1F�� 2V8g.y^hv9�<_�\0,�˚���zfPZY�\Zj���G�5��۳&�W��;�o����os��Yz7c�XW���9�.����\0�9r\'��|ڿ��*�P֏;�lxd��w�|Eqϸ|c�(�}�O7�k��ٺ5�əw�K��<�.�Zy��=���\0�� �$M����Bm?}���*k���9m�:�+d��f��)mn$\0X��p�WP��+Ӣ�p9�<�d�\nϳ�#yS�d�MJS�\0\0c�2`N���vG�Q�/\0\0� ���mmm����P���\0�\n�e�j\"����fkmm��6�r\0\0(m�2`M�h���[����)�}9\0\0�*r�������������~��\0��C.e�����v�f��c��\0\0PJ�e����i�ٺ����\0\0� ���[[[%�;::\"��ٗ\0@Q#��2\n�$�kkk��ڸ�\0\0F�e��E�Q��m�ٜN\'7�\0\0 � ��������v��o��\0\0PD�e\0s���\Z\Z��{{{;\0\0�� ] hjj��l��h\0\0�� �`0��:�r���\0�l��\0�\n����%�����ٗ\0�J#�,,������Z��9::j��\0\0�r�e\0y�x<uuu��h\0\0�� o^����a�֭���k\0���e\0�t��U�án�a��\0\0P(�2�%Q7Ш��u��i7иv����۹�\0����\0�A(jkk��l����\r4�x��{n�ܼ֭\0P��e\0�&��\\.�f����z+㪫����;4\0\0�\\�̢Ѩ�㩪��Lڰañc�̾.\0\0�\\���]�V�J�������\0 o�2����oTf����\'N\0\0%�\\�����2sY���f_\Z\0\0�!�\0\0\0C�2\0\0\0`�\\P�fgo�f�gOEm��?\\���ǽ�N��\'�w�|��??\0�� ���SO7�����x)�;���\'��,\0KE.(.�.ߪuvU��T5�o�9�����37#��y���p�6~��۞q��Κ��\0��\\P,$+�p�Uh���~�@��^��M>��!�^x����)�?]\0�\"��\0��j�;߶���齻\\��jIIEm+s�\0P��e\0E���S�,�iz�.���ڒ��N��\0�\\`�k�ê)��hz�.�8�7,� �����ٟ4\0 o�2\0�el:hz�h�o�QK2���\0y#��,<5�&_K��}��3j���&��Đ�\0L�|ʯf^M�ڂ��o��m>���?o\0@~�e\0&[k�udU���-�x����/��l��\r\0���d�G=,vC��N��\\��n��\r\0���d_�Y�t�wh��-�PK����\0�!��L��]���5�\0�\\`2�����vu����q��O�CEM�<�Wh��V��H�y��f�/��:k��,��+j;c[�v�Q[Ꝛ�y\0�C.0YN��O��t���� -�U��3W۹�Zq\"�3�M��gr\0�\n��d��<�L�,���B�]��Yg�e�\\[g�x[_޻:y��ƽ��@7��\0P��e\0&�!��6�6���$�[>kⴆ^hv����,�P֮��0���.f��j�e\0&[j.ϭKN�mgM,aw5�έ���\nW��5�]�w&[��9�b��+.��\\�RD.0�2,�H&u<�S�xc���f���1���=�r<�br\0,�\\`�%/�XxDꬰ����Xhv91K�W�\0����\0L��1nF�nW��һZIg�9�\\k���a.�\Z����2\0�\"r���e��Z(k��M�\Z��B��k��B���.g��X+�^����o��\\�RD.0�|��5qڼ�l��kl�X�iz\n�岫6-y�s9��emJ���e��\0L��b��s���N�f�oγO�p�ɩˈoO${b\rF�$4�\0�@.0Yk�K|��\0P��e\0&#�\0Ō\\`�U���ޡI�s��C�S�?o\0@~�e\0&���)y�o��-��y�\rf�\0����\0L��-��#��hz�t��4&o�g���y\0�C.0٦�ґ�y��-�X��#os��e��\r\0���d�F&�#�x|�$lz�n�S�,o����f�\0����\0���%%���mz�h�<�7�j���Ԍ�6\0 ?�2\0�\ZS�\'.�����>�)uO�M���\0y#���uX��?k�ؒ��3�����v�Κ�)\0�G.(\n�uG���������2�)�ʫ��/�L��\0�\\P,|Ó��ЬnN����鱻ı�ۯ�`��9ue��O\0�H�2�\"�5�P�6�j�y}KOɭf�Mn8pV�C��\0��\0P��e\0�ev�v�Aie��j�i�\"����oϲ^\0J��Ie6�����J\"����\'�~��.��\0k �\0\0\0C�2\0\0\0`�\\\0\0\0��\0\0\0�!r�\n�z����f_\0\0�!���r}}���5�Z\0\0�����~�\n�@ `��\0\0��2���Pn�#�\0%�\\�̮^��BY���k\0`��e\0�&8��[��\0\0� �,����^���k\0`9��\0�$655�\0\0�\"�,������l���f_\0\0�B.�[(jmm�P�x<f_\0\0�E.ȃ�r[[��rww���\0�J ��$��Pv���h���\0`���\0 ����A(\0������<6�r\0\00������G�V�%�Ѩ��&�\0 ��◞�cG7WV���ŴPnkk#�\0 ��%�uk��UG���rsKK�^���[�r(*��\0(=�2�+��{]��#����J(\0�G.�W���k|��~C���d\0��նk������ez����N�3.�)\0�rX]��jM��G��)��\"[�E;.��p.H.{�������&B\0\0#�2�sٚ��nf��}��2N92�G�ٖ1�\ne���p\Z\0\0��\\� �\\Ό��e�߿u�VB\0�����C��\"Kh\'�Я��OJ/C.K(7�]�z5�C\0(_�2����v�}9��WE��I�n�\\֯��|��g���\ne)��\"\0\0�\\�LB��p����\0\0,�X���\ne��k��\0\0P��e�j����鬫�#�\0X:r��6����}-\0\0X�XA(jkk#�\0Xv�2PڴPv��f_\0\0D.�*�����P�F�f_\0\0�D.�GB���CB��r�\0\0���c��D�ٗ\0����@i�Pv�݄2\0\0+�\\���mmm�P���\0����@Q�x<�2\0\0&\"��\"�B��t�\0\0��\\����U�;\0\0��	���z��A(\0P$�e�(����Pf_\0\0�C.&���\r\r\rv��P\0��ˀiT(y`��\0\0���e��@�n��\0\0?rXQ����������k\0\0#��U({�^��\0\0�\\\nNB��t�l6B\0��C.\n�T({<��\0\0,���r[[�\0@�#�Qf\r⵴Pv���h�/\0\0V�kR5�i��̌d�t�(O�}���#�HGG�\0���˰\Z-�%X���N���m��_��xs�\Z����O�����[�T:��}}};w�c�-Z(˿�2\0\0VB.�:�P�J>��q�Ï��������׬C�z�ߖ�\Z\n�B���͹D���hUUՋ/���ȟr���R��h\0\0`\r�2,B��$oǛ����e}��7g����>&Cȟ�����^�<62�͙�\"A\\SSSW[[{��A	���vB\0\0�\"�a������򾯪~�s���5gv���L���]����U_����c����Ҿ��ә�,�iӦʤ�{nÆ\r��Y�\Z\0\0�\0r%O��G��T�>�������z>ʬ��!��}LQ�Ї��=22211�3���pT�z�׸O\0\0�F.��i������}u�+�P֏�G����ڇv���`Z1����UUU/���Ν;�o�n����_��ՙ�\0\0�\"�Q�T+���C����v֥�9��o�b>����bVK�_}�Ն��������x�~��f��\0\0\0\n�\\F���+���wK�ھ��遁ŵ�\Zr�+�?��=�>ܙu�\0\0�r�J�5��E�������F�H�Ɏ�W��Ʒ7���\Z�G;QW�ug9I����^������W�F��2\0\0�\\FIRS�^�(i��?�Ӭ땥}��������-�y��JN(;����~�dd$\nݺu�	f\0\0�����~�D-�x��?Ϭ��������o|;sZ�剧Ԓ���O˙��c���n�l��\0\0+�\\F�QSˇ�CE��ީK����A[.�����}5�p9��\'��7�|�@ 011�3\0\0�\\F�f�F���}]����c7ΟO/\'�$��ޏ�r�s�?�&v[����s���\'��e\0\0�\r��ңVb��ǝ��\n��{��������ʫ����&�&���sf�;�r=]\'|>���p(R��0��\0�E.��H�~|�����#G�������\\�?�X�y����_��\Z\Z��c���\0��\"�Qzfff��n��}�o��Z����ߦƉ��E�����;I򄿌��p����1��~�\0\0`E��(1j�rǛ��}-.���~���/.�e��J������Ϝ9���Y�\0@y\"�Qb�V���m�&-���G?޵K?���E��Z����U.�>}��󍌌�_�#�\0(+�2JLZ.{w�Џ%��Ti��}ۏ\\\0����(1�\\�{�[i���F7�N�-� �\0(g�2J��e�~i���U��SU}�+?��R	�\0@9#�QbT.��<�����b��P��H�E�H�_����F��rZ�Fr�2\0\0�\\F�Q�W?Sr��>�~ɋ����ﾫ?������8t���\0P��e�u#9)�W�P�v�#k�ݱ�����ߚ�:��G�O�ϯ;���[~T���;v��\0P��e����)׶�7K�>��?uw�8^?|�}?���9�����7Υ.\'��Q����/$���\0\0�����駟޺ukxhHZY�����9u�R���Vy�}�rlr��Qڱ�GS!���v��I��ˏ`\0P��e����ɽ/n������`{���`ڸq��<����>QW�y��J}ɯ���<v��{~�2\0\0e�\\F�і/���w�vo�����s�3�WEsG�+�G�x��jHC�ޱ+���Ϋ9��w}��С�\'O�Wb�p\0�2D.��H��	扉���jI�+�?8=0�5�sr�K_�{�c��������Jr\0�rC.�$I�NOO������㻛�M�l_������r��Ն��Qk�VV����ey9Vb\0\0P��e�$m�9\n���~g�*�ʻ�:�ʷ����&��;;;�2��/\'�V-3�\0@\"�Q��\n�H$2111<<,ŬVe���t�#k��2���3����n��oe�\r?9����\0([�2J��`VK2��` 8}���V7���q�Ï�ޱk�ҥ�J���������[YN(�Ֆa��\0\0�\'r%,��/���}q��7J$�����W�p�#kd��S�d5���_t:�nG+\0\0=r�-�����Ξ>��I�UY�<��W�~�/�ookS_�;s�����$�2\0\0P�e�<}1OLL����|�s��u��������͒�ڐ?����d�A���T��p9	�\0\0rV�s$	�B������*�/��I\n��;����S��\ne9D���$�2\0\0P�eX�*�h4\Z�}�pX�桡!I၁���ӑ?e�<%;�PV��r���V\0\0\n�똍K�f���ׯK\r��\rǩǲQ��d��P��\0�B.�j��<==��Y	�heٍP\0\0Y�˰&-���̌J�4�Q�R��\0\0 +reaր��\0\0����5]b�V\0\0\0\0IEND�B`�',10001,'qingjia.png'),(10009,0,'<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n<process name=\"forkjoin\" xmlns=\"http://jbpm.org/4.4/jpdl\">\n   <start name=\"start1\" g=\"270,8,48,48\">\n      <transition name=\"to fork1\" to=\"fork1\" g=\"-53,-17\"/>\n   </start>\n   <end name=\"end1\" g=\"276,404,48,48\"/>\n   <task name=\"task1\" g=\"129,137,92,52\" assignee=\"张三\">\n      <transition name=\"to task3\" to=\"task3\" g=\"-53,-17\"/>\n   </task>\n   <task name=\"task2\" g=\"366,146,92,52\" assignee=\"干露露\">\n      <transition name=\"to task4\" to=\"task4\" g=\"-53,-17\"/>\n   </task>\n   <task name=\"task3\" g=\"106,275,92,52\" assignee=\"干露露\">\n      <transition name=\"to join1\" to=\"join1\" g=\"-74,6\"/>\n   </task>\n   <task name=\"task4\" g=\"391,292,92,52\" assignee=\"张三\">\n      <transition name=\"to join1\" to=\"join1\" g=\"3,11\"/>\n   </task>\n   <fork name=\"fork1\" g=\"273,95,48,48\">\n      <transition name=\"to task1\" to=\"task1\" g=\"-53,-17\"/>\n      <transition name=\"to task2\" to=\"task2\" g=\"9,-19\"/>\n   </fork>\n   <join name=\"join1\" g=\"293,326,48,48\">\n      <transition name=\"to end1\" to=\"end1\" g=\"-47,-17\"/>\n   </join>\r\n</process>',10008,'forkjoin.jpdl.xml'),(10010,0,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0�\0\0�\0\0\0c��\0\0@IDATx���{T[��������u�yg2�fN��tڦ�s��9��w�g�9�}\'��N�=��mr:���IzI�\r���S_�]�X��kl�\Z;�c��2F	s1᪀�D����-KB��l��~ֳX���R�;�?�\0\0\0��?�^\0\0`k�\0\0Љ\0\0:�\"\0\0@\'Z\0\0�D�\0\0\0�h\0\0�-\0\0t�E\0\0�N�\0\0Љ\0\0:�\"\0\0@\'ZH����w���悋���42���\0=h �T�Hj���LOOONNNLLbȃ�L ���	\0{�E�T2*����\ZGk�?����Ϧ���O~�����O?�#rC�ʃ��綏�������2E��h 5\"+d<0���O~����XwǏ7��-��]r&��ص	��!w�AyJ&�ɶz��~��O�\0�!ZH\"���SSS��Y?��������k����u\'2�L&�,��g\r����BdQ�\0��E��R!233399������G��8Ab��\"3�􍾾���QY�,�`��*F�����y��ז\"jȌ2��/�������@ @�\0�ZX9#D�$D����������\Z�On����ի]CCC�\0;�E��SǈLNNf���#�ܳ�1r�g>����#��òpu���\n\0�B�\0+4??���^.���~���Շ����[��hѱ_www���ʯ�_Ħ\0VE�\0+���^�~���ȏ��N�`��2e�a�g�ܮ�����1�El\Z`U��j����D������C3��+C��2���̕�ݙЍ��Y5�+�G:�C��W�f��C���|p����ߕ�!��;88(��M#\0��Vba�����\r��z���)���!w�\'�?���������S��oNvk���i����l�+��bOO��\"6�\0�*ZX6c����-__wGSכ]c�� ?�������q����4]�G.\\\r�[\\\r���{����������M#\0,��M��;66����z����5�#�j�S�}Xn�Gj�C#��H�vx���s���w�g�]yj��CO�����Jk����W~�:�W����E�e� ���	�������>����O]�9���/��Z���.�����,<Ah��7\\�f?%!����477�|>�u�Ki\0�C�\0�677799944��\'>Xp���?4���\Z��F���|�9�H��V�w�i��n>�L,����y�^�u�K�W�~�\0�b��l�`��������uϝ�r���ȹ+Gj}�F���Z�au���e���)uW��Ɍ)�AY�W}M����v�u�ݯ\0R��M� ����g�h+:�}MFu���\r��{0|�`�������Gԃ�c��wCӇ&8y�������ϸ�n�u�Ki\0�C�\0��\"o��9�q�tǫ7ǁ��zBw�:^��n���\Z��\\��泞W#�#Ӝh�+-r�L-��h`ٌ���?>X�jρ����PQr�f�PϪ�!r3>�nf��4����ܯ<�~i���6Z�U�\"��-���?��ȿ��+�^c��������\Zc�3�&S㵈���x��\0k�E�e3Z�?����\'��ڮێ`��H��#�,�?�>\Z\0�F�\0�f��S����OG���l��k���xs�dǚC��#<��?�T��[]]M�\0�0ZX6��}\'����?������ʛ�1[�?o>[�jL�_yk���I�yI�J���������c�����^\0F�\0�f\\����~?�r���{_��¸ua��۟���pU����Y���>y������\0�E�e3�����^��w�߄7n|7ޅ��иy7����B#�����Sφr�{���,�������k��0ZX6��z{{]��l��Dõ)w����ym��养���S�\\�y��iԃ���e�?����e��9s������`a��l���ꐑ��A�������T���t�^��2,c�3�s�shV�����\\xv��Px��,j�и�U��~���ƺ�Ǐ744ȯ�_��_���@��\"�J���ׯ_���===.�kC��y极�v�\\�*��t�#�|~C�W�=z��Y��\n�E���(��h`%\"7�x�ަ��u���m_��#W�\"On�����ȑ#\'O������(��h`�Ԧ������>��]�P!\r��3�T����-\"�n�Qf���~�\'N����be��+�(��h`�Ԧ����������K�.�;wnc�W������h�-\"�Ȍ2��Ç�?.���be��+�(��h`��}�����������W����JC�){�ٟ��������s�D&��db����G�9q�,D%�����W�Q���\"����ϫ�{���А�åK����N����l��7������u˾o���;�;vm�-Cn�]yP��	d2����G��<yRf��Ȣd��Xu/E\0X-�Jd�www���3g�?~�@Ŧ�=�x�����O~�����O?�#rC�ʃ�LPRR\"\"�,2��.�E\"\0l�V�ȑ�����Ѿ�>���r�\Z\Z\Z$/***�;VVV&���o�&7�<(O�2�L,�Ȍ2�,DE�\0�	ZH�#���SSSccc���===�����������������L�+�S2�L&�,2��.Qǈ\"\0�RC�H0�~���Ą������|^�������n˃�L ���2��(��B\0�A�\0�U$ccc###CCC�1�AyJ&�ɨ\0�E�\0�g��������䤤F �<(O�2��h ]T������\"�)5\r��h ����$At�\0�-dT~~���׽\0`\"��Q�\0D�E��*,,���ѽ\0`\"��QEEE>�O�Z\0���\"@�����8��q�w8�gU�\0�B��������;K��)--u:�+X1\0�*Z���E,��(��)�~�%��dE�;�q;���߸�/������^�\0+�E`Y�!����7q��2l�u\0�E`Y�k��Y�X���K�:\0�	-��d��>��oq:������\0l���%8�#��K/�l�A$q��(�\0D�E���x<�C�Z\0���\"@F�|���\"�k\0&B�\0���SXX�{-\0�Dh ��~~~��\0\0�E���E\0 \n-dT0���ѽ\0`\"��i��+\0��E�L���	���\0̂2-??����^\00Z�4Z\0\"�\"@�����^\00Zȴ��\"�ϧ{-\0�,h ����ѽ\0`��i���N�S�Z\0�Y�\"@��\"\0�2������Z�Z\0�Y�\"@�U��^\00Zȴ��ꊊ\n�k\0fA�\0��t:KKKu�\0�-d\Z-\0�h s�~����^)\0Ќ2g����!����^)\0Ќ2���޸q�\n����={�p1x\0�E��ھ}�j����\0n�\"@�9��\r6�illԽ:\0�-d��͛%G������u\0�h �N�8���U^^�{E\0�h ӂ��ƍ���\0S�E\0\0�N�\0\0Љ2j>���q�k\0\Z�\"@�\n���x:ē����9U$��\02�2�f�t���v~B�ޞ�@ 055%EB�\0�\'Z�\"##^	��;>�gۇeȍ�^�x������H����� 9�nh �bC���o/��7r���ahhh||�`C��^�!\"2:v��NM(Gv�rdώ��쮓#G\0�\r-�Q��\n���w[-9��h ]�\"2�N��D��D�h8J�\06G�\0i���QCm !G\0�-�ޢ�f�!2vs��j�M˅ߒ#\0�R,�Y3��f&\"B���\0{�E�T�\r��FF�F�Uぺ�o���Ww�2���`7��2�!rޙ;4|Jƨ�\\h����-�ܺ���踼{�)�95��B�\0�ZH���oȽ6p\\���ic�_�%�\Zc���T\Z���}B���\0�A�\0)\"\ruٽ�e�}G�����D�lk{!�Ed���i���Kf\'G\0�-�Vl��֭��-�u�HX\\�\r\r���E�sQ-r����F��kGռ�r��\"��Ć�ٚ_]����#����hq�F�H���W\"&�\nO��,AE�\0�<ZX���:�d���Ѿ_b��+���n��iϕbc\Zc����E��\0�F�\0+�Bdt�3\"D�]�\\$C\Z�gN����{\'O|W��C�W�ZD4�Ls��W�Bd�����F߹�9Y�o\0�-�����/2DZ�~�jݭBF[���s�F�G�Q���D.A(�Tź�o�\r333�#��\0X-ZX���3/��������Emm/ɐ(��n,+DT����%�)����U}}}~�jj*�~\0`�h`��E:U�T�~Rm�P�B�&\r5V�]$rӈ�S#-��X���el\Z��6\0�j�\"X����>��0Z�8}FՃǳO�~��E��E�CF�j�E\Z\ZNtvv����\"\0,�A꭬V0W�,�J:H�H\n������x�H�ל[�B��~�9��S\'4F챫��ʨ�[u*�,��3Uo�\\.˴H�^Y7iY%\0�G� �4�Ȋ�\n�	��F���o�����.��.1.�nǽ��zָɕ�UF�EJd�F�TVinn�t�R�����y�l�A�����%�77���\"��Λ�	�SSS~�����ȑ����ޒ�ޒȫ�����\rׅ8�]U�v_;jL�.�j|1��ȩS����].�����������E�z�}�,�#�犻1?���6???77�6�\r\r]v�9rޙ��\"�f�\r{��v����d�}Ge_�k�HKKKGGGOOO�����7�Nh�^JZ��\"�Oq?�/\'M�EFFFN�:URR2>>.}�n�3r�y~���ޑ��	��WF�����j.�=6D��ۻ��3s�3�%\03�E�zi�K�T��Z:������0??_ZdxxX�ʑ��\Z>%c���wG�Ⱦ���Ϫ�e��y�W�;���og�\Z�\Z���AZ$��Y�\\ƃ�ݍ�1r�\\����-++���q�J�R�s��Q��x���@��gn]�cjx<�B�7�ϑ�*2K�-\"mmmG�y��g�z�-�ߟ�/����`C��4��I	ɑ�g��ŋ�F����hRc��ω��e�ߩ�id��fd����ɓ\'���e}�H����e�Կ*\0�C�\0�����J��/,,lll��Xl��sĈ��ۣɅ��kfvvV�GVLڨ��?��	\0�-D�I_PP ��\"In~X2GB[>ީ��}�H(D���SɇH���%�YTT��x��~\0@z�\"��������⼼����loHf�dG�v��de!b��|�C���t��\0���E��gyii�$ȡC��n�j��II�$��U���������\0�Z�%����]TT�t:�,I��jv�$�����˥�*++�@J^\0�-�1پ}{uuu:�FI�ؑt��AfTG�f�t\0X%Zv!�N�s5��,˒9��1��n��hX���)--��͕��<dY�H��#D\"q�\r\03�E`Y򡮎�p8N�S�ᜋ�$�\Zg��hnn�V���HS�8��9�\"��@ P[[�=Lnh?~36G.��[.�ij<���TȥK�<����|���\00Z�������+//��u�ktKd��o���������r����t���6\0̃���v���AL{<Dd��g�����@�ܐ��`�B���6\0̀�\Zp���D�P���OP�?���b]��,�ʑ��������)���0�!w�Ay*�!b�t\0z�\"0��fee�����������۷o/((�G���#G��&���\"�8����Z\"�So�t����޼2����&�l.���iq��:����r_����;�w�gggK��Ǥ��{EE���N��a���021�ġ��>Z�=/V3����w`<ɗ,��e˖�O?�tsssZ�g�n��ۻw��T]2\0h�5�Q�c�C}�ߝ]�ԑ��k2F�禦o�y��|��Ec+�{~��7�MK��z�7n̺�s�=WVV����n�s��\r6��\0k-bj����Z�)���9����b���7�����ܷ����L������|(f�͇!�t�ۭ�Yl޼���D���Z��T���\'{�U�i��Tm)Q{���+�z�&�M�n���m���>[SS�{�\0�y��y9�*D��[{C�p8��j���\Zt��X���ި-U�#�t`�h���Tػ�ڵ�C�G��i,yu�]ú�i,�Ν;cw����rZ�ՠELJ흹o�	�ݐ��ԑ&��F�;�eؾ}{��x6mڤ{�\0�a��M�̩�k�`��ct|Nm�9�M#\0`k���4��6�Ő��}��2׿ޤ��FF��}\0�D���ÎЇtv�S{.�u�q�[^�gs8/�.lx�>\0ɠE�H�Ϣ�N����y�w�s�~��	6�d�$�\"ft�/��;w߸�������7�˶���$ZČ�_:�����-b\\�@b�����7C�R��7҈K�X-bF���K�H-bF�[�ް�����\"��%�\0$�1����\n\Z\"v��e5��0.� I����EV��ă�0.� I����E�)���i�Ս��p�\"�%�\0$�1�to�m��{d̘�A�X���$ZČ2��&vc�b[J/g���0.� I��e~�H���%��i�}\0�D��Q:��M|��bw#g���d���0��gl�1�J���G���\0�D���a��5����{�	�\"f���x��-̄��I��O�k�-bF�J�v8A�R��7҂�$ZČ��\\*ڪ.ho�ty��}�H����0�%��R}F-�-bF��}Ҫ_m\Z9�;��e޵����i�%�\0$�1��m��]\'��BZ���Ӈպ�o��9/ٗ���E�U�Ęsp\\����\'{|��ڋ!}���y�o^���~#-Lxɾt��-�\Z-bR��<!���@��bH�x�W}���̜�7ia�K�E�E\0��EL��kXm\Z����\r)��u͎�6��4҅S�$�1��tZ������S3:>�����ͥ���e�\r- I��yM�̩�{�Z�����7%��?�B�u���q��1҈�$Z�Լ�w用�pl�h��7w��`�O횑��|uX�����}\0�D������QH�:Ҵ� �O�g�_Tg�Ȑ�b��p�>\0I�Eր��e-�\"�\\\r��b&�����#b\\�@�h�5C>�K��vT��\n����{z���wm�K�H- -�d�$�\"\0҅K�H- ]�d�d�\"\0҈K�X- ��d�%�\"\0ҋK�H�����Rݫ\0[�}\0�E�kzz:77W�Z�.�d���\"����SXX�{-`/\\�@,Zľ\Z���t�\0��h�*//���ս\0\0��E���px<�k\0�;Zľ������\0\0�-bS�D\00	ZĦ8�\0`��Mq\r�@�%����h��$\Z�AaaaOO��\0�ZĦ8�vPVV��ب{-\0,��)N����֖���^\0K�E숓h`���p�^\0K�E숓h`�@ //O�Z\0X-bG�D���͝��ֽ\0�E숓h`�J�-bG�D����E숓h`�̏�N���p�6`~�����B|�G����a7�L��������j�kdk&G��Nqq���ֽ@�p*\r`r���l߾}hhH�Z\0��~I��h{	�999��Ȩ������k`Q����G6D�&G��IYaq�}<���:t�P:W\r0#vMfF��X�H�\\Q�D�M�4N��=q�6`f�H��j�$��/2�\n̌I��{I��o��\\Y�Gb�]�w��\Z���I��h�[l�ɒ9�x��G�,���~G���8j03Z$�R�\"7�m,YlKI2KS�s�\"�3�ER,M�E<��d���fjؙ����\0-�z��g,k.����FΘ`K���{�3	q�q�k Z�F8�v&!.9�{-\0�A��\'���$�%�u��8h���=؜����\0-b�DH�K��^\0�h��$\Z�Si\0s�E삓h`U	N�z�����tfd�\0,-b�D��K�l��̵�E�����-//_�*H+Z�.8����E�~I���q8+X%\0iE����>��{�%/���\\Q����\"�H ���[ի���-p6#�H�W\",�$��������ɭ>��El��<A���ȍ}Ud�������g��@z�\"��կ�E���$xj�y\reee���K�9�L�El�o�.��g,k��cA��M��q*\r`B��-p�\'@��|EEE���mh[��׀2==����{-\0܆�>N�\"����k�Z��8���p8<��\0p-b}�DD*//���ս\0n�E���h�H���eee���-���q\r������P�Z\0���>N�\"q*\r`6���q\r+??����^\0h��$\Z ��G!�i�^\0h��$\Z ��G!�i�^\0h��$\Z ��G!�i�^\0h��$\Z ��G!�i�^\0h��$\Z ��G!�i�^\0h+�$\Z`1���{-\0��\"V�I4�b8�0Z��8�X�u\0�A�XYYYYcc��\0̈���y�\"VVXX��ӣ{-\03�h*�<h+��͝��ֽ�Iq�`��e���<�k�W�L��,���p8t�`^\\�0	ZĲjkk���u�`^�J�-bY�D$Ʃ4�I�\"��I4@bS�-bY�D,��L\03�E�������C�hk�$\Z V�-bM�D$��R\03�E������D�hKy������ݻu�֪�*ݫ�GVf@�X��H��\nu�`j�JhG�XJyy�Q!999G����ֽR��9�ǣ{-\0[�E,exxxÆ\r�E����(,I\n���V�Z\0�F�XͦM�$D���\n\n\n���t�`v������5Z�j^~��\r6���K������D@/Z�j\\.�ƍw�ܩ{E��azz:77W�Z\0�F�XM0������ս\"�����t�`_�\0��T\Z@/Z��UTTp|�-��\\.סC�t�`_�\0����/((н�}�\"\0�.����^��h\0��}�v�\r�B�d����7[�S�to^�����n��{6��z���v�wrfN���Wqq���ֽ�M�\"i721�ġ��>Z�=/V3����w`\\�{	���\0\Z�\"���ޱΡ>���.y�H�q�5��sS�7�<�z>{����=?��Ҧ�y��)��JhD���|f���V}���c�.���X�p��?��z-��<121���R���WTTlڴ���`˖-��ź��Z$]T���\'{�U�i��Tm)Q{���+c�,�g�Ɋ�{�n��2�IG�W��|~ko�g�_�rz�P���H������l�E8PYY�{�\0{�ER�wtR}`�j�^)U�����5w\r�~���عs��\"{����|���Z$��ޙ�v���\ri\ZOiR{jt��@j�M�6I�lٲ%77W��\0�C����̜�l��VM<F��Ԇ��W�4����۸q�֭[9��<Z$�J�}j���bH��Ѿjy��_o��~)�m�6��ө{E\0ۡER�aG�C:�̩=�:�8�-/�9%��o e�����Խ\"���\")��f��gbG�F^����o\0��G��؝�< ��q������~\0�<Z$���I��wZ\0`�H���\n��~�\0k-�b�\0\0�B�����7,��\"\0\0�h�Ky��  �f�����E�����7[�S�to^�:����ͥ��?-��_睜����fA���	[d�K�E`B#3OjP_�v�w�����~/�h�Km��ݷ�Ƚ\"�#�A���\Zu^�-2��.y�H�q�5�?M���/\Z[q��=�)m�����Z�\")���\"Q�;Ad�,�4Zk�|f��班�o}r��?��z-��<121�����ER,�hb7�,����Ũy�O�l�h�)�]�Ԟ�{���:ۢER,��E<���������w,8��j���\Zt�ǀ�H���E��:@d���3rN/ֺ��I�����]{=�|T]P2n�\Z��N\Z�\")��1�E�Ij��};Nh�7?M�#MjO��w\ZЀI1ZH�ə9��`M��x��ϩ\r?篲i�C��-�\\I�Om3���}ZǏ�U��\\�z����4Z$���ٸ�Ƶ�]K�P�T��\r[x����.sj��>�����2?�S���2�I�{6��_�������{��|�E��o؂�2��N����y�R���o �h����V=�?r�w�˼k�A��7l��_���FuX����4Z$�vT�ɟ�v���G-�C����Z��\r[P\'�����I���qu9&����k�wg���|�b�����!ဵ�\"�w�������j������9�ګ=ŗ�##h��h��k�\ZV�F�;���iK���Ϩ3hvT��}����eeen�;�o;,L{�$�l1�3V�I��tZ������S3:>��h�gs�b��������srr����}�a5��ɕ��W+\0)A����̜:����-s��~��\n�;�9:Ǘ|�����.--���+((����������1g��~���-{�E��;0~wN������`�O횑�Ӽ�kTK�TTTH����˕���U����2�<\"�r�R�I���s�/7�6�<u�i�A����Eu֌��d��$��@���DG�*�S�\"�r�\"�5?���[BD��QCm`0��]�o]\\��`���}4�K�R�H\ns��=�\"� �%�};��D�D��>Z�ݽ���y�z�.{p�X淋$xj�yi`�h�{pW�[$�f���B�&�`�	-�\0-3b\"��E�9h�-�ch��h����-Z�6Zk{p�F�����\n���~��L�E�����U��.ho�tu����4Z��f�����ڵ�BZG}簺�����4ZV���Q�&��:�=�:�:�$/�aG����4ZVf�=8�a��P��^�4�����d�ž�:j�/[x�b����4Z�`�=8�BFG}##���N3a�`pnnN��u\\9�5Kz���4���<!���v�V{1�i�rΫ�l!��8̉����=87C�󥝟|i�]j���IQMMMI����7_��F�^�j�;esװ�4��`2���Qg��l��?�h��Zك�Bdd�+!�w��l����ҋ��uʇ����d֚�Y[��i��#��|�����N˧���<`�=5��s���K�gs����iA�\0�ރ\"-~{�|��#�\rCCC���&�	U~� \"+x�\'g��ɽw�?���ko���~��\n�;�9:����&G�\0��mNl�H������Sʑ�ٳ���u�#cccfˑ��+**Z����;�D]�c[E���X�8��S�f��4_N���9���=8qCD*DZ$6G�m�&��(��0��Ƀ�Z����QH�:Ҵ� q��?{��:kF��[D`s��-{p�\"2�N��D��D�h8J̓#���z��Z�%D�g�\Zj��G�:o}�9�a:�\"H����UN��4\Zel�b[DdL�CD\r��Dc���(Ԕ�WVr����zMTH�x�E��{z���w��m4�@V��߾\\�ۃ�讙p�����e�rᷙ̑��\n\0�h�Fo\r��1$�Gܹs�TB��=k&r��DD�9\"#�9��P�@����bLf��Ľw����n�����˫۲e���]l	�!����hը�j<P\Z�\r2����qC&�!/7GΞ=+y�؁��>\n\0Z�Y,�u8Hܹ�Y�n�H�{p�nݪ�kӦMR\0��Ć�yg���)��s�1vV~�8s�S�����Ԕ2K�9r��AY��{��rE�|ƎB����\"��vm8��MAO?��t@�d�!Rߐ{mฌ����h��K�5ƾ��4����L/3.�#rwǎje$�:��(T\06G��6�H:�4�6l�����K܈\"\ruٽ�e�}G�����D�lk{!�Ed���i���KfO�#���[�l�Z�B�-�h��H0ג���n�\rK��ASXXXPPp���]�vI�lܸ17776Dj������K$,�����P�빨��{TM�F���j^YH�ioo��Ύ\n�^x!j7\r\0d-�԰dC����������/***--���t:�>�ott4*D���ꊯ84�����]ݷF�37�E���1AWxzϕ�d	���ٴiӆ\r�lٲcǎm۶I�it�I\0���XxcF��n�:�d���Ѿ_b��+���n��iϕbc\Zc����E��r����������ԩSRE�FRH�///O����h@\"���!����\"��8s����;y���J��\"�1d��5�R\"C--6G�7�����\n�~\0 �4��E�Hk��\\��U@�hkY~������H<J^���%�e��X����@`ffFrD��\0\0!����ޙ�RBDZ��������dH��P7�\"�EԌ�rԒU�n�X˅���>��?55�U�\0�-h:�v�S�H��\'��-Dm�Pc5�E\"7��=5�\"M�]]]Ʀ�o�-�:i|5�\00!Z��h��U�>u�����1�11N��ih8���9000>>���XC\r�]������@oO۞���s�U@��b��3�|�ăƈ=v5�Y�u�N���\Z!r��u��e�����-h�Z$tz�F���o�����.��.1.�nǽ��zָɕ�UF�EJd�F�TVnnn�t�R����=�;��Kεإ�b�Z��Ї4�	�SSS~�����ȑ����ޒ�ޒȫ�����\rׅ8�]U�v_;jL�.�j|1��ȩS%���.���������`Y��ĝ+�%�\"�\ZE�\0\Z�����ͩM#CCC��uF��w檤����k��x+��h���}42Yo�Q��\Z!��������ӓ�szi\0+@�\0\Z�k�I\rLOO���K��j�q�ߪ��wd�t����=�2��Kf�\r�������t_�����ʑ`0(e066�#-~;4|Jƨ��1:.��}�?>�1�U�ˌ	B$�{e���`�%��ݨ���\"�6K�H���*��z�:-�ܺ����x��o��#�U2d�!�b4`g��S��xq���YcMjL��9q��;52�L��B��\0n�\"�v����G�l�\0�B�\0�-�#�-��Lܾ]$\"cg�)B��F�\0����Ɏ��\"j{	!`��E\0�XV�\"\0,�L$�a�\0+�E\0sI��B���\"��,�#�\0+�E\03J�#�߾K�\0X�h���I5�T�����r�:::\0k-�Wl�\\v׵\\�jj�hh8!r��%�ǣ�}��F�\"���9|���}}}]]]�arC�\Z߾K�\0X�h��FGG����֑@ ���%>��ܕ	\0k-dT�W�%�pN����T:cnnnfffjjJ�c<Ln�]yP�\"D\0�Q�-�_k,?ɯ���Q;k�9���L�K�\0X�h Z�Z$�ߕ�����ӹF\0�-�&����1j!q���������]�\0�����D��O�̍��T�nwqqq�k\0k-D[Y�Dm�HU�������.c�`��E�h��.�`���HAAA��+\r\0k-�{TG�ǋ��boGM;Y\\�`0\'\'g�/\0̌�����^\0H/Z0��0�k\0�E�\0�UTT���t�\0�-�WNNN0Խ\0�^�`R�����\0ҎL������\\�Z\0@��\"�I��n�k\0iG�\0&���;==�{-\0 �h���~~~��\0�L�E\03r:������\02��HBDrD�Z\0@&�\"������~�k\0�@�\0�3==����{-\0 Ch�t�nwqq��\0��E\0�)//���ս\0�!�`:�����\02���^طo_gggNN��u�̡E\0���\n۰a�D�իWu�\0d-��֭[�\"l޼���P�J@��\"�Y�ڵ���۷�߿���`�`P!���[VVV]]�{�\0 h�,�z�-u�ȩS�:�{u\0 Ch�,\\.����ݻ����������E\0����6lضm[ н.\0�9�`\"��ٜ��nh\0\0�-\0\0t�E\0\0�N����\"t�\0d-d�J�w������lyP�RӐ&\0�2��I�ɱ�Άf�[���r宽j�ݎs����������ׯ�.�H\0X-��Q!� 5�(�����]?{ߝ7�Go��ݟ�]_��4�@__ �.�(�H\0X-�����]{����B��G���?��3_�r�?|���#2�ܕճ2�L\\���ÃC�E��5@��\"@���t������-���?�ɽ�}��e�TG��ի���\Z�������2�%ٟ��KUgGFF�H���ggg�\0�C�\0i�B�����R���ϋ�����sW��c�q�[&s<���ڂ�N;^���$G\0X-��\"��_��x��_�<�D�Č�S��?�������t���������\0�C�\0)�B��V�\n�]_�����\r5�;:���?�9�(&G\0X-��q�ȓw~F\Z\"��:{���BD�Y�o��k��O���\"G\0X-������t�=\'��u���p���`]C�死���m_�_\rǃ��o/�;�Dkk֧�:���~�����i\0@�\0)�6�ߺM��?�X_eU���tI��8�����⣟�F��������/d�W~����\r��ׯ�i��\"@ʨ�=��OK4���_�&EwE��w�x����\'Z/E�{䧏���/67˒FFBWhU���`Uh 5�F�ӿ{�g�S�a��ř�����Cy2!�Ɩ���3^o���-���.y�����z����cccl\Z`��\Z�`0�}Mr���#�.E\rɋ$CD�7~��ۖ�zi�w\n�!�7���rEn\Z�E\0�i��\Zj�c��$Z���75��\Z�?����ǟ�^V���{�̻��Ʀ�W���}w>��?o���z��@@�P������\"@jHt��}�ݟ}b��������2�巈��G����`=Z����徾>c7��W\0+G�\0�177w�i�g�����c�q�\\�����h�;������Z��>��/���y�����n\Z�պ_=\0�-��:X�r�^i�]_��W�o��W+5���D.*�����mii��|2�h $fggO��GZ��[v��j�p���W�\"5�y����Q-r��y��;88���J�\0X�h �Z���ˑc�-���1_�E\0�]���-���oFmQ�)[��ؿ?rQ�>\ZZ�e�\"@\n�1�]�:^d5Ǯ^)�mQ�����Y�rg�\0ˠE�P-r�L�:����l�̗�c������N�	�D����9��\0ˠE�P-�y4|���mQ�Yٵή��D.Dm_y��^YQ���\0,�R@��+Y����KC���C��ЕR߉�����]V�����+�6޼�kc��ǟ��kΞ�^\0�A�\0�177\'YP���?��йڨ��U_��x���q��\Z9�Pm��n�=������k��ZH�w�}����}}�������ߣ��7�U�o������f��Ψy>�*��ر�����5�X-��j�ɱ��ozV��?�X�[�溻��Dkk�S|�>���msW��ꮨTG�<��555���\"\0�:ZH\r㐑����\Z���/L�ZcsDF���r�Vǃ�l��WԐ@9_����x�r)�3�]��[YQ�������E\0�u��\Zj����إsujO��/�?���͑�!��\"�vu=������-r��Դ��x����~c\r-`M�E���,������9W|H�ߛ���6�\Z�Ȓc�ҥ���>��?/�˗QG�E�ױ��ZG�\0)cl\Z	�����*G�>��}��,7D������{�9s��;���d�Ƒ\"l���\"@*��F������$G��\'C����_���C�������L�V}�C��uȪ,\\~G�\0�ZH%�iD��������+��>�u�̺�U�/��ՙ�����)�@]GD�Vs��\"�@Y��w�`��b�9��v�~ӳO~�S���N�������/߿�{ɐrW���4��{�ueE�:��`a��zQ9200���u���8/뗾�؟|l���S�|�_��Ɗc�ԑ�---n�[f��\"\0,��\"2G�������^o���x���Q|xۋ�Ɛ�G���6���i��S�6�Ȍ2�,�`I��.F�LOO������U$�/Kg�������dU!2��(��B\0�D�\0i�r$�.?9iI__�tFWW����F���<%�\nQ�CdvY!��h ��â�D\ncttTRc0l Lݖ�)�@&��B�%�\"@&D��쬊%�xP&�ɨ\0v@�\0�c����S]E���4T\0;�E\0m��{�\0 ������.��\0\0\0\0IEND�B`�',10008,'forkjoin.png'),(10016,0,'<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n<process key=\"qingjia\" name=\"qingjia\" xmlns=\"http://jbpm.org/4.4/jpdl\">\r\n   <start g=\"246,28,7,3\" name=\"start1\">\r\n      <transition g=\"-71,-17\" name=\"to 申请请假\" to=\"申请请假\"/>\r\n   </start>\r\n   <end g=\"226,320,48,48\" name=\"end1\"/>\r\n   <task assignee=\"#{form.applicator}\" g=\"88,99,92,52\" name=\"申请请假\">\r\n      <transition g=\"-138,5\" name=\"to 部门经理审批\" to=\"部门经理审批\"/>\r\n   </task>\r\n   <task assignee=\"jack\" g=\"233,156,92,52\" name=\"部门经理审批\">\r\n      <transition g=\"3,-26\" name=\"to 总经理审批\" to=\"总经理审批\"/>\r\n   </task>\r\n   <task assignee=\"cocochen\" g=\"380,226,92,52\" name=\"总经理审批\">\r\n      <transition g=\"-47,-17\" name=\"to end1\" to=\"end1\"/>\r\n   </task>\r\n</process>',10015,'qingjia.jpdl.xml'),(10017,0,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0�\0\0p\0\0\0���\0\05IDATx���op�}�����9������rә�{n��4cϴ7�47nf��I�Խ4N�H�֮�4��O6m:&m�6Q�H%�\"$�&b��P�DH%R�%JeBE�F�O	A	���\0�ş%����g���bw�@�|�̃��\0\0\0`�̾\0\0\0\0�x��\0\0\0�!r\0\0\00D.\0\0\0��e\0\0\0��\0\0\0\"�\0\0\0C�2\0\0\0`�\\\0\0\0��\0\0\0�!r\0\0\00D.\0\0\0��e\0\0\0��\0\0\0\"�\0\0\0C�2\0\0\0`�\\\0\0\0��\0\0\0�!r\0\0\00D.\0\0\0��e\0\0\0��\0\0\0\"�\0\0\0C�2\0\0\0`�\\\0\0\0��\0\0\0�!r\0\0\00D.\0\0\0��e\0\0\0��\0\0\0\"�\0\0\0C�2\0\0\0`�\\����~\Z7335 O�}dg��\0\0��Q�,5<55�D���7Bd�<%;�n�3�\0����@�ʷnݒ\Z������/��?��s������?#Cȟ�Q�z�x�����Ą�,��\0\0X��r����D]�c?x�Ͽ�nտU���o�ksg�i��Onxe��S6�S���&;�n8�f\0\0��\\FYS�<==}��M����U��g�z}����ǃ3���Av��吷T���LLL�I�T3\0\0VB.�|�V���\n��/��͇�y�c����9�9P\Z\Z�~���JNH1\0`�2ʔ�ʁ1�S��_��t����|[Y\r9P��|���B3\0\0�A.�i�,i+�����G>^\\+�!��I�TW�\\��\0�r�H�W��U��鱗�]b+k�,��J1������:f��+\0\0Xregvv6\Z�޼ysG�/����#�9a��_^�~]^B^�	f\0\0J\Z����駟޺u+���T�E������?9�﹡����	y!&�\0(i�2ʋ�Z�q�mϚ�>�ű�KcS�G�/���.����=�=�VC����Y�?���cۧ��/�i��>�oddD^�	f\0\0J\Z���Z����x����M�\'�!��՟��v�%���H�6����>ڟrZ9yoo�իW兘`\0����(#��򞎗�iݪ��&<���{E=��=P��Lz;L~���m��Jl���p%~H��}9y����~&�\0(u�2ʈ�y���D�\\��/];~q���\Zc�ո8&����؈o�?����x|{�O�Y��<5~\\N��<w�ܵk����M��~�\0\0`1�e�i�H$2>���s��>�\r���><��d�����~w�WmW���;�I>�;�Ciey�S�N��~y9yQr\0�E.����̄����ч����}?��A�������)�`P�(��*��<V��>�Q�-�����\\^�ĉ>�O^N^T^��w\0\0�\\FQ����|��v�z����-�/���s#�������zp<��]�9��zJ��Fb7mO�(\'��8v��ŋ����e��=\0\0XreD�5\n���g�/�������xЯ���s��O곲=�Emt�k��I��?�á�;�%\\.��땗�%�\0(Q�2ʈ>�{��7�xWr4������ǻ���R����6&�O>ۿK���������2\0\0��\\F�r��\'?��XM,s��ۯ\"X\nXusc2�ճ�q���}|$Y҉}���}�F^Br��2\0\0%�\\F�r����dc˿�u.���\"��B����ͭ��v��M��ݺ�����2\0\0@.��h������y�����=���[�߮rry	c\0\0`�2ʈ��������\\������)�^r��ks�O���Tl|�>����%��\0\0@.��h7�{�`�?����k��]G�\'H�����s�$�$�k&jK��QNް�n$\0���(#�ϔ�|��U�Y���7�{׉��N��_�O}6����b랒-rZ9������\0\0,�\\F�~�������#����ɏ�Lx�L~4 �Nx&>�=����geˤ\Z�-�c>Rg���#9�������\0��e�i֩�����k׮������wK�~r������$�/�g�O=H�З|�7����m��i������y��9y!y9yQr\0�E.����Ϊ��###����޷��~�H�ѩKcӗG�.�ɘ��w���z|)���ĳS�G�{�Q;�����t��.9���8p��ɓ��Bj᲼���\0\0,��lmmmU�?���[�n���W����>��돽t�p�������DN%\'ܷo_gg��\\^B^H^��e\0\0J�+����Q�E?����zzzֽ��?�x�b��W+�I�T---����əZ\0��eXS(jmm������O{JM0OLL\r\ry�^��v���^��ua�b散�r�.\'�����������%�Z\0�ԑ˰�h4���QWW��ݝu5�|����ׯ�?�����o���?��ͱ:�\\�C�@9��w�=p��JN(����K0�\0@�#�a)��f�I.G\"�yv���O��������ؕ+WΝ;\'�����T��w�����k.���e�Mv�C��{�������r9��PN+\'��`j\0�RG.����ʖ���cG[���mټ9uS.�$_���2)�q�+/3��___�t:C�Ђ;��Ϊ���Σ����ϟ���:�a�m���?�7׭���z��m�=����\r�y �FyJv��d��w����w��!9\\N\"���i���Z\0�ԑ��#{.\'��ͥm\nuH.����ZTG�_�蕗����hhh��/汱���A��������y�������}s�/�����g�ᇟ�!�O�(O����ʲ�\"��r9�\0����%e����Өo�&|�Z�\'5�9^h�dR�`.G\"������:I�E�s8�~���А�����=y�p{{����[[[���{�����S6�S���&;�!r�.\'�S��\0\0X	�\\R���(6�#�%��(�g�إ�3�ܹ�F].��fs��K9�*����7oNLL���\\�z����ܹs�N�:q�ıc��:u�O�(O����,�ȁr��D�W��\0�r����g�P���s9�)G���Ob��]�����koo���|9R�,�}�֭7n�Ai�k׮��~��w��Eo܅8�X6�S���&;�!r�.\'��\0�r���f�c�bM�C\'��rpl��-��ѣG�Rc�իW�n����$���gN�扉����������@�(O���\0����%e.�ӗeH�\Zܪb��������O���7�X�����V�b^��E���T$	��Rá�Q��d7B\0\0k#�KJ�sy���ɘ]�Rzi3�R�����>�\"�h333Q�ڇP\0����R����vY.(�7/en��v�l6��%���s\0\0\0,�\\Z������Ű��mγ�G��͛��e����M-{�^	嶶�e�>\0\0����c��)��3ǹ�zg�d(�h�}�94448�e�>\0\0@��e$͕��B9#qs�g	B�PSSS}}���_��\0\0,����D:::l6[oo���\0\00�\\��������$��>\0\0(6�2����/����\Z\n�̾\0\0�,�e�#��FGG;\0\0\0C�2VZ(jmm������7�Z\0\0\0@.c�D�ю�������n��\0\0 \'�2V����l����\0\0(!�2\n������;�N��\0\0J��\Zu8\r\r\r�@��k\0\0Xr�D������^���\0\0�x�2�Y4\Zu�\\6���v�}-\0\0\0KE.c9�����յ���}>\0\0`\r�2��իW�n����;\0\0�eC.c���������\0\0���e,^$ioo��|\0\0���e䤯�o�Ν��n��f��\\�h4j�\0\0������VUU���|����z%�����>\0\0�<r�&�����{�嗷l��p8�>\0\0(�2��F7m�T���s�mܸ��\0\0X9�2��p8*S���k����\0\0X!�2}����/��Bmm�]��o�n����_��ՙ}i\0\0\0+�\\�!�d��W_mhhp:������p\0\0�r\0\0\00D.\0\0\0��e\0\0\0��\0\0\0\"��6;{��3��8{*j[e���-E>�v�u>�p���O͘��\0\0�r9�7��n:y�\r��R�w��\rO��Y\0\0�r9W�.ߪuvU��T5�o�9�����37#��y���p�6~��۞q��Κ��\0\0=rya��O8�*4�}�g hz/zx�&z�z/�qp�Ɣٟ.\0\0@Q#��Z��Ƿml�`z�.�|�ZRRQ��3\0\0�<��ػ|��%1M��e���Z[�t�I�?c\0\0��E.�����j�-G.���>��\r�Ȼ;50f�\'\r\0\0P�����el:hz�h�o�QK2���\0\0��l(<5�&_K��}��3j���&�\0\0� �\r5��Wӣ��c��.y�������\0\0��ˆ��cY��1�h:�;=(o�K/4��y\0\0#rِ�Q��#s�S�6W����y\0\0#r��~�(��4�h=�m�?o\0\0�bD.R?}W��qM.\0\0�lH��b�����3c���v��-kW7�Ol�j+jj�+�Rw�u�Ꝛ�y\0\0#r�P!r9��k.mS�Cr��vgME���z�^_\"����L.\0\0,\r�l(�\\�N5V��m����B�$��\\\0\0($r��bry�SSf��3�);˖,T�氏t�<3��2\0\0�2!�\r-.\'��Si���O���]\0\0(8r�Pac�ZS�i�g|���iܻ˕�ci�\\\0\00B.*�b�x\n˃�{W���\Z��O���kty��2\0\0�2!�\r<�矁^`���e��]�Y�;H.\0\0,\n�l���1\n0�,�,Q�z�ڊ�7�#�\0\0�\\6T���]R���./�O�����eT�;�L.\0\0̃\\6T��)��3ǹ�zg�d(�hN�o�\0\0�8䲡���Bc.��v�Q�y��>�1�e\0\0\0#䲡��r1\rr\0\0��lh�:�D�wh��-�P����\0\0��ˆ�vJD�6=g=�m��d�ٟ7\0\0@1\"�\r}k�!��-G.���\'.��ۼ��=f�\0\0\0ň\\6���t�Co2�h:ַ���\\kw��y\0\0#r�Х�I��;��	����T5��|��ٟ7\0\0@1\"����%%���mz�h�<�7�j���Ԍ�6\0\0@1\"��sj`LM0��4fz�.���=16u\\0��\0\0(R�����a	�/���bK2�O�TԶ�[���9;k��\0\0P�����f���zv�g hz�.��T+�Zg�42i�g\0\0P�����\'�y�Yݜxc��cw�cO�_����s�ʘٟ.\0\0@Q#�s�5�P�6�j�y}KOɭf�Mn8pV�C��\0��\0\0\0\"�s5;{��̠���M5�4m���k~�gsY��t:��ۃ�`�?]\0\0�\"E.�G*�����U��w>������t�r�g������lv����D�т~�\0\0\0E�\\������Ngmmmkkk 0�r\0\0\0V��\\E\"���������:y �}E\0\0\0G.#o������555MMM���f_\0\0@��X���^��n���F \0\0�*rK�7\0����X6|#\0\0X��e�7\0����(�\0\0,�\\F��@\0\0P��e��\0\0J����7\0@	!�a�\0\0J���@\0\0P��e�y�x�ڵ��z�h\0\0���e���|��*++���(f\0\0���e)��۶m�L��\0�\n#�o��TV��%�;�YK���ئ��؎i6�;�v�쯡�Ҳ9�D���!sgO{F=���\\�����������?���(f\0\0���9���o�Q�<�Q\Z��Gu[��)����3j;�uo��ۼ�r��pd~���j^�<;{��3��8{*j[e���-E>�v�u>�p���O���\0\0�V.k����=�����%Eǲ��N��.���.�&��ѺC7=�q���[�f�o����\\�1�t��;�l0���2����ox��5\0\0Ȫ�s�v�a��83�\r^-���loʄt�b��f�3����K����E���-���[�ή����-=z?�q}r�f�v1u������x|�3Ξ�Y�?S\0\0ʏ�r9m�~7{�f�whi����h݅sy�<��o�O�j+(R.�������c�.\"�b��=ʞd��\n��_���^��ޡɇ�<���o�1e��\0@y�T.�g�Sfw�L�\Z�A[`�\\!��b��rNIs�K�0��_���]NY���b�	���x|������r�7�%%���1\0������+��g\"}.WHM��\rY^-�T�� 2V8g.y^hv9�|}�o�]>�ʒ��g�2�@P�-y��ٟ1\0\0e��s9e�qj�\Z�g1�쟥w3����і~�2�l���[�\\�VM���E�w�Ǒ�a��\0yw���#\0\0V�Us9�����/rr�8��ٞ���D&g�Y.�\r�v9v��V��1��MMO���-=jI�ٟ4\0\0��Z���f�ϊd���ch����)���}-ٮ\"k.�5��Mi[�Fry	Oͨ�ג�n����䌚>?}����\0`Y,��3�b�,�h���V�ٖYT�}��`��Y�3ź/�.�����E�)��y5=j:V�풷��oz���\0(e�˰���XGV�zL/ڂ��N�����f�\0\0�r֡~��b7������U��f�\0\0�r��5JGz�&M/�B�D���\0��@.�:�O��o\\��\0\0�r֡rY���55]�?/�]]���mڵ���%��+ҭnJ誝;I�g5kj��d�(�X9d�^_��u֬�uY]�v�jK�P����\0��@.�:t��%���NDjW�\\�f�Q_��d.k;��:�*Z}�j;\'_\"�ڙǦJ^�\0@�!�a)�˗��NN�&��r\"�;kԌ����s�U�u9�~�.���.�������M~�nܛ��)�L.\0�b�eXG�bU��R\n�˙=_.�&�S&�+�\\hv9��+�׳nvYY�:vBm��\0�J#�as��_O�M���J.w6��UӴ���yu[-�7�έ��/���k0�l0��`1F�v��2\0\0+�\\�ud~�/e\\֭]��hN�1���PN�⍇r\"ds�]֯���.�R\'^%�br\0\0s�˰}.�b�ȩS�s�{V�7�\\N_a4����9e��f���|�\0��B.�:�ry.��ze].�o��C��һZIg�9�\\k���a.��\'�\0Xa�2�#�\\N�9^��-�ȶ�#��{j��[}��.g��X+�^���� �\0Xy�2�#��6����N�eWmZ�\Z�r^��ڔ67�\0�L�2�#����<w��x��SX��&�9]�����\\���Fr*���S�YgNB��\0\0�rֱ��1,4�e\0\0V�� �\0��#�a���%\"�C���l��z�f�\0\0�r�qo�S\"�H߰�9[�!o��\'���\0(�2��[[IGn9r��-�8qiL��]��1��\0�,�˰�M�#z��E[б��G��Z����\0��@.�:.�LJG���6�H��-ܸ��Y���g���s�ײ��������?��-}�^���Ҳ�2]�rH�k�]���Y.\0�L�2,�7JJ�G���-��y�\'op�:�ͩ�?��5ij:�>)C8y��sZ�f�*���2\0`q�eXʩ�15�|�Ҙ�i��#�R����qa�?�X��3��\0��d	h�9e�X��Y�$�睠��u�n>z4#��f\0�|�eX�w�:,A���5ZlI��ə��Vyk�V;ggW�c]L.Ű:�n�wn��ˤ�����3��K���͉���\0�\r��	Oͨ;�����@���]�N�V^��~idr�?մ�a�L�Ak.��s�\'�o�O�j+(R^������f�u��m1F�\0\0dC.Â|Ó��ЬnN����鱻ı�ۯ�`��9uŤ��M¦�\0g��{b��ɤV園ݺ��0��_���]NY���b�\0���˰�𭙇�aV���[zJn5�whrÁ��>2�?\0L�WN�������Xp1F�� 2V8g.y^hv9�<_�\0,�˚���zfPZY�\Zj���G�5��۳&�W��;�o����os��Yz7c�XW���9�.����\0�9r\'��|ڿ��*�P֏;�lxd��w�|Eqϸ|c�(�}�O7�k��ٺ5�əw�K��<�.�Zy��=���\0�� �$M����Bm?}���*k���9m�:�+d��f��)mn$\0X��p�WP��+Ӣ�p9�<�d�\nϳ�#yS�d�MJS�\0\0c�2`N���vG�Q�/\0\0� ���mmm����P���\0�\n�e�j\"����fkmm��6�r\0\0(m�2`M�h���[����)�}9\0\0�*r�������������~��\0��C.e�����v�f��c��\0\0PJ�e����i�ٺ����\0\0� ���[[[%�;::\"��ٗ\0@Q#��2\n�$�kkk��ڸ�\0\0F�e��E�Q��m�ٜN\'7�\0\0 � ��������v��o��\0\0PD�e\0s���\Z\Z��{{{;\0\0�� ] hjj��l��h\0\0�� �`0��:�r���\0�l��\0�\n����%�����ٗ\0�J#�,,������Z��9::j��\0\0�r�e\0y�x<uuu��h\0\0�� o^����a�֭���k\0���e\0�t��U�án�a��\0\0P(�2�%Q7Ш��u��i7иv����۹�\0����\0�A(jkk��l����\r4�x��{n�ܼ֭\0P��e\0�&��\\.�f����z+㪫����;4\0\0�\\�̢Ѩ�㩪��Lڰañc�̾.\0\0�\\���]�V�J�������\0 o�2����oTf����\'N\0\0%�\\�����2sY���f_\Z\0\0�!�\0\0\0C�2\0\0\0`�\\P�fgo�f�gOEm��?\\���ǽ�N��\'�w�|��??\0�� ���SO7�����x)�;���\'��,\0KE.(.�.ߪuvU��T5�o�9�����37#��y���p�6~��۞q��Κ��\0��\\P,$+�p�Uh���~�@��^��M>��!�^x����)�?]\0�\"��\0��j�;߶���齻\\��jIIEm+s�\0P��e\0E���S�,�iz�.���ڒ��N��\0�\\`�k�ê)��hz�.�8�7,� �����ٟ4\0 o�2\0�el:hz�h�o�QK2���\0y#��,<5�&_K��}��3j���&��Đ�\0L�|ʯf^M�ڂ��o��m>���?o\0@~�e\0&[k�udU���-�x����/��l��\r\0���d�G=,vC��N��\\��n��\r\0���d_�Y�t�wh��-�PK����\0�!��L��]���5�\0�\\`2�����vu����q��O�CEM�<�Wh��V��H�y��f�/��:k��,��+j;c[�v�Q[Ꝛ�y\0�C.0YN��O��t���� -�U��3W۹�Zq\"�3�M��gr\0�\n��d��<�L�,���B�]��Yg�e�\\[g�x[_޻:y��ƽ��@7��\0P��e\0&�!��6�6���$�[>kⴆ^hv����,�P֮��0���.f��j�e\0&[j.ϭKN�mgM,aw5�έ���\nW��5�]�w&[��9�b��+.��\\�RD.0�2,�H&u<�S�xc���f���1���=�r<�br\0,�\\`�%/�XxDꬰ����Xhv91K�W�\0����\0L��1nF�nW��һZIg�9�\\k���a.�\Z����2\0�\"r���e��Z(k��M�\Z��B��k��B���.g��X+�^����o��\\�RD.0�|��5qڼ�l��kl�X�iz\n�岫6-y�s9��emJ���e��\0L��b��s���N�f�oγO�p�ɩˈoO${b\rF�$4�\0�@.0Yk�K|��\0P��e\0&#�\0Ō\\`�U���ޡI�s��C�S�?o\0@~�e\0&���)y�o��-��y�\rf�\0����\0L��-��#��hz�t��4&o�g���y\0�C.0٦�ґ�y��-�X��#os��e��\r\0���d�F&�#�x|�$lz�n�S�,o����f�\0����\0���%%���mz�h�<�7�j���Ԍ�6\0 ?�2\0�\ZS�\'.�����>�)uO�M���\0y#���uX��?k�ؒ��3�����v�Κ�)\0�G.(\n�uG���������2�)�ʫ��/�L��\0�\\P,|Ó��ЬnN����鱻ı�ۯ�`��9ue��O\0�H�2�\"�5�P�6�j�y}KOɭf�Mn8pV�C��\0��\0P��e\0�ev�v�Aie��j�i�\"����oϲ^\0J��Ie6�����J\"����\'�~��.��\0k �\0\0\0C�2\0\0\0`�\\\0\0\0��\0\0\0�!r�\n�z����f_\0\0�!���r}}���5�Z\0\0�����~�\n�@ `��\0\0��2���Pn�#�\0%�\\�̮^��BY���k\0`��e\0�&8��[��\0\0� �,����^���k\0`9��\0�$655�\0\0�\"�,������l���f_\0\0�B.�[(jmm�P�x<f_\0\0�E.ȃ�r[[��rww���\0�J ��$��Pv���h���\0`���\0 ����A(\0������<6�r\0\00������G�V�%�Ѩ��&�\0 ��◞�cG7WV���ŴPnkk#�\0 ��%�uk��UG���rsKK�^���[�r(*��\0(=�2�+��{]��#����J(\0�G.�W���k|��~C���d\0��նk������ez����N�3.�)\0�rX]��jM��G��)��\"[�E;.��p.H.{�������&B\0\0#�2�sٚ��nf��}��2N92�G�ٖ1�\ne���p\Z\0\0��\\� �\\Ό��e�߿u�VB\0�����C��\"Kh\'�Я��OJ/C.K(7�]�z5�C\0(_�2����v�}9��WE��I�n�\\֯��|��g���\ne)��\"\0\0�\\�LB��p����\0\0,�X���\ne��k��\0\0P��e�j����鬫�#�\0X:r��6����}-\0\0X�XA(jkk#�\0Xv�2PڴPv��f_\0\0D.�*�����P�F�f_\0\0�D.�GB���CB��r�\0\0���c��D�ٗ\0����@i�Pv�݄2\0\0+�\\���mmm�P���\0����@Q�x<�2\0\0&\"��\"�B��t�\0\0��\\����U�;\0\0��	���z��A(\0P$�e�(����Pf_\0\0�C.&���\r\r\rv��P\0��ˀiT(y`��\0\0���e��@�n��\0\0?rXQ����������k\0\0#��U({�^��\0\0�\\\nNB��t�l6B\0��C.\n�T({<��\0\0,���r[[�\0@�#�Qf\r⵴Pv���h�/\0\0V�kR5�i��̌d�t�(O�}���#�HGG�\0���˰\Z-�%X���N���m��_��xs�\Z����O�����[�T:��}}};w�c�-Z(˿�2\0\0VB.�:�P�J>��q�Ï��������׬C�z�ߖ�\Z\n�B���͹D���hUUՋ/���ȟr���R��h\0\0`\r�2,B��$oǛ����e}��7g����>&Cȟ�����^�<62�͙�\"A\\SSSW[[{��A	���vB\0\0�\"�a������򾯪~�s���5gv���L���]����U_����c����Ҿ��ә�,�iӦʤ�{nÆ\r��Y�\Z\0\0�\0r%O��G��T�>�������z>ʬ��!��}LQ�Ї��=22211�3���pT�z�׸O\0\0�F.��i������}u�+�P֏�G����ڇv���`Z1����UUU/���Ν;�o�n����_��ՙ�\0\0�\"�Q�T+���C����v֥�9��o�b>����bVK�_}�Ն��������x�~��f��\0\0\0\n�\\F���+���wK�ھ��遁ŵ�\Zr�+�?��=�>ܙu�\0\0�r�J�5��E�������F�H�Ɏ�W��Ʒ7���\Z�G;QW�ug9I����^������W�F��2\0\0�\\FIRS�^�(i��?�Ӭ땥}��������-�y��JN(;����~�dd$\nݺu�	f\0\0�����~�D-�x��?Ϭ��������o|;sZ�剧Ԓ���O˙��c���n�l��\0\0+�\\F�QSˇ�CE��ީK����A[.�����}5�p9��\'��7�|�@ 011�3\0\0�\\F�f�F���}]����c7ΟO/\'�$��ޏ�r�s�?�&v[����s���\'��e\0\0�\r��ңVb��ǝ��\n��{��������ʫ����&�&���sf�;�r=]\'|>���p(R��0��\0�E.��H�~|�����#G�������\\�?�X�y����_��\Z\Z��c���\0��\"�Qzfff��n��}�o��Z����ߦƉ��E�����;I򄿌��p����1��~�\0\0`E��(1j�rǛ��}-.���~���/.�e��J������Ϝ9���Y�\0@y\"�Qb�V���m�&-���G?޵K?���E��Z����U.�>}��󍌌�_�#�\0(+�2JLZ.{w�Џ%��Ti��}ۏ\\\0����(1�\\�{�[i���F7�N�-� �\0(g�2J��e�~i���U��SU}�+?��R	�\0@9#�QbT.��<�����b��P��H�E�H�_����F��rZ�Fr�2\0\0�\\F�Q�W?Sr��>�~ɋ����ﾫ?������8t���\0P��e�u#9)�W�P�v�#k�ݱ�����ߚ�:��G�O�ϯ;���[~T���;v��\0P��e����)׶�7K�>��?uw�8^?|�}?���9�����7Υ.\'��Q����/$���\0\0�����駟޺ukxhHZY�����9u�R���Vy�}�rlr��Qڱ�GS!���v��I��ˏ`\0P��e����ɽ/n������`{���`ڸq��<����>QW�y��J}ɯ���<v��{~�2\0\0e�\\F�і/���w�vo�����s�3�WEsG�+�G�x��jHC�ޱ+���Ϋ9��w}��С�\'O�Wb�p\0�2D.��H��	扉���jI�+�?8=0�5�sr�K_�{�c��������Jr\0�rC.�$I�NOO������㻛�M�l_������r��Ն��Qk�VV����ey9Vb\0\0P��e�$m�9\n���~g�*�ʻ�:�ʷ����&��;;;�2��/\'�V-3�\0@\"�Q��\n�H$2111<<,ŬVe���t�#k��2���3����n��oe�\r?9����\0([�2J��`VK2��` 8}���V7���q�Ï�ޱk�ҥ�J���������[YN(�Ֆa��\0\0�\'r%,��/���}q��7J$�����W�p�#kd��S�d5���_t:�nG+\0\0=r�-�����Ξ>��I�UY�<��W�~�/�ookS_�;s�����$�2\0\0P�e�<}1OLL����|�s��u��������͒�ڐ?����d�A���T��p9	�\0\0rV�s$	�B������*�/��I\n��;����S��\ne9D���$�2\0\0P�eX�*�h4\Z�}�pX�桡!I၁���ӑ?e�<%;�PV��r���V\0\0\n�똍K�f���ׯK\r��\rǩǲQ��d��P��\0�B.�j��<==��Y	�heٍP\0\0Y�˰&-���̌J�4�Q�R��\0\0 +reaր��\0\0����5]b�V\0\0\0\0IEND�B`�',10015,'qingjia.png'),(20002,0,'<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n<process name=\"forkjoin\" xmlns=\"http://jbpm.org/4.4/jpdl\">\n   <start name=\"start1\" g=\"270,8,48,48\">\n      <transition name=\"to fork1\" to=\"fork1\" g=\"-53,-17\"/>\n   </start>\n   <end name=\"end1\" g=\"276,404,48,48\"/>\n   <task name=\"task1\" g=\"129,137,92,52\" assignee=\"张三\">\n      <transition name=\"to task3\" to=\"task3\" g=\"-53,-17\"/>\n   </task>\n   <task name=\"task2\" g=\"366,146,92,52\" assignee=\"干露露\">\n      <transition name=\"to task4\" to=\"task4\" g=\"-53,-17\"/>\n   </task>\n   <task name=\"task3\" g=\"106,275,92,52\" assignee=\"干露露\">\n      <transition name=\"to join1\" to=\"join1\" g=\"-74,6\"/>\n   </task>\n   <task name=\"task4\" g=\"391,292,92,52\" assignee=\"张三\">\n      <transition name=\"to join1\" to=\"join1\" g=\"3,11\"/>\n   </task>\n   <fork name=\"fork1\" g=\"273,95,48,48\">\n      <transition name=\"to task1\" to=\"task1\" g=\"-53,-17\"/>\n      <transition name=\"to task2\" to=\"task2\" g=\"9,-19\"/>\n   </fork>\n   <join name=\"join1\" g=\"293,326,48,48\">\n      <transition name=\"to end1\" to=\"end1\" g=\"-47,-17\"/>\n   </join>\r\n</process>',20001,'forkjoin.jpdl.xml'),(20003,0,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0�\0\0�\0\0\0c��\0\0@IDATx���{T[��������u�yg2�fN��tڦ�s��9��w�g�9�}\'��N�=��mr:���IzI�\r���S_�]�X��kl�\Z;�c��2F	s1᪀�D����-KB��l��~ֳX���R�;�?�\0\0\0��?�^\0\0`k�\0\0Љ\0\0:�\"\0\0@\'Z\0\0�D�\0\0\0�h\0\0�-\0\0t�E\0\0�N�\0\0Љ\0\0:�\"\0\0@\'ZH����w���悋���42���\0=h �T�Hj���LOOONNNLLbȃ�L ���	\0{�E�T2*����\ZGk�?����Ϧ���O~�����O?�#rC�ʃ��綏�������2E��h 5\"+d<0���O~����XwǏ7��-��]r&��ص	��!w�AyJ&�ɶz��~��O�\0�!ZH\"���SSS��Y?��������k����u\'2�L&�,��g\r����BdQ�\0��E��R!233399������G��8Ab��\"3�􍾾���QY�,�`��*F�����y��ז\"jȌ2��/�������@ @�\0�ZX9#D�$D����������\Z�On����ի]CCC�\0;�E��SǈLNNf���#�ܳ�1r�g>����#��òpu���\n\0�B�\0+4??���^.���~���Շ����[��hѱ_www���ʯ�_Ħ\0VE�\0+���^�~���ȏ��N�`��2e�a�g�ܮ�����1�El\Z`U��j����D������C3��+C��2���̕�ݙЍ��Y5�+�G:�C��W�f��C���|p����ߕ�!��;88(��M#\0��Vba�����\r��z���)���!w�\'�?���������S��oNvk���i����l�+��bOO��\"6�\0�*ZX6c����-__wGSכ]c�� ?�������q����4]�G.\\\r�[\\\r���{����������M#\0,��M��;66����z����5�#�j�S�}Xn�Gj�C#��H�vx���s���w�g�]yj��CO�����Jk����W~�:�W����E�e� ���	�������>����O]�9���/��Z���.�����,<Ah��7\\�f?%!����477�|>�u�Ki\0�C�\0�677799944��\'>Xp���?4���\Z��F���|�9�H��V�w�i��n>�L,����y�^�u�K�W�~�\0�b��l�`��������uϝ�r���ȹ+Gj}�F���Z�au���e���)uW��Ɍ)�AY�W}M����v�u�ݯ\0R��M� ����g�h+:�}MFu���\r��{0|�`�������Gԃ�c��wCӇ&8y�������ϸ�n�u�Ki\0�C�\0��\"o��9�q�tǫ7ǁ��zBw�:^��n���\Z��\\��泞W#�#Ӝh�+-r�L-��h`ٌ���?>X�jρ����PQr�f�PϪ�!r3>�nf��4����ܯ<�~i���6Z�U�\"��-���?��ȿ��+�^c��������\Zc�3�&S㵈���x��\0k�E�e3Z�?����\'��ڮێ`��H��#�,�?�>\Z\0�F�\0�f��S����OG���l��k���xs�dǚC��#<��?�T��[]]M�\0�0ZX6��}\'����?������ʛ�1[�?o>[�jL�_yk���I�yI�J���������c�����^\0F�\0�f\\����~?�r���{_��¸ua��۟���pU����Y���>y������\0�E�e3�����^��w�߄7n|7ޅ��иy7����B#�����Sφr�{���,�������k��0ZX6��z{{]��l��Dõ)w����ym��养���S�\\�y��iԃ���e�?����e��9s������`a��l���ꐑ��A�������T���t�^��2,c�3�s�shV�����\\xv��Px��,j�и�U��~���ƺ�Ǐ744ȯ�_��_���@��\"�J���ׯ_���===.�kC��y极�v�\\�*��t�#�|~C�W�=z��Y��\n�E���(��h`%\"7�x�ަ��u���m_��#W�\"On�����ȑ#\'O������(��h`�Ԧ������>��]�P!\r��3�T����-\"�n�Qf���~�\'N����be��+�(��h`�Ԧ����������K�.�;wnc�W������h�-\"�Ȍ2��Ç�?.���be��+�(��h`��}�����������W����JC�){�ٟ��������s�D&��db����G�9q�,D%�����W�Q���\"����ϫ�{���А�åK����N����l��7������u˾o���;�;vm�-Cn�]yP��	d2����G��<yRf��Ȣd��Xu/E\0X-�Jd�www���3g�?~�@Ŧ�=�x�����O~�����O?�#rC�ʃ�LPRR\"\"�,2��.�E\"\0l�V�ȑ�����Ѿ�>���r�\Z\Z\Z$/***�;VVV&���o�&7�<(O�2�L,�Ȍ2�,DE�\0�	ZH�#���SSSccc���===�����������������L�+�S2�L&�,2��.Qǈ\"\0�RC�H0�~���Ą������|^�������n˃�L ���2��(��B\0�A�\0�U$ccc###CCC�1�AyJ&�ɨ\0�E�\0�g��������䤤F �<(O�2��h ]T������\"�)5\r��h ����$At�\0�-dT~~���׽\0`\"��Q�\0D�E��*,,���ѽ\0`\"��QEEE>�O�Z\0���\"@�����8��q�w8�gU�\0�B��������;K��)--u:�+X1\0�*Z���E,��(��)�~�%��dE�;�q;���߸�/������^�\0+�E`Y�!����7q��2l�u\0�E`Y�k��Y�X���K�:\0�	-��d��>��oq:������\0l���%8�#��K/�l�A$q��(�\0D�E���x<�C�Z\0���\"@F�|���\"�k\0&B�\0���SXX�{-\0�Dh ��~~~��\0\0�E���E\0 \n-dT0���ѽ\0`\"��i��+\0��E�L���	���\0̂2-??����^\00Z�4Z\0\"�\"@�����^\00Zȴ��\"�ϧ{-\0�,h ����ѽ\0`��i���N�S�Z\0�Y�\"@��\"\0�2������Z�Z\0�Y�\"@�U��^\00Zȴ��ꊊ\n�k\0fA�\0��t:KKKu�\0�-d\Z-\0�h s�~����^)\0Ќ2g����!����^)\0Ќ2���޸q�\n����={�p1x\0�E��ھ}�j����\0n�\"@�9��\r6�illԽ:\0�-d��͛%G������u\0�h �N�8���U^^�{E\0�h ӂ��ƍ���\0S�E\0\0�N�\0\0Љ2j>���q�k\0\Z�\"@�\n���x:ē����9U$��\02�2�f�t���v~B�ޞ�@ 055%EB�\0�\'Z�\"##^	��;>�gۇeȍ�^�x������H����� 9�nh �bC���o/��7r���ahhh||�`C��^�!\"2:v��NM(Gv�rdώ��쮓#G\0�\r-�Q��\n���w[-9��h ]�\"2�N��D��D�h8J�\06G�\0i���QCm !G\0�-�ޢ�f�!2vs��j�M˅ߒ#\0�R,�Y3��f&\"B���\0{�E�T�\r��FF�F�Uぺ�o���Ww�2���`7��2�!rޙ;4|Jƨ�\\h����-�ܺ���踼{�)�95��B�\0�ZH���oȽ6p\\���ic�_�%�\Zc���T\Z���}B���\0�A�\0)\"\ruٽ�e�}G�����D�lk{!�Ed���i���Kf\'G\0�-�Vl��֭��-�u�HX\\�\r\r���E�sQ-r����F��kGռ�r��\"��Ć�ٚ_]����#����hq�F�H���W\"&�\nO��,AE�\0�<ZX���:�d���Ѿ_b��+���n��iϕbc\Zc����E��\0�F�\0+�Bdt�3\"D�]�\\$C\Z�gN����{\'O|W��C�W�ZD4�Ls��W�Bd�����F߹�9Y�o\0�-�����/2DZ�~�jݭBF[���s�F�G�Q���D.A(�Tź�o�\r333�#��\0X-ZX���3/��������Emm/ɐ(��n,+DT����%�)����U}}}~�jj*�~\0`�h`��E:U�T�~Rm�P�B�&\r5V�]$rӈ�S#-��X���el\Z��6\0�j�\"X����>��0Z�8}FՃǳO�~��E��E�CF�j�E\Z\ZNtvv����\"\0,�A꭬V0W�,�J:H�H\n������x�H�ל[�B��~�9��S\'4F챫��ʨ�[u*�,��3Uo�\\.˴H�^Y7iY%\0�G� �4�Ȋ�\n�	��F���o�����.��.1.�nǽ��zָɕ�UF�EJd�F�TVinn�t�R�����y�l�A�����%�77���\"��Λ�	�SSS~�����ȑ����ޒ�ޒȫ�����\rׅ8�]U�v_;jL�.�j|1��ȩS����].�����������E�z�}�,�#�犻1?���6???77�6�\r\r]v�9rޙ��\"�f�\r{��v����d�}Ge_�k�HKKKGGGOOO�����7�Nh�^JZ��\"�Oq?�/\'M�EFFFN�:URR2>>.}�n�3r�y~���ޑ��	��WF�����j.�=6D��ۻ��3s�3�%\03�E�zi�K�T��Z:������0??_ZdxxX�ʑ��\Z>%c���wG�Ⱦ���Ϫ�e��y�W�;���og�\Z�\Z���AZ$��Y�\\ƃ�ݍ�1r�\\����-++���q�J�R�s��Q��x���@��gn]�cjx<�B�7�ϑ�*2K�-\"mmmG�y��g�z�-�ߟ�/����`C��4��I	ɑ�g��ŋ�F����hRc��ω��e�ߩ�id��fd����ɓ\'���e}�H����e�Կ*\0�C�\0�����J��/,,lll��Xl��sĈ��ۣɅ��kfvvV�GVLڨ��?��	\0�-D�I_PP ��\"In~X2GB[>ީ��}�H(D���SɇH���%�YTT��x��~\0@z�\"��������⼼����loHf�dG�v��de!b��|�C���t��\0���E��gyii�$ȡC��n�j��II�$��U���������\0�Z�%����]TT�t:�,I��jv�$�����˥�*++�@J^\0�-�1پ}{uuu:�FI�ؑt��AfTG�f�t\0X%Zv!�N�s5��,˒9��1��n��hX���)--��͕��<dY�H��#D\"q�\r\03�E`Y򡮎�p8N�S�ᜋ�$�\Zg��hnn�V���HS�8��9�\"��@ P[[�=Lnh?~36G.��[.�ij<���TȥK�<����|���\00Z�������+//��u�ktKd��o���������r����t���6\0̃���v���AL{<Dd��g�����@�ܐ��`�B���6\0̀�\Zp���D�P���OP�?���b]��,�ʑ��������)���0�!w�Ay*�!b�t\0z�\"0��fee�����������۷o/((�G���#G��&���\"�8����Z\"�So�t����޼2����&�l.���iq��:����r_����;�w�gggK��Ǥ��{EE���N��a���021�ġ��>Z�=/V3����w`<ɗ,��e˖�O?�tsssZ�g�n��ۻw��T]2\0h�5�Q�c�C}�ߝ]�ԑ��k2F�禦o�y��|��Ec+�{~��7�MK��z�7n̺�s�=WVV����n�s��\r6��\0k-bj����Z�)���9����b���7�����ܷ����L������|(f�͇!�t�ۭ�Yl޼���D���Z��T���\'{�U�i��Tm)Q{���+�z�&�M�n���m���>[SS�{�\0�y��y9�*D��[{C�p8��j���\Zt��X���ި-U�#�t`�h���Tػ�ڵ�C�G��i,yu�]ú�i,�Ν;cw����rZ�ՠELJ흹o�	�ݐ��ԑ&��F�;�eؾ}{��x6mڤ{�\0�a��M�̩�k�`��ct|Nm�9�M#\0`k���4��6�Ő��}��2׿ޤ��FF��}\0�D���ÎЇtv�S{.�u�q�[^�gs8/�.lx�>\0ɠE�H�Ϣ�N����y�w�s�~��	6�d�$�\"ft�/��;w߸�������7�˶���$ZČ�_:�����-b\\�@b�����7C�R��7҈K�X-bF���K�H-bF�[�ް�����\"��%�\0$�1����\n\Z\"v��e5��0.� I����EV��ă�0.� I����E�)���i�Ս��p�\"�%�\0$�1�to�m��{d̘�A�X���$ZČ2��&vc�b[J/g���0.� I��e~�H���%��i�}\0�D��Q:��M|��bw#g���d���0��gl�1�J���G���\0�D���a��5����{�	�\"f���x��-̄��I��O�k�-bF�J�v8A�R��7҂�$ZČ��\\*ڪ.ho�ty��}�H����0�%��R}F-�-bF��}Ҫ_m\Z9�;��e޵����i�%�\0$�1��m��]\'��BZ���Ӈպ�o��9/ٗ���E�U�Ęsp\\����\'{|��ڋ!}���y�o^���~#-Lxɾt��-�\Z-bR��<!���@��bH�x�W}���̜�7ia�K�E�E\0��EL��kXm\Z����\r)��u͎�6��4҅S�$�1��tZ������S3:>�����ͥ���e�\r- I��yM�̩�{�Z�����7%��?�B�u���q��1҈�$Z�Լ�w用�pl�h��7w��`�O횑��|uX�����}\0�D������QH�:Ҵ� �O�g�_Tg�Ȑ�b��p�>\0I�Eր��e-�\"�\\\r��b&�����#b\\�@�h�5C>�K��vT��\n����{z���wm�K�H- -�d�$�\"\0҅K�H- ]�d�d�\"\0҈K�X- ��d�%�\"\0ҋK�H�����Rݫ\0[�}\0�E�kzz:77W�Z�.�d���\"����SXX�{-`/\\�@,Zľ\Z���t�\0��h�*//���ս\0\0��E���px<�k\0�;Zľ������\0\0�-bS�D\00	ZĦ8�\0`��Mq\r�@�%����h��$\Z�AaaaOO��\0�ZĦ8�vPVV��ب{-\0,��)N����֖���^\0K�E숓h`���p�^\0K�E숓h`�@ //O�Z\0X-bG�D���͝��ֽ\0�E숓h`�J�-bG�D����E숓h`�̏�N���p�6`~�����B|�G����a7�L��������j�kdk&G��Nqq���ֽ@�p*\r`r���l߾}hhH�Z\0��~I��h{	�999��Ȩ������k`Q����G6D�&G��IYaq�}<���:t�P:W\r0#vMfF��X�H�\\Q�D�M�4N��=q�6`f�H��j�$��/2�\n̌I��{I��o��\\Y�Gb�]�w��\Z���I��h�[l�ɒ9�x��G�,���~G���8j03Z$�R�\"7�m,YlKI2KS�s�\"�3�ER,M�E<��d���fjؙ����\0-�z��g,k.����FΘ`K���{�3	q�q�k Z�F8�v&!.9�{-\0�A��\'���$�%�u��8h���=؜����\0-b�DH�K��^\0�h��$\Z�Si\0s�E삓h`U	N�z�����tfd�\0,-b�D��K�l��̵�E�����-//_�*H+Z�.8����E�~I���q8+X%\0iE����>��{�%/���\\Q����\"�H ���[ի���-p6#�H�W\",�$��������ɭ>��El��<A���ȍ}Ud�������g��@z�\"��կ�E���$xj�y\reee���K�9�L�El�o�.��g,k��cA��M��q*\r`B��-p�\'@��|EEE���mh[��׀2==����{-\0܆�>N�\"����k�Z��8���p8<��\0p-b}�DD*//���ս\0n�E���h�H���eee���-���q\r������P�Z\0���>N�\"q*\r`6���q\r+??����^\0h��$\Z ��G!�i�^\0h��$\Z ��G!�i�^\0h��$\Z ��G!�i�^\0h��$\Z ��G!�i�^\0h��$\Z ��G!�i�^\0h+�$\Z`1���{-\0��\"V�I4�b8�0Z��8�X�u\0�A�XYYYYcc��\0̈���y�\"VVXX��ӣ{-\03�h*�<h+��͝��ֽ�Iq�`��e���<�k�W�L��,���p8t�`^\\�0	ZĲjkk���u�`^�J�-bY�D$Ʃ4�I�\"��I4@bS�-bY�D,��L\03�E�������C�hk�$\Z V�-bM�D$��R\03�E������D�hKy������ݻu�֪�*ݫ�GVf@�X��H��\nu�`j�JhG�XJyy�Q!999G����ֽR��9�ǣ{-\0[�E,exxxÆ\r�E����(,I\n���V�Z\0�F�XͦM�$D���\n\n\n���t�`v������5Z�j^~��\r6���K������D@/Z�j\\.�ƍw�ܩ{E��azz:77W�Z\0�F�XM0������ս\"�����t�`_�\0��T\Z@/Z��UTTp|�-��\\.סC�t�`_�\0����/((н�}�\"\0�.����^��h\0��}�v�\r�B�d����7[�S�to^�����n��{6��z���v�wrfN���Wqq���ֽ�M�\"i721�ġ��>Z�=/V3����w`\\�{	���\0\Z�\"���ޱΡ>���.y�H�q�5��sS�7�<�z>{����=?��Ҧ�y��)��JhD���|f���V}���c�.���X�p��?��z-��<121���R���WTTlڴ���`˖-��ź��Z$]T���\'{�U�i��Tm)Q{���+c�,�g�Ɋ�{�n��2�IG�W��|~ko�g�_�rz�P���H������l�E8PYY�{�\0{�ER�wtR}`�j�^)U�����5w\r�~���عs��\"{����|���Z$��ޙ�v���\ri\ZOiR{jt��@j�M�6I�lٲ%77W��\0�C����̜�l��VM<F��Ԇ��W�4����۸q�֭[9��<Z$�J�}j���bH��Ѿjy��_o��~)�m�6��ө{E\0ۡER�aG�C:�̩=�:�8�-/�9%��o e�����Խ\"���\")��f��gbG�F^����o\0��G��؝�< ��q������~\0�<Z$���I��wZ\0`�H���\n��~�\0k-�b�\0\0�B�����7,��\"\0\0�h�Ky��  �f�����E�����7[�S�to^�:����ͥ��?-��_睜����fA���	[d�K�E`B#3OjP_�v�w�����~/�h�Km��ݷ�Ƚ\"�#�A���\Zu^�-2��.y�H�q�5�?M���/\Z[q��=�)m�����Z�\")���\"Q�;Ad�,�4Zk�|f��班�o}r��?��z-��<121�����ER,�hb7�,����Ũy�O�l�h�)�]�Ԟ�{���:ۢER,��E<���������w,8��j���\Zt�ǀ�H���E��:@d���3rN/ֺ��I�����]{=�|T]P2n�\Z��N\Z�\")��1�E�Ij��};Nh�7?M�#MjO��w\ZЀI1ZH�ə9��`M��x��ϩ\r?篲i�C��-�\\I�Om3���}ZǏ�U��\\�z����4Z$���ٸ�Ƶ�]K�P�T��\r[x����.sj��>�����2?�S���2�I�{6��_�������{��|�E��o؂�2��N����y�R���o �h����V=�?r�w�˼k�A��7l��_���FuX����4Z$�vT�ɟ�v���G-�C����Z��\r[P\'�����I���qu9&����k�wg���|�b�����!ဵ�\"�w�������j������9�ګ=ŗ�##h��h��k�\ZV�F�;���iK���Ϩ3hvT��}����eeen�;�o;,L{�$�l1�3V�I��tZ������S3:>��h�gs�b��������srr����}�a5��ɕ��W+\0)A����̜:����-s��~��\n�;�9:Ǘ|�����.--���+((����������1g��~���-{�E��;0~wN������`�O횑�Ӽ�kTK�TTTH����˕���U����2�<\"�r�R�I���s�/7�6�<u�i�A����Eu֌��d��$��@���DG�*�S�\"�r�\"�5?���[BD��QCm`0��]�o]\\��`���}4�K�R�H\ns��=�\"� �%�};��D�D��>Z�ݽ���y�z�.{p�X淋$xj�yi`�h�{pW�[$�f���B�&�`�	-�\0-3b\"��E�9h�-�ch��h����-Z�6Zk{p�F�����\n���~��L�E�����U��.ho�tu����4Z��f�����ڵ�BZG}簺�����4ZV���Q�&��:�=�:�:�$/�aG����4ZVf�=8�a��P��^�4�����d�ž�:j�/[x�b����4Z�`�=8�BFG}##���N3a�`pnnN��u\\9�5Kz���4���<!���v�V{1�i�rΫ�l!��8̉����=87C�󥝟|i�]j���IQMMMI����7_��F�^�j�;esװ�4��`2���Qg��l��?�h��Zك�Bdd�+!�w��l����ҋ��uʇ����d֚�Y[��i��#��|�����N˧���<`�=5��s���K�gs����iA�\0�ރ\"-~{�|��#�\rCCC���&�	U~� \"+x�\'g��ɽw�?���ko���~��\n�;�9:����&G�\0��mNl�H������Sʑ�ٳ���u�#cccfˑ��+**Z����;�D]�c[E���X�8��S�f��4_N���9���=8qCD*DZ$6G�m�&��(��0��Ƀ�Z����QH�:Ҵ� q��?{��:kF��[D`s��-{p�\"2�N��D��D�h8J̓#���z��Z�%D�g�\Zj��G�:o}�9�a:�\"H����UN��4\Zel�b[DdL�CD\r��Dc���(Ԕ�WVr����zMTH�x�E��{z���w��m4�@V��߾\\�ۃ�讙p�����e�rᷙ̑��\n\0�h�Fo\r��1$�Gܹs�TB��=k&r��DD�9\"#�9��P�@����bLf��Ľw����n�����˫۲e���]l	�!����hը�j<P\Z�\r2����qC&�!/7GΞ=+y�؁��>\n\0Z�Y,�u8Hܹ�Y�n�H�{p�nݪ�kӦMR\0��Ć�yg���)��s�1vV~�8s�S�����Ԕ2K�9r��AY��{��rE�|ƎB����\"��vm8��MAO?��t@�d�!Rߐ{mฌ����h��K�5ƾ��4����L/3.�#rwǎje$�:��(T\06G��6�H:�4�6l�����K܈\"\ruٽ�e�}G�����D�lk{!�Ed���i���KfO�#���[�l�Z�B�-�h��H0ג���n�\rK��ASXXXPPp���]�vI�lܸ17776Dj������K$,�����P�빨��{TM�F���j^YH�ioo��Ύ\n�^x!j7\r\0d-�԰dC����������/***--���t:�>�ott4*D���ꊯ84�����]ݷF�37�E���1AWxzϕ�d	���ٴiӆ\r�lٲcǎm۶I�it�I\0���XxcF��n�:�d���Ѿ_b��+���n��iϕbc\Zc����E��r����������ԩSRE�FRH�///O����h@\"���!����\"��8s����;y���J��\"�1d��5�R\"C--6G�7�����\n�~\0 �4��E�Hk��\\��U@�hkY~������H<J^���%�e��X����@`ffFrD��\0\0!����ޙ�RBDZ��������dH��P7�\"�EԌ�rԒU�n�X˅���>��?55�U�\0�-h:�v�S�H��\'��-Dm�Pc5�E\"7��=5�\"M�]]]Ʀ�o�-�:i|5�\00!Z��h��U�>u�����1�11N��ih8���9000>>���XC\r�]������@oO۞���s�U@��b��3�|�ăƈ=v5�Y�u�N���\Z!r��u��e�����-h�Z$tz�F���o�����.��.1.�nǽ��zָɕ�UF�EJd�F�TVnnn�t�R����=�;��Kεإ�b�Z��Ї4�	�SSS~�����ȑ����ޒ�ޒȫ�����\rׅ8�]U�v_;jL�.�j|1��ȩS%���.���������`Y��ĝ+�%�\"�\ZE�\0\Z�����ͩM#CCC��uF��w檤����k��x+��h���}42Yo�Q��\Z!��������ӓ�szi\0+@�\0\Z�k�I\rLOO���K��j�q�ߪ��wd�t����=�2��Kf�\r�������t_�����ʑ`0(e066�#-~;4|Jƨ��1:.��}�?>�1�U�ˌ	B$�{e���`�%��ݨ���\"�6K�H���*��z�:-�ܺ����x��o��#�U2d�!�b4`g��S��xq���YcMjL��9q��;52�L��B��\0n�\"�v����G�l�\0�B�\0�-�#�-��Lܾ]$\"cg�)B��F�\0����Ɏ��\"j{	!`��E\0�XV�\"\0,�L$�a�\0+�E\0sI��B���\"��,�#�\0+�E\03J�#�߾K�\0X�h���I5�T�����r�:::\0k-�Wl�\\v׵\\�jj�hh8!r��%�ǣ�}��F�\"���9|���}}}]]]�arC�\Z߾K�\0X�h��FGG����֑@ ���%>��ܕ	\0k-dT�W�%�pN����T:cnnnfffjjJ�c<Ln�]yP�\"D\0�Q�-�_k,?ɯ���Q;k�9���L�K�\0X�h Z�Z$�ߕ�����ӹF\0�-�&����1j!q���������]�\0�����D��O�̍��T�nwqqq�k\0k-D[Y�Dm�HU�������.c�`��E�h��.�`���HAAA��+\r\0k-�{TG�ǋ��boGM;Y\\�`0\'\'g�/\0̌�����^\0H/Z0��0�k\0�E�\0�UTT���t�\0�-�WNNN0Խ\0�^�`R�����\0ҎL������\\�Z\0@��\"�I��n�k\0iG�\0&���;==�{-\0 �h���~~~��\0�L�E\03r:������\02��HBDrD�Z\0@&�\"������~�k\0�@�\0�3==����{-\0 Ch�t�nwqq��\0��E\0�)//���ս\0�!�`:�����\02���^طo_gggNN��u�̡E\0���\n۰a�D�իWu�\0d-��֭[�\"l޼���P�J@��\"�Y�ڵ���۷�߿���`�`P!���[VVV]]�{�\0 h�,�z�-u�ȩS�:�{u\0 Ch�,\\.����ݻ����������E\0����6lضm[ н.\0�9�`\"��ٜ��nh\0\0�-\0\0t�E\0\0�N����\"t�\0d-d�J�w������lyP�RӐ&\0�2��I�ɱ�Άf�[���r宽j�ݎs����������ׯ�.�H\0X-��Q!� 5�(�����]?{ߝ7�Go��ݟ�]_��4�@__ �.�(�H\0X-�����]{����B��G���?��3_�r�?|���#2�ܕճ2�L\\���ÃC�E��5@��\"@���t������-���?�ɽ�}��e�TG��ի���\Z�������2�%ٟ��KUgGFF�H���ggg�\0�C�\0i�B�����R���ϋ�����sW��c�q�[&s<���ڂ�N;^���$G\0X-��\"��_��x��_�<�D�Č�S��?�������t���������\0�C�\0)�B��V�\n�]_�����\r5�;:���?�9�(&G\0X-��q�ȓw~F\Z\"��:{���BD�Y�o��k��O���\"G\0X-������t�=\'��u���p���`]C�死���m_�_\rǃ��o/�;�Dkk֧�:���~�����i\0@�\0)�6�ߺM��?�X_eU���tI��8�����⣟�F��������/d�W~����\r��ׯ�i��\"@ʨ�=��OK4���_�&EwE��w�x����\'Z/E�{䧏���/67˒FFBWhU���`Uh 5�F�ӿ{�g�S�a��ř�����Cy2!�Ɩ���3^o���-���.y�����z����cccl\Z`��\Z�`0�}Mr���#�.E\rɋ$CD�7~��ۖ�zi�w\n�!�7���rEn\Z�E\0�i��\Zj�c��$Z���75��\Z�?����ǟ�^V���{�̻��Ʀ�W���}w>��?o���z��@@�P������\"@jHt��}�ݟ}b��������2�巈��G����`=Z����徾>c7��W\0+G�\0�177w�i�g�����c�q�\\�����h�;������Z��>��/���y�����n\Z�պ_=\0�-��:X�r�^i�]_��W�o��W+5���D.*�����mii��|2�h $fggO��GZ��[v��j�p���W�\"5�y����Q-r��y��;88���J�\0X�h �Z���ˑc�-���1_�E\0�]���-���oFmQ�)[��ؿ?rQ�>\ZZ�e�\"@\n�1�]�:^d5Ǯ^)�mQ�����Y�rg�\0ˠE�P-r�L�:����l�̗�c������N�	�D����9��\0ˠE�P-�y4|���mQ�Yٵή��D.Dm_y��^YQ���\0,�R@��+Y����KC���C��ЕR߉�����]V�����+�6޼�kc��ǟ��kΞ�^\0�A�\0�177\'YP���?��йڨ��U_��x���q��\Z9�Pm��n�=������k��ZH�w�}����}}�������ߣ��7�U�o������f��Ψy>�*��ر�����5�X-��j�ɱ��ozV��?�X�[�溻��Dkk�S|�>���msW��ꮨTG�<��555���\"\0�:ZH\r㐑����\Z���/L�ZcsDF���r�Vǃ�l��WԐ@9_����x�r)�3�]��[YQ�������E\0�u��\Zj����إsujO��/�?���͑�!��\"�vu=������-r��Դ��x����~c\r-`M�E���,������9W|H�ߛ���6�\Z�Ȓc�ҥ���>��?/�˗QG�E�ױ��ZG�\0)cl\Z	�����*G�>��}��,7D������{�9s��;���d�Ƒ\"l���\"@*��F������$G��\'C����_���C�������L�V}�C��uȪ,\\~G�\0�ZH%�iD��������+��>�u�̺�U�/��ՙ�����)�@]GD�Vs��\"�@Y��w�`��b�9��v�~ӳO~�S���N�������/߿�{ɐrW���4��{�ueE�:��`a��zQ9200���u���8/뗾�؟|l���S�|�_��Ɗc�ԑ�---n�[f��\"\0,��\"2G�������^o���x���Q|xۋ�Ɛ�G���6���i��S�6�Ȍ2�,�`I��.F�LOO������U$�/Kg�������dU!2��(��B\0�D�\0i�r$�.?9iI__�tFWW����F���<%�\nQ�CdvY!��h ��â�D\ncttTRc0l Lݖ�)�@&��B�%�\"@&D��쬊%�xP&�ɨ\0v@�\0�c����S]E���4T\0;�E\0m��{�\0 ������.��\0\0\0\0IEND�B`�',20001,'forkjoin.png');

/*Table structure for table `jbpm4_participation` */

DROP TABLE IF EXISTS `jbpm4_participation`;

CREATE TABLE `jbpm4_participation` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `GROUPID_` varchar(255) DEFAULT NULL,
  `USERID_` varchar(255) DEFAULT NULL,
  `TYPE_` varchar(255) DEFAULT NULL,
  `TASK_` bigint(20) DEFAULT NULL,
  `SWIMLANE_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_PART_TASK` (`TASK_`),
  KEY `FK_PART_SWIMLANE` (`SWIMLANE_`),
  CONSTRAINT `FK_PART_SWIMLANE` FOREIGN KEY (`SWIMLANE_`) REFERENCES `jbpm4_swimlane` (`DBID_`),
  CONSTRAINT `FK_PART_TASK` FOREIGN KEY (`TASK_`) REFERENCES `jbpm4_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_participation` */

/*Table structure for table `jbpm4_property` */

DROP TABLE IF EXISTS `jbpm4_property`;

CREATE TABLE `jbpm4_property` (
  `KEY_` varchar(255) NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `VALUE_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_property` */

insert  into `jbpm4_property`(`KEY_`,`VERSION_`,`VALUE_`) values ('next.dbid',19,'190001');

/*Table structure for table `jbpm4_swimlane` */

DROP TABLE IF EXISTS `jbpm4_swimlane`;

CREATE TABLE `jbpm4_swimlane` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `NAME_` varchar(255) DEFAULT NULL,
  `ASSIGNEE_` varchar(255) DEFAULT NULL,
  `EXECUTION_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_SWIMLANE_EXEC` (`EXECUTION_`),
  CONSTRAINT `FK_SWIMLANE_EXEC` FOREIGN KEY (`EXECUTION_`) REFERENCES `jbpm4_execution` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_swimlane` */

/*Table structure for table `jbpm4_task` */

DROP TABLE IF EXISTS `jbpm4_task`;

CREATE TABLE `jbpm4_task` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` char(1) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `NAME_` varchar(255) DEFAULT NULL,
  `DESCR_` longtext,
  `STATE_` varchar(255) DEFAULT NULL,
  `SUSPHISTSTATE_` varchar(255) DEFAULT NULL,
  `ASSIGNEE_` varchar(255) DEFAULT NULL,
  `FORM_` varchar(255) DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_` datetime DEFAULT NULL,
  `DUEDATE_` datetime DEFAULT NULL,
  `PROGRESS_` int(11) DEFAULT NULL,
  `SIGNALLING_` bit(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(255) DEFAULT NULL,
  `ACTIVITY_NAME_` varchar(255) DEFAULT NULL,
  `HASVARS_` bit(1) DEFAULT NULL,
  `SUPERTASK_` bigint(20) DEFAULT NULL,
  `EXECUTION_` bigint(20) DEFAULT NULL,
  `PROCINST_` bigint(20) DEFAULT NULL,
  `SWIMLANE_` bigint(20) DEFAULT NULL,
  `TASKDEFNAME_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_TASK_SUPERTASK` (`SUPERTASK_`),
  KEY `FK_TASK_SWIML` (`SWIMLANE_`),
  CONSTRAINT `FK_TASK_SUPERTASK` FOREIGN KEY (`SUPERTASK_`) REFERENCES `jbpm4_task` (`DBID_`),
  CONSTRAINT `FK_TASK_SWIML` FOREIGN KEY (`SWIMLANE_`) REFERENCES `jbpm4_swimlane` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_task` */

insert  into `jbpm4_task`(`DBID_`,`CLASS_`,`DBVERSION_`,`NAME_`,`DESCR_`,`STATE_`,`SUSPHISTSTATE_`,`ASSIGNEE_`,`FORM_`,`PRIORITY_`,`CREATE_`,`DUEDATE_`,`PROGRESS_`,`SIGNALLING_`,`EXECUTION_ID_`,`ACTIVITY_NAME_`,`HASVARS_`,`SUPERTASK_`,`EXECUTION_`,`PROCINST_`,`SWIMLANE_`,`TASKDEFNAME_`) values (100001,'T',1,'总经理审批',NULL,'open',NULL,'cocochen',NULL,0,'2016-07-15 09:39:38',NULL,NULL,'','qingjia.30001','总经理审批','\0',NULL,30001,30001,NULL,'总经理审批'),(110001,'T',1,'总经理审批',NULL,'open',NULL,'cocochen',NULL,0,'2016-07-15 09:41:31',NULL,NULL,'','qingjia.30007','总经理审批','\0',NULL,30007,30007,NULL,'总经理审批'),(110003,'T',1,'总经理审批',NULL,'open',NULL,'cocochen',NULL,0,'2016-07-15 09:41:49',NULL,NULL,'','qingjia.40001','总经理审批','\0',NULL,40001,40001,NULL,'总经理审批'),(110005,'T',1,'总经理审批',NULL,'open',NULL,'cocochen',NULL,0,'2016-07-15 09:41:58',NULL,NULL,'','qingjia.60001','总经理审批','\0',NULL,60001,60001,NULL,'总经理审批'),(120001,'T',1,'总经理审批',NULL,'open',NULL,'cocochen',NULL,0,'2016-07-15 10:42:13',NULL,NULL,'','qingjia.70001','总经理审批','\0',NULL,70001,70001,NULL,'总经理审批'),(150005,'T',1,'部门经理审批',NULL,'open',NULL,'jack',NULL,0,'2016-07-15 11:10:28',NULL,NULL,'','qingjia.150001','部门经理审批','\0',NULL,150001,150001,NULL,'部门经理审批'),(160005,'T',1,'部门经理审批',NULL,'open',NULL,'jack',NULL,0,'2016-07-15 11:14:37',NULL,NULL,'','qingjia.160001','部门经理审批','\0',NULL,160001,160001,NULL,'部门经理审批'),(170001,'T',1,'总经理审批',NULL,'open',NULL,'cocochen',NULL,0,'2016-07-16 21:26:27',NULL,NULL,'','qingjia.80001','总经理审批','\0',NULL,80001,80001,NULL,'总经理审批'),(180007,'T',1,'总经理审批',NULL,'open',NULL,'cocochen',NULL,0,'2016-07-17 17:09:11',NULL,NULL,'','qingjia.180001','总经理审批','\0',NULL,180001,180001,NULL,'总经理审批');

/*Table structure for table `jbpm4_variable` */

DROP TABLE IF EXISTS `jbpm4_variable`;

CREATE TABLE `jbpm4_variable` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `KEY_` varchar(255) DEFAULT NULL,
  `CONVERTER_` varchar(255) DEFAULT NULL,
  `HIST_` bit(1) DEFAULT NULL,
  `EXECUTION_` bigint(20) DEFAULT NULL,
  `TASK_` bigint(20) DEFAULT NULL,
  `LOB_` bigint(20) DEFAULT NULL,
  `DATE_VALUE_` datetime DEFAULT NULL,
  `DOUBLE_VALUE_` double DEFAULT NULL,
  `CLASSNAME_` varchar(255) DEFAULT NULL,
  `LONG_VALUE_` bigint(20) DEFAULT NULL,
  `STRING_VALUE_` varchar(255) DEFAULT NULL,
  `TEXT_VALUE_` longtext,
  `EXESYS_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_VAR_LOB` (`LOB_`),
  KEY `FK_VAR_EXESYS` (`EXESYS_`),
  KEY `FK_VAR_TASK` (`TASK_`),
  KEY `FK_VAR_EXECUTION` (`EXECUTION_`),
  CONSTRAINT `FK_VAR_EXECUTION` FOREIGN KEY (`EXECUTION_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_VAR_EXESYS` FOREIGN KEY (`EXESYS_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_VAR_LOB` FOREIGN KEY (`LOB_`) REFERENCES `jbpm4_lob` (`DBID_`),
  CONSTRAINT `FK_VAR_TASK` FOREIGN KEY (`TASK_`) REFERENCES `jbpm4_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_variable` */

insert  into `jbpm4_variable`(`DBID_`,`CLASS_`,`DBVERSION_`,`KEY_`,`CONVERTER_`,`HIST_`,`EXECUTION_`,`TASK_`,`LOB_`,`DATE_VALUE_`,`DOUBLE_VALUE_`,`CLASSNAME_`,`LONG_VALUE_`,`STRING_VALUE_`,`TEXT_VALUE_`,`EXESYS_`) values (30002,'hib-long',0,'form',NULL,'\0',30001,NULL,NULL,NULL,NULL,'domain.Form',1,NULL,NULL,NULL),(30008,'hib-long',0,'form',NULL,'\0',30007,NULL,NULL,NULL,NULL,'domain.Form',2,NULL,NULL,NULL),(40002,'hib-long',0,'form',NULL,'\0',40001,NULL,NULL,NULL,NULL,'domain.Form',3,NULL,NULL,NULL),(60002,'hib-long',0,'form',NULL,'\0',60001,NULL,NULL,NULL,NULL,'domain.Form',4,NULL,NULL,NULL),(70002,'hib-long',0,'form',NULL,'\0',70001,NULL,NULL,NULL,NULL,'domain.Form',5,NULL,NULL,NULL),(80002,'hib-long',0,'form',NULL,'\0',80001,NULL,NULL,NULL,NULL,'domain.Form',6,NULL,NULL,NULL),(150002,'hib-long',0,'form',NULL,'\0',150001,NULL,NULL,NULL,NULL,'domain.Form',8,NULL,NULL,NULL),(160002,'hib-long',0,'form',NULL,'\0',160001,NULL,NULL,NULL,NULL,'domain.Form',9,NULL,NULL,NULL),(180002,'hib-long',0,'form',NULL,'\0',180001,NULL,NULL,NULL,NULL,'domain.Form',10,NULL,NULL,NULL);

/*Table structure for table `kynamic` */

DROP TABLE IF EXISTS `kynamic`;

CREATE TABLE `kynamic` (
  `kid` bigint(20) NOT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `isParent` bit(1) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `kynamic` */

insert  into `kynamic`(`kid`,`pid`,`isParent`,`name`) values (1,0,'','知识管理'),(3,1,'','文档'),(8,1,'','多媒体文件'),(14,3,'\0','另');

/*Table structure for table `menuitem` */

DROP TABLE IF EXISTS `menuitem`;

CREATE TABLE `menuitem` (
  `mid` bigint(20) NOT NULL,
  `isParent` bit(1) DEFAULT NULL,
  `checked` bit(1) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `target` varchar(100) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `menuitem` */

insert  into `menuitem`(`mid`,`isParent`,`checked`,`icon`,`url`,`target`,`name`,`pid`) values (1,'\0','\0','css/images/MenuIcon/FUNC20082.gif',NULL,NULL,'办公自动化',0),(2,'\0','\0','css/images/MenuIcon/FUNC20057.gif',NULL,NULL,'审批流程',1),(3,'\0','\0','css/images/MenuIcon/FUNC20056.gif','forwardAction_kynamic.action','right','知识管理',1),(4,'\0','\0','css/images/MenuIcon/manager.gif',NULL,NULL,'行政管理',1),(5,'\0','\0','css/images/MenuIcon/FUNC20001.gif',NULL,NULL,'人力资源',1),(7,'\0','\0','css/images/MenuIcon/FUNC20076.gif',NULL,NULL,'实用工具',1),(8,'\0','\0','css/images/MenuIcon/FUNC20001.gif',NULL,NULL,'个人设置',1),(9,'\0','\0','css/images/MenuIcon/system.gif',NULL,NULL,'系统管理',1),(10,'\0','\0','css/images/MenuIcon/FUNC20001.gif',NULL,NULL,'个人办公',1),(11,'\0','\0','css/images/MenuIcon/FUNC20054.gif',NULL,NULL,'个人考勤',10),(12,'\0','\0','css/images/MenuIcon/FUNC23700.gif',NULL,NULL,'日程安排',10),(13,'\0','\0','css/images/MenuIcon/FUNC20069.gif',NULL,NULL,'工作计划',10),(14,'\0','\0','css/images/MenuIcon/FUNC20056.gif',NULL,NULL,'工作日记',10),(15,'\0','\0','css/images/MenuIcon/time_date.gif',NULL,NULL,'通讯录',10),(24,'\0','\0','css/images/MenuIcon/manager.gif','forwardAction_pdManager.action','right','审批流程管理',2),(25,'\0','\0','css/images/MenuIcon/formmodel.gif','forwardAction_formTemplate.action','right','表单模板管理',2),(26,'\0','\0','css/images/MenuIcon/FUNC241000.gif','forwardAction_workFlow.action','right','发起申请',2),(27,'\0','\0','css/images/MenuIcon/FUNC20029.gif','forwardAction_showMyTaskList.action','right','审批处理',2),(28,'\0','\0','css/images/MenuIcon/FUNC20029.gif','forwardAction_showMySubmit.action','right','我的申请',2),(41,'\0','\0','css/images/MenuIcon/FUNC20070.gif',NULL,NULL,'考勤管理',4),(42,'\0','\0','css/images/MenuIcon/FUNC20064.gif',NULL,NULL,'会议管理',4),(43,'\0','\0','css/images/MenuIcon/radio_blue.gif',NULL,NULL,'车辆管理',4),(51,'\0','\0','css/images/MenuIcon/FUNC20076.gif',NULL,NULL,'档案管理',5),(52,'\0','\0','css/images/MenuIcon/FUNC55000.gif',NULL,NULL,'培训记录',5),(53,'\0','\0','css/images/MenuIcon/FUNC55000.gif',NULL,NULL,'奖赏记录',5),(54,'\0','\0','css/images/MenuIcon/FUNC55000.gif',NULL,NULL,'职位变更',5),(55,'\0','\0','css/images/MenuIcon/FUNC55000.gif',NULL,NULL,'人事合同',5),(56,'\0','\0','css/images/MenuIcon/FUNC20001.gif',NULL,NULL,'薪酬制度',5),(71,'\0','\0','css/images/MenuIcon/FUNC220000.gif',NULL,NULL,'车票预订',7),(72,'\0','\0','css/images/MenuIcon/search.gif',NULL,NULL,'GIS查询',7),(73,'\0','\0','css/images/MenuIcon/FUNC249000.gif',NULL,NULL,'邮政编码',7),(74,'\0','\0','css/images/MenuIcon/FUNC20001.gif',NULL,NULL,'天气信息',7),(81,'\0','\0','css/images/MenuIcon/FUNC20001.gif',NULL,NULL,'个人信息',8),(82,'\0','\0','css/images/MenuIcon/FUNC241000.gif',NULL,NULL,'密码修改',8),(91,'\0','\0','css/images/MenuIcon/FUNC20001.gif','postAction_getAllPost.action','right','岗位管理',9),(92,'\0','\0','css/images/MenuIcon/department.gif','departmentAction_getAllDepartment.action','right','部门管理',9),(93,'\0','\0','css/images/MenuIcon/FUNC20001.gif','userAction_getAllUser.action','right','用户管理',9);

/*Table structure for table `person` */

DROP TABLE IF EXISTS `person`;

CREATE TABLE `person` (
  `pid` bigint(20) NOT NULL,
  `pname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `person` */

/*Table structure for table `post` */

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
  `pid` bigint(20) NOT NULL,
  `pname` varchar(20) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `post` */

insert  into `post`(`pid`,`pname`,`description`) values (1,'程序员','编写代码'),(2,'会计','审核财务支出收入'),(3,'采购员','后勤采购'),(4,'HR','招聘员工'),(5,'架构师','规划项目架构'),(6,'需求分析师','和客户沟通需求');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `uid` bigint(20) NOT NULL,
  `email` varchar(20) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `sex` varchar(20) DEFAULT NULL,
  `did` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  KEY `FK36EBCBB49C0B5B` (`did`),
  KEY `FK36EBCBDAE6791` (`did`),
  CONSTRAINT `FK36EBCBB49C0B5B` FOREIGN KEY (`did`) REFERENCES `department` (`did`),
  CONSTRAINT `FK36EBCBDAE6791` FOREIGN KEY (`did`) REFERENCES `department` (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`uid`,`email`,`username`,`password`,`phone`,`sex`,`did`) values (2,'21321','admin','admin','sdaf','男',2),(3,'','jack','123456','','男',2),(7,'','????',NULL,'asdf',NULL,2),(8,'','',NULL,'',NULL,2);

/*Table structure for table `user_menuitem` */

DROP TABLE IF EXISTS `user_menuitem`;

CREATE TABLE `user_menuitem` (
  `uid` bigint(20) NOT NULL,
  `mid` bigint(20) NOT NULL,
  PRIMARY KEY (`mid`,`uid`),
  KEY `FKDF1022E6378E325` (`uid`),
  KEY `FKDF1022E6E8A0D44` (`mid`),
  KEY `FKDF1022E6BFBA1FDB` (`uid`),
  KEY `FKDF1022E619D1FEFA` (`mid`),
  CONSTRAINT `FKDF1022E619D1FEFA` FOREIGN KEY (`mid`) REFERENCES `menuitem` (`mid`),
  CONSTRAINT `FKDF1022E6378E325` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`),
  CONSTRAINT `FKDF1022E6BFBA1FDB` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`),
  CONSTRAINT `FKDF1022E6E8A0D44` FOREIGN KEY (`mid`) REFERENCES `menuitem` (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_menuitem` */

insert  into `user_menuitem`(`uid`,`mid`) values (2,1),(2,2),(2,3),(2,4),(2,5),(2,7),(2,8),(2,9),(2,10),(2,11),(2,12),(2,13),(2,14),(2,15),(2,24),(2,25),(2,26),(2,27),(2,28),(2,41),(2,42),(2,43),(2,51),(2,52),(2,53),(2,54),(2,55),(2,56),(2,71),(2,72),(2,73),(2,74),(2,81),(2,82),(2,91),(2,92),(2,93);

/*Table structure for table `user_menuitems` */

DROP TABLE IF EXISTS `user_menuitems`;

CREATE TABLE `user_menuitems` (
  `uid` bigint(20) NOT NULL,
  `mid` bigint(20) NOT NULL,
  PRIMARY KEY (`uid`,`mid`),
  KEY `FK2F43A4DBFBA1FDB` (`uid`),
  KEY `FK2F43A4D19D1FEFA` (`mid`),
  CONSTRAINT `FK2F43A4D19D1FEFA` FOREIGN KEY (`mid`) REFERENCES `menuitem` (`mid`),
  CONSTRAINT `FK2F43A4DBFBA1FDB` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_menuitems` */

insert  into `user_menuitems`(`uid`,`mid`) values (2,8),(2,9),(2,81),(2,82),(2,91),(2,92),(2,93);

/*Table structure for table `user_post` */

DROP TABLE IF EXISTS `user_post`;

CREATE TABLE `user_post` (
  `pid` bigint(20) NOT NULL,
  `uid` bigint(20) NOT NULL,
  PRIMARY KEY (`uid`,`pid`),
  KEY `FK143B0C94378E325` (`uid`),
  KEY `FK143B0C943767D35` (`pid`),
  KEY `FK143B0C94BFBA1FDB` (`uid`),
  KEY `FK143B0C94BFB7B9EB` (`pid`),
  CONSTRAINT `FK143B0C943767D35` FOREIGN KEY (`pid`) REFERENCES `post` (`pid`),
  CONSTRAINT `FK143B0C94378E325` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`),
  CONSTRAINT `FK143B0C94BFB7B9EB` FOREIGN KEY (`pid`) REFERENCES `post` (`pid`),
  CONSTRAINT `FK143B0C94BFBA1FDB` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_post` */

insert  into `user_post`(`pid`,`uid`) values (4,7),(1,8);

/*Table structure for table `version` */

DROP TABLE IF EXISTS `version`;

CREATE TABLE `version` (
  `vid` bigint(20) NOT NULL,
  `content` longtext,
  `title` varchar(100) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `kid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`vid`),
  KEY `FK14F51CD83CE61682` (`kid`),
  KEY `FK14F51CD8A89E160C` (`kid`),
  CONSTRAINT `FK14F51CD83CE61682` FOREIGN KEY (`kid`) REFERENCES `kynamic` (`kid`),
  CONSTRAINT `FK14F51CD8A89E160C` FOREIGN KEY (`kid`) REFERENCES `kynamic` (`kid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `version` */

insert  into `version`(`vid`,`content`,`title`,`updatetime`,`version`,`kid`) values (2,'第二个版本','文档二','2016-06-01 17:37:26',2,3),(3,'庚','5555344444444','2018-09-20 22:09:44',4,3),(5,'暗算','4444441','2018-09-03 22:09:50',6,3),(6,'暗东风','非该','2018-09-25 21:02:13',7,3),(7,'暗东风纷纷纷纷纷纷纷纷纷纷纷纷ff','非该','2018-09-25 21:02:28',8,3);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
