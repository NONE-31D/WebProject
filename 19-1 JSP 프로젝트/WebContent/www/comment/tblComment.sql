CREATE TABLE `tblComment` (
	`num`               int(11)              NOT NULL  auto_increment  ,
	`bnum`              int(11)                    ,
	`subject`           varchar(50)                    ,
	`comment`           text                           ,
	`name`                varchar(15)           ,
	`pass`               varchar(15)                    ,
	
	PRIMARY KEY ( `num` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
