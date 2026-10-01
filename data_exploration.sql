CREATE TABLE ab_testing (
    user_id BIGINT,
    timestamp TIMESTAMP,
    "group" VARCHAR(20),
    landing_page VARCHAR(20),
    converted INT,
    date DATE
);

SELECT COUNT(*)
FROM ab_testing;



SELECT *
FROM ab_testing
LIMIT 5;

---Q1---How many users and conversions are there in each A/B testing group?

SELECT
    "group",
    COUNT(*) AS total_users,
    SUM(converted) AS conversions
FROM ab_testing
GROUP BY "group"
ORDER BY "group";

---Q2---What is the conversion rate for each A/B testing group?

SELECT
    "group",
    COUNT(*) AS total_users,
    SUM(converted) AS conversions,
    ROUND(
        SUM(converted)::numeric / COUNT(*) * 100,
        2
    ) AS conversion_rate
FROM ab_testing
GROUP BY "group"
ORDER BY "group";


---Q3----How many users converted and did not convert in each group?
SELECT
    "group",
    converted,
    COUNT(*) AS users
FROM ab_testing
GROUP BY "group", converted
ORDER BY "group", converted;


---Q4---How many users were exposed to each landing page?
SELECT
    landing_page,
    COUNT(*) AS total_users
FROM ab_testing
GROUP BY landing_page;

---Q5--How many users converted on the new landing page?

SELECT COUNT(*) AS converted_users
FROM ab_testing
WHERE landing_page = 'new_page'
  AND converted = 1;

--Q6--How many users did not convert on the new landing page?
SELECT COUNT(*) AS non_converted_users
FROM ab_testing
WHERE landing_page = 'new_page'
  AND converted = 0;

--Q7-- What was the daily conversion rate during the experiment?
SELECT
    date,
    COUNT(*) AS total_users,
    SUM(converted) AS conversions,
    ROUND(
        SUM(converted)::numeric / COUNT(*) * 100,
        2
    ) AS conversion_rate
FROM ab_testing
GROUP BY date
ORDER BY date;


---Q8---Which day had the highest number of conversions?
SELECT
    date,
    SUM(converted) AS conversions
FROM ab_testing
GROUP BY date
ORDER BY conversions DESC
LIMIT 1;


---Q9--What is the difference in conversion rate between the treatment and control groups?
WITH conversion_rates AS (
    SELECT
        "group",
        ROUND(
            SUM(converted)::numeric / COUNT(*) * 100,
            2
        ) AS conversion_rate
    FROM ab_testing
    GROUP BY "group"
)

SELECT
    MAX(CASE WHEN "group" = 'control'
        THEN conversion_rate END) AS control_rate,

    MAX(CASE WHEN "group" = 'treatment'
        THEN conversion_rate END) AS treatment_rate,

    MAX(CASE WHEN "group" = 'treatment'
        THEN conversion_rate END)
    -
    MAX(CASE WHEN "group" = 'control'
        THEN conversion_rate END)
    AS rate_difference
FROM conversion_rates;

-- Q10: How does each group's conversion rate compare with the overall conversion rate?

WITH group_rates AS (
    SELECT
        "group",
        SUM(converted)::numeric / COUNT(*) * 100 AS conversion_rate
    FROM ab_testing
    GROUP BY "group"
),

overall_rate AS (
    SELECT
        SUM(converted)::numeric / COUNT(*) * 100 AS overall_conversion_rate
    FROM ab_testing
)

SELECT
    g."group",
    ROUND(g.conversion_rate, 2) AS group_conversion_rate,
    ROUND(o.overall_conversion_rate, 2) AS overall_conversion_rate,
    ROUND(
        g.conversion_rate - o.overall_conversion_rate,
        2
    ) AS difference_from_overall
FROM group_rates g
CROSS JOIN overall_rate o;