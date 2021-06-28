CREATE DATABASE PortfolioProject;
USE PortfolioProject;



-- COVID-19 DEATH EXCEL FILE 

SELECT *
FROM PortfolioProject..CovidDeaths
WHERE total_deaths IS NOT NULL
ORDER BY location, date;




-- COVID-19 VACCINATION EXCEL FILE

SELECT *
FROM PortfolioProject..CovidVaccinations
WHERE total_vaccinations IS NOT NULL
ORDER BY location, date;



-- GLOBAL DEATH PERCENTAGE

SELECT SUM(new_cases) AS TotalCases, SUM(CAST(new_deaths AS int)) AS TotalDeaths, 
SUM(CAST(new_deaths AS int))/SUM(new_cases)* 100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY TotalCases, TotalDeaths;


-- CONTINENTAL DEATH COUNT

SELECT location, SUM(CAST(new_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NULL AND location NOT IN ('World', 'European Union', 'International')
GROUP BY location
ORDER BY TotalDeathCount DESC;




-- COUNTRIES HIGHEST TOTAL INFECTIONS AND PERCENTAGE OF POPULATION INFECTED

SELECT location, population, MAX(total_cases) AS TotalInfections, MAX((total_cases/population)) * 100 
AS PopulationInfected
FROM PortfolioProject..CovidDeaths
GROUP BY location, population
ORDER BY PopulationInfected DESC;


SELECT location, population, date, MAX(total_cases) AS TotalInfections, MAX((total_cases/population)) * 100 
AS PopulationInfected
FROM PortfolioProject..CovidDeaths
GROUP BY location, population, date
ORDER BY PopulationInfected DESC;



-- COUNTRIES WITH HIGHEST DEATH COUNT

SELECT location, MAX(CAST(total_deaths AS int)) AS DeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY DeathCount DESC;



-- AFRICA TOTAL VACCINATION

SELECT continent, location, date, total_tests, total_vaccinations
FROM PortfolioProject..CovidVaccinations
WHERE continent LIKE ('Africa') AND total_vaccinations IS NOT NULL
ORDER BY location, date;



-- SOUTH AFRICA DEATH PERCENTAGE

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)* 
100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location LIKE ('South Africa') AND total_deaths IS NOT NULL
ORDER BY location, date;



-- SOUTH AFRICA INFECTION PERCENTAGE

SELECT location, date, total_cases, population, (total_cases/population) * 100
AS InfectionPercentage
FROM PortfolioProject..CovidDeaths
WHERE location LIKE ('South Africa') AND total_cases IS NOT NULL
ORDER BY location, date;
