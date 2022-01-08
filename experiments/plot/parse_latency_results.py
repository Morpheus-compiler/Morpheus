import matplotlib
matplotlib.use('Agg')

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

import argparse
import os
import sys
import shutil
from pathlib import Path
import scipy.stats


def parse_latency_data(service):
    results_folder = f'{sys.path[0]}/../{service}/results/latency'

    if not os.path.exists(results_folder):
        print(f"Results folder {results_folder} does not exist")
        return None

    data = dict()
    for loc in ["load", "no-load"]:
        data[loc] = dict()
        for test in ["baseline", "optimized", "unoptimized"]:
            file_prefix = f"results_{test}_latency_{loc}_run"
            latency = []
            for file in os.listdir(results_folder):
                if file.startswith(file_prefix):
                    file_path = os.path.join(results_folder, file)
                    df = pd.read_csv(file_path, header=None)
                    df[0].sort_values(ascending=False)

                    z_scores = scipy.stats.zscore(df)
                    abs_z_scores = np.abs(z_scores)
                    filtered_entries = (abs_z_scores < 3).all(axis=1)
                    new_df = df[filtered_entries]

                    usec_latency = round(new_df[0][10:-10].quantile(0.99), 2)
                    latency.append(usec_latency)
            data[loc][test] = np.mean(latency)/1e3

    return data

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Parse latency results for all the services')
    args = parser.parse_args()

    data_latency = dict()
    for service in ["router", "switch", "bpf-iptables", "katran"]:
        service_data = parse_latency_data(service)
        if not service_data:
            print(f"Error while parsing latency data for service: {service}")
            sys.exit(1)
        data_latency[service] = service_data

    # Let's now create the final file
    if os.path.exists(f'{sys.path[0]}/data/eval-latency'):
        shutil.rmtree(f'{sys.path[0]}/data/eval-latency')
    Path(f'{sys.path[0]}/data/eval-latency').mkdir(parents=True, exist_ok=True)

    for loc in ["load", "no-load"]:
        with open(f'{sys.path[0]}/data/eval-latency/99percentile_{loc}.dat','w') as f:
            f.write("#dataplane,baseline,morpheus-opt,morpheus-non-opt (latency ms)\n")
            for service in ["switch", "router", "katran", "bpf-iptables"]:
                f.write(f'{service},{np.round(data_latency[service][loc]["baseline"])},{np.round(data_latency[service][loc]["optimized"])},{np.round(data_latency[service][loc]["unoptimized"])}\n')

    print("Results parsed correctly!")
    print(f"The output is in: {sys.path[0]}/data/perf_eval")