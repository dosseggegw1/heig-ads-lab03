#!/bin/bash
#
# loganalysis - analyze log file

echo -n '01 Number of log entries: '
wc -l ads_website.log

echo -n '02a Number of "OK" (200) responses: '
cut ads_website.log -f10 | sort | uniq -c | grep 200$

echo -n '02b Number of "Not Found" (404) responses: '
cut ads_website.log -f10 | sort | uniq -c | grep 404$

echo    '03 URIs that generated a "Not Found" response: '
cut ads_website.log -f9-10 | grep "404$" | sort -u | cut -f1 | tr '"' ' ' | cut -d ' ' -f3

echo -n '04 Number of days on which requests were made: '
cut -f3 ads_website.log | cut -c2-12 | sort -u | wc -l

echo -n '05 Number of accesses on 4th March 2014: '
cut -f3 ads_website.log | cut -c2-12 | sort | uniq -c | grep "04/Mar/2014"

echo    '06 Top 3 days with the most accesses: '
cut -f3 ads_website.log | cut -c2-12 | sort | uniq -c | sort -gr | head -3

echo -n '07 User agent string with the most accesses: '
cut ads_website.log -f17 | sort | uniq -c | sort -nr | head -1

echo -n '08a Number of accesses from Windows machines: '
cut ads_website.log -f17 | grep -ci 'Windows'

echo -n '08b Number of accesses from Linux machines: '
cut ads_website.log -f17 | grep -ci 'Linux'

echo -n '08b Number of accesses from Linux machines without Android: '
cut ads_website.log -f17 | grep -v 'Android' | grep -ci 'Linux'

echo -n '08c Number of accesses from Mac OS X machines: '
cut ads_website.log -f17 | grep -ci 'Mac OS X'

echo -n '08c Number of accesses from Mac OS X machines Without iPhone and iPad: '
cut ads_website.log -f17 | grep -vEi 'iPhone|iPad' | grep -ci 'Mac OS X'

echo -n '09a Number of accesses from Windows machines: '
cut ads_website.log -f17 | tee useragents.txt |grep -ci 'Windows'

echo -n '09b User agent strings (with duplicates): '
cat useragents.txt

echo -n '10 Bonus List of unique status code in access.log: '

