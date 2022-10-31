----------------------------------------------------------------Bellabeat Analysis----------------------------------------------------------------------

#Find the number of user ids 
SELECT 
  COUNT (DISTINCT ID)
FROM
  `invertible-now-355003.Fita_base.daily_Activity` #33 ids

SELECT 
  COUNT (DISTINCT ID)
FROM
  `invertible-now-355003.Fita_base.daily_Calories` #33 ids

SELECT 
  COUNT (DISTINCT ID)
FROM
  `invertible-now-355003.Fita_base.daily_Intensities` #33 ids

SELECT 
  COUNT (DISTINCT ID)
FROM
  `invertible-now-355003.Fita_base.daily_Steps` #33 ids

SELECT 
  COUNT (DISTINCT ID)
FROM
  `invertible-now-355003.Fita_base.hourly_Intensities` #33 ids

SELECT 
  COUNT (DISTINCT ID)
FROM
  `invertible-now-355003.Fita_base.sleep_Day` #24 ids


SELECT 
  COUNT (DISTINCT ID)
FROM
  `invertible-now-355003.Fita_base.weight_LogInfo` #8 ids 
  
#Check Calories,SedentaryMinutes,StepTotal 
SELECT
  activity.TotalSteps , steps.StepTotal
FROM
   `invertible-now-355003.Fita_base.daily_Activity` AS activity
INNER JOIN
   `invertible-now-355003.Fita_base.daily_Steps` AS steps
   ON
   activity.Id = steps.Id AND
   activity.ActivityDate = steps.ActivityDay

SELECT
  activity.Calories , calories.Calories
FROM
   `invertible-now-355003.Fita_base.daily_Activity` AS activity
INNER JOIN
   `invertible-now-355003.Fita_base.daily_Calories` AS calories
   ON
   activity.Id = calories.Id AND
   activity.ActivityDate = calories.ActivityDay

SELECT
  activity.SedentaryMinutes , intensities.SedentaryMinutes
FROM
   `invertible-now-355003.Fita_base.daily_Activity` AS activity
INNER JOIN
   `invertible-now-355003.Fita_base.daily_Intensities` AS intensities
   ON
   activity.Id = intensities.Id AND
   activity.ActivityDate = intensities.ActivityDay

--only focus on daily_Activity
#Checking Start-End Date and Id 

SELECT
  MIN(ActivityDate) AS start_date,
  MAX(ActivityDate) AS end_date
FROM
   `invertible-now-355003.Fita_base.daily_Activity`

--start_date	end_date	
--2016-04-12  2016-05-12

SELECT
  MIN(ActivityDay_) AS start_date,
  MAX(ActivityDay_) AS end_date
FROM
   `invertible-now-355003.Fita_base.hourly_Intensities`
--start_date	end_date	
--2016-04-12  2016-05-12

SELECT
  MIN(SleepDay) AS start_date,
  MAX(SleepDay) AS end_date
FROM
   `invertible-now-355003.Fita_base.sleep_Day`

--start_date	end_date	
--2016-04-12  2016-05-12

SELECT
  MIN(Date) AS start_date,
  MAX(Date) AS end_date
FROM
   `invertible-now-355003.Fita_base.weight_LogInfo`

--start_date	end_date	
--2016-04-12  2016-05-12


#Check all IDs have the same length

SELECT 
  ID
FROM
    `invertible-now-355003.Fita_base.daily_Activity`
WHERE
  Length(CAST(ID AS STRING)) > 10 OR  Length(CAST(ID AS STRING)) < 10
-- No values returned;

SELECT 
  ID
FROM
    `invertible-now-355003.Fita_base.hourly_Intensities`
WHERE
  Length(CAST(ID AS STRING)) > 10 OR  Length(CAST(ID AS STRING)) < 10
-- No values returned;

SELECT 
  ID
FROM
    `invertible-now-355003.Fita_base.sleep_Day`
WHERE
  Length(CAST(ID AS STRING)) > 10 OR  Length(CAST(ID AS STRING)) < 10
-- No values returned;

SELECT 
  ID
FROM
    `invertible-now-355003.Fita_base.weight_LogInfo`
WHERE
  Length(CAST(ID AS STRING)) > 10 OR  Length(CAST(ID AS STRING)) < 10
-- No values returned;


#find the duplites of each row

SELECT
  ID,
  ActivityDate,
  COUNT(*) AS num_of_ids
FROM
  `invertible-now-355003.Fita_base.daily_Activity`
