Role Name
=========

Ansible role to install acmetool redirector with Certificate Transparency hooks

Role Variables
--------------
Default settings shown below can be overriden on group or host level.

    acme_redirector: true

Is ACME redirector enabled? This `acmetool` process will listen on `80/tcp` for any incoming connections and redirect them to the `https` equivalent and transparently handle all incoming ACME authorisation requests.

    ct_submit: true

Should we publish Certificate Transparency files on certificate renewals?

    ct_logs:
    - ct.googleapis.com/pilot
    - ctlog.wosign.com
    - ctlog.api.venafi.com

The list of CT log servers for publishing.

    ct_submit_deb: "https://github.com/kravietz/ansible-acme-ct/raw/master/files/ct-submit_1.1.2-1_amd64.deb"

The location of `ct-submit` tool DEB file.


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
      - kravietz.acme-ct

License
-------

BSD

Author Information
------------------

Pawel Krawczyk https://keybase.io/kravietz
