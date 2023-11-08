# io_heartbeat

The `io_heartbeat` Puppet module will create Heartbeat monitors for web servers, app servers, and hosts. It can be run with the DPK to automatically create monitors for Heartbeat to consume. 

## Table of Contents

- [io\_heartbeat](#io_heartbeat)
  - [Table of Contents](#table-of-contents)
  - [Setup](#setup)
    - [What io\_heartbeat affects](#what-io_heartbeat-affects)
  - [Reference](#reference)

## Setup

1. Clone the repository or add it as a submodule to the DPK.

    ```bash
    $ cd <DPK_LOCATION>
    $ git submodule add https://github.com/psadmin-io/io_heartbeat.git modules/io_heartbeat
    ```
2. Add the required `io_heartbeat::vars` (See the [Reference](#reference) section.)
3. Run the module to test

    ```bash
    $ puppet apply --confdir <DPK_LOCATION> -e "contain ::io_heartbeat"
    ```

4. (Optional) Include `io_heartbeat` as pat of your DPK build by added it to your DPK role.

    ```puppet
    # pt_tools_midtier.pp
    if $ensure == present {
      contain ::pt_profile::pt_tools_preboot_config
      contain ::pt_profile::pt_domain_boot
      contain ::pt_profile::pt_tools_postboot_config
      contain ::pt_profile::pt_password
      contain ::io_heartbeat
      
      Class['::pt_profile::pt_system'] ->
      Class['::pt_profile::pt_tools_deployment'] ->
      Class['::pt_profile::pt_psft_environment'] ->
      Class['::pt_profile::pt_appserver'] ->
      Class['::pt_profile::pt_prcs'] ->
      Class['::pt_profile::pt_pia'] ->
      Class['::pt_profile::pt_tools_preboot_config'] ->
      Class['::pt_profile::pt_domain_boot'] ->
      Class['::pt_profile::pt_tools_postboot_config'] ->
      Class['::io_heartbeat']
    }
    ```

### What io_heartbeat affects 

The module will not modify PeopleSoft domains. It only creates external files to be used with Heartbeat. 

## Reference

Configuration options:

* Service Name: used by Elasticsearch/Opensearch Observability to group different monitors into a application.
* Monitor Location: Where `io_heartbeat` will write the monitor files.
* Check Interval: How often to run the monitor (default is `60s`)
* Web (boolean): Create monitor files for web server
* Web Port: Specify HTTP port for the web monitor (default is `8000`)
* App (boolean): Create monitor files for app server
* App Port: Specify Jolt port for the app monitor (default is `9033`)
* PIA (boolean): Create a monitor to attempt a login
* PIA URL: The URL the login POST will use
* PIA User: The username to login to the PIA
* PIA Password: The password to login to the PIA
* PIA Check String: The HTML body string to verify login was successful (default is `WEBLIB_PTBR.ISCRIPT1.FieldFormula.IScript_StartPage`)
* Integration Gateway (boolean): Create monitor file for the IB Gateway
* IG URL: The URL to check for an ACTIVE gateway. Include `PSIGW/PeopleSoftListeningConnector` in the URL.

Add this configuration to your `psft_customizations.yaml` file to enable `io_heartbeat`.

```yaml
---
io_heartbeat::service_name:     "%{hiera('db_name')}"
io_heartbeat::monitor_location: '/psoft/share/heartbeat/'
io_heartbeat::check_interval:   '30s'
io_heartbeat::web:              true
io_heartbeat::web_port:         "%{hiera('pia_http_port')}"
io_heartbeat::app:              true
io_heartbeat::app_port:         "%{hiera('jolt_port')}"
io_heartbeat::pia:              true
io_heartbeat::pia_url:          "https://%{hiera('dns_name')}/psp/%{hiera('pia_site_name')}/EMPLOYEE/%{hiera('portalnode')}"
io_heartbeat::pia_user:         'UPTIME'
io_heartbeat::pia_pwd:          'UPT!ME' 
# you can also reference a Heartbeat keystore value
io_heartbeat::pia_pwd:          '${UPTIME_PWD}'
io_heartbeat::igw:              true
io_heartbeat::igw_url:          "https://%{hiera('dns_name')}/PSIGW/PeopleSoftListeningConnector"
```
