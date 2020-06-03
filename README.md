# Mr.Radar
<a href="http://www.youtube.com/watch?feature=player_embedded&v=DsGZYW_DTEg" target="_blank">
<img src="https://raw.githubusercontent.com/paulyc/Mr.Radar/master/Mr.Radar.jpg"
     alt="Mr. Coffee and Mr. Radar from 'Spaceballs' (1987)"
     width="320" height="180" border="10" />
</a>

"Now that I have my coffee, I'm ready to watch radar. Where is it?"

"Right here, sir!"

[_Spaceballs_, 1987]

## Objective
Automate the collection and distribution (in human-parsable format) of raw radar data, particularly 
the TDWR (Terminal Doppler Weather Radar) located in major airports and is particularly difficult 
to find anywhere because of ongoing technical issues seemingly related to changed upload locations 
on the NOAA distribution side.

## Tech Specs

### Data Location
Seems NOAA likes shuffling this around to keep people on their toes[1] but as of 21 May 2020 it's 
under

ftp://tgftp.nws.noaa.gov/SL.us008001/DF.of/DC.radar/DS.ppppp/SI.ssss/sn.cccc

where ppppp is product code eg 180z0 = 48nm Low Elevation Base Reflectivity.

ssss is the station/site eg ttpa = Tampa and cccc is a monotonically increasing counter from 0000 
but it wraps around at some point like 0250 so, sn.last is the most recent one (Beware partial 
files), and one could use the size/timestamp to figure out where in the chronological order it is. 
Those files are in various formats depending on the dataset as specced by NOAA and can usually be 
turned into images or charts by something like [their Weather and Climate 
Toolkit](https://www.ncdc.noaa.gov/wct/index.php) or [Unidata's 
MetPy](https://unidata.github.io/MetPy/). (in the case of WCT, being in the public domain as a Work 
of the Federal Government(R), I have also taken the liberty of putting it in [a 
repo](https://github.com/paulyc/NOAA-WCT) that should last at least as long as this one, and at the 
same URI, because you never really know where it will end up.)

[1] No I have never even worked at a private company that kept their engineers' docs up to date, 
can only imagine the absurd hassle it must be trying to fix any of them when they're the 
government's and the general public are the engineers.

#### Example
The most recent 48nm 0.5 degree reflectivity data (in NEXRAD_LEVEL3 format) for TTPA is found at

ftp://tgftp.nws.noaa.gov/SL.us008001/DF.of/DC.radar/DS.180z0/SI.ttpa/sn.last

### List of Product Codes (At least as far as I can tell)
* 141md = NEXRAD Level-III Digital Mesocyclone Detection Algorithm
* 152rs = Radar Status Log
* 180z0 = 48nm Low Elevation Base Reflectivity
* 180z1 = 48nm Mid Elevation Base Reflectivity
* 180z2 = 48nm High Elevation Base Reflectivity
* 182v0 = 48nm Low Elevation Base Radial Velocity
* 182v1 = 48nm Mid Elevation Base Radial Velocity
* 182v2 = 48nm High Elevation Base Radial Velocity
* 186zl = 225nm Low Elevation Base Reflectivity
* 32dhr = 124nm Digital Hybrid Scan Reflectivity
* 48vwp = VAD Wind Profile
* 57vil = 48nm Vertically Integrated Liquid
* 58sti = Storm Tracking
* 61tvs = Tornado Vortex Signature
* 78ohp = 225nm One Hour Precipitation
* 80stp = 225nm Storm Total Precipitation
* p2gsm = NEXRAD Level-III General Status Message
* p37cr = 124nm Composite Reflectivity
* p41et = 124nm Echo Tops
* p59hi = Hail Index

## Tools Usage
Rough. I've only had time to write a few scripts just to help me figure this stuff out, not my job 
though I'd apply, so they are only self-documented bash but generally simple enough.

### nexrad32plot.py [Python 3]
Usage:
nexrad32plot.py <FILENAME> <save|[plot]>

Requires Python3 and MetPy. (npm install from source or npm failed for me on Linux, use the 
Anaconda Package Manager imo). Attempts to transcode NEXRAD_LEVEL3 data in FILENAME to an image. 
Specify plot or save to either open an interactive plot window [default] or save to a PNG file in 
the same directory.

### fetch_tdwr.sh
Usage:
fetch_tdwr.sh [<plot|save|[none]>] [<station|[ttpa]> [<product|[180z0]> [[<counter|[last]>>]]]
Attempt to download NEXRAD_LEVEL3 data file from the NOAA distribution server, and optionally, 
process into an image. With no arguments, saves the latest 48nm 0.5deg base reflectivity data from 
TTPA and does no further processing. Specify plot or save before other arguments if MetPy to plot 
or save image if MetPy is installed.

## Why Do I Want This?
The Terminal Doppler Weather Radar/NEXRAD-3 gives you a much higher resolution radar image than the 
NEXRAD-2 system that has wider coverage, and it is rarely found in any OSS apps or free weather 
websites, if even any paid ones (at the current time of writing, I believe even Weather Underground 
has not updated their radar widget to pull TDWR from the new URI so they've all been perpetually 
'down for maintenance' for as many months as I can remember checking, though, [they are not 
really](https://radar3pub.ncep.noaa.gov/))
