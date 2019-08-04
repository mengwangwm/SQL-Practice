--597.Friend Requests I: Overall Acceptance Rate
select
round(
    ifnull(
    (select count(*) from (select distinct requester_id, accepter_id 
                           from request_accepted
                           WHERE (requester_id, accepter_id) IN 
                           (SELECT DISTINCT sender_id, send_to_id FROM friend_request) 
                          ) as A)
    /
    (select count(*) from (select distinct sender_id, send_to_id from friend_request) as B),
    0)
, 2) as accept_rate




--181.Employees Earning More Than Their Managers
SELECT e1.Name AS Employee
FROM Employee e1
JOIN Employee e2
ON e1.ManagerId = e2.Id
WHERE e1.Salary > e2.Salary
--OR
SELECT e1.Name FROM Employee e1, Employee e2
WHERE e1.ManagerId = e2.Id AND e1.Salary > e2.Salary;



--176.Second Highest Salary
select max(Salary) as SecondHighestSalary from Employee 
where Salary < (select max(Salary) from Employee)
--OR
select if(count(Salary) >= 1, Salary, null) as SecondHighestSalary 
 from (select distinct salary from Employee 
 order by Salary desc limit 1,1) tmp




 --175. Combine Two Tables
 SELECT Person.FirstName, Person.LastName, Address.City, Address.State
 FROM Person JOIN Address ON Person.PersonId = Address.PersonId





 --177. Get Highest Salary
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    set N=N-1;
  RETURN (
      select distinct e.Salary 
      from Employee e 
      order by Salary Desc 
      limit N,1
  );
END













--184.Department Highest Salary
Select
    Department.Name, emp1.Name, emp1.Salary
from 
    Employee emp1
join
    Department on emp1.DepartmentId = Department.Id
where
    emp1.Salary = (Select Max(Salary) from Employee emp2 
    	where emp2.DepartmentId = emp1.DepartmentId);

SELECT d.Name AS 'Department', e.Name AS 'Employee', e.Salary AS 'Salary'
FROM Employee e JOIN Department d ON e.DepartmentId = d.Id
WHERE (d.Id, e.Salary) IN (SELECT e.DepartmentId, MAX(Salary)
FROM Employee e JOIN Department d ON e.DepartmentId = d.Id
GROUP BY e.DepartmentId)





--578.Get Highest Answer Rate Question
(SELECT question_id, SUM(IF(action='show',1,0)) AS num_show, 
	   SUM(IF(action='answer',1,0)) AS num_answer
FROM survey_log GROUP BY question_id) AS t

SELECT question_id AS survey_log
FROM (SELECT question_id, SUM(IF(action='show',1,0)) AS num_show, 
	   SUM(IF(action='answer',1,0)) AS num_answer
	  FROM survey_log GROUP BY question_id) AS t 
ORDER BY (num_answer/num_show) DESC 
LIMIT 1








--602.Friend Requests II: Who Has the Most Friends
select a.id, count(*) as num
from 
	(select requester_id as id from request_accepted
	union all 
	select accepter_id as id from request_accepted) a
group by id
order by num desc
limit 1










--185.Department Top Three Salaries
SELECT d.Name AS Department, e.Name AS Employee, e.Salary FROM Employee e
JOIN Department d on e.DepartmentId = d.Id
WHERE (SELECT COUNT(DISTINCT Salary) FROM Employee WHERE Salary > e.Salary
AND DepartmentId = d.Id) < 3 
ORDER BY d.Name, e.Salary DESC














































######### Composer

table composer:
--userid | event | date,

#### what is the post success rate for each day in the last week?
SELECT date, 
       
ROUND(IFNULL( 
SUM(IF(event = 'post',1,0)) 
/SUM(IF(event = 'enter',1,0)),0),2) AS post_success_rate

FROM Composer

WHERE DATEDIFF(CURDATE(),date) <= 7

GROUP BY date;



	




table user:
--userid | date | country | dau_flag{0,1}



