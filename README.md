# How Can a Wellness Technology Company Play It Smart? - SQL -Tableau
Xinmei Luo

2022-09-08

🧰 excel ; Bigquery; Spreadsheet; Tableau

# 1.**Introduction:**

I have taken this case study from the Google Data Analytics courses on Coursera. In this case , I perform data analysis for Bellabeat, a high-tech manufacturer of health-focused products for women, and meet different characters and team members.

# **Scenario:**

I am a junior data analyst working on the marketing analyst team at Bellabeat.  Bellabeat is a successful small company, but they have the potential to become a larger player in the global smart device market. 

Urška Sršen, cofounder and Chief Creative Officer of Bellabeat, believes that analyzing smart device fitness data could help unlock new growth opportunities for the company. I have been asked to focus on one of Bellabeat’s products and analyze smart device data to gain insight into how consumers are using their smart devices. 

The insights I discover will then help guide marketing strategy for the company. I will present my analysis to the Bellabeat executive team along with  recommendations for Bellabeat’s marketing strategy.

There are six tips of the case: Ask , Prepare,  Process, Analysis, Share and Act.

# 2.Ask

- What are some trends in smart device usage?
- How could these trends apply to Bellabeat customers?
- How could these trends help influence Bellabeat marketing strategy?

# 3.Prepare

## **Data source**

