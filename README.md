# Public Radio Podcast Measurement Tools

This gem contains tools for parsing logs according to the PRPM Guidelines:

https://docs.google.com/document/d/1qMORNRNyAR3L_03VYlvZK9dpKMk_d7pUxCnJfeKgVn0/edit

To install:

gem install prpm-tools


The tools can be used from the command line via:

prpm-parse-logile

or the underlying classes can be used as part of a Ruby script or Rails app as needed.

These tools aim to provide a unified output for all input log formats, so that logs can be consolidated, and the parsed files can be imported into other systems for further analysis without any surprises

The criteria for extracting valid data are:

**Counting Unique Downloaders**

downloaders (over a time period like a week) =
  GET +
  200 or (206 + (byte range 0-* or -)) +
  not a bot or filtered IPs) +
  is > 200,000 bytes +
  (unique (IP + user agent) or unique (IP + user agent + show))


**Counting Unique Downloads**

downloads =
  GET +
  200 or (206 + (byte range 0-* or -)) +
  no bots or filtered IPs +
  is > 200,000 bytes +
  unique (IP + user agent + file + year + month + day) +
  byte range start < file size


This gem is primarily intended to be used from the command line, with the output being imported into some other system for further analysis.

The parser should generally be run over one week of log data as this is typically how radio cume is also measured.

If you are running this on data from a standalone podcast (no radio broadcasts) it is recommended that you use still a week because
the numbers you get will be comparable with the numbers published by public broadcasters who use this methodology.

## The output

The script outputs only lines that match according to the Guidelines. It outputs a line of data for each valid log line.

The first field is the date followed by downloader_uid and download_uid - these are SHA1 hashes of the relevant fields. The full list is:

date, downloader_uid, download_uid, show_id, status, bytes_sent, url

We use a SHA1 as this makes subsequent processing for uniqueness simpler.

## Quick and dirty counts

To get the number of downloaders:

prpm-parse-logfile --log-type=nginx podcast.radionz.co.nz-2016-01-31 | cut -f 2 -d ',' | sort | uniq | wc -l

To get the number of downloads:

prpm-parse-logfile --log-type=nginx podcast.radionz.co.nz-2016-01-31 | cut -f 3 -d ',' | sort | uniq | wc -l

You can also pipe the output of gunzip into the script:

gunzip -c podcast.radionz.co.nz-2016-01-31.gz | prpm-parse-logfile --log-type=nginx | cut -f 2 -d ',' | sort | uniq | wc -l


## Testing the code

Clone the repository locally, switch to the project root, and run from the terminal like this:

./bin/prpm-parse-logfile  

## Usage

TODO: Write full usage instructions

## Modules

The gem comes with a number of classes that can be wired together to parse logs

**Log Line Parser**

These extract data from one line of a log file. They should be set to only extract HTTP GET requests with status codes 200 or 206

**Show Filter**

A show filter is used to parse out the name (or code) for a show from the URL.

**Bot Filter**

This checks the user agent string against know bots.
(this is a work in progress)

This command can be used to update the data being used by the gem

./bin/prpm-update-botdata  

**Line Filter**

This is where the testing of lines is done against the guidlines.

NB: For log types that DO NOT contain a range, the filter allows ALL 206 requests for a file through.
Because they all have the same downloader_uid and download_uid, they will be filtered later.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/radionewzealand/prpm-tools.
