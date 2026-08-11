# ✈️ Aviocast

### Aviation Weather Intelligence for Aviation Enthusiasts

> **Decode aviation weather. Understand the sky.**
>
> Aviocast is an aviation-focused weather application built for **aviation enthusiasts**, combining meteorological data, **METAR processing**, cloud-cover analysis, and location-based weather forecasting into a unified aviation-oriented experience.

---

## ✈️ About Aviocast

Aviation weather information is often distributed through specialized meteorological reports such as **METAR (Meteorological Aerodrome Report)**.

These reports contain critical atmospheric observations in a compact coded format, including:

* Wind direction and speed
* Visibility
* Present weather
* Cloud amount and cloud base
* Temperature
* Dew point
* Atmospheric pressure
* Observation time

**Aviocast parses these aviation weather observations and transforms the coded data into understandable meteorological information.**

The application also considers weather conditions at an **alternate aerodrome** when generating its weather assessment, providing additional contextual information beyond the primary aerodrome.

---

# 🛫 Aviation-Centric Location Handling

Aviocast uses both internationally recognized airport identification systems:

### ICAO & IATA Airport Codes

Airports/aerodromes can be identified using their:

**ICAO Code**

The four-letter identifier used extensively in aviation operations and aeronautical information.

Example:

```text
VNKT — Tribhuvan International Airport
```

**IATA Code**

The three-letter identifier commonly used for passenger travel and airport identification.

Example:

```text
KTM — Tribhuvan International Airport
```

Aviocast supports the use of **ICAO and IATA identifiers** to associate airport locations with their corresponding meteorological information.

This allows aviation weather data to be tied directly to specific **aerodromes** rather than treating locations simply as generic cities.

---

# 📡 METAR Processing

One of the core technical components of Aviocast is **METAR parsing**.

For example:

```text
VNKT 111000Z 27008KT 6000 FEW025 SCT035 27/20 Q1012
```

Aviocast processes the METAR observation and extracts individual meteorological elements.

### METAR Processing Pipeline

```text
        METAR Observation
                │
                ▼
        ┌───────────────┐
        │  METAR Parser │
        └───────┬───────┘
                │
       ┌────────┼─────────┐
       ▼        ▼         ▼
     Wind   Visibility   Clouds
       │        │         │
       ├────────┼─────────┤
       ▼        ▼         ▼
 Temperature  Dew Point  Pressure
                │
                ▼
       Meteorological Data
                │
                ▼
        Aviocast Interface
```

The parser converts the coded observation into structured weather information that can be interpreted by the application.

---

# ☁️ Cloud Coverage & Oktas

Aviocast interprets METAR cloud groups including:

```text
FEW
SCT
BKN
OVC
```

These are associated with the **okta-based representation of sky coverage**.

| METAR Code | Cloud Amount | Oktas |
| :--------: | ------------ | :---: |
|     FEW    | Few          |  1–2  |
|     SCT    | Scattered    |  3–4  |
|     BKN    | Broken       |  5–7  |
|     OVC    | Overcast     |   8   |

The application uses this information to provide a more intuitive representation of **cloud coverage and cloud-base conditions**.

---

# 🌦️ Weather Assessment

Aviocast does not rely solely on a single weather location when assessing conditions.

### Primary Aerodrome

The primary airport/aerodrome's weather information is used as the main meteorological reference.

### Alternate Aerodrome

Weather data from an **alternate aerodrome** is also considered.

```text
              ┌─────────────────────┐
              │  Primary Aerodrome  │
              │      Weather        │
              └──────────┬──────────┘
                         │
                         ▼
                 Weather Assessment
                         ▲
                         │
              ┌──────────┴──────────┐
              │  Alternate Aerodrome│
              │      Weather        │
              └─────────────────────┘
```

This provides a broader view of the surrounding aviation weather environment instead of evaluating atmospheric conditions from only one aerodrome.

> **Note:** The alternate-aerodrome weather consideration is a project-level weather assessment feature and should not be interpreted as an operational flight-planning or dispatch decision system.

---

# 🌬️ Meteorological Parameters

Aviocast processes and presents aviation-relevant atmospheric parameters such as:

### 🌬️ Wind

* Wind direction
* Wind speed
* Wind variation where available

### 👁️ Visibility

Reported aerodrome visibility extracted from METAR observations.

### ☁️ Cloud Conditions

* Cloud amount
* Cloud layer
* Cloud base
* Oktas representation

### 🌡️ Temperature

* Air temperature
* Dew point temperature

### 📊 Atmospheric Pressure

* QNH / pressure information where available

### 🌧️ Present Weather

Weather phenomena reported within the METAR observation.

---

# 🧠 Aviation Meteorology Concepts

Aviocast incorporates several aviation meteorological concepts, including:

