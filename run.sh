#!/bin/bash
docker run -p 6080:6080 -v `pwd`:/host -it os-runner
