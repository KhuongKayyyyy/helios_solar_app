class WeatherModel {
  final Location location;
  final CurrentWeather current;

  WeatherModel({required this.location, required this.current});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: Location.fromJson(json['location']),
      current: CurrentWeather.fromJson(json['current']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'location': location.toJson(), 'current': current.toJson()};
  }
}

class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final int localtimeEpoch;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] ?? '',
      region: json['region'] ?? '',
      country: json['country'] ?? '',
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      tzId: json['tz_id'] ?? '',
      localtimeEpoch: (json['localtime_epoch'] as num?)?.toInt() ?? 0,
      localtime: json['localtime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'region': region,
      'country': country,
      'lat': lat,
      'lon': lon,
      'tz_id': tzId,
      'localtime_epoch': localtimeEpoch,
      'localtime': localtime,
    };
  }
}

class CurrentWeather {
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final int isDay;
  final Condition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final int pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double windchillC;
  final double windchillF;
  final double heatindexC;
  final double heatindexF;
  final double dewpointC;
  final double dewpointF;
  final int visKm;
  final int visMiles;
  final int uv;
  final double gustMph;
  final double gustKph;
  final int shortRad;
  final int diffRad;
  final int dni;
  final int gti;

  CurrentWeather({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.windchillC,
    required this.windchillF,
    required this.heatindexC,
    required this.heatindexF,
    required this.dewpointC,
    required this.dewpointF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
    required this.shortRad,
    required this.diffRad,
    required this.dni,
    required this.gti,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      lastUpdatedEpoch: (json['last_updated_epoch'] as num?)?.toInt() ?? 0,
      lastUpdated: json['last_updated'] ?? '',
      tempC: (json['temp_c'] as num).toDouble(),
      tempF: (json['temp_f'] as num).toDouble(),
      isDay: (json['is_day'] as num?)?.toInt() ?? 0,
      condition: Condition.fromJson(json['condition']),
      windMph: (json['wind_mph'] as num).toDouble(),
      windKph: (json['wind_kph'] as num).toDouble(),
      windDegree: (json['wind_degree'] as num?)?.toInt() ?? 0,
      windDir: json['wind_dir'] ?? '',
      pressureMb: (json['pressure_mb'] as num?)?.toInt() ?? 0,
      pressureIn: (json['pressure_in'] as num).toDouble(),
      precipMm: (json['precip_mm'] as num).toDouble(),
      precipIn: (json['precip_in'] as num).toDouble(),
      humidity: (json['humidity'] as num?)?.toInt() ?? 0,
      cloud: (json['cloud'] as num?)?.toInt() ?? 0,
      feelslikeC: (json['feelslike_c'] as num).toDouble(),
      feelslikeF: (json['feelslike_f'] as num).toDouble(),
      windchillC: (json['windchill_c'] as num).toDouble(),
      windchillF: (json['windchill_f'] as num).toDouble(),
      heatindexC: (json['heatindex_c'] as num).toDouble(),
      heatindexF: (json['heatindex_f'] as num).toDouble(),
      dewpointC: (json['dewpoint_c'] as num).toDouble(),
      dewpointF: (json['dewpoint_f'] as num).toDouble(),
      visKm: (json['vis_km'] as num?)?.toInt() ?? 0,
      visMiles: (json['vis_miles'] as num?)?.toInt() ?? 0,
      uv: (json['uv'] as num?)?.toInt() ?? 0,
      gustMph: (json['gust_mph'] as num).toDouble(),
      gustKph: (json['gust_kph'] as num).toDouble(),
      shortRad: json['short_rad'] ?? 0,
      diffRad: json['diff_rad'] ?? 0,
      dni: json['dni'] ?? 0,
      gti: json['gti'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last_updated_epoch': lastUpdatedEpoch,
      'last_updated': lastUpdated,
      'temp_c': tempC,
      'temp_f': tempF,
      'is_day': isDay,
      'condition': condition.toJson(),
      'wind_mph': windMph,
      'wind_kph': windKph,
      'wind_degree': windDegree,
      'wind_dir': windDir,
      'pressure_mb': pressureMb,
      'pressure_in': pressureIn,
      'precip_mm': precipMm,
      'precip_in': precipIn,
      'humidity': humidity,
      'cloud': cloud,
      'feelslike_c': feelslikeC,
      'feelslike_f': feelslikeF,
      'windchill_c': windchillC,
      'windchill_f': windchillF,
      'heatindex_c': heatindexC,
      'heatindex_f': heatindexF,
      'dewpoint_c': dewpointC,
      'dewpoint_f': dewpointF,
      'vis_km': visKm,
      'vis_miles': visMiles,
      'uv': uv,
      'gust_mph': gustMph,
      'gust_kph': gustKph,
      'short_rad': shortRad,
      'diff_rad': diffRad,
      'dni': dni,
      'gti': gti,
    };
  }
}

class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({required this.text, required this.icon, required this.code});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'] ?? '',
      icon: json['icon'] ?? '',
      code: (json['code'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'icon': icon, 'code': code};
  }
}