#### what is the average number of post per daily active user by country today?

SELECT u.country, 
       
ROUND(IFNULL( SUM(IF(c.event='post',1,0))/COUNT(userid) ,0),2) AS avg_posts

FROM User u 
LEFT JOIN Composer c 
ON u.userid = c.userid AND u.date = c.date

WHERE u.dau_flag == 1 AND date = CURDATE()

GROUP BY country





######### Message

table message:
--date | timestamp | send_id | receive_id

#### What’s the fraction of users communicating to > 5 users in a day?

SELECT date, ROUND(IFNULL( SUM(IF(cnt>5,1,0)) / COUNT(id) ,0),2) AS fraction

	(SELECT date, id, COUNT(*) AS cnt
	FROM
		(SELECT date, send_id as id FROM message)
		UNION ALL 
		(SELECT date, receive_id AS id FROM message)
	GROUP BY date, id)
GROUP BY date;




######### SMS-message

SQL — sms_message (fb to users)
| date | country | cell_numer | carrier | type
|2018-12-06 | US | xxxxxxxxxx | verizon | confirmation (ask user to confirm)
|2018-12-05 | UK | xxxxxxxxxx | t-mobile | notification

confirmation (users confirmed their phone number)
|date | cell_number |
(User can only confirm during the same day FB sent the confirmation message)

#### 1. yesterday how many confirmation texts by country.

SELECT country, COUNT(*)
FROM sms_message
WHERE type = ‘confirmation’ AND DATEDIFF(CURDATE(), date) = 1
GROUP BY 1
ORDER BY 2 DESC;

#### 2. Number of users who received notification every single day during the last 7 days.

SELECT COUNT(cell_number) AS num_users
FROM sms-message
WHERE type = 'notification' AND DATEDIFF(CURDATE(),date) <= 7
GROUP BY cell_number
HAVING COUNT(DISTINCT date) = 7

#### 3. confirmation rate for the past 30 days

SELECT ROUND(IFNULL( SUM(is_confirmed) / SUM(is_sent), 0),2) AS confirmation_rate
FROM (SELECT DISTINCT date, cell_number, 1 AS is_sent FROM sms-message WHERE type = 'confirmation' ) u
LEFT JOIN (SELECT DISTINCT date, cell_number, 1 AS is_confirmed FROM confirmation) t
ON u.date=t.date AND u.cell_number = t.cell_number
WHERE DATEDIFF(CURDATE(),date) <= 30 





######### SPAM 

Table: user_actions
ds (STRING) | user_id (BIGINT) |post_id (BIGINT) |action (STRING) | extra (STRING)
'2018-07-01'| 1209283021       | 329482048384792 | 'view'         |
'2018-07-01'| 1209283021       | 329482048384792 | 'like'         | 
'2018-07-01'| 1938409273       | 349573908750923 | 'reaction'     | 'LOVE'
'2018-07-01'| 1209283021       | 329482048384792 | 'comment'      | 'Such nice Raybans'
'2018-07-01'| 1238472931       | 329482048384792 | 'report'       | 'SPAM'
'2018-07-01'| 1298349287       | 328472938472087 | 'report'       | 'NUDITY'
'2018-07-01'| 1238712388       | 329482048384792 | 'reshare'      | 'I wanted to share with you 

#### 1.how many posts were reported yesterday for each report Reason?

reason | num_posts

SELECT extra AS reason, COUNT(DISTINCT post_id) AS num_posts
FROM user_actions
WHERE action = 'report' AND 
      DATEDIFF(CURDATE(), 
              (SELECT STR_TO_DATE(ds,'%Y-%m-%d')) 
               FROM use_actions) = 1
GROUP BY extra;


Table: reviewer_removals
ds (STRING) | reviewer_id (BIGINT) | post_id (BIGINT) |  
'2018-07-01'| 3894729384729078     | 329482048384792  |                
'2018-07-01'| 8477594743909585     | 388573002873499  | 


