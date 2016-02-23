-- replace with your own database name to test on your own
USE c_cs108_rbais;

-- drop all tables if they exist
DROP TABLE IF EXISTS mail;
DROP TABLE IF EXISTS friendships;
DROP TABLE IF EXISTS choices;
DROP TABLE IF EXISTS answers;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;

-- create all tables
CREATE TABLE users(
   user_id INTEGER,
   user_name VARCHAR(16),
   password TEXT,
   PRIMARY KEY(user_id)
);
CREATE TABLE mail(
   from_user INTEGER,
   to_user INTEGER,
   message TEXT
);
CREATE TABLE friendships(
   friend_1 INTEGER,
   friend_2 INTEGER
);
CREATE TABLE questions(
   question_id INTEGER,
   question TEXT,
   type VARCHAR(32),
   from_user INTEGER,
   quiz_id INTEGER
);
CREATE TABLE choices(
   question_answered INTEGER,
   choice VARCHAR(64)
);
CREATE TABLE answers(
   question_answered INTEGER,
   answer TEXT
);


-- Here I will create a simple database with queries on how to get things of interest
-- For now I will just store the passwords plain text, but application will change it later
-- For multiple choice I created a special table, since it is a quirk and it has many possible choices to pick from
INSERT INTO users VALUES
 (1, 'albert16','abcd'),
 (2, 'john57', 'defg'),
 (3, 'tackyuser', 'password');

INSERT INTO mail VALUES
 (1,2, 'Hello my name is albert'),
 (2,3, 'Hello tacky user, my name is john'),
 (2,1, 'Hi albert, I am john');

INSERT INTO friendships VALUES
 (1,2),
 (2,3),
 (3,1);

INSERT INTO questions VALUES
 (1, 'Who is the first president of the united states?', 'fill—in the blank', 1, 1),
 (2, 'Who is the fifteenth president of the united states', 'question-response', 1, 1),
 (3, 'Which one of these are not like the other?', 'multiple-choice', 1, 2),
 (4, 'Who invented mass assembly', 'fill—in the blank', 2, 3),
 (5, 'What is the highest-grossing film of all time', 'question-response', 2, 3),
 (6, 'Which one of these are not like the other?', 'multiple-choice', 2, 3);

INSERT INTO choices VALUES
 (3, 'orange'),
 (3, 'apple'),
 (3, 'banana'),
 (3, 'spinach'),
 (6, 'pork'),
 (6, 'shark'),
 (6, 'chicken'),
 (6, 'beef');

-- Demonstrates that a question can have more than one answer
INSERT INTO answers VALUES
 (1, 'George Washington'),
 (1, 'Washington'),
 (2, 'Lincoln'),
 (2, 'Great Abe'),
 (2, 'Abraham Lincoln'),
 (3, 'spinach'),
 (4, 'Ford'),
 (5, 'Avatar'),
 (6, 'shark');

SELECT 'Now I will be performing some queries' as '';

SELECT 'This is how to get all friends of user albert16' as '';

(SELECT u2.user_name as friend FROM friendships INNER JOIN users as u1 INNER JOIN users as u2 WHERE friend_1 = u1.user_id AND u1.user_name = 'albert16' AND u2.user_id = friend_2) 
UNION 
(SELECT u2.user_name as friend FROM friendships INNER JOIN users as u1 INNER JOIN users as u2 WHERE friend_2 = u1.user_id AND u1.user_name = 'albert16' AND u2.user_id = friend_1);

SELECT 'This is how to get all messages sent to john57' as '';

SELECT message, u2.user_name as message_from FROM users as u1 INNER JOIN mail INNER JOIN users as u2 WHERE u1.user_id = to_user AND u2.user_id = from_user AND u1.user_name = 'john57';

SELECT 'This is how to get all quizzes from albert 16 (note that the quiz id at the end is different so this gets all questions from every quiz)' as '';
SELECT question, user_name, quiz_id FROM questions INNER JOIN users WHERE from_user = user_id AND user_name = 'albert16';

SELECT 'This is how to get all answers for a certain question (in this case the possible answers for [Who was the first president of US])' as '';
SELECT answer FROM answers INNER JOIN questions where question_answered = question_id AND question_id = 1;
