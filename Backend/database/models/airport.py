from dataclasses import dataclass,field


@dataclass
class Airport:
    icao: str
    iata: str
    name: str
    latitude: float
    longitude: float
    has_metar: bool
    alternates: list = field(default_factory=list)



AIRPORTS = {
  
   "VNKT": Airport(
    icao="VNKT",
    iata="KTM",
    name="Tribhuvan International Airport",
    latitude=27.69639,
    longitude=85.35889,
    has_metar=True,
    alternates=["VNBW", "VNPR", "VNJP"]
),

"VNBW": Airport(
    icao="VNBW",
    iata="BWA",
    name="Gautam Buddha International Airport",
    latitude=27.5057,
    longitude=83.4163,
    has_metar=False,
    alternates=["VNKT", "VNNG"]
),

"VNPR": Airport(
    icao="VNPR",
    iata="PKR",
    name="Pokhara International Airport",
    latitude=28.2010,
    longitude=83.9820,
    has_metar=False,
    alternates=["VNKT", "VNBW"]
),

"VNVT": Airport(
    icao="VNVT",
    iata="BIR",
    name="Biratnagar Airport",
    latitude=26.4815,
    longitude=87.2639,
    has_metar=False,
    alternates=["VNKT", "VNBW"]
),

"VNNG": Airport(
    icao="VNNG",
    iata="KEP",
    name="Nepalgunj Airport",
    latitude=28.1036,
    longitude=81.6670,
    has_metar=False,
    alternates=["VNBW", "VNKT"]
),

"VNDH": Airport(
    icao="VNDH",
    iata="DHI",
    name="Dhangadhi Airport",
    latitude=28.7533,
    longitude=80.5819,
    has_metar=False,
    alternates=["VNNG", "VNBW"]
),

"VNJP": Airport(
    icao="VNJP",
    iata="JKR",
    name="Janakpur Airport",
    latitude=26.7088,
    longitude=85.9244,
    has_metar=False,
    alternates=["VNKT"]
),

"VNSI": Airport(
    icao="VNSI",
    iata="SIF",
    name="Simara Airport",
    latitude=27.1595,
    longitude=84.9801,
    has_metar=False,
    alternates=["VNKT"]
),

"VNBP": Airport(
    icao="VNBP",
    iata="BHR",
    name="Bharatpur Airport",
    latitude=27.6781,
    longitude=84.4294,
    has_metar=False,
    alternates=["VNKT"]
),

"VNCG": Airport(
    icao="VNCG",
    iata="BDP",
    name="Chandragadhi Airport",
    latitude=26.5711,
    longitude=88.0796,
    has_metar=False,
    alternates=["VNVT", "VNKT"]
),

"VNTR": Airport(
    icao="VNTR",
    iata="TMI",
    name="Tumlingtar Airport",
    latitude=27.3150,
    longitude=87.1933,
    has_metar=False,
    alternates=["VNVT", "VNKT"]
),

"VNSK": Airport(
    icao="VNSK",
    iata="SKH",
    name="Surkhet Airport",
    latitude=28.5860,
    longitude=81.6360,
    has_metar=False,
    alternates=["VNNG", "VNKT"]
),

"VNLK": Airport(
    icao="VNLK",
    iata="LUA",
    name="Tenzing-Hillary Airport (Lukla)",
    latitude=27.6869,
    longitude=86.7297,
    has_metar=False,
    alternates=["VNKT", "VNRC"]
),

"VNJS": Airport(
    icao="VNJS",
    iata="JMO",
    name="Jomsom Airport",
    latitude=28.7822,
    longitude=83.7225,
    has_metar=False,
    alternates=["VNPR", "VNKT"]
),

"VNJL": Airport(
    icao="VNJL",
    iata="JUM",
    name="Jumla Airport",
    latitude=29.2742,
    longitude=82.1933,
    has_metar=False,
    alternates=["VNKT"]
),

"VNDP": Airport(
    icao="VNDP",
    iata="DOP",
    name="Dolpa (Juphal) Airport",
    latitude=28.9868,
    longitude=82.8191,
    has_metar=False,
    alternates=["VNJL"]
),

"VNTJ": Airport(
    icao="VNTJ",
    iata="TPJ",
    name="Taplejung Suketar Airport",
    latitude=27.3509,
    longitude=87.6953,
    has_metar=False,
    alternates=["VNVT"]
),

"VNMA": Airport(
    icao="VNMA",
    iata="NGX",
    name="Manang Airport",
    latitude=28.6417,
    longitude=84.0891,
    has_metar=False,
    alternates=["VNJS"]
),

"VNSB": Airport(
    icao="VNSB",
    iata="SYH",
    name="Syangboche Airport",
    latitude=27.8112,
    longitude=86.7124,
    has_metar=False,
    alternates=["VNLK", "VNKT"]
),

"VNMG": Airport(
    icao="VNMG",
    iata="MEY",
    name="Meghauli Airport",
    latitude=27.5774,
    longitude=84.2288,
    has_metar=False,
    alternates=["VNBP"]
),

"VNRB": Airport(
    icao="VNRB",
    iata="RJB",
    name="Rajbiraj Airport",
    latitude=26.5100,
    longitude=86.7339,
    has_metar=False,
    alternates=["VNJP"]
),

"VNRT": Airport(
    icao="VNRT",
    iata="RUM",
    name="Rumjatar Airport",
    latitude=27.3035,
    longitude=86.5504,
    has_metar=False,
    alternates=["VNKT"]
),

"VNRC": Airport(
    icao="VNRC",
    iata="RCH",
    name="Ramechhap Airport",
    latitude=27.3939,
    longitude=86.0614,
    has_metar=False,
    alternates=["VNKT"]
),

"VNBJ": Airport(
    icao="VNBJ",
    iata="BHP",
    name="Bhojpur Airport",
    latitude=27.1474,
    longitude=87.0508,
    has_metar=False,
    alternates=["VNVT"]
),

"VNSR": Airport(
    icao="VNSR",
    iata="FEB",
    name="Sanfebagar Airport",
    latitude=29.2366,
    longitude=81.2168,
    has_metar=False,
    alternates=["VNDH"]
),

"VNBG": Airport(
    icao="VNBG",
    iata="BJH",
    name="Bajhang Airport",
    latitude=29.5389,
    longitude=81.1854,
    has_metar=False,
    alternates=["VNBR"]
),

"VNBR": Airport(
    icao="VNBR",
    iata="BJU",
    name="Bajura Airport",
    latitude=29.5020,
    longitude=81.6689,
    has_metar=False,
    alternates=["VNBG"]
),

"VNBT": Airport(
    icao="VNBT",
    iata="BIT",
    name="Baitadi Airport",
    latitude=29.4650,
    longitude=80.5490,
    has_metar=False,
    alternates=["VNDL"]
),

"VNDL": Airport(
    icao="VNDL",
    iata="DAP",
    name="Darchula Airport",
    latitude=29.6692,
    longitude=80.5484,
    has_metar=False,
    alternates=["VNBT"]
),

"VNTP": Airport(
    icao="VNTP",
    iata="TPU",
    name="Tikapur Airport",
    latitude=28.5219,
    longitude=81.1237,
    has_metar=False,
    alternates=["VNBW"]
),

}

    



