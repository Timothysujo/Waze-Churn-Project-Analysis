Use waze_dataset;

-- Dataset
Select *
From users;

-- Q1. What is the overall churn rate, and how does the number of retained
--    vs. churned users compare?
Select label, 
count(*) as count, 
count(*) * 100 / sum(Count(*)) OVER () AS percentage
From users
Group By label;

# Overall churn rate is 16.9%, with 4.67% null.

-- Q2. Do users with above-average monthly sessions have a lower churn rate
--    than users with below-average sessions?

Select label, avg(total_sessions) as avg_total_sessions
from users
Group By label;
# Retained: 187.96 avg total sessions
# Churned: 196.89 avg total sessions
# Users who churned actually had a higher total sessions rate than retained.



-- Q3. Which activity-day groups have the highest and lowest churn rates?
Select 
CASE
	WHEN activity_days < 6 THEN "0-5"
    WHEN activity_days BETWEEN 6 and 10 THEN "6-10"
    WHEN activity_days BETWEEN 11 and 15 THEN "11-15"
    WHEN activity_days BETWEEN 16 and 20 THEN "16-20"
    WHEN activity_days BETWEEN 21 and 26 THEN "21-26"
    WHEN activity_days > 26 THEN "Greater than 26"
END as activity_day_groupings, COUNT(*) as total_users,
SUM(CASE
WHEN label = "churned" 
THEN 1 ELSE 0 END) AS churned_users,
SUM(CASE 
WHEN label = "churned" THEN 1 ELSE 0 END) * 100 / COUNT(*) AS churn_rate_pct
From users
Group By activity_day_groupings
ORDER BY churn_rate_pct desc;
# 0-5: 36.23%
# 6-10: 25.21%
# 11-15: 16.8%
# 16-20: 10.53%
# 21-26 7.10%
# Greater than 26: 4.53%
# 0-5 had highest churn rate pct followed by 6-10 activity days, followed by 11-15, followed by 16-20, followed by 21-26, followed by greater than 26

-- Q4. How does average driving distance differ between retained and
--     churned users?
Select label, avg(driven_km_drives) as avg_driven_km_drives
FROM users
GROUP BY label;
# Retained: 4022 km driven
# Churned: 4147 km driven average

-- Q5. How does churn vary across different onboarding-age groups?
Select
CASE 
	WHEN n_days_after_onboarding BETWEEN 0 and 500 THEN "0-500"
    WHEN n_days_after_onboarding BETWEEN 500 and 1000 THEN "500-1000"
    WHEN n_days_after_onboarding BETWEEN 1000 and 1500 THEN "1000-1500"
    WHEN n_days_after_onboarding BETWEEN 1500 and 2000 THEN "1500-2000"
    WHEN n_days_after_onboarding BETWEEN 2000 and 2500 THEN "2000-2500"
    WHEN n_days_after_onboarding BETWEEN 2500 and 3000 THEN "2500-3000"
    WHEN n_days_after_onboarding > 3000 THEN ">3000"
END as n_days_after_onboarding_groupings, count(*) as label_count,
SUM(CASE
WHEN label = "churned" 
THEN 1 ELSE 0 END) AS churned_users,
SUM(CASE 
WHEN label = "churned" THEN 1 ELSE 0 END) * 100 / COUNT(*) AS churn_rate_pct
FROM users
GROUP BY n_days_after_onboarding_groupings
ORDER BY churn_rate_pct desc;

# 0-500: 23.94%
# 500-1000: 22.39%
# 1000-1500: 19.36%
# 1500-2000: 15.34%
# 2000-2500: 14.33%
# 2500-3000: 11.84%
# >3000: 11.1%
# Highest churn rate is the 0-500 group, and as the number of days after onboarding increases, churn rate percentage decreases

-- Q6. Do users who navigate to their favorite locations more frequently
--     have lower churn rates?
SELECT
	total_navigations_fav_bucket,
    COUNT(*) as label_count,
    SUM(CASE WHEN label = "Churned" THEN 1 ELSE 0 END) AS churned_users,
	SUM(CASE WHEN label = "Churned" THEN 1 ELSE 0 END) * 100 / count(*) AS churned_rate_pct