* **METAR** — routine aerodrome meteorological observations
* **TAF** — planned future enhancement for aerodrome forecasts
* **ICAO Airport Identifiers**
* **IATA Airport Codes**
* **Aerodrome Weather**
* **Cloud Amount**
* **Cloud Base**
* **Visibility**
* **Wind Direction & Velocity**
* **Temperature / Dew Point**
* **QNH / Atmospheric Pressure**
* **Alternate Aerodrome Weather**
* **Oktas Cloud-Cover Representation**

---

# ⚙️ Technical Architecture

The application follows a data-processing approach where aviation weather observations are transformed before being presented to the user.

```text
┌──────────────────────────────┐
│   Aviation Weather Source    │
└──────────────┬───────────────┘
               │
               ▼
        METAR Observation
               │
               ▼
       ┌───────────────┐
       │ METAR Parsing │
       └───────┬───────┘
               │
               ▼
   ┌─────────────────────────┐
   │ Meteorological Elements │
   └────────────┬────────────┘
                │
       ┌────────┴────────┐
       ▼                 ▼
 Primary Aerodrome   Alternate Aerodrome
       │                 │
       └────────┬────────┘
                ▼
       Weather Assessment
                │
                ▼
       Cloud / Oktas Analysis
                │
                ▼
       Human-Readable Data
                │
                ▼
           Aviocast UI
```

---

# 🛠️ Technology Stack

### Application

* **Flutter**
* **Dart**

### Data & APIs

* **METAR Aviation Weather Data**
* **REST APIs**
* **JSON**

### Aviation / Meteorology

* METAR Parsing
* ICAO Airport Identification
* IATA Airport Identification
* Cloud Coverage Analysis
* Oktas Representation
* Aerodrome Weather Assessment
* Alternate Aerodrome Weather Consideration

---

# ✨ Core Features

| Feature                         | Description                                                               |
| ------------------------------- | ------------------------------------------------------------------------- |
| 📡 **METAR Parsing**            | Converts coded aerodrome observations into structured weather information |
| ✈️ **ICAO Support**             | Uses ICAO airport identifiers for aviation weather data                   |
| 🏷️ **IATA Support**            | Uses IATA airport codes for airport identification                        |
| ☁️ **Cloud Analysis**           | Interprets FEW, SCT, BKN and OVC cloud groups                             |
| 🌤️ **Oktas Representation**    | Represents reported cloud amount using the okta scale                     |
| 🌬️ **Wind Analysis**           | Processes wind direction and velocity                                     |
| 👁️ **Visibility**              | Processes aerodrome visibility observations                               |
| 🌡️ **Temperature & Dew Point** | Extracts atmospheric temperature information                              |
| 📊 **Pressure**                 | Processes reported atmospheric pressure/QNH                               |
| 🛬 **Alternate Aerodrome**      | Considers alternate-aerodrome weather in the weather assessment           |
| 📱 **Mobile Application**       | Built using Flutter                                                       |

---

# 🎯 Project Motivation

Aviocast was created at the intersection of two interests:

### ✈️ Aviation + 💻 Software Development

Aviation weather is one of the most interesting areas where software, data, and meteorology come together.

Rather than building another generic weather application, Aviocast focuses on **aviation-specific meteorological information** and the challenge of turning highly compressed weather observations such as METAR into information that is easier for aviation enthusiasts to understand.

Through this project, I explored:

* Aviation weather data
* METAR syntax and parsing
* Aerodrome meteorology
* Cloud-cover interpretation
* Airport identification systems
* Weather-data processing
* Alternate-aerodrome weather consideration
* Mobile application development with Flutter

---

# 🚀 Future Development

Potential future improvements include:

* [ ] **TAF parsing and interpretation**
* [ ] METAR history and observation timelines
* [ ] Interactive aviation weather maps
* [ ] Wind visualization
* [ ] Improved cloud-base visualization
* [ ] Aerodrome weather trends
* [ ] NOTAM integration
* [ ] SIGMET / AIRMET integration
* [ ] More detailed alternate-aerodrome analysis
* [ ] Advanced aviation meteorological analysis

---

# 🧪 Project Status

**🚧 Active Development**

Aviocast is an evolving project focused on exploring aviation meteorology through software and data processing.

---

# 👨‍💻 Author

## Mandeep Pokharel

**BSc. CSIT Student • Software Developer • Aviation Enthusiast**

Aviocast is a personal project combining my interests in **aviation, meteorology, and software engineering**.

---

<p align="center">

### ✈️ Decode the Weather. Explore Aviation.

**Aviocast**

⭐ If you find the project interesting, consider giving the repository a star.

</p>

---

## 📄 License

This project is currently intended for **educational, experimental, and portfolio purposes**.
