select * from portfolioproject..CovidVaccinations
order by 3,4
select * from portfolioproject..CovidDeaths
order by 3,4

--Select Data that we are going to be using

select location, date, total_cases, new_cases, total_deaths, population from portfolioproject..CovidDeaths
order by 1,2

--Looking at Total Cases vs Total Deaths

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from portfolioproject..CovidDeaths
where location like '%France%'
order by 1,2

--Looking at countries with Highest Infection Rate compared to Population

select location, population, max(total_cases) as HighestInfectionCount, max(total_deaths/population)*100 as PercentpopulationInfected
from portfolioproject..CovidDeaths
--where location like '%France%'
group by Location, Population
order by PercentpopulationInfected desc

--Showing Countries with Highest Death Count per Population

select location, MAX(cast(total_deaths as int)) as TotalDeathCount
from portfolioproject..CovidDeaths
--where location like '%France%'
group by Location
order by TotalDeathCount desc

--Break things down by continet

select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from portfolioproject..CovidDeaths
--where location like '%France%'
where continent is not null
group by continent
order by TotalDeathCount desc

--Showing the coninent with the highest death count per population

--Global Number

select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
from portfolioproject..CovidDeaths
--where location like '%France%'
where continent is not null
order by 1,2

--Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.Location) as rollingpeoplevaccinated
--(RollingPeopleVaccinated/Population)*100 
from Portfolioproject..CovidDeaths dea
Join Portfolioproject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3

--Use CTE
with PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.Location) as rollingpeoplevaccinated
--(RollingPeopleVaccinated/Population)*100 
from Portfolioproject..CovidDeaths dea
Join Portfolioproject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
from PopvsVac


--Temp Table

Drop Table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
continent nvarchar(255),
Location nvarchar(255),
date datetime,
population numeric,
New_vaccinations numeric,
Rollingpeoplevaccinated numeric
)
Insert Into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.Location) as rollingpeoplevaccinated
--(RollingPeopleVaccinated/Population)*100 
from Portfolioproject..CovidDeaths dea
Join Portfolioproject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3


Select *, (RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated


Create view PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.Location) as rollingpeoplevaccinated
--(RollingPeopleVaccinated/Population)*100 
from Portfolioproject..CovidDeaths dea
Join Portfolioproject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3

Select * from PercentPopulationVaccinated