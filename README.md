Tower Bridge
============

tower-bridge.rb is a bot that tweets the opening and closing of Tower Bridge. The code is presented for explanatory purposes; not so you can run your own bot, as it were.

Also: how to separate out OAuth configuration variables from a script that sends tweets - ie, so you can

Configuration
-------------

* Put all these files on a server.
* Set up a cron task to download http://www.towerbridge.org.uk/TBE/EN/BridgeLiftTimes/ , once a day, to schedule.htm
* Run as a sinatra app, returns 2 if the bridge should be open(ing), 1 if it should be closing and 0 if there's no change required.
