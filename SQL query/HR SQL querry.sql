create database HR_Analystics;
use HR_Analystics;

CREATE TABLE Hr_data(
    EmpID VARCHAR(50) PRIMARY KEY,
    Age INT,
    AgeGroup VARCHAR(50),
    Attrition VARCHAR(3),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(50),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(50),
    MonthlyIncome INT,
    SalarySlab VARCHAR(50),
    MonthlyRate VARCHAR(50),
    NumCompaniesWorked INT,
    Over18 VARCHAR (5),
	OverTime VARCHAR (50),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
	YearsInCurrentRole INT,
	YearsSinceLastPromotion INT,
	YearsWithCurrManager INT NULL);
    
Drop table hr_data;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HR_Analyticss.csv'
INTO TABLE hr_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Checked for inconsistent data, 7 rows were updated

UPDATE hr_data
SET BusinessTravel = 'Travel_Rarely'
WHERE BusinessTravel = 'TravelRarely';

-- Business Questions 

-- 1. How many employees have left the company (Attrition = 'Yes')? Ans = 237
SELECT COUNT(*) AS Employees_Left
FROM hr_data
WHERE Attrition = 'Yes';

-- 2. What is the average age of employees who left versus those who stayed? Ans, yes= 33.61, no = 37.56
SELECT Attrition, ROUND(AVG(Age),2) AS Avg_Age
FROM hr_data
GROUP BY Attrition;

-- 3. How many employees in each AgeGroup have experienced attrition? Answer = 26-35 has highest count of 116 while 55+ is lowest by 8
SELECT AgeGroup, COUNT(*) AS Attrition_Count
FROM hr_data
WHERE Attrition = 'Yes'
GROUP BY AgeGroup;

-- 4. Which department has the highest attrition rate? Ans = sales by 20.63
SELECT Department, 
       ROUND(100.0 * SUM(Attrition = 'Yes') / COUNT(*), 2) AS AttritionRate
FROM hr_data
GROUP BY Department
ORDER BY AttritionRate DESC
LIMIT 1;

-- 5. What is the average MonthlyIncome per Department? 
SELECT Department, AVG(MonthlyIncome) AS Avg_Income
FROM hr_data
GROUP BY Department;

-- 6. List the top 5 job roles with the highest number of employees. 
SELECT JobRole, COUNT(*) AS Total_Employees
FROM hr_data
GROUP BY JobRole
ORDER BY Total_Employees DESC
LIMIT 5;

-- 7. How many employees are at JobLevel 5 in each department? 
SELECT Department, COUNT(*) AS Level5_Count
FROM hr_data
WHERE JobLevel = 5
GROUP BY Department;

-- 8. What is the average YearsAtCompany for employees who travel frequently? 
SELECT AVG(YearsAtCompany) AS Avg_Years
FROM hr_data
WHERE BusinessTravel = 'Travel_Frequently';

-- 9. Find the average WorkLifeBalance score across departments.
SELECT Department, round(AVG(WorkLifeBalance),2) AS Avg_WLB
FROM hr_data
GROUP BY Department;
 
-- 10. Which JobRole has the highest average OverTime rate? 
SELECT JobRole,
       ROUND(100.0 * SUM(OverTime = 'Yes') / COUNT(*), 2) AS OverTimeRate
FROM hr_data
GROUP BY JobRole
ORDER BY OverTimeRate DESC
LIMIT 1;

-- 11. Compare the average MonthlyIncome by EducationField. 
SELECT EducationField, AVG(MonthlyIncome) AS Avg_Income
FROM hr_data
GROUP BY EducationField;

-- 12. What is the distribution of Education levels across genders? 
SELECT Gender, Education, COUNT(*) AS Count
FROM hr_data
GROUP BY Gender, Education
ORDER BY Gender, Education;

-- 13. Which education field has the highest attrition rate? 
SELECT EducationField, 
       ROUND(100.0 * SUM(Attrition = 'Yes') / COUNT(*), 2) AS AttritionRate
FROM hr_data
GROUP BY EducationField
ORDER BY AttritionRate DESC
LIMIT 1;

-- 14. How many employees received a PercentSalaryHike greater than 15% and have not been promoted in the last 3 years? 
SELECT COUNT(*) AS Eligible_Employees
FROM hr_data
WHERE PercentSalaryHike > 15
  AND YearsSinceLastPromotion >= 3;


-- 15. Identify employees with high PerformanceRating (4 or 5) but low JobSatisfaction (1 
SELECT EmpID, JobRole, PerformanceRating, JobSatisfaction
FROM hr_data
WHERE PerformanceRating >= 4
  AND JobSatisfaction <= 2;








