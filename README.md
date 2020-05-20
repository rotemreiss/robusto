# RobuSTO
:collision:*Robust-Subdomain-Takeover*:collision:

Get a domain, enumerate subdomains and then search for subdomain takeovers.

## How is it different from other tools?
This tools was build around the idea of automating the process, and allow blue-teams to use it to scan their own assets.

For example, scan all my organization's subdomains on a recurring basis and trigger an internal alert when an issue pops.

The tool was also built as **"CI-Ready"** (see more about it below).

## Installation
- Prerequisites
  - Docker
- Clone the repository with `git clone --recursive` (the recursive flag will also clone the Git submodule - nuclei-templates) 

## Usage
RobuSTO supports both single/multiple domain(s).

- Single domain
```bash
echo "domain.com" > ./robusto.sh
```

- Multiple domains
```bash
cat domains.txt > ./robusto.sh
```

## Using the Results
- Results are saved to results.txt
- The scanner is "CI-Ready" and it returns a matching exit code according to scan results.
```
0 - No results
2 - Found subdomain(s) to takeover
```

For example, if there were results, the file will contain something like:

```
[detect-all-takeovers:aws-s3-bucket] [http] http://take.me.over/
```

## Hooks/Integrations
The scanner is built in a flexible way that allows the user to trigger integrations once results have been found.
Just add a file named `_found_hook` in the hooks directory and do all the integrations you want there. This file will automatically be executed once vulnerable subdomains have been found.

See the `hooks` directory for examples like automated Jira ticketing on new results.

More integration suggestions (not shipped with the scanner, but contributions are welcome):
- Slack/Teams/..
- Email
- SMS

---
## Contributing
Feel free to fork the repository and submit pull-requests.

---

## Support

Want to say thanks? :) Message me on <a href="https://www.linkedin.com/in/reissr" target="_blank">Linkedin</a>

---

## Credits
RobuSTO relies on the following great tools:
- https://github.com/projectdiscovery/subfinder
- https://github.com/projectdiscovery/dnsprobe
- https://github.com/projectdiscovery/nuclei
- https://github.com/tomnomnom/httprobe

Thanks for @tomnomnom and @projectdiscovery! :heart:

---

## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)
