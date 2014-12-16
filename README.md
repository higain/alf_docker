Experimental Dockerised Alfresco Deployment
===========================================

This project provides some very rough-around-the-edges docker containerisation of Alfresco deployments.

1.  Dump a license and installer into this directory.
    - Installer must be a 64-bit Linux installer and by default the Dockerfile will expect 4.2.5 to be available,
    e.g. alfresco-enterprise-4.2.5-installer-linux-x64.bin
    - License file must be cluster-enabled if deploying more than one Enterprise instance.
    e.g. enterprise-4.2-developer-cluster-unlimited.lic

2.  Build the images for the Alfresco server and Postgres database server
    - e.g. make && (cd alf_postgres && make)

3.  Deploy, either:
    - Inspect 'deployment' and execute by hand; or
    - Run the deployment bash script - this deploys a database, repository server(s) and share server(s).
    See "deployment -h" for details.
