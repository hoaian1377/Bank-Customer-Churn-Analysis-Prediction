-- 1.1. Tổng số khách hàng
SELECT COUNT(*) AS total_customers
FROM customerchurn;


-- 1.2. Tổng quan churn và retention
SELECT
    COUNT(*) AS total_customers,

    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        AS total_exited,

    SUM(CASE WHEN "Exited" = 0 THEN 1 ELSE 0 END)
        AS total_retained,

    ROUND(
        100.0 * SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS churn_rate,

    ROUND(
        100.0 * SUM(CASE WHEN "Exited" = 0 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS retention_rate

FROM customerchurn;


-- 1.3. Tỷ trọng khách hàng churn và retained
SELECT
    CASE
        WHEN "Exited" = 1 THEN 'Churned'
        ELSE 'Retained'
    END AS customer_status,

    COUNT(*) AS total_customers,

    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (), 2
    ) AS percentage

FROM customerchurn
GROUP BY "Exited"
ORDER BY "Exited" DESC;

-- 2.1. Phân bố độ tuổi
SELECT
    "Age",
    COUNT(*) AS total_customers
FROM customerchurn
GROUP BY "Age"
ORDER BY total_customers DESC;


-- 2.2. Top 10 độ tuổi có số lượng churn cao nhất
SELECT
    "Age",
    COUNT(*) AS total_exited
FROM customerchurn
WHERE "Exited" = 1
GROUP BY "Age"
ORDER BY total_exited DESC, "Age"
LIMIT 10;


-- 2.3. Churn rate theo nhóm tuổi
SELECT
    CASE
        WHEN "Age" < 30 THEN 'Under 30'
        WHEN "Age" < 40 THEN '30-39'
        WHEN "Age" < 50 THEN '40-49'
        WHEN "Age" < 60 THEN '50-59'
        ELSE '60+'
    END AS age_group,

    COUNT(*) AS total_customers,

    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        AS total_exited,

    ROUND(
        100.0 * SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS churn_rate

FROM customerchurn
GROUP BY age_group
ORDER BY churn_rate DESC;


-- 2.4. Churn rate theo giới tính
SELECT
    "Gender",
    COUNT(*) AS total_customers,
    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        AS total_exited,

    ROUND(
        100.0 * SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS churn_rate

FROM customerchurn
GROUP BY "Gender"
ORDER BY churn_rate DESC;


-- 2.5. Churn rate theo quốc gia
SELECT
    "Geography",
    COUNT(*) AS total_customers,
    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        AS total_exited,

    ROUND(
        100.0 * SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS churn_rate

FROM customerchurn
GROUP BY "Geography"
ORDER BY churn_rate DESC;

-- 3.1. Churn rate theo số năm gắn bó
SELECT
    "Tenure",
    COUNT(*) AS total_customers,
    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        AS total_exited,

    ROUND(
        100.0 * SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS churn_rate

FROM customerchurn
GROUP BY "Tenure"
ORDER BY "Tenure";


-- 3.2. Churn rate theo trạng thái hoạt động
SELECT
    CASE
        WHEN "IsActiveMember" = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS member_status,

    COUNT(*) AS total_customers,
    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        AS total_exited,

    ROUND(
        100.0 * SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS churn_rate

FROM customerchurn
GROUP BY "IsActiveMember"
ORDER BY churn_rate DESC;


-- 3.3. Churn rate theo số sản phẩm sử dụng
SELECT
    "NumOfProducts",
    COUNT(*) AS total_customers,
    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        AS total_exited,

    ROUND(
        100.0 * SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS churn_rate

FROM customerchurn
GROUP BY "NumOfProducts"
ORDER BY "NumOfProducts";


-- 3.4. Churn rate theo tình trạng sở hữu thẻ tín dụng
SELECT
    CASE
        WHEN "HasCrCard" = 1 THEN 'Has Credit Card'
        ELSE 'No Credit Card'
    END AS credit_card_status,

    COUNT(*) AS total_customers,
    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        AS total_exited,

    ROUND(
        100.0 * SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS churn_rate

FROM customerchurn
GROUP BY "HasCrCard"
ORDER BY churn_rate DESC;

-- 4.1. Churn rate theo nhóm điểm tín dụng
SELECT
    CASE
        WHEN "CreditScore" < 580 THEN 'Low'
        WHEN "CreditScore" < 670 THEN 'Fair'
        WHEN "CreditScore" < 740 THEN 'Good'
        ELSE 'High'
    END AS credit_group,

    COUNT(*) AS total_customers,
    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        AS total_exited,

    ROUND(
        100.0 * SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS churn_rate

FROM customerchurn
GROUP BY credit_group
ORDER BY churn_rate DESC;


-- 4.2. Churn rate theo nhóm số dư
SELECT
    CASE
        WHEN "Balance" = 0 THEN 'Zero Balance'
        WHEN "Balance" < 50000 THEN 'Low Balance'
        WHEN "Balance" < 100000 THEN 'Medium Balance'
        ELSE 'High Balance'
    END AS balance_group,

    COUNT(*) AS total_customers,
    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        AS total_exited,

    ROUND(
        100.0 * SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS churn_rate

FROM customerchurn
GROUP BY balance_group
ORDER BY churn_rate DESC;


-- 4.3. Churn rate theo nhóm thu nhập
SELECT
    CASE
        WHEN "EstimatedSalary" <= 90000 THEN 'Low Salary'
        WHEN "EstimatedSalary" <= 150000 THEN 'Medium Salary'
        ELSE 'High Salary'
    END AS salary_group,

    COUNT(*) AS total_customers,
    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        AS total_exited,

    ROUND(
        100.0 * SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS churn_rate

FROM customerchurn
GROUP BY salary_group
ORDER BY churn_rate DESC;


-- 4.4. So sánh đặc điểm trung bình giữa churned và retained
SELECT
    CASE
        WHEN "Exited" = 1 THEN 'Churned'
        ELSE 'Retained'
    END AS customer_status,

    COUNT(*) AS total_customers,
    ROUND(AVG("CreditScore"), 2) AS avg_credit_score,
    ROUND(AVG("Age"), 2) AS avg_age,
    ROUND(AVG("Tenure"), 2) AS avg_tenure,
    ROUND(AVG("Balance"), 2) AS avg_balance,
    ROUND(AVG("NumOfProducts"), 2) AS avg_products,
    ROUND(AVG("EstimatedSalary"), 2) AS avg_salary

FROM customerchurn
GROUP BY "Exited"
ORDER BY "Exited" DESC;

-- 5.1. Churn theo quốc gia và trạng thái hoạt động
SELECT
    "Geography",
    "IsActiveMember",
    COUNT(*) AS total_customers,

    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        AS total_exited,

    ROUND(
        100.0 * SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS churn_rate

FROM customerchurn
GROUP BY "Geography", "IsActiveMember"
ORDER BY "Geography", churn_rate DESC;


-- 5.2. Churn theo nhóm tuổi và số sản phẩm
SELECT
    CASE
        WHEN "Age" < 30 THEN 'Under 30'
        WHEN "Age" < 40 THEN '30-39'
        WHEN "Age" < 50 THEN '40-49'
        WHEN "Age" < 60 THEN '50-59'
        ELSE '60+'
    END AS age_group,

    "NumOfProducts",
    COUNT(*) AS total_customers,

    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        AS total_exited,

    ROUND(
        100.0 * SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS churn_rate

FROM customerchurn
GROUP BY age_group, "NumOfProducts"
ORDER BY age_group, churn_rate DESC;


-- 5.3. Churn theo nhóm tuổi và trạng thái hoạt động
SELECT
    CASE
        WHEN "Age" < 30 THEN 'Under 30'
        WHEN "Age" < 40 THEN '30-39'
        WHEN "Age" < 50 THEN '40-49'
        WHEN "Age" < 60 THEN '50-59'
        ELSE '60+'
    END AS age_group,

    "IsActiveMember",
    COUNT(*) AS total_customers,

    SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        AS total_exited,

    ROUND(
        100.0 * SUM(CASE WHEN "Exited" = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS churn_rate

FROM customerchurn
GROUP BY age_group, "IsActiveMember"
ORDER BY age_group, churn_rate DESC;

