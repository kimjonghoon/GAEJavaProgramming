# GAE Java Programming Example

## Spring Message Board Program with
* Spring MVC
* MyBatis-Spring
* i18n
* Apache Tiles

## Database Design

	mysql --user=root --password mysql
	
	create user 'java'@'%' identified by 'school';
	grant all privileges on *.* to 'java'@'%';
	
	create database javaschool;
	exit;
	
	mysql --user=java --password javaschool
	
	create table board (
	    boardcd varchar(20),
	    boardnm varchar(40) NOT NULL,
	    boardnm_ko varchar(40) NOT NULL,
	    constraint PK_BOARD PRIMARY KEY(boardcd)
	);
	
	create table article (
	    articleno int NOT NULL AUTO_INCREMENT,
	    boardcd varchar(20),
	    title varchar(200) NOT NULL,
	    content text NOT NULL,
	    owner varchar(60),
	    hit bigint,    
	    regdate datetime,
	    nickname varchar(20),
	    constraint PK_ARTICLE PRIMARY KEY(articleno),
	    constraint FK_ARTICLE FOREIGN KEY(boardcd) REFERENCES board(boardcd)
	);
	
	create table comments (
	    commentno int NOT NULL AUTO_INCREMENT,
	    articleno int,    
	    owner varchar(60),    
	    memo varchar(4000) NOT NULL,
	    regdate datetime,
	    nickname varchar(20), 
	    constraint PK_COMMENTS PRIMARY KEY(commentno)
	);
	
	create table attachfile (
	    attachfileno int NOT NULL AUTO_INCREMENT,
	    filename varchar(255) NOT NULL,
	    filetype varchar(255),
	    filesize bigint,
	    articleno int,
	    owner varchar(60),
	    filekey varchar(255),
	    creation datetime,
	    constraint PK_ATTACHFILE PRIMARY KEY(attachfileno)
	);
	
	insert into board values ('free','Free','자유 게시판');
	commit;

## How to Install
	mvn clean install

## How to Run (localhost)
	mvn appengine:devserver