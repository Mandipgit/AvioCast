# ✈️ Aviocast

### Aviation Weather • METAR Intelligence • Cloud Analysis

> **Aviation weather, decoded.**
>
> Aviocast is a modern aviation weather application built for **aviation enthusiasts**, transforming coded aviation weather observations into understandable and visually engaging weather information.

---

<p align="center">

**🌤️ Weather Data**   •   **✈️ Aviation Meteorology**   •   **📡 METAR Parsing**   •   **☁️ Cloud Analysis**

</p>

---

## 🛫 About Aviocast

Aviation weather information is often distributed through specialized formats such as **METAR**, which contain a large amount of meteorological information in a compact coded structure.

**Aviocast takes that coded information and makes it easier to understand.**

The application retrieves aviation weather observations, parses the METAR report, extracts individual meteorological parameters, and presents them through a clean aviation-oriented interface.

It also applies basic aviation meteorology concepts such as the **Oktas cloud-cover scale** to interpret reported cloud conditions.

### The idea is simple:

```text
      Raw Aviation Weather
              │
              ▼
        ┌─────────────┐
        │    METAR    │
        │    Parser   │
        └──────┬──────┘
               │
               ▼
     Meteorological Data
               │
       ┌───────┴────────┐
       ▼                ▼
  Weather Data     Cloud Analysis
       │                │
       └───────┬────────┘
               ▼
       Human-Readable
       Aviation Weather
               │
               ▼
          ✈️ Aviocast
```

---

## 🌦️ What Aviocast Provides

### 📡 METAR Processing

Aviocast works with **METAR (Meteorological Aerodrome Report)** observations and breaks down the coded report into meaningful weather parameters.

Instead of displaying something like:

```text
VNKT 111000Z 27008KT 6000 FEW025 SCT035 27/20 Q1012
```

Aviocast interprets the individual components and presents them in an understandable format.

---

### 🌬️ Wind Information

METAR wind observations are parsed to provide information such as:

* Wind direction
* Wind speed
* Wind variations
* Direction in degrees
* Aviation-style wind representation

---

### 👁️ Visibility

Visibility information from METAR observations is extracted and presented in a more readable format, helping users understand the current atmospheric visibility around an aerodrome.

---

### ☁️ Cloud Coverage

Aviocast interprets METAR cloud groups such as:

```text
FEW
SCT
BKN
OVC
```

and maps them to the **Oktas cloud-cover scale**.

| METAR | Meaning    | Oktas |
| :---: | ---------- | :---: |
|  FEW  | Few clouds |  1–2  |
|  SCT  | Scattered  |  3–4  |
|  BKN  | Broken     |  5–7  |
|  OVC  | Overcast   |   8   |

This allows coded cloud observations to be represented in a much more intuitive way.

---

### 🌡️ Atmospheric Conditions

Aviocast extracts and presents important meteorological parameters including:

* 🌡️ Temperature
* 💧 Dew point
* 🌬️ Wind
* 👁️ Visibility
* ☁️ Cloud coverage
* 🧭 Wind direction
* 📊 Atmospheric pressure
* 🌧️ Present weather conditions

---

# 🧠 Aviation Meteorology

A key aspect of Aviocast is its focus on **aviation-specific weather data**, rather than simply providing generic consumer weather information.

The project explores concepts such as:

**METAR**

Standardized aerodrome weather observations.

**Cloud Amount**

Interpretation of FEW, SCT, BKN and OVC cloud groups.

**Oktas**

A traditional method of expressing the fraction of the sky covered by clouds.

**Visibility**

An important meteorological parameter reported in aviation weather observations.

**Dew Point**

Used alongside temperature to understand atmospheric moisture and potential cloud/fog conditions.

**QNH / Pressure**

Atmospheric pressure information reported within aviation weather observations.

---

# ⚙️ Technical Implementation

### METAR → Structured Weather Data

The core processing pipeline follows a structured approach:

```text
METAR String
     │
     ▼
Tokenization
     │
     ▼
METAR Component Detection
     │
     ├── Wind
     ├── Visibility
     ├── Weather
     ├── Clouds
     ├── Temperature
     ├── Dew Point
     └── Pressure
     │
     ▼
Data Interpretation
     │
     ▼
Oktas / Cloud Analysis
     │
     ▼
UI Representation
```

This allows Aviocast to work with aviation weather observations at the **individual component level** instead of simply displaying the original METAR string.

---

# 🛠️ Built With

<p align="center">

### Application

**Flutter** • **Dart**

### Data

**METAR** • **Aviation Weather Data** • **REST APIs** • **JSON**

### Concepts

**Aviation Meteorology** • **METAR Parsing** • **Cloud Coverage Analysis**

</p>

---

# ✨ Highlights

| Feature                    | Description                                   |
| -------------------------- | --------------------------------------------- |
| 📡 **METAR Parser**        | Processes coded aviation weather observations |
| ☁️ **Cloud Analysis**      | Interprets cloud groups using the Oktas scale |
| 🌬️ **Wind Data**          | Extracts aviation wind observations           |
| 👁️ **Visibility**         | Processes reported visibility                 |
| 🌡️ **Temperature**        | Displays temperature and dew point            |
| 📊 **Pressure**            | Presents aviation pressure information        |
| ✈️ **Aviation Focused**    | Designed specifically around aviation weather |
| 📱 **Flutter Application** | Cross-platform mobile application             |

---

# 🎯 Why I Built Aviocast

Aviocast started from a simple intersection of two interests:

### ✈️ Aviation + 💻 Technology

As someone interested in aviation, I wanted to explore how software could be used to make **aviation meteorological information more accessible and understandable**.

Building Aviocast gave me practical experience with:

* Working with real-world weather APIs
* Understanding aviation weather formats
* Parsing structured meteorological data
* Learning METAR syntax
* Applying aviation meteorology concepts
* Working with cloud-cover representation
* Building a mobile application using Flutter
* Converting raw technical data into meaningful UI information

---

# 🚀 Future Roadmap

Aviocast is an evolving project.

### Planned Improvements

* [ ] **TAF parsing and interpretation**
* [ ] METAR history and timeline
* [ ] Interactive aviation weather maps
* [ ] Improved cloud-base visualization
* [ ] Wind visualization
* [ ] Airport-focused weather dashboards
* [ ] Weather trend analysis
* [ ] NOTAM integration
* [ ] SIGMET / AIRMET information
* [ ] More advanced aviation meteorological analysis

---

# 📸 Screenshots

<p align="center">

### Aviocast Interface

*Screenshots coming soon.*

</p>

---

# 🧪 Project Status

**🚧 Active Development**

Aviocast is currently an evolving project. New aviation weather features, visualizations, and meteorological interpretations may be added as development continues.

---

# 👨‍💻 Author

## Mandeep Pokharel

**BSc. CSIT Student • Software Developer • Aviation Enthusiast**

Aviocast is a personal project built at the intersection of my interests in **aviation, meteorology, and software development**.

---

<p align="center">

### ✈️ Decode the Sky. Understand the Weather.

**Aviocast**

⭐ If you find the project interesting, consider giving the repository a star.

</p>

---

## 📄 License

This project is currently intended for **educational, experimental, and portfolio purposes**.