// Forecast Weather Models
class ForecastWeatherModel {
  final Location location;
  final Forecast forecast;

  ForecastWeatherModel({required this.location, required this.forecast});

  factory ForecastWeatherModel.fromJson(Map<String, dynamic> json) {
    return ForecastWeatherModel(
      location: Location.fromJson(json['location']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'location': location.toJson(), 'forecast': forecast.toJson()};
  }
}

// Complete Weather Model (Current + Forecast)
class CompleteWeatherModel {
  final Location location;
  final CurrentWeather current;
  final Forecast forecast;

  CompleteWeatherModel({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory CompleteWeatherModel.fromJson(Map<String, dynamic> json) {
    return CompleteWeatherModel(
      location: Location.fromJson(json['location']),
      current: CurrentWeather.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      'current': current.toJson(),
      'forecast': forecast.toJson(),
    };
  }
}

class Forecast {
  final List<ForecastDay> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      forecastday:
          (json['forecastday'] as List?)
              ?.map((item) => ForecastDay.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'forecastday': forecastday.map((day) => day.toJson()).toList()};
  }
}

class ForecastDay {
  final String date;
  final int dateEpoch;
  final Day day;
  final Astro astro;
  final List<Hour> hour;

  ForecastDay({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: json['date'] ?? '',
      dateEpoch: (json['date_epoch'] as num?)?.toInt() ?? 0,
      day: Day.fromJson(json['day']),
      astro: Astro.fromJson(json['astro']),
      hour:
          (json['hour'] as List?)
              ?.map((item) => Hour.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'date_epoch': dateEpoch,
      'day': day.toJson(),
      'astro': astro.toJson(),
      'hour': hour.map((h) => h.toJson()).toList(),
    };
  }
}

class Day {
  final double maxtempC;
  final double maxtempF;
  final double mintempC;
  final double mintempF;
  final double avgtempC;
  final double avgtempF;
  final double maxwindMph;
  final double maxwindKph;
  final double totalprecipMm;
  final double totalprecipIn;
  final double totalsnowCm;
  final double avgvisKm;
  final double avgvisMiles;
  final int avghumidity;
  final int dailyWillItRain;
  final int dailyChanceOfRain;
  final int dailyWillItSnow;
  final int dailyChanceOfSnow;
  final Condition condition;
  final int uv;