GROUP BY
  ID,ActivityDate
HAVING
  num_of_ids>1

-- no data to display


SELECT
  ID,
  Date,
  COUNT(*) AS num_of_ids
FROM
  `invertible-now-355003.Fita_base.weight_LogInfo`
GROUP BY
  ID,	Date
HAVING
  num_of_ids>1

-- no data to display

SELECT
  ID,
  SleepDay,
  COUNT(*) AS num_of_ids
FROM
  `invertible-now-355003.Fita_base.sleep_Day`
GROUP BY
  ID,SleepDay
HAVING
  num_of_ids>1

-- There are 3 duplicate rows returned

#Remove the duplite rows

CREATE  TABLE invertible-now-355003.Fita_base.sleep_Day_new
AS SELECT *
FROM
(
  SELECT *, 
  ROW_NUMBER() 
  OVER (PARTITION BY Id, SleepDay)
  row_number
  FROM  `invertible-now-355003.Fita_base.sleep_Day`
)
WHERE row_number = 1

#Check duplite again 

SELECT
  ID,
  SleepDay,
  COUNT(*) AS num_of_ids
FROM
  `invertible-now-355003.Fita_base.sleep_Day_new`
GROUP BY
  ID,SleepDay
HAVING
  num_of_ids>1

-- no data to display 


#Find Unsuitable Data
#Check if  TotalSteps = 0 in daily_Activity
SELECT 
  Id,
  COUNT(*) AS num_of_zero_steps
FROM
  `invertible-now-355003.Fita_base.daily_Activity`
WHERE
  TotalSteps = 0
GROUP BY 
  Id
ORDER BY 
  num_of_zero_steps

-- 15 ids with zero total steps

#Create a new table and remove the zero steps

CREATE TABLE
  invertible-now-355003.Fita_base.daily_Activity_new
AS SELECT *
FROM `invertible-now-355003.Fita_base.daily_Activity`

#Delete all rows that contain zero steps
DELETE FROM 
  `invertible-now-355003.Fita_base.daily_Activity_new`
WHERE 
  TotalSteps = 0

#check NULL

SELECT 
  *
FROM
  `invertible-now-355003.Fita_base.daily_Activity_new`
WHERE 
  Id IS NULL
--no data display

SELECT 
  *
FROM
  `invertible-now-355003.Fita_base.hourly_Intensities`
WHERE 
  Id IS NULL
--no data display

SELECT 
  *
FROM
  `invertible-now-355003.Fita_base.sleep_Day_new`
WHERE 
  Id IS NULL
--no data display

SELECT 
  *
FROM
  `invertible-now-355003.Fita_base.weight_LogInfo`
WHERE 
  Id IS NULL
--no data display


#Usertype by total steps
SELECT
  Id,
  AVG(TotalSteps) AS avg_step,
CASE 
  WHEN AVG(TotalSteps) < 5000 THEN 'Sedentary Lifestyle'
  WHEN AVG(TotalSteps) BETWEEN 5000 and 8000 THEN 'Physically Inactive'
  WHEN AVG(TotalSteps) BETWEEN 8000 and 12000 THEN 'Physically Active'
  WHEN AVG(TotalSteps) > 12000 THEN 'Very Active'
END AS user_type_class
FROM
   `invertible-now-355003.Fita_base.daily_Activity_new`
GROUP BY Id
ORDER BY avg_step


#Usertype by tracker-wear
SELECT 
  Id,
  COUNT(Id) as total_user_activity,
  CASE
  WHEN COUNT(Id) BETWEEN 21 and 31 THEN 'Vigorous User'
  WHEN COUNT(Id) BETWEEN 11 and 20 THEN 'Moderate User'
  WHEN COUNT(Id) BETWEEN 1  and 10 THEN 'Gentle User'
  END AS user_activity_class
FROM
   `invertible-now-355003.Fita_base.daily_Activity_new`
GROUP BY Id
ORDER BY total_user_activity

#Average activity minutes by day of week
SELECT 
  day_of_week,
  ROUND(AVG(VeryActiveMinutes),2) AS avg_very_act_min,
  ROUND(AVG(FairlyActiveMinutes),2) AS avg_fairly_act_min,
  ROUND(AVG(LightlyActiveMinutes),2) AS avg_lightly_act_min,
  ROUND(AVG(SedentaryMinutes),2) AS avg_sed_act_min,
