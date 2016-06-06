Description
===========

Installs and configures [nullmailer](http://untroubled.org/nullmailer/), simple relay-only mail transport agent.

Attributes
==========

- `node['nullmailer']['install_method']`

  Installation method: `package` or `source` (defaults to `source`)

- `node['nullmailer']['src_url']`

  URL of the source repository (defaults to `http://untroubled.org/nullmailer/archive/`)

- `node['nullmailer']['version']`

  Version of the source package (defaults to `1.13`)

- `node['nullmailer']['checksum']`

  Checksum of the source tarball

- `node['nullmailer']['dir']`

  Prefix for the installation (defaults to `/usr/local`)

- `node['nullmailer']['tls']`

  Enables TLS if set to true (default `true`)

- `node['nullmailer']['mailname']`

  Fully-qualified host name of the node running relay agent. Defaults to `node.fqdn`.

- `node['nullmailer']['remotes']`

  A list of remote servers to which to send each message. Each element contains a remote host name or address followed by an optional  protocol            string,  separated by white space.  The protocol name defaults to smtp, and may be followed by command-line arguments for that module.

  Examples:

  ```ruby
  node['nullmailer']['remotes'] = ['1.2.3.4', 'host.domain smtp --port=2525 --user=user --pass=pass']
  ```

  Possible command-line arguments:
  - --port, set the port number of the remote host to connect to
  - --user, set the user name to be used for authentication
  - --pass, set the password for authentication
  - --auth-login, use AUTH LOGIN instead of auto-detecting in SMTP
  - --ssl, Connect using SSL (on port 465 instead) (1.10+)
  - --starttls, use STARTTLS command (1.10+)
  - --x509cafile, Certificate authority trust file (1.10+)
  - --x509crlfile, Certificate revocation list file (1.10+)
  - --x509fmtdef, X.509 files are in DER format (1.10+)
  - --insecure, Do not abort if server certificate fails validation (1.10+)


- `node['nullmailer']['adminaddr']`

  Recipients to users on localhost or canonical host name (mailname) are remapped to this address. This allows local daemons to send emails to 'somebody@localhost' and have it go somewhere sensible instead of being bounced by your relay host.

License and Authors
===================

Author:: Arkency <dev@arkency.com>

Copyright 2012, Arkency

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
