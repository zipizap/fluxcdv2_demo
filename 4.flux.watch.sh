kf() { kubectl get helmreleases,kustomizations,alerts,providers,receivers,buckets,gitrepositories,helmcharts,helmrepositories -A; }
TMP_FILE=$(mktemp)
while :;do sleep 2; kf &> $TMP_FILE; clear; date; cat $TMP_FILE ; done
