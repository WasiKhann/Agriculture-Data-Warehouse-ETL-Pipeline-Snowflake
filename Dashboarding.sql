CREATE OR REPLACE VIEW V_AGRI_KPIS AS
SELECT
  SUM(TotalYield) AS Total_Yield,
  ROUND(AVG(TotalYieldPerAcre), 2) AS Avg_Yield_Per_Acre,
  COUNT(DISTINCT FarmID) AS Farm_Count,
  COUNT(DISTINCT CropID) AS Crop_Count,
  ROUND(AVG(AvgSoilpH), 2) AS Avg_Soil_pH
FROM AGRI_SUMMARY_KPIS;

CREATE OR REPLACE VIEW V_MONTHLY_TRENDS AS
SELECT
  d.MonthName,
  d.Month,
  d.Year,
  SUM(k.TotalYield) AS Monthly_Yield,
  SUM(k.TotalSubsidy) AS Monthly_Subsidy
FROM AGRI_SUMMARY_KPIS k
JOIN DIM_DATE d ON k.FullDate = d.FullDate
GROUP BY d.Year, d.Month, d.MonthName
ORDER BY d.Year, d.Month;

CREATE OR REPLACE VIEW V_YIELD_PH_BY_FARM AS
SELECT
  f.Name AS FarmName,
  SUM(k.TotalYield) AS TotalYield,
  ROUND(AVG(k.AvgSoilpH), 2) AS AvgSoilpH
FROM AGRI_SUMMARY_KPIS k
JOIN DIM_FARMS f ON k.FarmID = f.FarmID
GROUP BY f.Name;

CREATE OR REPLACE VIEW V_YIELD_BY_CROP AS
SELECT
  c.Name AS CropName,
  SUM(k.TotalYield) AS TotalYield,
  ROUND(AVG(k.TotalYieldPerAcre), 2) AS AvgYieldPerAcre
FROM AGRI_SUMMARY_KPIS k
JOIN DIM_CROPS c ON k.CropID = c.CropID
GROUP BY c.Name;

CREATE OR REPLACE VIEW V_DISTINCT_MONTHS AS
SELECT DISTINCT MonthName, Month, Year
FROM DIM_DATE
ORDER BY Year, Month;

CREATE OR REPLACE VIEW V_DISTINCT_LOCATIONS AS
SELECT DISTINCT Location
FROM DIM_FARMS;

CREATE OR REPLACE VIEW V_SOIL_PH_RANGE AS
SELECT
  MIN(pH_Level) AS Min_pH,
  MAX(pH_Level) AS Max_pH
FROM DIM_SOIL;

CREATE OR REPLACE VIEW V_CROP_SEASONS AS
SELECT DISTINCT Season
FROM DIM_CROPS
WHERE Season IS NOT NULL;

CREATE OR REPLACE VIEW V_AGRI_DASHBOARD AS
SELECT
  d.FullDate,
  d.Month,
  d.MonthName,
  d.Year,
  f.Name AS FarmName,
  f.Location AS FarmLocation,
  f.Size_Acres,
  c.Name AS CropName,
  c.Season,
  k.TotalYield,
  k.TotalYieldPerAcre,
  k.TotalSubsidy,
  k.AvgSoilpH,
  k.TotalYield / NULLIF(f.Size_Acres, 0) AS YieldPerAcre,
  mp.PricePerTon,
  mp.PricePerTon * k.TotalYield AS Revenue,
  (mp.PricePerTon * k.TotalYield) - 0 AS Profit
FROM AGRI_SUMMARY_KPIS k
JOIN DIM_DATE d ON k.FullDate = d.FullDate
LEFT JOIN DIM_FARMS f ON k.FarmID = f.FarmID
LEFT JOIN DIM_CROPS c ON k.CropID = c.CropID
LEFT JOIN DIM_MARKET_PRICES mp ON c.Name = mp.CropName;
