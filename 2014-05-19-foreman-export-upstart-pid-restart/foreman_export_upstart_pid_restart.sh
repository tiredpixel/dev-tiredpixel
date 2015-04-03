# note this reloads with *old* config; it does not cause config to be reread; see other restart method for a better implementation which reloads configs
for pid in $(ps axu | grep SERVICE_NAME | grep "su - deploy" | grep -v "grep" | cut -c 10-16); do echo "RESTARTING $(hostname -f) PID $pid" && kill $pid && sleep 10; done
service SERVICE_NAME start || true
