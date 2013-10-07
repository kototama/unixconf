#!/bin/bash

find ~/Documents/Projects/carneades/src/CarneadesEngine -name '*.clj' | xargs etags
find ~/Documents/Projects/carneades/src/PolicyModellingTool/resources/policymodellingtool/public/js/app/ -name "*.js" -exec etags -a {} \;