FROM
  (SELECT *,
  CASE 
  WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 1) THEN 'Mon'
  WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 2) THEN 'Tue'
  WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 3) THEN 'Wed'
  WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 4) THEN 'Thr'
  WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 5) THEN 'Fri'
  WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 6) THEN 'Sta'
  WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 7) THEN 'Sun'
  END as day_of_week
  FROM `invertible-now-355003.Fita_base.daily_Activity_new`
  ) 
GROUP BY day_of_week
ORDER BY 
   CASE
          WHEN day_of_week = 'Mon' THEN 1
          WHEN day_of_week = 'Tue' THEN 2
          WHEN day_of_week = 'Wed' THEN 3
          WHEN day_of_week = 'Thr' THEN 4
          WHEN day_of_week = 'Fri' THEN 5
          WHEN day_of_week = 'Sat' THEN 6
          WHEN day_of_week = 'Sun' THEN 7
     END ASC
 
 
 SELECT
  day_of_week,
  ROUND(AVG(TotalSteps),2) AS avg_total_steps,
  ROUND(AVG(TotalDistance),2) AS avg_total_dist,
  ROUND(AVG(Calories),2) AS calories
FROM
  (
    SELECT *,
    CASE
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 1) THEN 'Mon'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 2) THEN 'Tue'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 3) THEN 'Wed'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 4) THEN 'Thr'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 5) THEN 'Fri'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 6) THEN 'Sat'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 7) THEN 'Sun'
    END AS day_of_week 
    FROM `invertible-now-355003.Fita_base.daily_Activity_new`
  )
GROUP BY  day_of_week
ORDER BY 
   CASE
          WHEN day_of_week = 'Mon' THEN 1
          WHEN day_of_week = 'Tue' THEN 2
          WHEN day_of_week = 'Wed' THEN 3
          WHEN day_of_week = 'Thr' THEN 4
          WHEN day_of_week = 'Fri' THEN 5
          WHEN day_of_week = 'Sat' THEN 6
          WHEN day_of_week = 'Sun' THEN 7
     END ASC
  
  
 #Insight the relationship between total minutes asleep and daily steps

SELECT 
  activity.Id,
  activity.Totalsteps AS daily_steps,
  sleep.TotalMinutesAsleep AS daily_asleep
FROM
  `invertible-now-355003.Fita_base.daily_Activity_new` AS activity
INNER JOIN
  `invertible-now-355003.Fita_base.sleep_Day_new` AS sleep
ON activity.Id = sleep.Id
GROUP BY daily_steps,activity.Id,daily_asleep

SELECT
  sleep.Id,
  TotalMinutesAsleep,
  CASE
  WHEN TotalMinutesAsleep <= 420 THEN 'Less than 7h'
  WHEN TotalMinutesAsleep BETWEEN 421 and 540 THEN '7h to 9h'
  WHEN TotalMinutesAsleep > 540 THEN 'More than 9h'
  END AS sleep_quality,
  TotalSteps,
  CASE
  WHEN TotalSteps <= 4999 THEN 'Less than 5000 steps'
  WHEN TotalSteps BETWEEN 5000 and 7999  THEN '5000-7999 steps'
  WHEN TotalSteps BETWEEN 8000 and 11999  THEN '8000-11999 steps'
  WHEN TotalSteps > 12000  THEN 'More than 12000 steps'
  END AS steps_class
FROM
   `invertible-now-355003.Fita_base.sleep_Day_new` AS sleep
INNER JOIN
  `invertible-now-355003.Fita_base.daily_Activity_new` AS activity
ON activity.Id = sleep.Id
GROUP BY sleep.Id,TotalMinutesAsleep,TotalSteps
ORDER BY sleep_quality

#Insight the relationship between weight and calories burns

SELECT 
  activity.Id,
  AVG(activity.Calories) AS avg_calories,
  AVG(weight.WeightKg) AS avg_weightKg
FROM
  `invertible-now-355003.Fita_base.daily_Activity_new` AS activity
INNER JOIN
  `invertible-now-355003.Fita_base.weight_LogInfo` AS weight
ON activity.Id = weight.Id
GROUP BY activity.Id


#Insight the relationship between steps and calories burns

SELECT 
  activity.Id,
  activity.Totalsteps AS daily_steps,
  activity.Calories AS daily_calories
FROM
  `invertible-now-355003.Fita_base.daily_Activity_new` AS activity
GROUP BY activity.Id,daily_steps,daily_calories


