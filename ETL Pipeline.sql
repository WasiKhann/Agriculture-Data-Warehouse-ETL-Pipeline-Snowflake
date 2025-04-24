CREATE OR REPLACE TABLE CLEAN_HARVEST AS
SELECT *
FROM DIM_HARVEST
WHERE CropID IS NOT NULL 
  AND FarmID IS NOT NULL 
  AND Quantity_Tons IS NOT NULL;

CREATE OR REPLACE TABLE FACT_HARVEST AS
SELECT
  h.HarvestID,
  h.FarmID,
  h.CropID,
  h.Quantity_Tons AS YieldAmount,
  h.HarvestDate,
  f.Size_Acres AS FarmSize,
  mp.PricePerTon,
  gs.Amount AS SubsidyAmount,
  (mp.PricePerTon * h.Quantity_Tons) AS Revenue,
  (mp.PricePerTon * h.Quantity_Tons) - 0 AS Profit,
  h.Quantity_Tons / NULLIF(f.Size_Acres, 0) AS YieldPerAcre
FROM CLEAN_HARVEST h
JOIN DIM_FARMS f ON h.FarmID = f.FarmID
LEFT JOIN DIM_CROPS c ON h.CropID = c.CropID
LEFT JOIN DIM_MARKET_PRICES mp ON c.Name = mp.CropName
LEFT JOIN DIM_FARMERS fa ON f.FarmID = fa.FarmID
LEFT JOIN DIM_GOV_SUBSIDIES gs ON fa.FarmerID = gs.FarmerID;

CREATE OR REPLACE TABLE DIM_DATE AS
SELECT
  DATEADD(DAY, SEQ4(), '2020-01-01') AS FullDate,
  DAY(DATEADD(DAY, SEQ4(), '2020-01-01')) AS Day,
  MONTH(DATEADD(DAY, SEQ4(), '2020-01-01')) AS Month,
  YEAR(DATEADD(DAY, SEQ4(), '2020-01-01')) AS Year,
  TO_CHAR(DATEADD(DAY, SEQ4(), '2020-01-01'), 'Month') AS MonthName,
  WEEK(DATEADD(DAY, SEQ4(), '2020-01-01')) AS Week
FROM TABLE(GENERATOR(ROWCOUNT => 4000));

CREATE OR REPLACE TABLE AGRI_SUMMARY_KPIS AS
SELECT
  h.FarmID,
  h.CropID,
  d.FullDate,
  SUM(h.YieldAmount) AS TotalYield,
  AVG(h.YieldPerAcre) AS TotalYieldPerAcre,
  AVG(sq.pH_Level) AS AvgSoilpH,
  SUM(h.SubsidyAmount) AS TotalSubsidy
FROM FACT_HARVEST h
JOIN DIM_DATE d ON h.HarvestDate = d.FullDate
LEFT JOIN DIM_SOIL sq ON h.FarmID = sq.FarmID
GROUP BY h.FarmID, h.CropID, d.FullDate;

CREATE OR REPLACE TABLE CLEAN_FARM_EQUIPMENT AS
SELECT 
  e.*,
  d.FullDate
FROM DIM_FARM_EQUIPMENT e
JOIN DIM_DATE d ON e.LastMaintenance = d.FullDate;

CREATE OR REPLACE TABLE CLEAN_GOV_SUBSIDIES AS
SELECT 
  s.*,
  d.FullDate
FROM DIM_GOV_SUBSIDIES s
JOIN DIM_DATE d ON s.IssuedDate = d.FullDate;

CREATE OR REPLACE TABLE CLEAN_MARKET_PRICES AS
SELECT 
  m.*,
  d.FullDate
FROM DIM_MARKET_PRICES m
JOIN DIM_DATE d ON m.Date = d.FullDate;
