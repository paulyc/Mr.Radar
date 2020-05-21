# Mr.Radar
"Now that I have my coffee, I'm ready to watch radar. Where is it?"

"Right here, sir!"

### TDWR Level III Base Reflectivity Data (48nm range)
Seems NOAA likes shuffling this around to keep people on their toes but as of 21 May 2020 it's under
ftp://tgftp.nws.noaa.gov/SL.us008001/DF.of/DC.radar/DS.180z0/SI.txxx/sn.0yyy
where txxx is the station eg ttpa = Tampa and the yyy is a monotonically increasing counter but it wraps around
at some point like 250 so, sn.last is the most recent one, and one could use the size/timestamp to figure out where
in the chronological order it is. Those files are in the Offical Mr. TDWR(R) Binary Format(TM) as specced by NOAA
and you can use something like [their Weather and Climate Toolkit](https://www.ncdc.noaa.gov/wct/index.php) to turn it
into an image. (Much like the TDWR data itself, by the time you're reading this it may have moved, so, being in the
public domain as a Work of the Federal Government(R), I have also taken the liberty of putting it in
[a repo](https://github.com/paulyc/NOAA-WCT) that should last at least as long as this one, and at the same URI....