#### 2: what percent of daily content that users view on FB is actually spam? 
(no need to consider if the removal happen at the same post date or not.)

SELECT u.date, u.user_id, ROUND(IFNULL(SUM(is_remove)/COUNT(DISTINCT u.post_id),0),2) AS percentage_SPAM
FROM user_actions u
LEFT JOIN (SELECT *, 1 is_remove FROM reviewer_removals) r
ON u.post_id = r.post_id
GROUP BY date, user_id;

#### 3. How to find the user who abuses this spam system?

SELECT u.user_id, COUNT(DISTINCT u.post_id) AS num_rep_spam, SUM(r.is_remove) AS num_real_spam
FROM user_actions u
LEFT JOIN (SELECT *, 1 is_remove FROM reviewer_removals) r
ON u.post_id = r.post_id
WHERE u.action = 'report' AND u.extra = 'SPAM'
GROUP BY u.user_id


#### 4. What percent of yesterday's content views were on content reported for spam?

SELECT ROUND(IFNULL( SUM(is_rep_spam)/SUM(is_viewed) ,0),2) as percentage_spam_from_view
FROM
	(SELECT post_id, 1 AS is_viewed 
	FROM user_actions 
	WHERE action = 'view' AND DATEDIFF(CURDATE(),date) = 1 
	GROUP BY post_id) v
LEFT JOIN
	(SELECT post_id, 1 AS is_rep_spam 
	FROM user_actions 
	WHERE action = 'report' AND 
	      extra = 'spam' AND 
	      DATEDIFF(CURDATE(),date) = 1 
	GROUP BY post_id) s
ON v.post_id = s.post_id







######### Payment page
Table: payment
-- user, group, time, displays, clicks

#### number of clicks and displays in a given day

SELECT SUM(cliks), SUM(displays)
FROM payment
GROUP BY time;

#### click through rate

SELECT ROUND(IFNULL(SUM(clicks)/SUM(displays),0),2) AS click_rate
FROM payment

#### click through rate for each group

SELECT ROUND(IFNULL(SUM(clicks)/SUM(displays),0),2) AS click_rate
FROM payment
GROUP BY group;







######### fraud
Table: fraud
-- ad_account,date, spend, status (open,close,fraud)

#### the rate of fraud of active account

SELECT SUM(IF(status='fraud',1,0))/SUM(IF(spend>0,1,0)) AS rate_fraud
FROM fraud

#### num of acccount that have been labeled as fraud today?

SELECT COUNT(DISTINCT ad_account)
FROM fraud
WHERE status = 'fraud' AND date= CURDATE()






######### comment distribution
Table: content_action 
-- Date, User_id (), Content_id (primary key),Content_type (status_update, photo, video, comment),
Target_id (it’s the original content_id associated with the comment, if the content type is not comment, this will be null)


#### find the distribution of stories(photo+video) based on comment count?

SELECT t.num_stories, COUNT(t.user_id)
FROM 
(SELECT user_id, COUNT(DISTINCT content_id) AS num_stories
 FROM content_action
 WHERE content_type = 'photo' OR content_type = 'video'
 GROUP BY user_id ) t

#### 2. what if content_type becomes (comment/ post), what is the distribution of comments?

SELECT t.num_comment, COUNT(t.user_id)
FROM 
(SELECT user_id, COUNT(DISTINCT content_id) AS num_comment
 FROM content_action
 WHERE content_type = 'comment'
 GROUP BY user_id ) t

#### 3.Now what if content_type becomes {comment, post, video, photo, article}
#### what is the comment distribution for each content type?

SELECT t.content_type, t.num_comment, COUNT(t.user_id) AS freq
FROM 
(SELECT user_id, content_type, COUNT(DISTINCT content_id) AS num_comment
 FROM content_action
 GROUP BY user_id, content_type ) t



#### 4. distribution of number of comments per post, by post type









