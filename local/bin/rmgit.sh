#!/bin/bash

# DONE projects/markos/databases/db-1c7a00de-bd51-47e5-ac20-6267a26af8f6.h2.db
# DONE projects/markos/databases/db-8f7118ee-440d-4938-ab7b-443ace4f540b.h2.db
# DONE projects/markos/databases/db-968161d3-78d3-4b9a-9fcb-acd140fecc6f.h2.db
# DONE projects/markos/databases/db-a1c85086-1c6a-47bb-b276-ee075aa32e9a.h2.db
# DONE projects/markos/databases/db-c1dd9c6b-0961-4d5e-858a-26c3585b4a72.h2.db
# DONE projects/markos/databases/db-d0cdf870-6a37-4e53-aed9-0a2dbb3059ac.h2.db
# DONE projects/markos/databases/db-e773bbb4-1188-4b2d-b3a4-9c69ad1a407d.h2.db
# DONE projects/markos/databases/db-f7d9e136-eb47-42a0-977e-27bc87621848.h2.db
# db-f7d9e136-eb47-42a0-977e-27bc87621848.h2.db

git filter-branch --index-filter \
    'git rm --cached --ignore-unmatch src/CarneadesExamples/data/databases/copyright.h2.db' \
    --tag-name-filter cat -- --all