FROM(
	SELECT (total_navigations_fav1 + total_navigations_fav2), label,
	CASE
		WHEN (total_navigations_fav1 + total_navigations_fav2) < 50 THEN "0-50"
		WHEN (total_navigations_fav1 + total_navigations_fav2) BETWEEN 50 AND 100 THEN "50-100"
		WHEN (total_navigations_fav1 + total_navigations_fav2) BETWEEN 101 AND 150 THEN "101-150"
		WHEN (total_navigations_fav1 + total_navigations_fav2) BETWEEN 151 AND 200 THEN "151-200"
		WHEN (total_navigations_fav1 + total_navigations_fav2) BETWEEN 201 AND 250 THEN "201-250"
		WHEN (total_navigations_fav1 + total_navigations_fav2) BETWEEN 251 AND 300 THEN "251-300"
		WHEN (total_navigations_fav1 + total_navigations_fav2) > 300 THEN ">300"
	END AS total_navigations_fav_bucket
	FROM users
) AS t
GROUP BY total_navigations_fav_bucket
ORDER BY churned_rate_pct desc;

# Churn rate pct.
# >300: 21.4%
# 151-200: 17.93%
# 201-250: 17.77%
# 101-150: 16.28%
# 251-300: 16.23%
# 50-100: 15.96%
# 0-50: 15.17%
# It seems that users who have traveled to over 300 navigations have the highest percentage. However, the churned rate percentages are relatively close together, so it is difficult to draw any conclusions.

-- Q7. What is the number of Android and iPhone users in the dataset?
Select device, count(*) as num_devices, 
count(*) * 100 / sum(count(*)) OVER () AS percentage
FROM users
GROUP BY device;
# 35% of users Android, 65% of users iPhone

-- Q8. Do Android and iPhone users have different churn rates?
Select device, count(*) as num_devices, 
count(*) * 100 / sum(count(*)) OVER () AS percentage, label
FROM users
GROUP BY device, label
HAVING label = "retained";

Select device, count(*) as num_devices, 
count(*) * 100 / sum(count(*)) OVER () AS percentage, label
FROM users
GROUP BY device, label
HAVING label = "churned";

# Both retained and churned datasets have the same proportion of retained and churned users (35-65%)

-- Q9. Do users with above-average drives have a lower churn rate
--    than users with below-average drives?

Select label, avg(drives) as avg_drives
from users
Group By label;

# retained users had 66.08 avg drives, churned users had 72.3 avg drives.

-- Q10. How does churn vary across different duration of minutes driven?
Select
CASE 
	WHEN duration_minutes_drives BETWEEN 0 and 500 THEN "0-500"
    WHEN duration_minutes_drives BETWEEN 500 and 1000 THEN "500-1000"
    WHEN duration_minutes_drives BETWEEN 1000 and 1500 THEN "1000-1500"
    WHEN duration_minutes_drives BETWEEN 1500 and 2000 THEN "1500-2000"
    WHEN duration_minutes_drives BETWEEN 2000 and 2500 THEN "2000-2500"
    WHEN duration_minutes_drives BETWEEN 2500 and 3000 THEN "2500-3000"
    WHEN duration_minutes_drives > 3000 THEN ">3000"
END as duration_minutes_drives_groupings, count(*) as label_count,
SUM(CASE
WHEN label = "churned" 
THEN 1 ELSE 0 END) AS churned_users,
SUM(CASE 
WHEN label = "churned" THEN 1 ELSE 0 END) * 100 / COUNT(*) AS churn_rate_pct
FROM users
GROUP BY duration_minutes_drives_groupings
ORDER BY churn_rate_pct desc;

# Churn rate > 3000 minutes driven = 19.23 percent
# 2000-2500 18.15
# 2500-3000 17.9
# 1500-2000 17.24
# 1000-1500 17.16
# 500-1000 15.19
# 0-500 13.85
# Generally, as duration of minutes driven increased, the churn percentage increased