#Comparison of Average Active Minutes By Usage Groups

CREATE TABLE invertible-now-355003.Fita_base.active_usage AS 
SELECT 
  Id,
  ROUND(AVG(VeryActiveMinutes),2) AS avg_very_act_min,
  ROUND(AVG(FairlyActiveMinutes),2) AS avg_fairly_act_min,
  ROUND(AVG(LightlyActiveMinutes),2) AS avg_lightly_act_min,
  ROUND(AVG(SedentaryMinutes),2) AS avg_sed_act_min,
  CASE
  WHEN COUNT(Id) BETWEEN 21 and 31 THEN 'Vigorous User'
  WHEN COUNT(Id) BETWEEN 11 and 20 THEN 'Moderate User'
  WHEN COUNT(Id) BETWEEN 1  and 10 THEN 'Gentle User'
  END AS user_activity_class
FROM
   `invertible-now-355003.Fita_base.daily_Activity_new`
GROUP BY Id
ORDER BY user_activity_class
  
SELECT 
  user_activity_class,
  ROUND(AVG(avg_very_act_min),2) AS user_very_act_min,
  ROUND(AVG(avg_fairly_act_min),2) AS user_fairly_act_min,
  ROUND(AVG(avg_lightly_act_min),2) AS user_lightly_act_min,
  ROUND(AVG(avg_sed_act_min),2) AS user_sed_act_min
FROM
  `invertible-now-355003.Fita_base.active_usage`
GROUP BY user_activity_class

#Intensity By Time, Day, Group Usage

SELECT 
  Intensities.Id,
  
  ActivityHour,
  ROUND(AVG(AverageIntensity),2) AS avg_intensities,
  CASE
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDay_) = 1) THEN 'Mon'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDay_) = 2) THEN 'Tue'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDay_) = 3) THEN 'Wed'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDay_) = 4) THEN 'Thr'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDay_) = 5) THEN 'Fri'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDay_) = 6) THEN 'Sat'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDay_) = 7) THEN 'Sun'
    END AS day_of_week,
  user_activity_class
FROM
   `invertible-now-355003.Fita_base.hourly_Intensities` AS Intensities
INNER JOIN 
  `invertible-now-355003.Fita_base.active_usage` AS usage
ON Intensities.Id = usage.Id
GROUP BY Intensities.Id,ActivityHour,user_activity_class,day_of_week


# Average Sleep Hours by Day, Group 

SELECT
  sleep.Id,
  user_activity_class,
   ROUND(AVG(TotalMinutesAsleep),2) AS avg_sleeptime,
  CASE
    WHEN (EXTRACT(DAYOFWEEK FROM SleepDay) = 1) THEN 'Mon'
    WHEN (EXTRACT(DAYOFWEEK FROM SleepDay) = 2) THEN 'Tue'
    WHEN (EXTRACT(DAYOFWEEK FROM SleepDay) = 3) THEN 'Wed'
    WHEN (EXTRACT(DAYOFWEEK FROM SleepDay) = 4) THEN 'Thr'
    WHEN (EXTRACT(DAYOFWEEK FROM SleepDay) = 5) THEN 'Fri'
    WHEN (EXTRACT(DAYOFWEEK FROM SleepDay) = 6) THEN 'Sat'
    WHEN (EXTRACT(DAYOFWEEK FROM SleepDay) = 7) THEN 'Sun'
    END AS day_of_week
FROM
  `invertible-now-355003.Fita_base.sleep_Day_new` AS sleep
INNER JOIN
  `invertible-now-355003.Fita_base.active_usage` AS usage
ON sleep.Id = usage.Id
GROUP BY sleep.Id, user_activity_class ,day_of_week

# Average Distance by Day, Group 
SELECT
  activity.Id,
  user_activity_class,
   ROUND(AVG(TotalDistance),2) AS avg_distence,
  CASE
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 1) THEN 'Mon'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 2) THEN 'Tue'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 3) THEN 'Wed'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 4) THEN 'Thr'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 5) THEN 'Fri'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 6) THEN 'Sat'
    WHEN (EXTRACT(DAYOFWEEK FROM ActivityDate) = 7) THEN 'Sun'
    END AS day_of_week
FROM
  `invertible-now-355003.Fita_base.daily_Activity_new` AS activity
INNER JOIN
  `invertible-now-355003.Fita_base.active_usage` AS usage
ON activity.Id = usage.Id
GROUP BY activity.Id, user_activity_class ,day_of_week