  Day({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avgtempC,
    required this.avgtempF,
    required this.maxwindMph,
    required this.maxwindKph,
    required this.totalprecipMm,
    required this.totalprecipIn,
    required this.totalsnowCm,
    required this.avgvisKm,
    required this.avgvisMiles,
    required this.avghumidity,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtempC: (json['maxtemp_c'] as num).toDouble(),
      maxtempF: (json['maxtemp_f'] as num).toDouble(),
      mintempC: (json['mintemp_c'] as num).toDouble(),
      mintempF: (json['mintemp_f'] as num).toDouble(),
      avgtempC: (json['avgtemp_c'] as num).toDouble(),
      avgtempF: (json['avgtemp_f'] as num).toDouble(),
      maxwindMph: (json['maxwind_mph'] as num).toDouble(),
      maxwindKph: (json['maxwind_kph'] as num).toDouble(),
      totalprecipMm: (json['totalprecip_mm'] as num).toDouble(),
      totalprecipIn: (json['totalprecip_in'] as num).toDouble(),
      totalsnowCm: (json['totalsnow_cm'] as num).toDouble(),
      avgvisKm: (json['avgvis_km'] as num).toDouble(),
      avgvisMiles: (json['avgvis_miles'] as num).toDouble(),
      avghumidity: (json['avghumidity'] as num?)?.toInt() ?? 0,
      dailyWillItRain: (json['daily_will_it_rain'] as num?)?.toInt() ?? 0,
      dailyChanceOfRain: (json['daily_chance_of_rain'] as num?)?.toInt() ?? 0,
      dailyWillItSnow: (json['daily_will_it_snow'] as num?)?.toInt() ?? 0,
      dailyChanceOfSnow: (json['daily_chance_of_snow'] as num?)?.toInt() ?? 0,
      condition: Condition.fromJson(json['condition']),
      uv: (json['uv'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maxtemp_c': maxtempC,
      'maxtemp_f': maxtempF,
      'mintemp_c': mintempC,
      'mintemp_f': mintempF,
      'avgtemp_c': avgtempC,
      'avgtemp_f': avgtempF,
      'maxwind_mph': maxwindMph,
      'maxwind_kph': maxwindKph,
      'totalprecip_mm': totalprecipMm,
      'totalprecip_in': totalprecipIn,
      'totalsnow_cm': totalsnowCm,
      'avgvis_km': avgvisKm,
      'avgvis_miles': avgvisMiles,
      'avghumidity': avghumidity,
      'daily_will_it_rain': dailyWillItRain,
      'daily_chance_of_rain': dailyChanceOfRain,
      'daily_will_it_snow': dailyWillItSnow,
      'daily_chance_of_snow': dailyChanceOfSnow,
      'condition': condition.toJson(),
      'uv': uv,
    };
  }
}

class Astro {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final int moonIllumination;
  final int isMoonUp;
  final int isSunUp;

  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
    required this.isMoonUp,
    required this.isSunUp,
  });

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
      sunrise: json['sunrise'] ?? '',
      sunset: json['sunset'] ?? '',
      moonrise: json['moonrise'] ?? '',
      moonset: json['moonset'] ?? '',
      moonPhase: json['moon_phase'] ?? '',
      moonIllumination: (json['moon_illumination'] as num?)?.toInt() ?? 0,
      isMoonUp: (json['is_moon_up'] as num?)?.toInt() ?? 0,
      isSunUp: (json['is_sun_up'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sunrise': sunrise,
      'sunset': sunset,
      'moonrise': moonrise,
      'moonset': moonset,
      'moon_phase': moonPhase,
      'moon_illumination': moonIllumination,
      'is_moon_up': isMoonUp,
      'is_sun_up': isSunUp,
    };
  }
}

class Hour {
  final int timeEpoch;
  final String time;
  final double tempC;
  final double tempF;
  final int isDay;
  final Condition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final int pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final double snowCm;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double windchillC;
  final double windchillF;
  final double heatindexC;
  final double heatindexF;
  final double dewpointC;
  final double dewpointF;
  final int willItRain;
  final int chanceOfRain;
  final int willItSnow;
  final int chanceOfSnow;
  final int visKm;
  final int visMiles;
  final double gustMph;
  final double gustKph;
  final double uv;
  final int shortRad;
  final int diffRad;
  final int dni;
  final int gti;

