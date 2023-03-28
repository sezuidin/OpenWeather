<#
  .SYNOPSIS
  Gets weather data for one or more specified cities.

  .DESCRIPTION
  This PowerShell script queries the OpenWeather API for one or more specified cities and gets the weather data for those cities.

  .EXAMPLE
  PS C:\> Get-WeatherData.ps1 -ApiKey jlj3f34lkjf34lkf43lkfj3kl24flk34 -CityIds 2759887

  .EXAMPLE
  PS C:\> Get-WeatherData.ps1 -ApiKey jlj3f34lkjf34lkf43lkfj3kl24flk34 -CityIds 2759887,2759794

  .EXAMPLE
  PS C:\> Get-WeatherData.ps1 -ApiKey jlj3f34lkjf34lkf43lkfj3kl24flk34 -CityIds 2759887,2759794 -Unit Metric

  .EXAMPLE
  PS C:\> Get-WeatherData.ps1 -ApiKey jlj3f34lkjf34lkf43lkfj3kl24flk34 -CityIds 2759887,2759794 -Unit Kelvin

  .LINK
  More information can be found at https://github.com/sezuidin/OpenWeather
#>

[CmdletBinding()]
param (
  [Parameter(HelpMessage='You can get an API token from https://openweathermap.org/')]
  [String]
  $ApiKey = $(throw 'Provide an Api Key to authorize against https://api.openweathermap.org'),

  [Parameter(HelpMessage='You can get any city id from https://openweathermap.org/')]
  [String[]]
  $CityIds = $(throw 'Enter at least one city id to collect weather information for'),

  [Parameter(HelpMessage='Select the appropriate unit. Available units are Imperial, Kelvin and Metric. Default is Metric.')]
  [ValidateSet('Imperial', 'Kelvin', 'Metric')]
  [String]
  $Unit = 'Metric'
)

Write-Output "The unit of measurement is set to $Unit."

foreach ($cityId in $CityIds) {
  $cityWeatherDetails = Invoke-RestMethod -Method Get -Uri "https://api.openweathermap.org/data/2.5/weather?id=$cityId&APPID=$ApiKey&units=$Unit"

  Write-Output "It is currently $($cityWeatherDetails.main.temp) degrees in $($cityWeatherDetails.name) but if feels like $($cityWeatherDetails.main.feels_like) degrees."
}