######### marketplace
Table: session
-- Date, sessionid, userid, action (login/exit/logout)
Table: time (unique session_id)
-- Date, Sessionid, time_spent (s)


#### 1. Average sessions/user per day within the last 30 days

SELECT  date, 
	COUNT(session_id)/COUNT(DISTINCT user_id) AS session_user
FROM session
WHERE DATEDIFF(CURDATE(),date) <= 30
GROUP BY date


#### 2. # of users who at least spent more than 10s on each session

SELECT COUNT(user_id) AS num_users
FROM
(SELECT a.user_id, COUNT(session_id)/COUNT(IF(a.time_spend>=10,1,0) AS ratio
FROM
	(SELECT s.user_id, t.session_id, t.time_spend
 	FROM session s
 	JOIN time t
 	ON s.session_id = t.session) a
GROUP BY a.user_id)
WHERE ratio=1


#### 3. Average time spent on session 1 per user within the last 30 days

SELECT s.user_id, IFNULL(avg(t.time_spend),0) AS avg_time
FROM session s
LEFT JOIN time t
ON s.session_id = t.session_id
WHERE s.session_id = 1 AND DATEDIFF(CURDATE(), s.date) <= 30
GROUP BY s.user_id


#### 4. Plot the histogram of avg(time_spent). 
#### How do you know within certain time period, how many people are in there?


CREATE FUNCTION time_hist (t1 , t2) RETURNS INT DETERMINISTIC
BEGIN

SELECT COUNT(p.user_id) AS freq
FROM 
(SELECT s.user_id, IFNULL(avg(t.time_spend),0) AS avg_time
 FROM session s
 LEFT JOIN time t
 ON s.session_id = t.session_id
 WHERE s.session_id = 1 AND DATEDIFF(CURDATE(), s.date) <= 30
 GROUP BY s.user_id) p
WHERE p.avg_time > t1 AND p.avg_time <= t2

END;

SELECT time_hist(10,20)





######### friend request
Table: request
-- sender_id, send_to_id, time)
Table: accept
-- requester_id, accepter_id, time)


#### 1. On date XXX, what's the acceptance rate/percentage?

## with date
SELECT r.date, ROUND(IFNULL( SUM(is_accept)/SUM(is_send) ,0),2) AS accept_rate
FROM 
(SELECT DISTINCT sender_id AS id_1, send_to_id AS id_2, request_date AS date, 1 AS is_send
FROM friend_request) r
LEFT JOIN
(SELECT DISTINCT requester_id AS id_1, accepter_id AS id_2, accept_date AS date, 1 AS is_accept
FROM request_accepted) a
ON r.id_1 = a.id_1 AND r.id_2 = a.id_2 AND r.date = a.date
GROUP BY r.date

## without date
SELECT ROUND(IFNULL( SUM(is_accept)/SUM(is_send) ,0),2) AS accept_rate
FROM 
(SELECT DISTINCT sender_id AS id_1, send_to_id AS id_2, 1 AS is_send
FROM friend_request) r
LEFT JOIN
(SELECT DISTINCT requester_id AS id_1, accepter_id AS id_2, 1 AS is_accept
FROM request_accepted) a
ON r.id_1 = a.id_1 AND r.id_2 = a.id_2 



#### 2. who has the most friend

SELECT u.id, COUNT(*) AS num
FROM
(SELECT requester_id AS id FROM request_accepted
UNION ALL
SELECT accepter_id as id FROM request_accepted) u
GROUP BY u.id
ORDER BY num DESC
LIMIT 1











######### interactions
table 1: 
--user1 | user2
123 456
456 123
123 789
789 123
table 2: 
--sender | reciepient | action | date
123 456 create 2019-01-01
456 123 create 2019-01-01
123 789 create 2019-01-01


#### number of interactions (creats) for each pair of the friend


SELECT u.user1, u.user2, COUNT(*) AS num_interactions
FROM (SELECT DISTINCT user1, user2 FROM table_1 WHERE user1 < user2) u
LEFT JOIN
table_2 t
ON (u.user1 = t.sender AND u.user2=t.recipient) OR (u.user2 = t.sender AND u.user1=t.recipient)
GROUP BY u.user1, u.user2







