cleanup_hosts:
  file.replace:
    - name: /etc/hosts
    - pattern: |
        \# START\: CORE4.+?END\: CORE4.+?\n
    - flags:
      - MULTILINE
      - DOTALL
    - repl: ""

cleanup_hosts_2:
  file.replace:
    - name: /etc/hosts
    - pattern: |
        \# begin of devops hosts.+?end of devops hosts.*\n?
    - flags:
      - MULTILINE
      - DOTALL
    - repl: ""

/etc/hosts:
  file.blockreplace:
    - name: /etc/hosts
    - marker_start: "# DO NOT EDIT - begin of devops"
    - marker_end: "# DO NOT EDIT - end of devops"
    - append_if_not_found: True
    - content: |

        127.0.0.1       testmongo

        # prod database
        # ----------------------------------------------------------------------
        10.249.1.30     pnbi_mongodb1 mongodb1
        10.249.1.31     pnbi_mongodb2 mongodb2

        10.249.1.3	pnbi_mongodb_rs2 mongodb_rs2
        10.249.1.4	pnbi_mongodb_rs3 mongodb_rs3

        # nfs
        # ----------------------------------------------------------------------
        10.249.1.10     pnbi_file1 file1

        # git
        # ----------------------------------------------------------------------
        10.249.2.7      pnbi_git

        # jira
        # ----------------------------------------------------------------------
        10.249.2.5      pnbi_jira jira
        10.249.1.51     pnbi_jira_psql jira_psql

        # core3
        # ----------------------------------------------------------------------
        10.249.1.6      pnbi_worker1 worker1
        10.249.1.11     pnbi_worker2 worker2
        10.249.1.14     pnbi_worker3 worker3

        10.249.1.8      pnbi_app1 app1
        10.249.1.15     pnbi_app2 app2

        10.249.2.3      pnbi_proxyExt proxyExt
        10.249.2.4      pnbi_postgresExt postgresExt
        10.249.2.20     pnbi_psqlExt_audible psqlExt_audible

        # core3 staging
        # ----------------------------------------------------------------------
        10.249.1.151    pnbi_staging_mongodb staging_mongodb
        10.249.1.152    pnbi_staging_worker1 staging_worker1
        10.249.1.153    pnbi_staging_app staging_app
        10.249.1.154    pnbi_staging_proxyExt staging_proxyExt staging.bi.plan-net.com

        # core4 staging
        # ----------------------------------------------------------------------
        10.249.1.191 salt.staging
        10.249.2.30 proxy.staging
        10.249.1.160 app1.staging
        10.249.1.161 worker1.staging
        10.249.1.162 mongodb.staging

        # obsolete
        10.249.1.9      pnbi_conti1 conti1

        # salt (old)
        10.249.1.7      pnbi_salt1 salt master pnbi_salt

        # jupyter (old)
        10.249.1.98     pnbi_ipython ipython-server ipython-srv

        # jupyter
        10.249.1.147    jupyter.spm  # jupyterhub IN spm

        # salt (core4)
        10.249.1.100    salt.spm

    - show_changes: True
