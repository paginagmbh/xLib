#!/bin/bash

for xspectest in *.xspec;
    do /tmp/xspec/bin/xspec.sh $xspectest 2>&1 | tee result.log;
    if grep -q ".*failed:\s[1-9]" result.log || grep -q -E "\*+\sError\s(running|compiling)\sthe\stest\ssuite" result.log;
      then echo "FAILED: $xspectest" && exit 1;
      else echo "OK: $xspectest";
    fi
done