######### message failure
table 1:  --date, userid, message_sends
table 2:  --date, userid, failed_message_sends


####Write a query to obtain avg number of successful message-sends for users in 2 groups: 
####(1)who did not have message_send failure on a given day. 

SELECT ROUND(IFNULL(AVG(message_sends),0),2) as avg_suc
FROM table_1
WHERE date = 'XXX' AND
      userid IN 
		(SELECT DISTINCT userid 
	 	FROM table_2 
	 	WHERE failed_message_sends = 0 AND date = 'XXX')

####(2) users who faces message-send failure on that day

SELECT ROUND(IFNULL(AVG(t1.message_sends),0),2) as avg_suc
FROM table_1 t1 JOIN table_2 t2 ON t1.userid = t2.userid
WHERE date = 'XXX' AND t2.failed_message_sends >0








######### spotify
table 1:  --time | userid | songid
table 2:  --userid1 | userid2


#### the most frequent song today

SELECT songid, COUNT(DISTINCT user_id) AS num
FROM table_1
WHERE DATE(time) = CURDATE()
GROUP BY songid
ORDER BY num DESC
LIMIT 1


#### pairs of friends who share more than two songs


SELECT T1.userid1, T1.userid2, COUNT(DISTINCT T2.songid) AS num_song
FROM table2 T1
JOIN table1 T2 ON T1.userid1 = T2.userid
JOIN table1 T3 ON T1.userid2 = T3.userid AND T2.songid = T3.songid
GROUP BY 1, 2
HAVING num_song >= 2;



######### AD_ROI
adv_info: 
--advertiser_id| ad_id| spend
(The Advertiser pay for this ad)

ad_info: 
--ad_id| user_id| price
(The user spend through this ad (Assume all prices in this column >0))

#### 1. The fraction of advertiser has at least 1 conversion?

SELECT COUNT(v.advertiser_id)/ (SELECT COUNT(DISTINCT advertiser_id) FROM adv_info) AS fraction
FROM adv_info v
JOIN ad_info a
ON v.ad_id = a.ad_id

#### 2. What metrics would you show to advertisers

CASE 1: ROI each ad each advertiser

SELECT T1.advertiser_id, T1.ad_id, SUM(IFNULL(T2.price, 0))/T1.spend AS ad_ROI
FROM adv_info T1
LEFT JOIN ad_info T2
ON T1.ad_id = T2.ad_id
GROUP BY 1, 2;

CASE 2: ROI each advertiser

SELECT T1.advertiser_id, ROUND(IFNULL(total_revenue/total_spend, 0), 2) AS adv_ROI
FROM
	(SELECT advertiser_id, SUM(IFNULL(spend, 0)) AS total_spend
	FROM adv_info
	GROUP BY 1) T1
LEFT JOIN
	(SELECT advertiser_id, SUM(IFNULL(T2.price, 0)) AS total_revenue
	FROM adv_info
	LEFT JOIN ad_info
	ON adv_info.ad_id = ad_info.ad_id
	GROUP BY 1) T2
ON T1.advertiser_id = T2.advertiser_id;








######### AD_ROI
survey_log: 
--user_id,question_id,question_order,event = {imp, answered,skipped},timestamp

#### question who has the highest answer rate

(SELECT question_id, SUM(IF(action='show',1,0)) AS num_show, 
	   SUM(IF(action='answer',1,0)) AS num_answer
FROM survey_log GROUP BY question_id) AS t

SELECT question_id AS survey_log
FROM (SELECT question_id, SUM(IF(action='show',1,0)) AS num_show, 
	   SUM(IF(action='answer',1,0)) AS num_answer
	  FROM survey_log GROUP BY question_id) AS t 
ORDER BY (num_answer/num_show) DESC 
LIMIT 1














    