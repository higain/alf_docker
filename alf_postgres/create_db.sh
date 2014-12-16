#!/bin/sh


gosu postgres postgres --single <<-EOF
    CREATE USER alfresco;
    CREATE DATABASE alfresco;
    GRANT ALL PRIVILEGES ON DATABASE alfresco TO alfresco;
EOF
