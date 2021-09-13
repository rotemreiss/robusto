# RobuSTO
:collision:*Robust-Subdomain-Takeover*:collision:

Get a list of domains and search for subdomain takeovers.

## How is it different from other tools?
This tools was build around the idea of automating the process, and allow blue-teams to use it to scan their own assets.

For example, scan all my organization's subdomains on a recurring basis and trigger an internal alert when an issue pops.

The tool was also built as **"CI-Ready"** (see more about it below).

## Installation
- Prerequisites
  - [Nuclei](https://github.com/projectdiscovery/nuclei)
- Clone the repository with `git clone https://github.com/rotemreiss/robusto.git` 

## Usage
RobuSTO supports both single/multiple domain(s).

- Single domain
```bash
echo "domain.com" | ./robusto.sh
```

- Multiple domains
```bash
cat domains-tmp.txt | ./robusto.sh
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
The scanner is flexible and allows the user to trigger integrations once results have been found.
Just add a file named `_found_hook` in the hooks directory and do all the integrations you want there. This file will automatically be executed once vulnerable subdomains have been found.

See the `hooks` directory for examples, such as:
- Jira integration
- Slack integration

More integration suggestions (not shipped with the scanner, but contributions are welcome):
- MS Teams
- Email
- SMS

---
## Contributing
Feel free to fork the repository and submit pull-requests.

---

## Support

Want to say thanks? :) Message me on [Linkedin](https://www.linkedin.com/in/reissr)

---

## Credits
RobuSTO relies on the following great tools:
- https://github.com/projectdiscovery/nuclei

Thanks to @projectdiscovery! :heart:

---

## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)
