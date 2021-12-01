Count all running jobs: ```bjobs -r | wc -l```

Kill all running jobs: ```bjobs -w | grep 'RUN' | awk '{print $1}' | xargs bkill```
