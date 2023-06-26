USE master
GO

if DB_ID ('PepTalkGenerator') IS NOT NULL
BEGIN 
	ALTER DATABASE PepTalkGenerator SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE PepTalkGenerator;
END
GO

CREATE DATABASE PepTalkGenerator
GO

USE PepTalkGenerator
GO

BEGIN TRANSACTION

CREATE TABLE pep_talk (
pep_talk_id int IDENTITY (1,1) NOT NULL,
talk_text nvarchar (max) NOT NULL,

CONSTRAINT [PK_pep_talk_id] PRIMARY KEY (pep_talk_id)
);
GO

CREATE TABLE users (
user_id int IDENTITY (1,1) NOT NULL,
username nvarchar (50) NOT NULL,
password nvarchar (200) NOT NULL,
--I know the below is more secure, but need to look into how to impliment 
--password_hash nvarchar (200) NOT NULL,
--salt nvarchar (200) NOT NULL,
email nvarchar (100) NOT NULL

CONSTRAINT [PK_user_id] PRIMARY KEY (user_id),
CONSTRAINT [UQ_email] UNIQUE (email)
);
GO

CREATE TABLE account(
account_number int IDENTITY (1,1) NOT NULL,
user_id int NOT NULL,

CONSTRAINT [PK_account_number] PRIMARY KEY (account_number),
CONSTRAINT [FK_user_id] FOREIGN KEY (user_id) REFERENCES users(user_id)
);
GO

CREATE TABLE pep_talk_account(
pep_talk_id int NOT NULL,
account_number int NOT NULL,
tag nvarchar (200)

CONSTRAINT [PK_pep_talk_account] PRIMARY KEY (pep_talk_id, account_number)
);

