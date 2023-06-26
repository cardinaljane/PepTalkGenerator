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

INSERT into pep_talk (talk_text)
VALUES 
('You can do hard things.'),
('Focus on the step in front of you, not the whole staircase.'),
('Oprah has said "Where there is no struggle, there is no strength." What are you willing to struggle through to get better at? You can handle struggle'),
('You can handle discomfort. Try to do the thing you want to do for 30 seconds. You can work through discomfort. Do it in small bursts at first and eventually you will be working for hours withou realizing it.'),
('"Much must be done before the brief light die;/ She may not loiter rapt in the vain dream./ With unused trembling hands and faltering feet,/She staggers forth her lot assigned to meet" - Emma Lazarus poem "Work"'),
('Everyone you admire was also a beginner. There is no shame in being a beginner. It is how you become better at what you value. It is how babies learned to talk and walk and how we all become who we are and want to be. You are doing something wonderful for yourself.'),
('What can you do today? Right now, with who you are and what you have available. Do that. Meet yourself where you''re at every day and you will not be stuck.'),
('Hard work is not clean and light or fast. It is sweaty, taxing, overwhelming. The goal isn''t to be perfect. It is to act'),
('Being bad at something is the first step to being kind of good at something. I think that''s from a cartoon. But it''s true! What''s more, being bad at something is not a moral failing and doesn''t reflect on your worth as a person. It''s intregal to being a living being, and maybe creature. Do you think other animals worry about failing? Would you shame a herding dog for struggling to herd sheep?'),
('Struggle is where the life blood is. It is vital and momentous. As in present. As in you''re doing it right now! Progress over product. Presence over future casting')