  Hour({
    required this.timeEpoch,
    required this.time,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.snowCm,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.windchillC,
    required this.windchillF,
    required this.heatindexC,
    required this.heatindexF,
    required this.dewpointC,
    required this.dewpointF,
    required this.willItRain,
    required this.chanceOfRain,
    required this.willItSnow,
    required this.chanceOfSnow,
    required this.visKm,
    required this.visMiles,
    required this.gustMph,
    required this.gustKph,
    required this.uv,
    required this.shortRad,
    required this.diffRad,
    required this.dni,
    required this.gti,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      timeEpoch: (json['time_epoch'] as num?)?.toInt() ?? 0,
      time: json['time'] ?? '',
      tempC: (json['temp_c'] as num).toDouble(),
      tempF: (json['temp_f'] as num).toDouble(),
      isDay: (json['is_day'] as num?)?.toInt() ?? 0,
      condition: Condition.fromJson(json['condition']),
      windMph: (json['wind_mph'] as num).toDouble(),
      windKph: (json['wind_kph'] as num).toDouble(),
      windDegree: (json['wind_degree'] as num?)?.toInt() ?? 0,
      windDir: json['wind_dir'] ?? '',
      pressureMb: (json['pressure_mb'] as num?)?.toInt() ?? 0,
      pressureIn: (json['pressure_in'] as num).toDouble(),
      precipMm: (json['precip_mm'] as num).toDouble(),
      precipIn: (json['precip_in'] as num).toDouble(),
      snowCm: (json['snow_cm'] as num).toDouble(),
      humidity: (json['humidity'] as num?)?.toInt() ?? 0,
      cloud: (json['cloud'] as num?)?.toInt() ?? 0,
      feelslikeC: (json['feelslike_c'] as num).toDouble(),
      feelslikeF: (json['feelslike_f'] as num).toDouble(),
      windchillC: (json['windchill_c'] as num).toDouble(),
      windchillF: (json['windchill_f'] as num).toDouble(),
      heatindexC: (json['heatindex_c'] as num).toDouble(),
      heatindexF: (json['heatindex_f'] as num).toDouble(),
      dewpointC: (json['dewpoint_c'] as num).toDouble(),
      dewpointF: (json['dewpoint_f'] as num).toDouble(),
      willItRain: (json['will_it_rain'] as num?)?.toInt() ?? 0,
      chanceOfRain: (json['chance_of_rain'] as num?)?.toInt() ?? 0,
      willItSnow: (json['will_it_snow'] as num?)?.toInt() ?? 0,
      chanceOfSnow: (json['chance_of_snow'] as num?)?.toInt() ?? 0,
      visKm: (json['vis_km'] as num?)?.toInt() ?? 0,
      visMiles: (json['vis_miles'] as num?)?.toInt() ?? 0,
      gustMph: (json['gust_mph'] as num).toDouble(),
      gustKph: (json['gust_kph'] as num).toDouble(),
      uv: (json['uv'] as num).toDouble(),
      shortRad: (json['short_rad'] as num?)?.toInt() ?? 0,
      diffRad: (json['diff_rad'] as num?)?.toInt() ?? 0,
      dni: (json['dni'] as num?)?.toInt() ?? 0,
      gti: (json['gti'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time_epoch': timeEpoch,
      'time': time,
      'temp_c': tempC,
      'temp_f': tempF,
      'is_day': isDay,
      'condition': condition.toJson(),
      'wind_mph': windMph,
      'wind_kph': windKph,
      'wind_degree': windDegree,
      'wind_dir': windDir,
      'pressure_mb': pressureMb,
      'pressure_in': pressureIn,
      'precip_mm': precipMm,
      'precip_in': precipIn,
      'snow_cm': snowCm,
      'humidity': humidity,
      'cloud': cloud,
      'feelslike_c': feelslikeC,
      'feelslike_f': feelslikeF,
      'windchill_c': windchillC,
      'windchill_f': windchillF,
      'heatindex_c': heatindexC,
      'heatindex_f': heatindexF,
      'dewpoint_c': dewpointC,
      'dewpoint_f': dewpointF,
      'will_it_rain': willItRain,
      'chance_of_rain': chanceOfRain,
      'will_it_snow': willItSnow,
      'chance_of_snow': chanceOfSnow,
      'vis_km': visKm,
      'vis_miles': visMiles,
      'gust_mph': gustMph,
      'gust_kph': gustKph,
      'uv': uv,
      'short_rad': shortRad,
      'diff_rad': diffRad,
      'dni': dni,
      'gti': gti,
    };
  }
}
