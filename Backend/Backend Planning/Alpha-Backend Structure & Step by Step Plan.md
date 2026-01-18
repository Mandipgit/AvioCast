# Backend Structure:

WeatherAlpha/

│

├── frontend/

│   └── flutter/

│

├── backend/

│   ├── main.py

│   │

│   ├── config/

│   │   └── settings.py

│   │

│   ├── database/

│   │   ├── database.py

│   │   └── models/

│   │       ├── airport.py

│   │       └── (later) weather\_request.py

│   │

│   ├── routers/

│   │   └── weather.py

│   │

│   ├── services/

│   │   ├── weather\_service.py

│   │   └── risk\_service.py

│   │

│   └── schemas/

│       └── (later) weather.py





# Step By Step Plan:

2\. What Each Backend File Is Responsible For



This is the mental model you must keep while coding.



#### main.py (Application Entry Point)



What it does:



Creates FastAPI app



Includes routers



Starts the server



What it must NOT do:



Weather API calls



Database queries



Risk logic



Think:



“This file only wires things together.”



#### config/settings.py (Configuration Layer)



Purpose:



Store environment variables



Weather API key



Database URL



App-level settings



Why this matters:



No hardcoded secrets



Easy to switch environments later



You don’t need advanced config now — just define the place.



#### database/database.py (DB Connection)



Purpose:



PostgreSQL connection



Session handling



Dependency setup



This is where:



FastAPI ↔ PostgreSQL first meet



No business logic here.



#### database/models/airport.py (Core Table)



Purpose:



Represents the airports table



Fields you should think about:



id



airport\_code (KTM, BIR, BDP)



name



latitude



longitude



⚠️ This table is the backbone of your entire project.



#### routers/weather.py (API Layer)



Purpose:



Define endpoints



Receive input



Return output



Rule:



Routes should be thin.



They should:



Validate input



Call services



Return response



They should NOT:



Call weather APIs directly



Contain risk calculation logic



#### services/weather\_service.py (External Integration)



Purpose:



Call weather API



Convert raw response → clean weather data



This file:



Knows nothing about FastAPI routes



Knows nothing about PostgreSQL



It only answers:



“What is the weather at this location?”



#### services/risk\_service.py (Core Intelligence 🧠)



Purpose:



Apply aviation risk rules



Convert weather → risk score + explanation



This is:



Pure logic



No API



No DB



No FastAPI



This separation is what makes you think like a real backend engineer.



#### schemas/ (Data Shape Layer)



Purpose:



Define request and response structure



Keep API clean and predictable



You’ll use this slowly — no rush.



### 3\. EXACT Order You Should Build the Backend (Very Important)



Follow this order strictly 👇

This avoids confusion and burnout.



#### 🔹 PHASE 1: Backend Bootstrapping (Day 1)

##### Step 1: Make the App Run



Files:



main.py



Goal:



Server starts



/docs works



No database



No weather API



If Swagger doesn’t open → stop and fix.



##### Step 2: Config Layer (Light Setup)



Files:



config/settings.py



Do this:



Define placeholders for:



Database URL



Weather API key



Don’t use them yet



This builds good habits early.



#### 🔹 PHASE 2: PostgreSQL Foundation (Critical)

##### Step 3: Database Connection



Files:



database/database.py



Goal:



Backend connects to PostgreSQL



Sessions work



Focus on learning:



Engine vs session



Dependency idea (even if confusing at first)



##### Step 4: Airport Table (First Real Model)



Files:



database/models/airport.py



Do this carefully.

This table will be used everywhere.



##### Step 5: Test Airport Data



What to do:



Insert 3–4 Nepal airports manually



Create a simple GET endpoint to fetch airport by code



Files involved:



routers/weather.py



airport.py



This step proves:



DB works



Models work



Routing works



#### 🔹 PHASE 3: Services (Only After DB Works)

##### Step 6: Weather Service



Files:



services/weather\_service.py



Goal:



Fetch weather using lat/long



Extract only what aviation needs



Test this without routes first.



##### Step 7: Risk Service



Files:



services/risk\_service.py



Goal:



Rule-based risk scoring



Input: weather data



Output: risk + explanation



Test using fake data.



#### 🔹 PHASE 4: Final Integration



Only now:



Route → DB → weather service → risk service → response



This is when the project comes alive.



###### 4\. Beginner Rules You MUST Remember 🚨



❌ Don’t put logic in routes



❌ Don’t hardcode secrets



❌ Don’t call weather API from Flutter



❌ Don’t mix DB + logic + API in one file



If something feels messy, you’re mixing layers.

###### 5\. Your Immediate Next Task (Choose One)



Reply with one of these:



“Help me design the airport table properly”



“Help me start Step 1 (main.py) correctly”



“Let me explain my DB connection approach and you review it”