In this project, I will be using datasets from [FitBit Fitness Tracker Data](https://www.kaggle.com/datasets/arashnic/fitbit),  which has been published by Möbius in Kaggle under the CC0: Public Domain Creative Common License.

## Dataset Summary

I downloaded zip files provided, then extracted to csv files. There are 18 datasets, but I only used 7 datasets for this study. Each document represents different quantitative data tracked by Fitbit.

![image](https://user-images.githubusercontent.com/113983558/199001028-ae393d03-4381-4a0f-b869-0f7f74c4da17.png)

I used excel to take a glimpse of the data ,.The data only collected  31 days information (04-12-2016 to 05-12-2016), which is outdate. No demographic information (gender, location, age) collected makes the data bias.

Any way , I used the excel to separate the date data by day and hour, check the data type.

## **Data Import**

After converting data type ,I opened Bigquery Console ,then select my Project. Create  Fita_base  name of the dataset .I imported the .csv datasets I previously downloaded from [FitBit Fitness Tracker Data](https://www.kaggle.com/datasets/arashnic/fitbit)
After that, I started  my work by finding the total number of user’s Id.

# 4.Process

## 4.1 ****Comparing Datasets****

from the number of ID, there are four datasets have common , daily_Activity , daily_Calories , daily_Intensities, daily_Steps .I checked if the id and date of those 3 tables are the same with the one in daily_Activity.

It showed the Calories, Sedentary Minutes, Step Total have the same number of rows and describe of data .So we only focus on daily_activity data.

and the remaining datasets that would be used in this study:

- daily_Activity
- sleep_Day
- weight_Log
- hourly_Intensities

##4.2 Checking Start-End Date and Id 

All the dataset show the same length :10 characters

## 4.3 Cleaning data

### move the duplicates
 Find unsuitable data
  Find NULL data
# 5.Analyze and Share

After cleaning the data

## 5.1 User type by total steps

According to the total steps ,I created four user types:

🚶‍♂️ Sedentary Lifestyle  → total steps < 5000 

🚶‍♂️ Physically Inactive  → 5000 < total steps < 8000

🚶‍♂️ Physically Active → 8000 < total steps < 12000

🚶‍♂️ Very Active  → total steps > 12000
 
 ![image](https://user-images.githubusercontent.com/113983558/199001615-df6252e1-d116-4b6f-b8ee-3e935e7c5596.png)

 ✍️**Key takeaway** : 

- More than 2/3 users keep moderately active
- Sedentary lifestyle are always not to be underestimated

## 5.2 User type by tracker-wear

According to the tracker-wear days  ,I created three user types:

⌚ Vigorous User  → 21-31 days

⌚ Moderate User  →  11-20 days

⌚ Gentle User  →  1-10 days

![image](https://user-images.githubusercontent.com/113983558/199001794-e97c930e-c131-440f-8c7a-d34b6f7365a1.png)

✍️**Key takeaway** : 

- More than 3/4 users are vigorous user
- Moderate user are potential active user


## 5.3 look deep into data day by day

### 5.3.1 Average activity minutes by day of week

➡️First , I want to find the user activity trend between weekdays and weekends:
![image](https://user-images.githubusercontent.com/113983558/199001894-4ee77a67-94bb-4bc7-8b05-0d3109a6d934.png)

✍️**Key takeaway** : 

- the four part of activity minutes are almost **no differences**
- **Sedentary Minutes** are the highest type of active minutes


### 5.3.2  Average of steps, distances, and calories

➡️Next, I wanted to know the average of steps, distances, and calories spent per week.

![image](https://user-images.githubusercontent.com/113983558/199002004-4bcf8120-330b-4ecc-a657-0a76a66b23ca.png)

✍️**Key takeaway** : 

- The highest average step and distance per day was on **Sunday** and **Wednesday** with **almost 9 thousand steps** and **6 km distance**.
- Average calories shows little difference throughout the week.

### 5.3.3 Find Correlations : ****total minutes asleep , steps, calories and weight****

➡️We will now determine if there is any correlation between different variables:

- Daily steps and daily sleep
- Average calories and weight
- Calories burned by steps

1️⃣Firstly, I bind the ****total minutes asleep and steps,**** I want to insight whether the asleep time related to steps.

![image](https://user-images.githubusercontent.com/113983558/199002105-4b7eae3a-3f6d-458e-afd4-6fa5dad43eaa.png)

✍️**Key takeaway** : 

- There is **no correlation** between daily activity level based on steps and the amount of minutes users sleep a day.

⚒️ **Make adjustments**

Now, distribute the sleep time , as we know , mostly asleep time  between 7h and 9h ,then I  will insight the steps .

![image](https://user-images.githubusercontent.com/113983558/199002956-d388483f-a244-4d58-ab40-5dc814d995c3.png)

✍️**Key takeaway** : 

- Participants average hour of sleep follows a normal distribution, with majority sleeping or 7-9 hours.
- There a more participants that receive 'Below Recommended' amounts of sleep than there those the receive 'Above Recommended' amounts of sleep.
- Exercise appropriately may help sleep well

2️⃣Secondly, I bind the calories and weights****,**** I want to insight whether the weight related to the  burn calories.

![image](https://user-images.githubusercontent.com/113983558/199003072-4d128c65-657a-48c2-8bde-5b0ab3d108fb.png)

✍️**Key takeaway** : 

- around  the healthy weight ,the calories burn steadily
- more fat facilitate ones burn more calories to lose weight
- Excessive obesity will Loss of confidence to lose weight

3️⃣Then , I bind the calories and steps****,**** I want to insight how close  the steps related to the  burn calories.

![image](https://user-images.githubusercontent.com/113983558/199003158-4a852b0c-97e7-4f58-92df-4bd9ce5487e3.png)

✍️**Key takeaway** : 

- there is a clear positive correlation between these two variables: the more steps taken in a day, the more calories burned.

## 5.4 look deep into data  by user type

### 5.4.1 ****Comparison of Light and Active Minutes****

➡️Here we will compare how the four states of activity grouped between Light Minutes (Sedentary & Lightly Active Minutes) and Active (Fairly Active & Very Active Minutes) across Usage Groups.

![image](https://user-images.githubusercontent.com/113983558/199003272-9032d178-fa81-4f7c-8586-34b93e165534.png)

![image](https://user-images.githubusercontent.com/113983558/199003311-eb7a5931-67ac-41a2-8ff4-81059eac2e32.png)

✍️**Key takeaway** : 

- **'Vigorous User' participants are exceptionally active**, with 40 mins of daily active minutes. Compared to 21 mins for 'Moderate User' participants and lower 10 mins for 'Gentle User' participants.
- Likewise **'Vigorous User'** participants are considerably less sedentary with 900 minutes of light minutes. Compared to approximately 1200 minutes for both 'Moderate' and 'Gentle User' participants.

### 5.4.2 Intensities ****by Day, Usage Group****

➡️  Here we will compare how the Intensities of activity grouped across Usage Groups.

![image](https://user-images.githubusercontent.com/113983558/199003386-be85b326-4384-46c6-802f-8af1839abdfb.png)

✍️**Key takeaway** : 

- **'Vigorous User'** participants **** tend to maintain a **high average hourly intensity rate across all days of the week.**
- Compared to other groups, the '**Vigorous User**' participants are display higher intensities between 16:00PM - 19:00PM. We can assume that participants from this group are excercising after they  work.


### 5.4.3 ****Average Sleep Hours by Day, Group****

➡️  Here we plot out the average sleep hours between the different Usage Groups.

![image](https://user-images.githubusercontent.com/113983558/199003499-86deb0d5-23f3-475a-a995-8d11a6b6912e.png)

✍️**Key takeaway** : 

- The '**Vigorous User**'  group has a relatively lower average hours of sleep. The variability of sleep for this group also follows a more consistent pattern as oppose to other groups.
- The **'Moderate User'** group has the highest average hours of sleep . The variability of sleep is inconsistent through the week.
- The **‘Gentle User’ group was not found in the sleep data .**

### 5.4.4 ****Average Distance  by Day, Group****

➡️  Here we plot out the average distance miles between the different Usage Groups.

![image](https://user-images.githubusercontent.com/113983558/199003550-b712d295-5cb4-468e-b441-737b2a2a8fb9.png)


✍️**Key takeaway** : 

- The '**Vigorous User**'  group has a relatively highest daily move distance . The variability of distance for this group also follows a more consistent cross day of week.
- The **'Moderate User'** group has the almost 1/2 average miles  of distance . The variability of miles is inconsistent through the week.
- The **‘Gentle User’  was not found in the Monday and Tuesday .**

# 6.Act and Recommendations

👉Follow the questions:

**1. What are some trends in smart device usage?**

**a)** The Fitbit data show that not every tracker user have not fully utilize the function of smart device. All 33 unique users  open the steps function, 24/33 users open the sleep tracking function, and only 8/33 users used their device to record their weight data. With the '**Vigorous User**' regularly use the device, other users and functions were used irregularly.

**b)**'**Vigorous User**'

This group consists of 25 users or 76% of the total sample size, and wears the device regularly between 21-31 days. This is the most active group in every exercise day by day, with most time and miles. They complete more than 26 miles a week, which is over a half marathons.

They spend more than 40 minutes a day on fairly and very active exercise. Amongst all other groups, they have the highest and also the widest range in calorie burned and steps taken. Suggesting users are varied in the ways that they are active. 

They are consistently active through the week with little difference in activity minutes and calories. They keep a habitual exercise routine.

**c)'Moderate User'**

This group consists of 7 users or 21% of the total sample size, and wears the device between 11 - 20 days. Users in the group are less active and walk fewer steps compared with the Vigorous User

over the weekdays but active on during the weekends, between 08:00AM to 1:00PM. 

While they less active ,they also have their exercise  routine , and sufficient sleep.

**d)‘Gentle User’**

This group consists of 1 user or 3% of the total sample size, and wears the device between 11 - 20 days, Which is too small to provide meaningful analysis. 

**2. How could these trends apply to Bellabeat customers?**

a)During the user trends ,we can see steps and sleep monitor are the prefer functions user like to use .

b)While lack of weight data ,we also can speculate the user tracker the swatch to lose weight. 

c)How to make the user **understand the benefits of smartwatches and full use the  tracker may be the most important task.**

   

**3. How could these trends help influence Bellabeat marketing strategy?**

**My Recommendations** are here:

Product designers could focus on gamifying features to encourage more frequent use in the devices.

**a)Add socializing Features & Reward mechanism**

1️⃣Set the list of **Steps, Calories ,** **Sedentary Minutes, etc.** To compare the list number and balance the exercise condition for most of people ,find the fit habitual routine and keep healthy , while keep healthy also win the prize .Users can be engaged further by receiving prompts on how they are doing at the point of the day or week when compared to others in their age/location/gender group.

2️⃣Congratulating users on meeting their targets or encouraging them to go the extra mile. These could be some of the prompts/push-notifications:

- Keep it up! You’re almost as active as you were this time last week!
- You’re not alone in this! You’re in the 50th percentile of most active minutes this week!
- Rest up! A good recovery is just as important as a good run.

3️⃣Set the medal for full usage of the tracker function, and send the reports daily and weekly.

**b)Expanding device line-up & Facilitate purchases**

1️⃣To monitor the heart rate and exercise routine ,Set the Exception warning and Fall detection, and so on .When happened to the condition ,initiate alert function ,After more than 1 minute send Automatic alarm to the ambulance. This is the **purchase function. Or the whole** medals attain fixed numbers or the list number is always high ,which can get this function free.

2️⃣Simplify the device screen , user can set the data show .

3️⃣Offer the free watchband and screen maintenance service for the medal and active user.

**c)Email** 

The most important function of an health-focused product is detect health conditions ,and conform an reliable report to user, which can help user understand their healthy condition more specifically. 

The report must obey the fitness  authority  and give the advice sincerely.


